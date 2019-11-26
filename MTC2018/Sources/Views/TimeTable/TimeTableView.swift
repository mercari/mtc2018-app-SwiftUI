//
//  TimeTableView.swift
//  MTC2018
//
//  Created by masamichi on 2019/07/10.
//  Copyright © 2019 Mercari. All rights reserved.
//

import SwiftUI

struct TimeTableView : View {

    @State private var page = 0
    @ObservedObject var viewModel: TimeTableViewModel

    var body: some View {
        NavigationView {
            VStack {
                Picker("Page", selection: $page) {
                    Text("TRACK A").tag(0)
                    Text("TRACK B").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12))
                if viewModel.isLoading {
                    VStack {
                        Spacer()
                        ActivityIndicator(isAnimating: $viewModel.isLoading, style: .medium)
                        Spacer()
                    }
                } else {
                    // NavigationLink in PageView crashes on Xcode11.2.1
//                    PageView([
//                        ScrollView(.vertical, showsIndicators: true) {
//                            ForEach(viewModel.trackASessions, id: \.id) { session in
//                                VStack {
//                                    TimeTableRow(session: session)
//                                    Divider()
//                                }
//
//                            }
//                        },
//                        ScrollView(.vertical, showsIndicators: true) {
//                            ForEach(viewModel.trackBSessions, id: \.id) { session in
//                                VStack {
//                                    TimeTableRow(session: session)
//                                    Divider()
//                                }
//                            }
//                        }
//                    ], currentPage: $page)

                    // Workaround
                    if page == 0 {
                        ScrollView(.vertical, showsIndicators: true) {
                            ForEach(viewModel.trackASessions, id: \.id) { session in
                                VStack {
                                    TimeTableRow(session: session)
                                    Divider()
                                }

                            }
                        }
                    } else {
                        ScrollView(.vertical, showsIndicators: true) {
                            ForEach(viewModel.trackBSessions, id: \.id) { session in
                                VStack {
                                    TimeTableRow(session: session)
                                    Divider()
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(Text("TimeTable"))
        }
        .onAppear(perform: {
            self.viewModel.apply(.onAppear)            
        })
    }
}

#if DEBUG
struct TimeTableView_Previews : PreviewProvider {
    static var previews: some View {
        TimeTableView(viewModel: TimeTableViewModel(apiService: APIService()))
    }
}
#endif

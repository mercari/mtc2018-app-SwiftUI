//
//  TimeTableView.swift
//  MTC2018
//
//  Created by masamichi on 2019/07/10.
//  Copyright © 2019 Mercari. All rights reserved.
//

import SwiftUI

struct ShadowedProgressViews: View {
    var body: some View {
        VStack {
            ProgressView(value: 0.25)
            ProgressView(value: 0.75)
        }
        .progressViewStyle(DarkBlueShadowProgressViewStyle())
    }
}

struct DarkBlueShadowProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .shadow(color: Color(red: 0, green: 0, blue: 0.6),
                    radius: 4.0, x: 1.0, y: 2.0)
    }
}

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
                        ProgressView()
                        Spacer()
                    }
                } else {
                    PageView([
                        ScrollView(.vertical, showsIndicators: true) {
                            ForEach(viewModel.trackASessions, id: \.id) { session in
                                VStack {
                                    TimeTableRow(session: session)
                                    Divider()
                                }

                            }
                        },
                        ScrollView(.vertical, showsIndicators: true) {
                            ForEach(viewModel.trackBSessions, id: \.id) { session in
                                VStack {
                                    TimeTableRow(session: session)
                                    Divider()
                                }
                            }
                        }
                    ], currentPage: $page)
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

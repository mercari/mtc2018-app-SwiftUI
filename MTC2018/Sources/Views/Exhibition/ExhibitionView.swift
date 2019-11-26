//
//  ExhibitionView.swift
//  MTC2018
//
//  Created by masamichi on 2019/07/10.
//  Copyright © 2019 Mercari. All rights reserved.
//

import SwiftUI

struct ExhibitionView : View {

    @State private var page = 0
    @ObservedObject var viewModel: ExhibitionViewModel

    var body: some View {
        NavigationView {
            VStack {
                Picker("Page", selection: $page) {
                    Text("BOOTH A").tag(0)
                    Text("BOOTH B").tag(1)
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
//                            ForEach(viewModel.boothAExhibitions, id: \.id) { exhibition in
//                                VStack {
//                                    ExhibitionRow(exhibition: exhibition)
//                                    Divider()
//                                }
//                            }
//                        },
//                        ScrollView(.vertical, showsIndicators: true) {
//                            ForEach(viewModel.boothBExhibitions, id: \.id) { exhibition in
//                                VStack {
//                                    ExhibitionRow(exhibition: exhibition)
//                                    Divider()
//                                }
//                            }
//                        }
//                    ], currentPage: $page)

                    // Workaround
                    if page == 0 {
                        ScrollView(.vertical, showsIndicators: true) {
                            ForEach(viewModel.boothAExhibitions, id: \.id) { exhibition in
                                VStack {
                                    ExhibitionRow(exhibition: exhibition)
                                    Divider()
                                }
                            }
                        }
                    } else {
                        ScrollView(.vertical, showsIndicators: true) {
                            ForEach(viewModel.boothBExhibitions, id: \.id) { exhibition in
                                VStack {
                                    ExhibitionRow(exhibition: exhibition)
                                    Divider()
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Booth"))
        }
        .onAppear(perform: {
            self.viewModel.apply(.onAppear)
        })
    }
}

#if DEBUG
struct ExhibitionView_Previews : PreviewProvider {
    static var previews: some View {
        ExhibitionView(viewModel: ExhibitionViewModel(apiService: APIService()))
    }
}
#endif

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
                        ProgressView()
                        Spacer()
                    }
                } else {
                    PageView([
                        List {
                            ForEach(viewModel.boothAExhibitions, id: \.id) { exhibition in
                                NavigationLink(destination: ExhibitionDetailView(viewModel: ExhibitionDetailViewModel(exhibition: exhibition))) {
                                    ExhibitionRow(exhibition: exhibition)
                                }
                            }
                        },
                        List {
                            ForEach(viewModel.boothBExhibitions, id: \.id) { exhibition in
                                NavigationLink(destination: ExhibitionDetailView(viewModel: ExhibitionDetailViewModel(exhibition: exhibition))) {
                                    ExhibitionRow(exhibition: exhibition)
                                }
                            }
                        }
                    ], currentPage: $page)
                }
            }
            .navigationBarTitle(Text("Booth"))
            .listStyle(PlainListStyle())
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

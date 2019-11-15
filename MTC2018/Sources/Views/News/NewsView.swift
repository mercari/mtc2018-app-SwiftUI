//
//  NewsView.swift
//  MTC2018
//
//  Created by masamichi on 2019/07/16.
//  Copyright © 2019 Mercari. All rights reserved.
//

import SwiftUI

struct NewsView : View {
    @ObservedObject var viewModel: NewsViewModel

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    VStack {
                        Spacer()
                        ActivityIndicator(isAnimating: $viewModel.isLoading, style: .medium)
                        Spacer()
                    }
                } else {
                    ScrollView(.vertical, showsIndicators: true) {
                        ForEach(viewModel.news, id: \.id) { news in
                            VStack(alignment: .leading, spacing: nil) {
                                self.buildRow(news: news)
                                Divider()
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(Text("News"))
        }
        .onAppear(perform: {
            self.viewModel.apply(.onAppear)
        })
    }

    func buildRow(news: News) -> AnyView {
        if let url = URL(string: news.link) {
            return AnyView(
                NavigationLink(destination: NewsDetailView(url: url).navigationBarTitle(Text(""), displayMode: .inline)) {
                    NewsRow(news: news)
            })
        } else {
            return AnyView(NewsRow(news: news))
        }
    }
}

#if DEBUG
struct NewsView_Previews : PreviewProvider {
    static var previews: some View {
        NewsView(viewModel: NewsViewModel(apiService: APIService()))
    }
}
#endif

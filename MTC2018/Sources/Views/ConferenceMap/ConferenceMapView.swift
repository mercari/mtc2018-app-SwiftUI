//
//  ConferenceMapView.swift
//  MTC2018
//
//  Created by masamichi on 2019/07/10.
//  Copyright © 2019 Mercari. All rights reserved.
//

import SwiftUI

struct ConferenceMapView : View {
    
    @State private var page = 0
    @ObservedObject var viewModel: ConferenceMapViewModel

    var body: some View {
        NavigationView {
            VStack {
                Picker("Map", selection: $page) {
                    Text("ALL").tag(0)
                    Text("BOOTH A").tag(1)
                    Text("BOOTH B").tag(2)
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
                    PageView([
                        ScrollView(.vertical, showsIndicators: true) {
                            AnyView(
                                VStack(alignment: .leading, spacing: nil) {
                                    Image("tab_all")
                                        .resizable()
                                        .scaledToFit()
                                }
                                .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                            )
                        },
                        ScrollView(.vertical, showsIndicators: true) {
                            AnyView(
                                VStack(alignment: .leading, spacing: nil) {
                                    Image("booth_a")
                                        .resizable()
                                        .scaledToFit()
                                    VStack(alignment: .leading, spacing: nil) {
                                        ForEach(0..<viewModel.boothAExhibitions.count, id: \.self) { index in
                                            HStack(alignment: .top, spacing: nil) {
                                                Text("\(index + 1). ")
                                                    .font(.system(size: 14, weight: .bold))
                                                Text("\(self.viewModel.boothAExhibitions[index].localizedTitle)")
                                                    .font(.system(size: 14))
                                                Spacer()
                                            }
                                            .padding(.bottom, 16)
                                        }
                                    }
                                    .padding(EdgeInsets(top: 24, leading: 24, bottom: 0, trailing: 24))
                                    .background(Color.mtcGray)
                                    .cornerRadius(8)
                                }
                                .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                            )
                        },
                        ScrollView(.vertical, showsIndicators: true) {
                            AnyView(
                                VStack(alignment: .leading, spacing: nil) {
                                    Image("booth_b")
                                        .resizable()
                                        .scaledToFit()
                                    VStack(alignment: .leading, spacing: nil) {
                                        ForEach(0..<viewModel.boothBExhibitions.count, id: \.self) { index in
                                            HStack(alignment: .top, spacing: nil) {
                                                Text("\(index + self.viewModel.boothAExhibitions.count + 1). ")
                                                    .font(.system(size: 14, weight: .bold))
                                                Text("\(self.viewModel.boothBExhibitions[index].localizedTitle)")
                                                    .font(.system(size: 14))
                                                Spacer()
                                            }
                                            .padding(.bottom, 16)
                                        }
                                    }
                                    .padding(EdgeInsets(top: 24, leading: 24, bottom: 0, trailing: 24))
                                    .background(Color.mtcGray)
                                    .cornerRadius(8)
                                    VStack(alignment: .leading, spacing: nil) {
                                        Text("AskTheSpeaker.Title")
                                            .font(.system(size: 18, weight: .bold))
                                            .padding(.bottom, 12)
                                        Text("AskTheSpeaker.Description")
                                            .font(.system(size: 14))
                                    }
                                    .padding(.top, 24)
                                }
                                .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
                            )

                        }
                    ], currentPage: $page)
                }
            }
            .navigationBarTitle("Map")
        }
        .onAppear(perform: {
            self.viewModel.apply(.onAppear)
        })
    }
}

#if DEBUG
struct ConferenceMapView_Previews : PreviewProvider {
    static var previews: some View {
        ConferenceMapView(viewModel: ConferenceMapViewModel(apiService: APIService()))
    }
}
#endif

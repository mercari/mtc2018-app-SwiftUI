//
//  AboutView.swift
//  MTC2018
//
//  Created by masamichi on 2019/07/10.
//  Copyright © 2019 Mercari. All rights reserved.
//

import SwiftUI

struct AboutView : View {

    @EnvironmentObject private var userState: UserState

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading, spacing: nil) {
                    Text("About.Description")
                        .padding(.bottom, 24)
                    VStack(alignment: .leading, spacing: nil) {
                        Text("ACCESS")
                            .font(.system(size: 18, weight: .bold))
                            .padding(.bottom, 12)
                        Text("About.Access.Title")
                            .font(.system(size: 14))
                            .padding(.bottom, 8)
                        Text("About.Access.Address")
                            .font(.system(size: 14))
                    }
                    .padding(.bottom, 24)
                    VStack(alignment: .leading, spacing: nil) {
                        Text("About.Access.Subway.Title")
                            .font(.system(size: 18, weight: .bold))
                            .padding(.bottom, 12)
                        Text("About.Access.Subway.Description")
                            .font(.system(size: 14))
                            .padding(.bottom, 12)
                        Button(action: {
                            let map = "https://maps.apple.com/?sll=35.6604311,139.7287178&z=10&q=%e5%85%ad%e6%9c%ac%e6%9c%a8%e3%82%a2%e3%82%ab%e3%83%87%e3%83%9f%e3%83%bc%e3%83%92%e3%83%ab%e3%82%ba";
                            let url = URL(string: map)!
                            UIApplication.shared.open(url)
                        }) {
                            Text("About.OpenMap")
                        }                    }.padding(.bottom, 24)
                    VStack(alignment: .leading, spacing: nil) {
                        Text("About.Access.Bus.Title")
                            .font(.system(size: 18, weight: .bold))
                            .padding(.bottom, 12)
                        Text("About.Access.Bus.Title.From.Shibuya")
                            .font(.system(size: 14, weight: .bold))
                            .padding(.bottom, 12)
                        Text("About.Access.Bus.Description.From.Shibuya")
                            .font(.system(size: 14))
                            .padding(.bottom, 12)
                        Text("About.Access.Bus.Title.From.Shinjuku")
                            .font(.system(size: 14, weight: .bold))
                            .padding(.bottom, 12)
                        Text("About.Access.Bus.Description.From.Shinjuku")
                            .font(.system(size: 14))
                    }
                    .padding(.bottom, 24)

                    VStack(alignment: .leading, spacing: nil) {
                        Text("About.AccessToAcademyhills")
                            .font(.system(size: 18, weight: .bold))
                            .padding(.bottom, 12)
                        NavigationLink(destination: WebView(url: URL(string: "https://forum.academyhills.com/roppongi/access/index.html")!).navigationBarTitle(Text(""), displayMode: .inline)) {
                            Text("About.AcademyhillsSite")
                                .padding(.bottom, 12)
                        }
                        
                    }
                }
                .padding(24)
            }
            .navigationBarTitle(Text("About"))
        }
    }
}

#if DEBUG
struct AboutView_Previews : PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
#endif

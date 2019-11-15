//
//  ContentView.swift
//  MTC2018
//
//  Created by masamichi on 2019/07/04.
//  Copyright © 2019 Mercari. All rights reserved.
//

import SwiftUI

struct ContentView : View {

    @State var isMapViewPresented = false

    let timeTableViewModel = TimeTableViewModel(apiService: APIService())
    let exhitibionViewModel = ExhibitionViewModel(apiService: APIService())
    let newsViewModel = NewsViewModel(apiService: APIService())
    let conferenceViewModel = ConferenceMapViewModel(apiService: APIService())

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            TabView(){
                TimeTableView(viewModel: timeTableViewModel)
                    .tabItem {
                        Image(systemName: "table.fill")
                        Text("Time Table")
                }
                .tag(0)
                ExhibitionView(viewModel: exhitibionViewModel)
                    .tabItem {
                        Image(systemName: "cube.fill")
                        Text("Booth")
                }
                .tag(1)
                AccountView()
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("Account")
                }
                .tag(2)
                NewsView(viewModel: newsViewModel)
                    .tabItem {
                        Image(systemName: "bell.fill")
                        Text("News")
                }
                .tag(3)
                AboutView()
                    .tabItem {
                        Image(systemName: "m.circle.fill")
                        Text("About")
                }
                .tag(4)
            }

            Button(action: {
                self.isMapViewPresented = true
            }) {
                ConferenceMapButtonView()
            }
            .frame(width: 50, height: 50)
            .offset(x: -20, y: -70)
        }
        .sheet(isPresented: $isMapViewPresented, onDismiss: {
            self.isMapViewPresented = false
        }) {
            ConferenceMapView(viewModel: self.conferenceViewModel)
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

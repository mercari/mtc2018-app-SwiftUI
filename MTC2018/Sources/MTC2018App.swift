//
//  MTC2018App.swift
//  MTC2018
//
//  Created by masamichi on 2020/07/02.
//  Copyright © 2020 Mercari. All rights reserved.
//

import SwiftUI

@main
struct MTC2018App: App {

    @StateObject var userState: UserState = {
        let jsonDecoder = JSONDecoder()

        let userState = UserState()
        if let userData = UserDefaults.standard.data(forKey: "user"), let user = try? jsonDecoder.decode(User.self, from: userData) {
            userState.user = user
        }
        return userState
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userState)
        }
    }
}

//
//  ProfileView.swift
//  MTC2018
//
//  Created by masamichi on 2019/10/14.
//  Copyright © 2019 Mercari. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var userState: UserState

    var body: some View {
        return ScrollView(.vertical, showsIndicators: true) {
            if let user = userState.user {
                VStack(alignment: .leading, spacing: 24) {
                    Row(key: "ID", value: user.id)
                    Divider()
                    Row(key: "Name", value: user.name)
                    Divider()
                    Row(key: "Email", value: user.email)
                    Divider()
                    Spacer()
                    Button(action: {
                        UserDefaults.standard.set(nil, forKey: "user")
                        userState.user = nil
                    }) {
                        Text("SignOut")
                    }
                }
                .padding(24)
            }
        }
    }
}

struct Row: View {
    var key: String
    var value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(key)
                .font(.system(size: 14, weight: .bold))
            Text(value)
                .font(.system(size: 18))
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}


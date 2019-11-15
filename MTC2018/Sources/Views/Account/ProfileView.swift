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
        let keys = ["ID", "Name", "Email"]
        let values = [userState.user!.id, userState.user!.name, userState.user!.email]

        return ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: 24) {
                ForEach(keys.indices) {index in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(keys[index])
                            .font(.system(size: 14, weight: .bold))
                        Text(values[index])
                            .font(.system(size: 18))
                    }
                    Divider()
                }
                Spacer()
                Button(action: {
                    UserDefaults.standard.set(nil, forKey: "user")
                    self.userState.user = nil
                }) {
                    Text("SignOut")
                }
            }
            .padding(24)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

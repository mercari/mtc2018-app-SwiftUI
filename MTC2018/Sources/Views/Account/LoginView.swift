//
//  LoginView.swift
//  MTC2018
//
//  Created by kagemiku on 2019/07/12.
//  Copyright © 2019 Mercari. All rights reserved.
//

import SwiftUI

struct LoginView : View {
    @EnvironmentObject private var userState: UserState

    var body: some View {
        VStack {
            AppleIDButtonViewController(userState: userState, completion: { (succeeded: Bool) in
                guard let user = self.userState.user else { return }
                let jsonEncoder = JSONEncoder()
                guard let userData = try? jsonEncoder.encode(user) else { return }
                UserDefaults.standard.set(userData, forKey: "user")
            })
            .frame(height: 50)
            .padding()
        }
    }
}

#if DEBUG
struct LoginView_Previews : PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
#endif

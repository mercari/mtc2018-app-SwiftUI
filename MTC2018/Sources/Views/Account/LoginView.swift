//
//  LoginView.swift
//  MTC2018
//
//  Created by kagemiku on 2019/07/12.
//  Copyright © 2019 Mercari. All rights reserved.
//

import SwiftUI
import AuthenticationServices

struct LoginView : View {
    @EnvironmentObject private var userState: UserState
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var buttonStyle: SignInWithAppleButton.Style {
        switch colorScheme {
        case .light:
            return .black
        case .dark:
            return .white
        @unknown default:
            return .black
        }
    }

    var body: some View {
        VStack {
            SignInWithAppleButton(
                .signIn,
                onRequest: { request in
                    request.requestedScopes = [.fullName, .email]
                },
                onCompletion: { result in
                    switch result {
                    case .success (let authResults):
                        if let appleIDCredential = authResults.credential as? ASAuthorizationAppleIDCredential {
                            let id = appleIDCredential.user
                            let fullName = appleIDCredential.fullName
                            let email = appleIDCredential.email

                            let name = "\(fullName?.givenName ?? "") \(fullName?.familyName ?? "")"
                            
                            let user = User(id: id, name: name, email: email ?? "")
                            userState.user = user
                            let jsonEncoder = JSONEncoder()
                            guard let userData = try? jsonEncoder.encode(user) else { return }
                            UserDefaults.standard.set(userData, forKey: "user")
                        }
                    case .failure (let error):
                        print("Authorization failed: " + error.localizedDescription)
                    }
                }
            )
            .signInWithAppleButtonStyle(buttonStyle)
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

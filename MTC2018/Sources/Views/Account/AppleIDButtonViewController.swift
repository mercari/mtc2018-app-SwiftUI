//
//  AppleIDButtonViewController.swift
//  MTC2018
//
//  Created by kagemiku on 2019/07/12.
//  Copyright © 2019 Mercari. All rights reserved.
//

import SwiftUI
import UIKit
import AuthenticationServices

struct AppleIDButtonViewController: UIViewControllerRepresentable {

    @ObservedObject var userState: UserState
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    let completion: ((Bool) -> Void)?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        let authorizationButton: ASAuthorizationAppleIDButton
        switch colorScheme {
        case .light:
            authorizationButton = ASAuthorizationAppleIDButton(authorizationButtonType: .default, authorizationButtonStyle: .black)
        case .dark:
            authorizationButton = ASAuthorizationAppleIDButton(authorizationButtonType: .default, authorizationButtonStyle: .white)
        @unknown default:
            authorizationButton = ASAuthorizationAppleIDButton(authorizationButtonType: .default, authorizationButtonStyle: .black)
        }
        authorizationButton.addTarget(context.coordinator, action: #selector(Coordinator.handleAuthorizationAppleIDButtonPress), for: .touchUpInside)

        let vc = UIViewController()
        vc.view.addSubview(authorizationButton)

        let height: CGFloat = 50
        authorizationButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                authorizationButton.heightAnchor.constraint(equalToConstant: height),
                authorizationButton.topAnchor.constraint(equalTo: vc.view.topAnchor, constant: 0),
                authorizationButton.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor, constant: 0),
                authorizationButton.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor, constant: 0)
            ]
        )

        return vc
    }

    func updateUIViewController(_ viewController: UIViewController, context: Context) {
        // nothing to do
    }

    class Coordinator: NSObject, ASAuthorizationControllerDelegate {

        var parent: AppleIDButtonViewController

        init(_ viewController: AppleIDButtonViewController) {
            self.parent = viewController
        }

        @objc
        func handleAuthorizationAppleIDButtonPress() {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]

            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.performRequests()
        }

        func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
            if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                let user = appleIDCredential.user
                let fullName = appleIDCredential.fullName
                let email = appleIDCredential.email

                let name = "\(fullName?.givenName ?? "") \(fullName?.familyName ?? "")"
                parent.userState.user = User(id: user, name: name, email: email ?? "")
                parent.completion?(true)
            } else {
                parent.completion?(false)
            }
        }

        func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
            print("Error: \(error)")
            parent.completion?(false)
        }

    }

}

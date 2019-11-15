//
//  UserState.swift
//  MTC2018
//
//  Created by kagemiku on 2019/07/12.
//  Copyright © 2019 Mercari. All rights reserved.
//

import SwiftUI
import Combine

final class UserState: ObservableObject {
    @Published var user: User? = nil

    var isLoggedIn: Bool {
        user != nil
    }

}

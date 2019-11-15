//
//  User.swift
//  MTC2018
//
//  Created by kagemiku on 2019/07/12.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation

struct User: Codable {

    let id: String
    let name: String
    let email: String

    static let `default` = Self(id: "id", name: "name", email: "email")

}

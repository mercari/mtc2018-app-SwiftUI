//
//  News.swift
//  MTC2018
//
//  Created by masamichi on 2019/07/11.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation

struct News: Codable {
    let id: String
    let date: String
    let message: String
    let messageJa: String
    let link: String

    var localizedMessage: String {
        if isJa() {
            return messageJa
        } else {
            return message
        }
    }

    static let `default` = Self(id: "id", date: "date", message: "message", messageJa: "messageJa", link: "link")
}

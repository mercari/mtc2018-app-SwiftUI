//
//  Speaker.swift
//  MTC2018
//
//  Created by masamichi on 2019/07/11.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation

struct Speaker: Codable {
    let id: String
    let name: String
    let nameJa: String
    let company: String
    let position: String
    let positionJa: String
    let profile: String
    let profileJa: String
    let iconUrl: String
    let twitterId: String
    let githubId: String

    var localizedName: String {
        if isJa() {
            return nameJa
        } else {
            return name
        }
    }

    var localizedPosition: String {
        if isJa() {
            return positionJa
        } else {
            return position
        }
    }

    var localizedProfile: String {
        if isJa() {
            return profileJa
        } else {
            return profile
        }
    }

    

    static let `default` = Self(id: "id", name: "name", nameJa: "nameJa", company: "company", position: "position", positionJa: "positionJa", profile: "profile", profileJa: "profileJa", iconUrl: "iconUrl", twitterId: "twitterId", githubId: "githubId")
}

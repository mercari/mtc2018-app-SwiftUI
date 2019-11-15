//
//  Session.swift
//  MTC2018
//
//  Created by masamichi on 2019/07/11.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation

struct Session: Codable {
    let id: String
    let type: String
    let place: String
    let startTime: String
    let endTime: String
    let title: String
    let titleJa: String
    let outline: String
    let outlineJa: String
    let lang: String
    let tags: [String]
    let speakers: [Speaker]

    var localizedTitle: String {
        if isJa() {
            return titleJa
        } else {
            return title
        }
    }

    var localizedOutline: String {
        if isJa() {
            return outlineJa
        } else {
            return outline
        }
    }

    static let `default` = Self(id: "id", type: "typ", place: "place", startTime: "startTime", endTime: "endTime", title: "title", titleJa: "tileJa", outline: "outline", outlineJa: "outlineJa", lang: "lang", tags: [], speakers: [Speaker.default])
}

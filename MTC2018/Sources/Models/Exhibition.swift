//
//  Exhibition.swift
//  MTC2018
//
//  Created by masamichi on 2019/07/11.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation

struct Exhibition: Codable {
    let id: String
    let place: String
    let title: String
    let titleJa: String
    let description: String
    let descriptionJa: String
    let exhibitionImage: String
    let boothImage: String

    static let `default` = Self(id: "id", place: "place", title: "title", titleJa: "titleJa", description: "description", descriptionJa: "descriptionJa", exhibitionImage: "exhibitionImage", boothImage: "boothImage")

    var localizedTitle: String {
        if isJa() {
            return titleJa
        } else {
            return title
        }
    }

    var localizedDescription: String {
        if isJa() {
            return descriptionJa
        } else {
            return description
        }
    }
}

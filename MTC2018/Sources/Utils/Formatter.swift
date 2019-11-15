//
//  Formatter.swift
//  MTC2018
//
//  Created by masamichi on 2019/10/11.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation

enum Formatter {
    static let iso8601DateFormatter = ISO8601DateFormatter()

    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()

}




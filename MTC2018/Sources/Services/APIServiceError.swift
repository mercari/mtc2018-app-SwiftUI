//
//  APIServiceError.swift
//  MTC2018
//
//  Created by masamichi on 2019/10/12.
//  Copyright © 2019 Mercari. All rights reserved.
//

// https://github.com/kitasuke/SwiftUI-MVVM/blob/master/SwiftUI-MVVM/Services/APIServiceError.swift

import Foundation

enum APIServiceError: Error {
    case responseError
    case parseError(Error)
}

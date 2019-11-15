//
//  UnidirectionalDataFlowType.swift
//  MTC2018
//
//  Created by masamichi on 2019/10/12.
//  Copyright © 2019 Mercari. All rights reserved.
//

// https://github.com/kitasuke/SwiftUI-MVVM/blob/master/SwiftUI-MVVM/ViewModels/UnidirectionalDataFlowType.swift

import Foundation

protocol UnidirectionalDataFlowType {
    associatedtype InputType

    func apply(_ input: InputType)
}

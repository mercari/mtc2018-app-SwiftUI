//
//  ExhibitionDetailViewModel.swift
//  MTC2018
//
//  Created by masamichi on 2019/10/13.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import Combine

final class ExhibitionDetailViewModel: ObservableObject {

    let exhibition: Exhibition

    init(exhibition: Exhibition) {
        self.exhibition = exhibition
    }

}

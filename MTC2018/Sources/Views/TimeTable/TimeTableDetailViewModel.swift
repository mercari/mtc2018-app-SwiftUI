//
//  TimeTableDetailViewModel.swift
//  MTC2018
//
//  Created by masamichi on 2019/10/13.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import Combine

final class TimeTableDetailViewModel: ObservableObject {
    let session: Session

    var timeRange: String? {
        guard
            let startDate = Formatter.iso8601DateFormatter.date(from: session.startTime),
            let endDate = Formatter.iso8601DateFormatter.date(from: session.endTime) else {
                return nil
        }
        let startTime = Formatter.dateFormatter.string(from: startDate)
        let endTime = Formatter.dateFormatter.string(from: endDate)
        return "\(startTime) ~ \(endTime)"
    }

    init(session: Session) {
        self.session = session
    }
}

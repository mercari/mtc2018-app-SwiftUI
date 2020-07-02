//
//  TimeTableRow.swift
//  MTC2018
//
//  Created by masamichi on 2019/07/23.
//  Copyright © 2019 Mercari. All rights reserved.
//

import SwiftUI

struct TimeTableRow: View {
    @State var session: Session

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
    
    var body: some View {
        VStack(alignment: .leading, spacing: nil) {
            VStack(alignment: .leading, spacing: nil) {
                timeRange.map {
                    Text($0)
                        .font(.system(size: 14))
                        .padding(.bottom, 8)
                }
                Text(session.localizedTitle)
                    .font(.system(size: 18, weight: .bold))
                    .padding(.bottom, 16)
                HStack {
                    ForEach(session.tags, id: \.self) { tag in
                        TagView(tag: tag, color: Color.mtcRed)
                    }
                }
            }
            .padding(.bottom, 12)
            .foregroundColor(.primary)

            ForEach(session.speakers, id: \.id) { speaker in
                HStack(spacing: nil) {
                    URLImage(url: speaker.iconUrl) {
                        $0.renderingMode(.original)
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 50.0, height: 50.0)
                    }
                    VStack(alignment: .leading, spacing: nil) {
                        Text(speaker.localizedName)
                            .font(.system(size: 14, weight: .bold))
                        Text(speaker.localizedPosition)
                            .font(.system(size: 12))
                    }
                    .foregroundColor(.primary)
                }
            }
        }
        .padding(EdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24))
    }
}

#if DEBUG
struct TimeTableRow_Previews: PreviewProvider {
    static var previews: some View {
        TimeTableRow(session: Session.default)
    }
}
#endif

//
//  TimeTableDetailView.swift
//  MTC2018
//
//  Created by masamichi on 2019/07/23.
//  Copyright © 2019 Mercari. All rights reserved.
//

import SwiftUI

struct TimeTableDetailView: View {
    @ObservedObject var viewModel: TimeTableDetailViewModel

    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: nil) {
                viewModel.timeRange.map {
                    Text($0)
                        .font(.system(size: 14))
                        .padding(.bottom, 8)
                }
                Text(viewModel.session.localizedTitle)
                    .font(.system(size: 18, weight: .bold))
                    .padding(.bottom, 12)
                HStack {
                    ForEach(viewModel.session.tags, id: \.self) { tag in
                        TagView(tag: tag, color: Color.mtcRed)
                    }
                }.padding(.bottom, 16)
                Text(viewModel.session.localizedOutline)
                    .font(.system(size: 14))
                    .padding(.bottom, 24)

                VStack(alignment: .leading, spacing: nil) {
                    ForEach(viewModel.session.speakers, id: \.id) { speaker in
                        VStack(alignment: .leading, spacing: nil) {
                            HStack(alignment: .center, spacing: nil) {
                                URLImage(url: speaker.iconUrl) {
                                    $0.renderingMode(.original)
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(Circle())
                                        .frame(width: 50.0, height: 50.0)
                                }
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(speaker.localizedName)
                                        .font(.system(size: 14, weight: .bold))
                                    Text(speaker.localizedPosition)
                                        .font(.system(size: 12))
                                }
                                .foregroundColor(.primary)
                                Spacer()
                            }
                            .padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
                            Text(speaker.localizedProfile)
                                .font(.system(size: 14))
                        }
                        .padding(.bottom, 12)
                    }
                }
                .padding(EdgeInsets(top: 12, leading: 12, bottom: 0, trailing: 12))
                .background(Color.mtcGray)
                .cornerRadius(8)
            }
            .padding(EdgeInsets(top: 0, leading: 24, bottom: 24, trailing: 24))
        }
    }
}

#if DEBUG
struct TimeTableDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TimeTableDetailView(viewModel: TimeTableDetailViewModel(session: Session.default))
    }
}
#endif

//
//  SpeakerDetailView.swift
//  MTC2018
//
//  Created by masamichi on 2019/10/11.
//  Copyright © 2019 Mercari. All rights reserved.
//

import SwiftUI

struct SpeakerDetailView: View {
    @State var speaker: Speaker

    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
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
                        Text(speaker.localizedName).font(.system(size: 14, weight: .bold))
                        Text(speaker.localizedPosition).font(.system(size: 12))
                    }
                    .foregroundColor(.primary)
                    Spacer()
                }
                .padding(EdgeInsets(top: 4, leading: 0, bottom: 12, trailing: 0))
                Text(speaker.localizedProfile)
                    .font(.system(size: 14))
            }
            .padding(24)
        }
    }
}

struct SpeakerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SpeakerDetailView(speaker: Speaker.default)
    }
}

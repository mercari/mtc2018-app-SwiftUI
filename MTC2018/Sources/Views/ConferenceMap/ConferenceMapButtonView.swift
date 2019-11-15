//
//  ConferenceMapButtonView.swift
//  MTC2018
//
//  Created by kagemiku on 2019/07/14.
//  Copyright © 2019 Mercari. All rights reserved.
//

import SwiftUI

struct ConferenceMapButtonView : View {
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.red)
            Image(systemName: "map.fill")
                .foregroundColor(.white)
        }
    }
}

#if DEBUG
struct ConferenceMapButtonView_Previews : PreviewProvider {
    static var previews: some View {
        ConferenceMapButtonView()
            .previewLayout(.fixed(width: 50, height: 50))
    }
}
#endif

//
//  NewsRow.swift
//  MTC2018
//
//  Created by masamichi on 2019/07/16.
//  Copyright © 2019 Mercari. All rights reserved.
//

import SwiftUI

struct NewsRow : View {
    @State var news: News
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(news.date)
                .font(.system(size: 14))
            Text(news.localizedMessage)
                .font(.system(size: 18, weight: .bold))
        }
        .padding(EdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24))
        .foregroundColor(.primary)
    }
}

#if DEBUG
struct NewsRow_Previews : PreviewProvider {
    static var previews: some View {
        NewsRow(news: News.default)
    }
}
#endif

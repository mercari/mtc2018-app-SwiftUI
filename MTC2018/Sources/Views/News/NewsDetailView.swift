//
//  NewsDetailView.swift
//  MTC2018
//
//  Created by masamichi on 2019/07/16.
//  Copyright © 2019 Mercari. All rights reserved.
//

import SwiftUI

struct NewsDetailView : View {
    var url: URL
    var body: some View {
        WebView(url: url)
    }
}

#if DEBUG
struct NewsDetailView_Previews : PreviewProvider {
    static var previews: some View {
        NewsDetailView(url: URL(string: "https://apple.com")!)
    }
}
#endif

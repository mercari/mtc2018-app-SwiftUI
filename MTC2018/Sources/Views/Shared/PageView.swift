//
//  PageView.swift
//  MTC2018
//
//  Created by masamichi on 2019/07/29.
//  Copyright © 2019 Mercari. All rights reserved.
//

import SwiftUI

struct PageView<Page: View>: View {
    var viewControllers: [UIHostingController<Page>]
    @Binding var currentPage: Int

    init(_ views: [Page], currentPage: Binding<Int>) {
        self._currentPage = currentPage
        self.viewControllers = views.map { UIHostingController(rootView: $0) }
    }

    var body: some View {
        PageViewController(controllers: viewControllers, currentPage: $currentPage)
    }
}

#if DEBUG
struct PageView_Previews: PreviewProvider {
    @State static var page = 0
    static var previews: some View {
        PageView([Text("Hello")], currentPage: $page)
    }
}
#endif

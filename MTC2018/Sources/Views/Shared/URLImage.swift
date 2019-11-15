//
//  URLImage.swift
//  MTC2018
//
//  Created by masamichi on 2019/10/11.
//  Copyright © 2019 Mercari. All rights reserved.
//

import SwiftUI
import Combine

struct URLImage<Content>: View where Content: View {
    @ObservedObject var imageLoader = ImageLoader()

    private let url: String
    private let content: (_ image: Image) -> Content

    init(url: String, content: @escaping (_ image: Image) -> Content) {
        self.url = url
        self.content = content
    }

    var body: some View {
        ZStack {
            if imageLoader.image != nil {
                content(imageLoader.image!)
            } else {
                content(Image("placeholder"))
            }
        }.onAppear {
            self.imageLoader.load(url: self.url)
        }
    }
}

struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        URLImage(url: "") {
            $0
        }
    }
}

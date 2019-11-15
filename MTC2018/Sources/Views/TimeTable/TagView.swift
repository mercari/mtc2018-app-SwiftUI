//
//  TagView.swift
//  MTC2018
//
//  Created by masamichi on 2019/07/29.
//  Copyright © 2019 Mercari. All rights reserved.
//

import SwiftUI

struct TagView: View {
    let tag: String
    let color: Color

    var body: some View {
        Text("# \(tag)")
            .foregroundColor(color)
            .font(.system(size: 14))
            .padding(EdgeInsets(top: 4, leading: 8, bottom: 6, trailing: 8))
            .background(Color.clear)
            .overlay(RoundedRectangle(cornerRadius: 100).stroke(lineWidth: 1).foregroundColor(color))
    }
}

#if DEBUG
struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(tag: "Tag", color: Color.red)
    }
}
#endif

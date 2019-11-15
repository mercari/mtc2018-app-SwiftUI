//
//  ExhibitionRow.swift
//  MTC2018
//
//  Created by kagemiku on 2019/08/16.
//  Copyright © 2019 Mercari. All rights reserved.
//

import SwiftUI

struct ExhibitionRow: View {

    @State var exhibition: Exhibition

    var body: some View {
        NavigationLink(destination: ExhibitionDetailView(viewModel: ExhibitionDetailViewModel(exhibition: exhibition))) {
            VStack(alignment: .leading, spacing: nil) {
                if !exhibition.exhibitionImage.isEmpty {
                    Image(exhibition.exhibitionImage.components(separatedBy: ".")[0])
                        .renderingMode(.original)
                        .resizable()
                    .scaledToFit()
                }

                Text(exhibition.localizedTitle)
                    .font(.system(size: 18, weight: .bold))
                    .padding(.bottom, 8)

                Text(exhibition.localizedDescription)
                    .lineLimit(3)
                    .font(.system(size: 14))

            }
            .foregroundColor(.primary)
        }
        .padding(EdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24))
    }
}

#if DEBUG
struct ExhibitionRow_Previews: PreviewProvider {
    static var previews: some View {
        ExhibitionRow(exhibition: Exhibition.default)
    }
}
#endif

//
//  ExhibitionDetailView.swift
//  MTC2018
//
//  Created by kagemiku on 2019/08/16.
//  Copyright © 2019 Mercari. All rights reserved.
//

import SwiftUI

struct ExhibitionDetailView: View {

    @ObservedObject var viewModel: ExhibitionDetailViewModel

    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading, spacing: nil) {
                Text(viewModel.exhibition.localizedTitle)
                    .font(.system(size: 18, weight: .bold))
                    .padding(.bottom, 12)

                if !viewModel.exhibition.exhibitionImage.isEmpty {
                    Image(viewModel.exhibition.exhibitionImage.components(separatedBy: ".")[0])
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom, 12)
                }

                Text(viewModel.exhibition.localizedDescription)
                    .font(.system(size: 14))
                    .padding(.bottom, 24)

                Text("BOOTH MAP")
                    .font(.system(size: 18, weight: .bold))
                    .padding(.bottom, 12)
                Image(viewModel.exhibition.boothImage.components(separatedBy: ".")[0])
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
            }
            .padding(EdgeInsets(top: 0, leading: 24, bottom: 24, trailing: 24))
        }
    }
}

#if DEBUG
struct ExhibitionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ExhibitionDetailView(viewModel: ExhibitionDetailViewModel(exhibition: Exhibition.default))
    }
}
#endif

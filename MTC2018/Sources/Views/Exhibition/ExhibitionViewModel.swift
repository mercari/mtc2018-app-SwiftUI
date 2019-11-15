//
//  ExhibitionViewModel.swift
//  MTC2018
//
//  Created by masamichi on 2019/10/13.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import Combine

final class ExhibitionViewModel: ObservableObject, UnidirectionalDataFlowType {
    enum InputType {
        case onAppear
    }
    func apply(_ input: ExhibitionViewModel.InputType) {
        switch input {
        case .onAppear:
            if exhibitions.count > 0 {
                return
            }
            isLoading = true
            onAppearSubject.send(())
        }
    }

    @Published private(set) var exhibitions: [Exhibition] = []
    @Published var isLoading: Bool = false

    var boothAExhibitions: [Exhibition] {
        return exhibitions.filter {
            $0.place == "BoothA"
        }
    }

    var boothBExhibitions: [Exhibition] {
        return exhibitions.filter {
            $0.place == "BoothB"
        }
    }

    private let apiService: APIServiceType
    private let onAppearSubject = PassthroughSubject<Void, Never>()
    private var cancellables: [AnyCancellable] = []

    init(apiService: APIServiceType) {
        self.apiService = apiService
        bind()
    }

    private func bind() {
        let request = GetExhibitionsRequest()
        let responsePublisher = onAppearSubject
            .flatMap { [apiService] _ in
                apiService.response(from: request).catch { error -> Empty<GetExhibitionsResponse, Never > in
                    return .init()
                }
        }
        .map { $0.data.exhibitionList.nodes }

        let exhibitionsStream = responsePublisher
            .assign(to: \.exhibitions, on: self)

        let stopLoadingStream = responsePublisher
            .map({ _ in
                return false
            })
            .assign(to: \.isLoading, on: self)

        cancellables += [
            exhibitionsStream,
            stopLoadingStream
        ]
    }
}

//
//  NewsViewModel.swift
//  MTC2018
//
//  Created by masamichi on 2019/10/13.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation
import Combine

final class NewsViewModel: ObservableObject, UnidirectionalDataFlowType {
    enum InputType {
        case onAppear
    }
    func apply(_ input: NewsViewModel.InputType) {
        switch input {
        case .onAppear:
            if news.count > 0 {
                return
            }
            isLoading = true
            onAppearSubject.send(())
        }
    }

    @Published private(set) var news: [News] = []
    @Published var isLoading: Bool = false

    private let apiService: APIServiceType
    private let onAppearSubject = PassthroughSubject<Void, Never>()
    private var cancellables: [AnyCancellable] = []

    init(apiService: APIServiceType) {
        self.apiService = apiService
        bind()
    }

    private func bind() {
        let request = GetNewsRequest()
        let responsePublisher = onAppearSubject
            .flatMap { [apiService] _ in
                apiService.response(from: request).catch { error -> Empty<GetNewsResponse, Never > in
                    return .init()
                }
        }
        .map { $0.data.newsList.nodes }

        let newsStream = responsePublisher
            .assign(to: \.news, on: self)

        let stopLoadingStream = responsePublisher
            .map({ _ in
                return false
            })
            .assign(to: \.isLoading, on: self)

        cancellables += [
            newsStream,
            stopLoadingStream
        ]
    }
}

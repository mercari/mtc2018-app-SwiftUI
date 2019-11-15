//
//  TimeTableViewModel.swift
//  MTC2018
//
//  Created by masamichi on 2019/10/12.
//  Copyright © 2019 Mercari. All rights reserved.
//


import Foundation
import SwiftUI
import Combine

final class TimeTableViewModel: ObservableObject, UnidirectionalDataFlowType {
    enum InputType {
        case onAppear
    }
    func apply(_ input: TimeTableViewModel.InputType) {
        switch input {
        case .onAppear:
            if sessions.count > 0 {
                return
            }
            isLoading = true
            onAppearSubject.send(())
        }
    }

    @Published private(set) var sessions: [Session] = []
    @Published var isLoading: Bool = false

    var trackASessions: [Session] {
        return sessions.filter {
            $0.place == "TrackA"
        }
    }

    var trackBSessions: [Session] {
        return sessions.filter {
            $0.place == "TrackB"
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
        let request = GetSessionsRequest()
        let responsePublisher = onAppearSubject
            .flatMap { [apiService] _ in
                apiService.response(from: request).catch { error -> Empty<GetSessionsResponse, Never > in
                    return .init()
                }
        }
        .map { $0.data.sessionList.nodes }

        let sessionsStream = responsePublisher
            .assign(to: \.sessions, on: self)

        let stopLoadingStream = responsePublisher
            .map({ _ in
                return false
            })
            .assign(to: \.isLoading, on: self)

        cancellables += [
            sessionsStream,
            stopLoadingStream
        ]
    }
}

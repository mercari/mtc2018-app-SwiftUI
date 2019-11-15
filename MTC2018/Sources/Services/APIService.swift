//
//  APIService.swift
//  MTC2018
//
//  Created by masamichi on 2019/10/12.
//  Copyright © 2019 Mercari. All rights reserved.
//

// https://github.com/kitasuke/SwiftUI-MVVM/blob/master/SwiftUI-MVVM/Services/APIService.swift

import Foundation
import Combine

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
protocol APIRequestType {
    associatedtype Response: Decodable

    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
}

protocol APIServiceType {
    func response<Request>(from request: Request) -> AnyPublisher<Request.Response, APIServiceError> where Request: APIRequestType
}

final class APIService: APIServiceType {

    private let baseURL: URL = {
        #if DEBUG
        return URL(string: "https://mtc2018.dev.citadelapps.com")!
        #else
        return URL(string: "https://techconf.mercari.com")!
        #endif
    }()

    func response<Request>(from request: Request) -> AnyPublisher<Request.Response, APIServiceError> where Request: APIRequestType {

        // FIXME: Remove this later
        if request is GetExhibitionsRequest {
            let exhibitionData: [Exhibition] = load("exhibitions.json")
            return Future<Request.Response, APIServiceError> { promise in
                let response = GetExhibitionsResponse(data: .init(exhibitionList: .init(nodes: exhibitionData))) as! Request.Response
                promise(.success(response))
            }.eraseToAnyPublisher()
        }

        let pathURL = URL(string: request.path, relativeTo: baseURL)!

        var urlComponents = URLComponents(url: pathURL, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = request.queryItems
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.httpBody = request.body

        let decorder = JSONDecoder()
        decorder.keyDecodingStrategy = .convertFromSnakeCase
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map { data, urlResponse in data }
            .mapError { _ in APIServiceError.responseError }
            .decode(type: Request.Response.self, decoder: decorder)
            .mapError(APIServiceError.parseError)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

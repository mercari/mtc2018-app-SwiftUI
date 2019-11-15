//
//  GetNewsRequest.swift
//  MTC2018
//
//  Created by masamichi on 2019/10/13.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation

struct GetNewsRequest: APIRequestType {
    typealias Response = GetNewsResponse

    var path: String {
        return "/2018/api/query"
    }

    var httpMethod: HTTPMethod {
        return .post
    }

    var queryItems: [URLQueryItem]? {
        return nil
    }

    var body: Data? {
        let query = """
{
  newsList {
    nodes {
      id
      date
      message
      messageJa
      link
    }
  }
}
"""
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode([
            "query": query
        ]) else { return nil }
        return data
    }
}

struct GetNewsResponse: Codable {
    let data: SessionData

    struct SessionData: Codable {
        let newsList: Node

        struct Node: Codable {
            let nodes: [News]
        }
    }
}

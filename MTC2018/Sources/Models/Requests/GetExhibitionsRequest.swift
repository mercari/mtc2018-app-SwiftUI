//
//  GetExhibitionsRequest.swift
//  MTC2018
//
//  Created by masamichi on 2019/10/13.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation

struct GetExhibitionsRequest: APIRequestType {
    typealias Response = GetExhibitionsResponse

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
  exhibitionList {
    nodes {
      id
      place
      title
      titleJa
      description
      descriptionJa
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

struct GetExhibitionsResponse: Codable {
    let data: SessionData

    struct SessionData: Codable {
        let exhibitionList: Node

        struct Node: Codable {
            let nodes: [Exhibition]
        }
    }
}

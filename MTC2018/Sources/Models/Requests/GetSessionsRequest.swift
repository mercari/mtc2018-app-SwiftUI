//
//  GetSessionsRequest.swift
//  MTC2018
//
//  Created by masamichi on 2019/10/12.
//  Copyright © 2019 Mercari. All rights reserved.
//

import Foundation

struct GetSessionsRequest: APIRequestType {
    typealias Response = GetSessionsResponse

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
 sessionList {
   nodes {
     id
     type
     place
     title
     titleJa
     startTime
     endTime
     outline
     outlineJa
     lang
     tags
     speakers {
       id
       name
       nameJa
       company
       position
       positionJa
       profile
       profileJa
       iconUrl
       twitterId
       githubId
     }
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

struct GetSessionsResponse: Codable {
    let data: SessionData

    struct SessionData: Codable {
        let sessionList: Node

        struct Node: Codable {
            let nodes: [Session]
        }
    }
}

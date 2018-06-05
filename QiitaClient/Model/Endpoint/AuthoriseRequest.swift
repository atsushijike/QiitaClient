//
//  AuthoriseRequest.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/06/05.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import Foundation

struct AuthoriseRequest: Request {
    var path: String { return "/oauth/authorize" }
    var method: HTTPMethod { return .get }
    var parameters: [String : Any]? {
        return [
            "client_id": clientId,
            "scope": "read_qiita+write_qiita",
            "state": stateId
        ]
    }

    let clientId: String
    let stateId: String

    public init(clientId: String, stateId: String) {
        self.clientId = clientId
        self.stateId = stateId
    }

    var urlRequest: URLRequest {
        var components = URLComponents()
        components.scheme = baseURL.scheme
        components.host = baseURL.host
        components.path = version + path
        var queryItems: [URLQueryItem] = []
        parameters?.keys.forEach({ (key) in
            if let value = parameters?[key] as? String {
                queryItems.append(URLQueryItem(name: key, value: value))
            }
        })
        components.queryItems = queryItems
        guard let url = components.url else {
            fatalError()
        }
        return URLRequest(url: url)
    }
}

//https://qiita.com/api/v2/oauth/authorize?client_id=110f5a9aabd17aaea26cfa6a7855e02e369e154b&scope=read_qiita+write_qiita

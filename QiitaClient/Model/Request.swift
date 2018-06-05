//
//  Request.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/04/10.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import Foundation

protocol Request {
    var baseURL: URL { get }
    var version: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
}

extension Request {
    public var baseURL: URL { return  URL(string: "https://qiita.com")! }
    public var version: String { return "/api/v2" }
    public var parameters: [String: Any]? { return nil }
    public var headers: [String: String]? {
        let accessToken = store.state.authentication.accessToken
        return accessToken.isEmpty ? nil : ["Authorization": "Bearer \(accessToken)"]
    }
}

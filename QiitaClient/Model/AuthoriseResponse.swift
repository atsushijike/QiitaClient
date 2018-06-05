//
//  AuthoriseResponse.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/06/05.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import Foundation

struct AuthoriseResponse {
    let url: URL

    public init(url: URL) {
        self.url = url
    }

    var parameters: [String: String] {
        var parameters: [String: String] = [:]
        var components = URLComponents(string: url.absoluteString)
        components?.queryItems?.forEach({ (queryItem) in
            parameters[queryItem.name] = queryItem.value ?? ""
        })
        return parameters
    }

    var code: String {
        return parameters["code"] ?? ""
    }

    var state: String {
        return parameters["state"] ?? ""
    }
}

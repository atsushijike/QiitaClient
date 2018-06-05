//
//  AccessTokenRequest.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/06/05.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import Foundation

struct AccessTokenRequest: Request {
    var path: String { return "/access_tokens" }
    var method: HTTPMethod { return .post }
    var parameters: [String : Any]? {
        return [
            "client_id": clientId,
            "client_secret": clientSecret,
            "code": code
        ]
    }

    let clientId: String
    let clientSecret: String
    let code: String

    public init(clientId: String, clientSecret: String, code: String) {
        self.clientId = clientId
        self.clientSecret = clientSecret
        self.code = code
    }
}

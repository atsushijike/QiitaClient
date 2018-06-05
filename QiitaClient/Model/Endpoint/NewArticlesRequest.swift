//
//  NewArticlesRequest.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/04/10.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import Foundation

struct NewArticlesRequest: Request {
    var path: String { return "/items" }
    var method: HTTPMethod { return .get }
    var parameters: [String : Any]? {
        return [
            "page": page,
            "per_page": perPage
        ]
    }
    var headers: [String: String]? {
        let accessToken = "3b00c0f97c79fb7a8c704c170ce518955822e470"
        return ["Authorization": "Bearer \(accessToken)"]
    }

    private let page: Int
    private let perPage: Int
    
    public init(page: Int, perPage: Int) {
        self.page = page
        self.perPage = perPage
    }
}

//
//  UserFolloweesRequest.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/06/07.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import Foundation

struct UserFolloweesRequest: Request {
    var path: String { return "/users/\(userId)/followees" }
    var method: HTTPMethod { return .get }
    var parameters: [String : Any]? {
        return [
            "page": page,
            "per_page": perPage
        ]
    }
    
    private let userId: String
    private let page: Int
    private let perPage: Int
    
    public init(userId: String, page: Int, perPage: Int) {
        self.userId = userId
        self.page = page
        self.perPage = perPage
    }
}

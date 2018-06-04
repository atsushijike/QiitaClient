//
//  TimelineArticlesRequest.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/04/10.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import Foundation

struct TimelineArticlesRequest: Request {
    var path: String { return "/items" }
    var method: HTTPMethod { return .get }
    var parameters: [String : Any]? {
        return [
            "page": page,
            "per_page": perPage
        ]
    }

    private let page: Int
    private let perPage: Int
    
    public init(page: Int, perPage: Int) {
        self.page = page
        self.perPage = perPage
    }
}

//
//  AuthenticatedUserRequest.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/06/06.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import Foundation

struct AuthenticatedUserRequest: Request {
    var path: String { return "/authenticated_user" }
    var method: HTTPMethod { return .get }
}

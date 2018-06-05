//
//  AuthenticationState.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/06/05.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import Foundation

struct AuthenticationState {
    let clientId = "110f5a9aabd17aaea26cfa6a7855e02e369e154b"
    let clientSecret = "4cfeedb1b1781118b029a201b8ec75c7bb2a27d1"
    let stateId = UUID().uuidString
    var code: String = ""
    var accessToken: String = ""

    mutating func updateCode(code: String) {
        self.code = code
    }

    mutating func updateAccessToken(accessToken: String) {
        self.accessToken = accessToken
    }
}

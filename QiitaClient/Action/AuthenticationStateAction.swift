//
//  AuthenticationStateAction.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/06/05.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import Foundation
import ReSwift

extension AuthenticationState {
    struct AuthenticationCodeAction: Action {
        let code: String
    }

    struct AuthenticationAccessTokenAction: Action {
        let accessToken: String
    }
}

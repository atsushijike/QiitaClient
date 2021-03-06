//
//  AuthenticationReducer.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/06/05.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import Foundation
import ReSwift

func authenticationReducer(action: Action, state: AuthenticationState?) -> AuthenticationState {
    var newState = state ?? .init()
    var authenticationState = newState
    
    switch action {
    case let action as AuthenticationState.AuthenticationCodeAction:
        authenticationState.updateCode(code: action.code)
    case let action as AuthenticationState.AuthenticationAccessTokenAction:
        authenticationState.updateAccessToken(accessToken: action.accessToken)
    default:
        break
    }

    newState = authenticationState
    return newState
}

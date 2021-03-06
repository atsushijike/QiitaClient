//
//  AppReducer.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/06/06.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import Foundation
import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(authentication: authenticationReducer(action: action, state: state?.authentication),
                    newItems: newItemsReducer(action: action, state: state?.newItems),
                    authenticatedUser: authenticatedUserReducer(action: action, state: state?.authenticatedUser))
}

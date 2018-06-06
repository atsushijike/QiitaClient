//
//  AppState.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/04/10.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import Foundation
import ReSwift

struct AppState: StateType {
    var authentication = AuthenticationState()
    var newArticles = NewArticlesState()
    var authenticatedUser = AuthenticatedUserState()
}

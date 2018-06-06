//
//  AuthenticatedUserState.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/06/06.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import Foundation

struct AuthenticatedUserState {
    var title: String = ""
    var user: User?

    mutating func updateTitle(title: String) {
        self.title = title
    }

    mutating func updateUser(user: User?) {
        self.user = user
    }
}

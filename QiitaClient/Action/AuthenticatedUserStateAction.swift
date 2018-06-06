//
//  AuthenticatedUserStateAction.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/06/06.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import Foundation
import ReSwift

extension AuthenticatedUserState {
    struct AuthenticatedUserTitleAction: Action {
        let title: String
    }

    struct AuthenticatedUserUserAction: Action {
        let user: User
    }
}

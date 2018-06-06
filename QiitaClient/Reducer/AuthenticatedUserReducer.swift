//
//  AuthenticatedUserReducer.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/06/06.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import Foundation
import ReSwift

func authenticatedUserReducer(action: Action, state: AuthenticatedUserState?) -> AuthenticatedUserState {
    var newState = state ?? .init()
    var authenticatedUserState = newState

    switch action {
    case let action as AuthenticatedUserState.AuthenticatedUserTitleAction:
        authenticatedUserState.updateTitle(title: action.title)
    case let action as AuthenticatedUserState.AuthenticatedUserUserAction:
        authenticatedUserState.updateUser(user: action.user)
    case let action as AuthenticatedUserState.AuthenticatedUserPageNumberAction:
        authenticatedUserState.updatePageNumber(pageNumber: action.pageNumber)
    case let action as AuthenticatedUserState.AuthenticatedUserItemsAction:
        authenticatedUserState.updateItems(items: action.items)
    default:
        break
    }

    newState = authenticatedUserState
    return newState
}

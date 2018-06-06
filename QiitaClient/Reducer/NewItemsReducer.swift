//
//  NewItemsReducer.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/04/10.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import Foundation
import ReSwift

func newItemsReducer(action: Action, state: NewItemsState?) -> NewItemsState {
    var newState = state ?? .init()
    var newItemsState = newState

    switch action {
    case let action as NewItemsState.NewItemsRefreshAction:
        newItemsState.updateIsRefresh(isRefresh: action.isRefresh)
        newItemsState.updatePageNumber(pageNumber: action.pageNumber)
    case let action as NewItemsState.NewItemsResultAction:
        newItemsState.updateItems(items: action.items)
    default:
        break
    }

    newState = newItemsState
    return newState
}

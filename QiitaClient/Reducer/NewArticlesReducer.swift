//
//  NewArticlesReducer.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/04/10.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import Foundation
import ReSwift

func newArticlesReducer(action: Action, state: NewArticlesState?) -> NewArticlesState {
    var newState = state ?? .init()
    var newArticlesState = newState

    switch action {
    case let action as NewArticlesState.NewArticlesRefreshAction:
        newArticlesState.updateIsRefresh(isRefresh: action.isRefresh)
        newArticlesState.updatePageNumber(pageNumber: action.pageNumber)
    case let action as NewArticlesState.NewArticlesResultAction:
        newArticlesState.updateArticles(articles: action.articles)
    default:
        break
    }

    newState = newArticlesState
    return newState
}

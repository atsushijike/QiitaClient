//
//  NewArticlesReducer.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/04/10.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import Foundation
import ReSwift

func NewArticlesReducer(action: Action, state: AppState?) -> AppState {
    var newState = state ?? AppState()
    var newArticlesState = newState.newArticles

    switch action {
    case let action as NewArticlesState.NewArticlesRefreshAction:
        newArticlesState.updateIsRefresh(isRefresh: action.isRefresh)
        newArticlesState.updatePageNumber(pageNumber: action.pageNumber)
    case let action as NewArticlesState.NewArticlesResultAction:
        newArticlesState.updateArticles(articles: action.articles)
    default:
        break
    }

    newState.newArticles = newArticlesState
    return newState
}

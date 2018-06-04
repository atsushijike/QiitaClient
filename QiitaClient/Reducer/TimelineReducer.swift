//
//  TimelineReducer.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/04/10.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import Foundation
import ReSwift

func TimelineReducer(action: Action, state: AppState?) -> AppState {
    var newState = state ?? AppState()
    var timelineState = newState.timeline

    switch action {
    case let action as TimelineState.TimelineRefreshAction:
        timelineState.updateIsRefresh(isRefresh: action.isRefresh)
        timelineState.updatePageNumber(pageNumber: action.pageNumber)
    case let action as TimelineState.TimelineResultAction:
        timelineState.updateArticles(articles: action.articles)
    default:
        break
    }

    newState.timeline = timelineState
    return newState
}

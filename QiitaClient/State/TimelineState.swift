//
//  TimelineState.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/04/10.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import Foundation

struct TimelineState {
    var title: String = ""
    var pageNumber: Int = 1
    var articles: [Article]?
    var errorString: String?
    var isRefresh: Bool = false

    mutating func updateIsRefresh(isRefresh: Bool) {
        self.isRefresh = isRefresh
    }

    mutating func updatePageNumber(pageNumber: Int) {
        self.pageNumber = pageNumber
    }

    mutating func updateArticles(articles: [Article]?) {
        self.articles = articles
        incrementPageNumber()
    }

    mutating func appendArticles(articles: [Article]?) {
        guard let articles = articles else { return }
        self.articles?.append(contentsOf: articles)
        incrementPageNumber()
    }

    private mutating func incrementPageNumber() {
        pageNumber += 1
    }
}

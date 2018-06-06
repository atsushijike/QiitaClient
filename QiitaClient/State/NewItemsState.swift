//
//  NewItemsState.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/04/10.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import Foundation

struct NewItemsState {
    var title: String = "New"
    var pageNumber: Int = 1
    var isRefresh: Bool = false
    var items: [Item]?
    var errorString: String?

    mutating func updateIsRefresh(isRefresh: Bool) {
        self.isRefresh = isRefresh
    }

    mutating func updatePageNumber(pageNumber: Int) {
        self.pageNumber = pageNumber
    }

    mutating func updateItems(items: [Item]?) {
        self.items = items
    }

    mutating func appendItems(items: [Item]?) {
        guard let items = items else { return }
        self.items?.append(contentsOf: items)
    }
}

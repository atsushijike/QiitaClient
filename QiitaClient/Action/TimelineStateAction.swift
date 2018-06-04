//
//  TimelineStateAction.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/04/10.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import Foundation
import ReSwift

extension TimelineState {
    struct TimelineRefreshAction: Action {
        let isRefresh: Bool
        let pageNumber: Int
    }

    struct TimelineResultAction: Action {
        let articles: [Article]
    }
}

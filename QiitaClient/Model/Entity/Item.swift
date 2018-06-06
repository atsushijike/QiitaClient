//
//  Item.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/04/10.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import Foundation

struct Item: Codable {
    /* HTML形式の本文
     * Example: "<h1>Example</h1>" */
    let renderedBody: String
    /* Markdown形式の本文
     * Example: "# Example" */
    let body: String
    /* この投稿が共同更新状態かどうか (Qiita:Teamでのみ有効)
     * Example: false */
    let coediting: Bool
    /* この投稿へのコメントの数
     * Example: 100 */
    let commentsCount: Int
    /* データが作成された日時
     * Example: "2000-01-01T00:00:00+00:00"
     * Format: date-time */
    let createdAt: String
    /* Qiita:Teamのグループを表します。 */
    let group: Group?
    /* 投稿の一意なID
     * Example: "4bd431809afb1bb99e4f"
     * Pattern: /^[0-9a-f]{20}$/ */
    let id: String
    /* この投稿への「いいね！」の数（Qiitaでのみ有効）
     * Example: 100 */
    let likesCount: Int
    /* 限定共有状態かどうかを表すフラグ (Qiita:Teamでは無効)
     * Example: false */
    let `private`: Bool
    /* 絵文字リアクションの数（Qiita:Teamでのみ有効）
     * Example: 100 */
    let reactionsCount: Int
    /* 投稿に付いたタグ一覧
     * Example: [{"name"=>"Ruby", "versions"=>["0.0.1"]}] */
    let tags: [Tag]
    /* 投稿のタイトル
     * Example: "Example title" */
    let title: String
    /* データが最後に更新された日時
     * Example: "2000-01-01T00:00:00+00:00"
     * Format: date-time */
    let updatedAt: String
    /* 投稿のURL
     * Example: "https://qiita.com/yaotti/items/4bd431809afb1bb99e4f" */
    let url: String
    /* Qiita上のユーザを表します。 */
    let user: User
    /* 閲覧数
     * Example: 100 */
    let pageViewsCount: Int?
}

struct Group: Codable {
    /* Example: "2000-01-01T00:00:00+00:00"
     * Format: date-time */
    let createdAt: String
    /* Example: 1 */
    let id: Int
    /* Example: "Dev" */
    let name: String
    /* Example: false */
    let `private`: Bool
    /* Example: "2000-01-01T00:00:00+00:00"
     * Format: date-time */
    let updatedAt: String
    /* Example: "dev" */
    let urlName: String
}

struct Tag: Codable {
    /* タグを特定するための一意な名前
     * Example: "qiita" */
    let name: String
    /* Example: ["0.0.1"] */
    let versions: [String]
}

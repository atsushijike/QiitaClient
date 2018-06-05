//
//  Article.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/04/10.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import Foundation

struct Article: Codable {
    /* HTML形式の本文
     * Example: "<h1>Example</h1>" */
    let rendered_body: String
    /* Markdown形式の本文
     * Example: "# Example" */
    let body: String
    /* この投稿が共同更新状態かどうか (Qiita:Teamでのみ有効)
     * Example: false */
    let coediting: Bool
    /* この投稿へのコメントの数
     * Example: 100 */
    let comments_count: Int
    /* データが作成された日時
     * Example: "2000-01-01T00:00:00+00:00"
     * Format: date-time */
    let created_at: String
    /* Qiita:Teamのグループを表します。 */
    let group: Group?
    /* 投稿の一意なID
     * Example: "4bd431809afb1bb99e4f"
     * Pattern: /^[0-9a-f]{20}$/ */
    let id: String
    /* この投稿への「いいね！」の数（Qiitaでのみ有効）
     * Example: 100 */
    let likes_count: Int
    /* 限定共有状態かどうかを表すフラグ (Qiita:Teamでは無効)
     * Example: false */
    let `private`: Bool
    /* 絵文字リアクションの数（Qiita:Teamでのみ有効）
     * Example: 100 */
    let reactions_count: Int
    /* 投稿に付いたタグ一覧
     * Example: [{"name"=>"Ruby", "versions"=>["0.0.1"]}] */
    let tags: [Tag]
    /* 投稿のタイトル
     * Example: "Example title" */
    let title: String
    /* データが最後に更新された日時
     * Example: "2000-01-01T00:00:00+00:00"
     * Format: date-time */
    let updated_at: String
    /* 投稿のURL
     * Example: "https://qiita.com/yaotti/items/4bd431809afb1bb99e4f" */
    let url: String
    /* Qiita上のユーザを表します。 */
    let user: User
    /* 閲覧数
     * Example: 100 */
    let page_views_count: Int?
}

struct Group: Codable {
    /* Example: "2000-01-01T00:00:00+00:00"
     * Format: date-time */
    let created_at: String
    /* Example: 1 */
    let id: Int
    /* Example: "Dev" */
    let name: String
    /* Example: false */
    let `private`: Bool
    /* Example: "2000-01-01T00:00:00+00:00"
     * Format: date-time */
    let updated_at: String
    /* Example: "dev" */
    let url_name: String
}

struct Tag: Codable {
    /* タグを特定するための一意な名前
     * Example: "qiita" */
    let name: String
    /* Example: ["0.0.1"] */
    let versions: [String]
}

struct User: Codable {
    /* 自己紹介文
     * Example: "Hello, world." */
    let description: String?
    /* Facebook ID
     * Example: "yaotti" */
    let facebook_id: String?
    /* このユーザがフォローしているユーザの数
     * Example: 100 */
    let followees_count: Int
    /* このユーザをフォローしているユーザの数
     * Example: 200 */
    let followers_count: Int
    /* GitHub ID
     * Example: "yaotti" */
    let github_login_name: String?
    /* ユーザID
     * Example: "yaotti" */
    let id: String
    /* このユーザが qiita.com 上で公開している投稿の数 (Qiita:Teamでの投稿数は含まれません)
     * Example: 300 */
    let items_count: Int
    /* LinkedIn ID
     * Example: "yaotti" */
    let linkedin_id: String?
    /* 居住地
     * Example: "Tokyo, Japan" */
    let location: String?
    /* 設定している名前
     * Example: "Hiroshige Umino" */
    let name: String?
    /* 所属している組織
     * Example: "Increments Inc" */
    let organization: String?
    /* ユーザごとに割り当てられる整数のID
     * Example: 1 */
    let permanent_id: Int
    /* 設定しているプロフィール画像のURL
     * Example: "https://si0.twimg.com/profile_images/2309761038/1ijg13pfs0dg84sk2y0h_normal.jpeg" */
    let profile_image_url: String
    /* Twitterのスクリーンネーム
     * Example: "yaotti" */
    let twitter_screen_name: String?
    /* 設定しているWebサイトのURL
     * Example: "http://yaotti.hatenablog.com" */
    let website_url: String?
}

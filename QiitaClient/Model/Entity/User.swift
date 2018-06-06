//
//  User.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/06/06.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import Foundation

struct User: Codable {
    /* 自己紹介文
     * Example: "Hello, world." */
    let description: String?
    /* Facebook ID
     * Example: "yaotti" */
    let facebookId: String?
    /* このユーザがフォローしているユーザの数
     * Example: 100 */
    let followeesCount: Int
    /* このユーザをフォローしているユーザの数
     * Example: 200 */
    let followersCount: Int
    /* GitHub ID
     * Example: "yaotti" */
    let githubLoginName: String?
    /* ユーザID
     * Example: "yaotti" */
    let id: String
    /* このユーザが qiita.com 上で公開している投稿の数 (Qiita:Teamでの投稿数は含まれません)
     * Example: 300 */
    let itemsCount: Int
    /* LinkedIn ID
     * Example: "yaotti" */
    let linkedinId: String?
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
    let permanentId: Int
    /* 設定しているプロフィール画像のURL
     * Example: "https://si0.twimg.com/profile_images/2309761038/1ijg13pfs0dg84sk2y0h_normal.jpeg" */
    let profileImageUrl: String
    /* Twitterのスクリーンネーム
     * Example: "yaotti" */
    let twitterScreenName: String?
    /* 設定しているWebサイトのURL
     * Example: "http://yaotti.hatenablog.com" */
    let websiteUrl: String?
}

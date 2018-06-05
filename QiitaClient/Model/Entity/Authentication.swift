//
//  Authentication.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/06/05.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import Foundation

struct Authentication: Codable {
    /* 登録されたAPIクライアントを特定するためのID
     * Example: "a91f0396a0968ff593eafdd194e3d17d32c41b1da7b25e873b42e9058058cd9d"
     * Pattern: /^[0-9a-f]{40}$/ */
    let clientId: String?
    /* アクセストークンに許された操作の一覧 */
    let scopes: [String]?
    /* アクセストークンを表現する文字列
     * Example: "ea5d0a593b2655e9568f144fb1826342292f5c6b7d406fda00577b8d1530d8a5"
     * Pattern: /^[0-9a-f]{40}$/ */
    let token: String
}

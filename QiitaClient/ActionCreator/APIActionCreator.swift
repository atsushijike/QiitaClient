//
//  APIActionCreator.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/06/01.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import Foundation
import ReSwift
import Alamofire

struct APIActionCreator {
    // API client
    static func send(urlRequest: URLRequest, responseHandler: @escaping ([Article]?) -> Void) -> Store<AppState>.ActionCreator {
        return { (state, store) in
            Alamofire.request(urlRequest).response { (response) in
                guard let data = response.data else {
                    responseHandler(nil)
                    return
                }

                let articles = try! JSONDecoder().decode(Array<Article>.self, from: data)
                responseHandler(articles)
            }
            return nil
        }
    }
}

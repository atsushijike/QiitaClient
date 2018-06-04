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

public typealias HTTPMethod = Alamofire.HTTPMethod

struct APIActionCreator {
    private static let manager = SessionManager(configuration: {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.shouldUseExtendedBackgroundIdleMode = true
        return configuration
    }())

    // API client
    static func send(request: Request, responseHandler: @escaping ([Article]?) -> Void) -> Store<AppState>.ActionCreator {
        return { (state, store) in
            let url = request.baseURL.appendingPathComponent(request.version).appendingPathComponent(request.path)
            manager.request(url,
                            method: request.method,
                            parameters: request.parameters,
                            encoding: URLEncoding.default,
                            headers: request.headers).response { (response) in
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

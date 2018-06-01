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
    static func send(urlRequest: URLRequest, responseHandler: @escaping () -> Void) -> Store<AppState>.ActionCreator {
        return { (state, store) in
            Alamofire.request(urlRequest).responseJSON { (response) in
                responseHandler()
            }
            return nil
        }
    }
}

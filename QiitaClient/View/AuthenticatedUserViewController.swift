//
//  AuthenticatedUserViewController.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/06/06.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import Foundation
import ReSwift

class AuthenticatedUserViewController: UserViewController {
    var authenticatedUserState = store.state.authenticatedUser

    init() {
        super.init(user: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        store.unsubscribe(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshAuthenticatedUser()
    }

    private func refreshAuthenticatedUser() {
        if store.state.authentication.accessToken.isEmpty {
            return
        }

        let actionCreator = APIActionCreator.send(request: AuthenticatedUserRequest()) { (data) in
            if data != nil {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try! jsonDecoder.decode(User.self, from: data!)
                let resultAction = AuthenticatedUserState.AuthenticatedUserUserAction(user: user)
                store.dispatch(resultAction)
            }
        }
        store.dispatch(actionCreator)
    }

    override func newState(state: AppState) {
        authenticatedUserState = state.authenticatedUser
        user = authenticatedUserState.user
        updateHeaderView()
        refreshData()
    }
}

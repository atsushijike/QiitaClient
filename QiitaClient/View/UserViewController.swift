//
//  UserViewController.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/06/06.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import UIKit
import ReSwift

class UserViewController: UIViewController {
    var authenticatedUserState = store.state.authenticatedUser

    deinit {
        store.unsubscribe(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.tabBarItem.title = title
        navigationController?.tabBarItem.image = #imageLiteral(resourceName: "first")
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshBarButtonAction))
        store.subscribe(self)
        refreshData()
    }

    @objc private func refreshBarButtonAction() {
        refreshData()
    }

    private func refreshData() {
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
}

extension UserViewController: StoreSubscriber {
    func newState(state: AppState) {
        authenticatedUserState = state.authenticatedUser
    }
}

//
//  NewItemsViewController.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/04/10.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import UIKit
import ReSwift

private func defaultCellIdentifier<T: NSObject>(_ clazz: T.Type) -> String {
    return String(describing: clazz)
}

class NewItemsViewController: UITableViewController {
    var newItemsState = store.state.newItems

    deinit {
        store.unsubscribe(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = newItemsState.title
        navigationController?.tabBarItem.title = title
        navigationController?.tabBarItem.image = #imageLiteral(resourceName: "first")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(loginBarButtonAction))
        tableView.register(NewItemsTableViewCell.self, forCellReuseIdentifier: "default")
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshBarButtonAction), for: .valueChanged)
        store.subscribe(self)
        refreshData()
    }

    @objc private func refreshBarButtonAction() {
        refreshData()
    }

    @objc private func loginBarButtonAction() {
        let authenticationViewController = AuthenticationViewController()
        let nc = UINavigationController(rootViewController: authenticationViewController)
        navigationController?.present(nc, animated: true, completion: nil)
    }

    private func refreshData() {
        let refreshStartAction = NewItemsState.NewItemsRefreshAction(isRefresh: true)
        store.dispatch(refreshStartAction)

        let actionCreator = APIActionCreator.send(request: NewItemsRequest(page: newItemsState.pageNumber, perPage: 20)) { [weak self] (data) in
            let refreshEndAction = NewItemsState.NewItemsRefreshAction(isRefresh: false)
            store.dispatch(refreshEndAction)
            let pageNumber = self?.newItemsState.pageNumber ?? 1
            let pageNumberAction = NewItemsState.NewItemsPageNumberAction(pageNumber: pageNumber)
            store.dispatch(pageNumberAction)

            if data != nil {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let items = try! jsonDecoder.decode(Array<Item>.self, from: data!)
                let resultAction = NewItemsState.NewItemsItemsAction(items: items)
                store.dispatch(resultAction)
                self?.refreshControl?.endRefreshing()
            }
        }
        store.dispatch(actionCreator)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newItemsState.items?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)
        if let item = newItemsState.items?[indexPath.row] {
            cell.textLabel?.text = item.title
        }
        return cell
    }
}

extension NewItemsViewController: StoreSubscriber {
    func newState(state: AppState) {
        newItemsState = state.newItems
        tableView.reloadData()
    }
}

private class NewItemsTableViewCell: UITableViewCell {
    
}

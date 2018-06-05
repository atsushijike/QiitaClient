//
//  NewArticlesViewController.swift
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

class NewArticlesViewController: UITableViewController {
    var newArticlesState = store.state.newArticles

    deinit {
        store.unsubscribe(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = newArticlesState.title
        tabBarItem.title = title
        tabBarItem.image = #imageLiteral(resourceName: "first")
        tableView.register(NewArticlesTableViewCell.self, forCellReuseIdentifier: "default")
        store.subscribe(self)
        refreshData()
    }

    func refreshData() {
        let refreshStartAction = NewArticlesState.NewArticlesRefreshAction(isRefresh: true, pageNumber: 1)
        store.dispatch(refreshStartAction)

        let actionCreator = APIActionCreator.send(request: NewArticlesRequest(page: newArticlesState.pageNumber, perPage: 20)) { (articles) in
            let pageNumber = self.newArticlesState.pageNumber
            let refreshEndAction = NewArticlesState.NewArticlesRefreshAction(isRefresh: false, pageNumber: pageNumber)
            store.dispatch(refreshEndAction)
            if let articles = articles {
                let resultAction = NewArticlesState.NewArticlesResultAction(articles: articles)
                store.dispatch(resultAction)
            }
        }
        store.dispatch(actionCreator)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newArticlesState.articles?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)
        if let article = newArticlesState.articles?[indexPath.row] {
            cell.textLabel?.text = article.title
        }
        return cell
    }
}

extension NewArticlesViewController: StoreSubscriber {
    func newState(state: AppState) {
         newArticlesState = state.newArticles
        tableView.reloadData()
    }
}

class NewArticlesTableViewCell: UITableViewCell {
    
}

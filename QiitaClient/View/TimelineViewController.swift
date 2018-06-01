//
//  TimelineViewController.swift
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

class TimelineViewController: UITableViewController {
    let timelineState = store.state.timeline

    deinit {
        store.unsubscribe(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = timelineState.title
        tabBarItem.title = title
        tabBarItem.image = #imageLiteral(resourceName: "first")
        tableView.register(TimelineTableViewCell.self, forCellReuseIdentifier: "default")
        store.subscribe(self)
        refreshData()
    }

    func refreshData() {
        let refreshStartAction = TimelineState.TimelineRefreshAction(isRefresh: true, pageNumber: 1)
        store.dispatch(refreshStartAction)

        let urlRequest = URLRequest(url: URL(string: "https://www.apple.com/")!)
        let actionCreator = APIActionCreator.send(urlRequest: urlRequest) {
            let pageNumber = self.timelineState.pageNumber
            let refreshEndAction = TimelineState.TimelineRefreshAction(isRefresh: false, pageNumber: pageNumber)
            store.dispatch(refreshEndAction)
        }
        store.dispatch(actionCreator)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)
        return cell
    }
}

extension TimelineViewController: StoreSubscriber {
    func newState(state: AppState) {
        tableView.reloadData()
    }
}

class TimelineTableViewCell: UITableViewCell {
    
}

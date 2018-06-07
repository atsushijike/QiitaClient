//
//  AuthenticatedUserViewController.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/06/06.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import UIKit
import ReSwift
import AlamofireImage
import Hydra

class AuthenticatedUserViewController: UITableViewController {
    var authenticatedUserState = store.state.authenticatedUser
    private let headerView = UserHeaderView(frame: .zero)
    
    deinit {
        store.unsubscribe(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.tabBarItem.title = title
        navigationController?.tabBarItem.image = #imageLiteral(resourceName: "first")
        tableView.register(AuthenticatedUserTableViewCell.self, forCellReuseIdentifier: "default")
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshBarButtonAction), for: .valueChanged)
        headerView.segmentedControl.addTarget(self, action: #selector(headerViewSegmentedControlAction), for: .touchDown)
        store.subscribe(self)
        refreshData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if tableView.tableHeaderView == nil {
            headerView.frame.size = CGSize(width: view.bounds.width, height: 444)
            tableView.tableHeaderView = headerView
        }
    }

    @objc private func refreshBarButtonAction() {
        refreshData()
    }

    @objc private func headerViewSegmentedControlAction(sender: Any) {
        
    }

    func refreshData() {
        refreshAuthenticatedUser()
    }

    private func refreshAuthenticatedUser() {
        if store.state.authentication.accessToken.isEmpty {
            return
        }

        func fetchUser() -> Promise<String> {
            return Promise<String>(in: .background, { (resolve, reject, operation) in
                let actionCreator = APIActionCreator.send(request: AuthenticatedUserRequest()) { (data) in
                    if data != nil {
                        let jsonDecoder = JSONDecoder()
                        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                        let user = try! jsonDecoder.decode(User.self, from: data!)
                        let resultAction = AuthenticatedUserState.AuthenticatedUserUserAction(user: user)
                        store.dispatch(resultAction)
                        resolve(user.id)
                    }
                }
                store.dispatch(actionCreator)
            })
        }
        
        func fetchItems(userId: String) -> Promise<Any> {
            return Promise<Any>(in: .background, { (resolve, reject, operation) in
                let actionCreator = APIActionCreator.send(request: UserItemsRequest(userId: userId, page: self.authenticatedUserState.pageNumber, perPage: 20)) { [weak self] (data) in
                    let pageNumber = self?.authenticatedUserState.pageNumber ?? 1
                    let pageNumberAction = AuthenticatedUserState.AuthenticatedUserPageNumberAction(pageNumber: pageNumber)
                    store.dispatch(pageNumberAction)
                    
                    if data != nil {
                        let jsonDecoder = JSONDecoder()
                        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                        let items = try! jsonDecoder.decode(Array<Item>.self, from: data!)
                        let itemsAction = AuthenticatedUserState.AuthenticatedUserItemsAction(items: items)
                        store.dispatch(itemsAction)
                        resolve(items)
                    }
                }
                store.dispatch(actionCreator)
            })
        }

        fetchUser().then(fetchItems).then { [weak self] (items) in
            self?.updateHeaderView()
            self?.tableView.reloadData()
            self?.refreshControl?.endRefreshing()
        }
    }

    func updateHeaderView() {
        guard let user = authenticatedUserState.user else { return }

        title = user.name
        headerView.imageView.setImage(with: user.profileImageUrl)
        headerView.nameLabel.text = user.name
        headerView.idLabel.text = user.id
        headerView.organizationLabel.text = user.organization
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return authenticatedUserState.items?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)
        if let item = authenticatedUserState.items?[indexPath.row] {
            cell.textLabel?.text = item.title
        }
        return cell
    }
}

extension AuthenticatedUserViewController: StoreSubscriber {
    func newState(state: AppState) {
        authenticatedUserState = state.authenticatedUser
    }
}

private class UserHeaderView: UIView {
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let idLabel = UILabel()
    let organizationLabel = UILabel()
    let segmentedControl = UISegmentedControl(items: ["Items", "Followees"])
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        nameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        nameLabel.textAlignment = .center
        addSubview(nameLabel)
        idLabel.font = UIFont.systemFont(ofSize: 17)
        idLabel.textColor = .gray
        idLabel.textAlignment = .center
        addSubview(idLabel)
        organizationLabel.font = UIFont.systemFont(ofSize: 14)
        organizationLabel.textAlignment = .center
        addSubview(organizationLabel)
        segmentedControl.selectedSegmentIndex = 0
        addSubview(segmentedControl)
        
        imageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(300)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(12)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(10)
        }
        idLabel.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
        }
        organizationLabel.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.top.equalTo(idLabel.snp.bottom).offset(8)
        }
        segmentedControl.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(40)
            make.top.equalTo(organizationLabel.snp.bottom).offset(12)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class AuthenticatedUserTableViewCell: UITableViewCell {
    
}

extension UIImageView {
    func setImage(with urlString: String?) {
        if let urlString = urlString, let url = URL(string: urlString) {
            af_setImage(withURL: url)
        }
    }
}

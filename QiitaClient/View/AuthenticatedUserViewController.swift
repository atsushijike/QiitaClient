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
    enum ListType: Int {
        case items = 0, followees = 1
    }
    var authenticatedUserState = store.state.authenticatedUser
    private let headerView = UserHeaderView(frame: .zero)
    var listType: ListType = .items {
        didSet { tableView.reloadData() }
    }
    
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
        headerView.segmentedControl.addTarget(self, action: #selector(headerViewSegmentedControlAction), for: .valueChanged)
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
        guard let type = ListType(rawValue: headerView.segmentedControl.selectedSegmentIndex) else { return }
        listType = type
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

        func fetchItems(userId: String) -> Promise<String> {
            return Promise<String>(in: .background, { (resolve, reject, operation) in
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
                        resolve(userId)
                    }
                }
                store.dispatch(actionCreator)
            })
        }

        func fetchFollowees(userId: String) -> Promise<String> {
            return Promise<String>(in: .background, { (resolve, reject, operation) in
                let actionCreator = APIActionCreator.send(request: UserFolloweesRequest(userId: userId, page: self.authenticatedUserState.pageNumber, perPage: 20)) { [weak self] (data) in
                    let pageNumber = self?.authenticatedUserState.pageNumber ?? 1
                    let pageNumberAction = AuthenticatedUserState.AuthenticatedUserPageNumberAction(pageNumber: pageNumber)
                    store.dispatch(pageNumberAction)
                    
                    if data != nil {
                        let jsonDecoder = JSONDecoder()
                        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                        let followees = try! jsonDecoder.decode(Array<User>.self, from: data!)
                        let followeesAction = AuthenticatedUserState.AuthenticatedUserFolloweesAction(followees: followees)
                        store.dispatch(followeesAction)
                        resolve(userId)
                    }
                }
                store.dispatch(actionCreator)
            })
        }

        fetchUser().then(fetchItems).then(fetchFollowees).then { [weak self] (userId) in
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
        switch listType {
        case .items:
            return authenticatedUserState.items?.count ?? 0
        case .followees:
            return authenticatedUserState.followees?.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)
        switch listType {
        case .items:
            cell.textLabel?.text = authenticatedUserState.items?[indexPath.row].title
        case .followees:
            cell.textLabel?.text = authenticatedUserState.followees?[indexPath.row].name
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

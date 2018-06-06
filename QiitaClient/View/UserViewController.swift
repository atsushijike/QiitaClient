//
//  UserViewController.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/06/06.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import UIKit
import ReSwift
import AlamofireImage

class UserViewController: UITableViewController, StoreSubscriber {
    var user: User?
    private let headerView = UserHeaderView(frame: .zero)

    init(user: User?) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        store.unsubscribe(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.tabBarItem.title = title
        navigationController?.tabBarItem.image = #imageLiteral(resourceName: "first")
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshBarButtonAction))
        tableView.register(AuthenticatedUserTableViewCell.self, forCellReuseIdentifier: "default")
        store.subscribe(self)
        refreshData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if tableView.tableHeaderView == nil {
            headerView.frame.size = CGSize(width: view.bounds.width, height: 300)
            tableView.tableHeaderView = headerView
        }
    }

    @objc private func refreshBarButtonAction() {
        refreshData()
    }

    func refreshData() {
        guard let user = user else { return }
    }

    func updateHeaderView() {
        guard let user = user else { return }

        headerView.imageView.setImage(with: user.profileImageUrl)
        headerView.nameLabel.text = user.name
        headerView.idLabel.text = user.id
        headerView.organizationLabel.text = user.organization
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

    func newState(state: AppState) {
        updateHeaderView()
        tableView.reloadData()
    }
}

private class UserHeaderView: UIView {
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let idLabel = UILabel()
    let organizationLabel = UILabel()

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

        imageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(400)
            make.center.equalToSuperview()
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

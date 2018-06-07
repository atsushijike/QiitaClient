//
//  ItemViewController.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/06/07.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class ItemViewController: UIViewController {
    let item: Item
    let webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())

    init(item: Item) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = item.title
        view.addSubview(webView)

        webView.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
        }

        if let url = URL(string: item.url) {
            webView.load(URLRequest(url: url))
        }
    }
}

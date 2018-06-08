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
import Down

class ItemViewController: UIViewController, WKNavigationDelegate {
    let item: Item
    var downView: DownView?

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
        if let downView = try? DownView(frame: self.view.bounds, markdownString: item.body) {
            self.downView = downView
            view.addSubview(downView)

            downView.snp.makeConstraints { (make) in
                make.size.equalToSuperview()
            }
        }
    }
}

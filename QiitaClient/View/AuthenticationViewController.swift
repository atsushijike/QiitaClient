//
//  AuthenticationViewController.swift
//  QiitaClient
//
//  Created by 寺家 篤史 on 2018/06/05.
//  Copyright © 2018年 Yumemi Inc. All rights reserved.
//

import UIKit
import ReSwift
import WebKit
import SnapKit

class AuthenticationViewController: UIViewController, WKNavigationDelegate {
    var authenticationState = store.state.authentication
    let webView = WKWebView(frame: .zero, configuration: WKWebViewConfiguration())
    let clientId = "110f5a9aabd17aaea26cfa6a7855e02e369e154b"
    let clientSecret = "4cfeedb1b1781118b029a201b8ec75c7bb2a27d1"
    let stateId = UUID().uuidString

    deinit {
        store.unsubscribe(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Login"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(closeButtonAction))
        webView.navigationDelegate = self
        view.addSubview(webView)

        webView.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
        }

        let request = AuthoriseRequest(clientId: clientId, stateId:  stateId)
        webView.load(request.urlRequest)
        store.subscribe(self)
    }

    @objc private func closeButtonAction() {
        navigationController?.dismiss(animated: true, completion: nil)
    }

    // WKNavigationDelegate
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url, url.scheme == "qiitaclient" {
            let response = AuthoriseResponse(url: url)
            if response.state == stateId {
                let code = response.code
                let codeAction = AuthenticationState.AuthenticationCodeAction(code: code)
                store.dispatch(codeAction)
                
                let request = AccessTokenRequest(clientId: clientId, clientSecret: clientSecret, code: code)
                let actionCreator = APIActionCreator.send(request: request) { [weak self] (data) in
                    if data != nil {
                        let jsonDecoder = JSONDecoder()
                        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                        let authentication = try! jsonDecoder.decode(Authentication.self, from: data!)
                        let accessTokenAction = AuthenticationState.AuthenticationAccessTokenAction(accessToken: authentication.token)
                        store.dispatch(accessTokenAction)

                        self?.navigationController?.dismiss(animated: true, completion: nil)
                    }
                }
                store.dispatch(actionCreator)
            }
            
            decisionHandler(.cancel)
        } else {
            decisionHandler(.allow)
        }
    }
}

extension AuthenticationViewController: StoreSubscriber {
    func newState(state: AppState) {
        authenticationState = state.authentication
    }
}

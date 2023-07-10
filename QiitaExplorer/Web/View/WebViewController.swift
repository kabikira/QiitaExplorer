//
//  WebViewController.swift
//  QiitaExplorer
//
//  Created by koala panda on 2023/07/06.
//

import UIKit
import WebKit

final class WebViewController: UIViewController {
    private var presenter: WebPresenterInput!

    @IBOutlet private weak var webView: WKWebView!

    func inject(presenter: WebPresenterInput) {
        self.presenter = presenter
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidFinishLoading()
    }
}

extension WebViewController: WebPresenterOutput {
    func load(request: URLRequest) {
        self.webView.load(request)
    }
}

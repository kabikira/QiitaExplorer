//
//  WebPresenter.swift
//  QiitaExplorer
//
//  Created by koala panda on 2023/07/06.
//

import Foundation

protocol WebPresenterInput {
    func viewDidFinishLoading()
}

protocol WebPresenterOutput: AnyObject {
    func load(request: URLRequest)
}

final class WebPresenter {
    private weak var output: WebPresenterOutput!
    private var qiitaModel: QiitaModel

    init(output: WebPresenterOutput!, qiitaModel: QiitaModel) {
        self.output = output
        self.qiitaModel = qiitaModel
    }
}

extension WebPresenter: WebPresenterInput {
    func viewDidFinishLoading() {
        let url = qiitaModel.url
        self.output.load(request: URLRequest(url: url))
    }
}

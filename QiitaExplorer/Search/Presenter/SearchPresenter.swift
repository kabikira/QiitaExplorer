//
//  SearchPresenter.swift
//  QiitaExplorer
//
//  Created by koala panda on 2023/07/01.
//

import Foundation

protocol QiitaSearchPresenterInput {
    var numberOfItems: Int { get }
    func qiitaItem(index: Int) -> QiitaModel?
    func searchText(_ text: String?)
    func didSelect(index: Int)

}

protocol QiitaSearchPresenterOutput: AnyObject {
    func showLoadingIndicator(loading: Bool)
    func updateModel(qiitaModels: [QiitaModel])
    func get(error: Error)
    func showWeb(qiitaModel: QiitaModel)
}

final class QiitaSearchPresenter {
    private weak var output: QiitaSearchPresenterOutput!
    private var client: QiitaClient
    private var imageDownloader: ImageDownloaderProtocol!
    private var qiitaModels: [QiitaModel]

    init (output: QiitaSearchPresenterOutput, client:QiitaClient = QiitaClient(httpClient: URLSession.shared), imageDownloader: ImageDownloaderProtocol = ImageDownloader.shared) {
        self.output = output
        self.client = client
        self.imageDownloader = imageDownloader
        self.qiitaModels = []
    }
}

extension QiitaSearchPresenter: QiitaSearchPresenterInput {
    var numberOfItems: Int { qiitaModels.count }
    func qiitaItem(index: Int) -> QiitaModel? { qiitaModels[index] }
    func didSelect(index: Int) {
        output.showWeb(qiitaModel: qiitaModels[index])
    }
    func searchText(_ text: String?) {
        guard let text = text else {return}
        output.showLoadingIndicator(loading: true)
        let request = QiitaAPI.GetArticles(keyword: text)
        client.send(request: request) { [weak self] result in
            DispatchQueue.main.async {
                self?.output.showLoadingIndicator(loading: false)
                switch result {
                case .failure(let error):
                    self?.output.get(error: error)
                case .success(let items):
                    self?.qiitaModels = items
                    self?.output.updateModel(qiitaModels: items)
                }
            }
        }
    }
}

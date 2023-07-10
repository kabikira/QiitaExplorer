//
//  QiitaClient.swift
//  QiitaExplorer
//
//  Created by koala panda on 2023/07/01.
//

import Foundation

final class QiitaClient {
    private let httpClient: HTTPClient
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    func send<Request: QiitaRequest>(
        request: Request,
        completion: @escaping (Result<Request.Response, QiitaClientError>) -> Void)
    {
        let urlRequest = request.buildURLRequest()
        httpClient.sendRequest(urlRequest) { result in
            switch result {
            case .success((let data , let urlResponse)):
                do {
                    let response = try request.response(from: data, urlResponse: urlResponse)
                    completion(.success(response))
                } catch {
                    completion(.failure(.responseParseError(error)))
                }
            case .failure(let error):
                completion(.failure(.connectionError(error)))
            }
        }
    }
}


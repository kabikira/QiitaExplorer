//
//  HTTPClient.swift
//  QiitaExplorer
//
//  Created by koala panda on 2023/07/01.
//

import Foundation

protocol HTTPClient {
    func sendRequest( _ urlRequest: URLRequest, completion: @escaping(Result<(Data, HTTPURLResponse), Error>) -> Void)
}

extension URLSession: HTTPClient {
    func sendRequest(_ urlRequest: URLRequest, completion: @escaping (Result<(Data, HTTPURLResponse), Error>) -> Void) {
        let task = dataTask(with: urlRequest) { data, urlResponse, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data, let urlResponse = urlResponse as? HTTPURLResponse else {
                fatalError("invalid response combination \(String(describing: (data, urlRequest, error))).")
            }
            completion(.success((data, urlResponse)))
        }
        task.resume()
    }
}


//
//  QiitaRequest.swift
//  QiitaExplorer
//
//  Created by koala panda on 2023/07/01.
//

import Foundation

protocol QiitaRequest {
    associatedtype Response: Decodable
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem] { get }
}

extension QiitaRequest {
    var baseURL: URL {
        return URL(string: "https://qiita.com")!
    }
    func buildURLRequest() -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)

        switch method {
            // .get以外のHTTPメソッドは考慮しない
        case .get:
            components?.queryItems = queryItems
        default:
            fatalError("Unsupprted method \(method)")
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.url = components?.url
        urlRequest.httpMethod = method.rawValue

        // タイムアウトを60秒に設定
        urlRequest.timeoutInterval = 60

        return urlRequest
    }

    func response(from data: Data, urlResponse: HTTPURLResponse) throws -> Response {
        let decoder = JSONDecoder()
        if (200..<300).contains(urlResponse.statusCode) {
            return try decoder.decode(Response.self, from: data)
        } else {
            throw try decoder.decode(QiitaAPIError.self, from: data)
        }
    }
}

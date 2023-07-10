//
//  QiitaAPI.swift
//  QiitaExplorer
//
//  Created by koala panda on 2023/07/01.
//

import Foundation
final class QiitaAPI {
    struct GetArticles: QiitaRequest {
        let keyword: String
        init(keyword: String) {
            self.keyword = keyword
        }
        // このリクエストのレスポンスは配列を返すので[QiitaModel]
        typealias Response = [QiitaModel]
        var path: String {
            return "/api/v2/items"
        }
        var method: HTTPMethod {
            return .get
        }
        var queryItems: [URLQueryItem] {
            return [URLQueryItem(name: "query", value: keyword),
                    URLQueryItem(name: "page", value: "1"),
                    URLQueryItem(name: "per_page", value: "20")
            ]
        }
    }
    // TODO　タグで検索も追加

}

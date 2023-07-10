//
//  QiitaModel.swift
//  QiitaExplorer
//
//  Created by koala panda on 2023/06/30.
//

import Foundation

struct QiitaModel: Codable {
    let title: String
    let url: URL
    let user: User

    enum CodingKeys: String, CodingKey {
        case title
        case url
        case user
    }
}

struct User: Codable {
    let profileImageURL: URL

    enum CodingKeys: String, CodingKey {
        case profileImageURL = "profile_image_url"
    }
}

struct QiitaResponse: Codable {
    var items: [QiitaModel]?
}

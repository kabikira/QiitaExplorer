//
//  QiitaAPIError.swift
//  QiitaExplorer
//
//  Created by koala panda on 2023/06/30.
//

import Foundation
struct QiitaAPIError: Decodable, Error {
    var massage: String
    var type : String
}

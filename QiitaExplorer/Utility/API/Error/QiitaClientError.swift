//
//  QiitaClientError.swift
//  QiitaExplorer
//
//  Created by koala panda on 2023/06/30.
//

import Foundation

enum QiitaClientError: Error {

    case connectionError(Error)

    case responseParseError(Error)

    case apiError(QiitaAPIError)
}

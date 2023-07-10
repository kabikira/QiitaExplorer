//
//  ImageDownloader.swift
//  QiitaExplorer
//
//  Created by koala panda on 2023/07/09.
//

import UIKit

enum ImageDownloaderError: Error {
    case networkError(Error)
    case imageDataCreationFailed
}

protocol ImageDownloaderProtocol {
    func downloadImage(from url: URL, completion: @escaping (Result<UIImage, ImageDownloaderError>) -> Void)
}

final class ImageDownloader: ImageDownloaderProtocol {

    static let shared = ImageDownloader()
    private init() {}

    func downloadImage(from url: URL, completion: @escaping (Result<UIImage, ImageDownloaderError>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            guard let data = data,
                  let image = UIImage(data: data) else {
                return
            }
            completion(.success(image))
        }
        task.resume()
    }


}

//
//  QiitaTableViewCell.swift
//  QiitaExplorer
//
//  Created by koala panda on 2023/07/04.
//

import UIKit

final class QiitaTableViewCell: UITableViewCell {
    static var className: String { String(describing: QiitaTableViewCell.self)}


    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
        self.iconImageView.image = nil
    }

    func configure(qiitaModel: QiitaModel) {
        self.titleLabel.text = qiitaModel.title
        let iconImageURL = qiitaModel.user.profileImageURL
        ImageDownloader.shared.downloadImage(from: iconImageURL) {[weak self] result in
            switch result {
            case .success(let imageDate):
                DispatchQueue.main.async {
                    self?.iconImageView.image = imageDate

                }
                case .failure(let error):
                print(error)
            }
        }
    }
}

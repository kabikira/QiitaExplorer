//
//  QiitaSearchViewController.swift
//  QiitaExplorer
//
//  Created by koala panda on 2023/07/05.
//

import UIKit

class QiitaSearchViewController: UIViewController {

    @IBOutlet private weak var searchButton: UIButton!

    @IBOutlet private weak var searchTextField: UITextField! {
        didSet {
            searchButton.addTarget(self, action: #selector(tapSearchBotton(_sender:)), for: .touchUpInside)
        }
    }
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib.init(nibName: QiitaTableViewCell.className, bundle: nil), forCellReuseIdentifier: QiitaTableViewCell.className)
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    private var presenter: QiitaSearchPresenter!
    func inject(presenter: QiitaSearchPresenter) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        indicator.isHidden = true
    }
    @objc func tapSearchBotton(_sender: UIResponder) {
        self.presenter.searchText(searchTextField.text)

    }
}

extension QiitaSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelect(index: indexPath.row)
    }
}

extension QiitaSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QiitaTableViewCell.className) as? QiitaTableViewCell else {
            fatalError()
        }
        let qiitaModel = presenter.qiitaItem(index: indexPath.row)!
        cell.configure(qiitaModel: qiitaModel)
        //ここで画像URLをわたして
        //cellのconfigureにもわたす
        return cell
    }
}

extension QiitaSearchViewController: QiitaSearchPresenterOutput {
    func showLoadingIndicator(loading: Bool) {
        DispatchQueue.main.async {
            self.tableView.isHidden = loading
            self.indicator.isHidden = !loading
        }
    }

    func updateModel(qiitaModels: [QiitaModel]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func get(error: Error) {
        DispatchQueue.main.async {
            print(error.localizedDescription)
        }
    }

    func showWeb(qiitaModel: QiitaModel) {
        DispatchQueue.main.async {
            Router.shared.shoWeb(from: self, qiitaModel: qiitaModel)
        }
    }
}

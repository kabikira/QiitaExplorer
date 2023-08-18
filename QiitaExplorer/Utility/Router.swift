//
//  Router.swift
//  QiitaExplorer
//
//  Created by koala panda on 2023/07/06.
//

import UIKit

protocol RouterProtocol {
    func showRoot(window: UIWindow)
    func showWeb(from: UIViewController, qiitaModel: QiitaModel)
}

final class Router: RouterProtocol {

    static let shared = Router()
    private init() {}

    private var window: UIWindow?

    func showRoot(window: UIWindow) {
        guard let vc = UIStoryboard.init(name: "QiitaSearch", bundle: nil).instantiateInitialViewController() as? QiitaSearchViewController else {
            return
        }
        let presenter = QiitaSearchPresenter(output: vc)
        vc.inject(presenter: presenter)

        let nav = UINavigationController(rootViewController: vc)
        window.rootViewController = nav
        window.makeKeyAndVisible()
        self.window = window
    }

    func showWeb(from: UIViewController, qiitaModel: QiitaModel) {
        guard let web = UIStoryboard.init(name: "Web", bundle: nil).instantiateInitialViewController() as? WebViewController else {
          return
        }
        let presenter = WebPresenter(output: web, qiitaModel: qiitaModel)
        web.inject(presenter: presenter)
        show(from: from, to: web)
    }
    private func show(from: UIViewController, to: UIViewController, completion:(() -> Void)? = nil){
      if let nav = from.navigationController {
        nav.pushViewController(to, animated: true)
        completion?()
      } else {
        from.present(to, animated: true, completion: completion)
      }
    }
}

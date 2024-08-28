//
//  ModuleBuilder.swift
//  iOS HW-22 Oksana Kazarinova
//
//  Created by Oksana Kazarinova on 24/08/2024.
//

import UIKit

protocol ModuleBuilder {
    static func createMainModule() -> UIViewController
    static func createDetailModule() -> UIViewController
}

class ModuleAssembler: ModuleBuilder {
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let user = User()
        let presenter = MainViewPresenterProtocol(view: view, user: user)
        view.mainPresenter = presenter
        return view
    }

    static func createDetailModule() -> UIViewController {
        let user = User()
        let view = DetailViewController()
        let presenter = DetailViewPresenterProtocol(view: view, user: user)
        view.detailPresenter = presenter
        return view
    }
}


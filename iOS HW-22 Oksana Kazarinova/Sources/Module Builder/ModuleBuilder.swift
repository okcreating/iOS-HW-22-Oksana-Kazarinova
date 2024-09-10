//
//  ModuleBuilder.swift
//  iOS HW-22 Oksana Kazarinova
//
//  Created by Oksana Kazarinova on 24/08/2024.
//

import UIKit

protocol ModuleBuilder {
    static func createMainModule() -> UIViewController
    static func createDetailModule(model: User) -> UIViewController
}

class ModuleAssembler: ModuleBuilder {
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let presenter = MainViewPresenter(view: view)
        view.mainPresenter = presenter
        return view
    }

    static func createDetailModule(model: User) -> UIViewController {
        let user = model
        user.name = model.name
        let view = DetailViewController()
        let presenter = DetailViewPresenter(view: view, user: model)
        view.detailPresenter = presenter
        return view
    }
}


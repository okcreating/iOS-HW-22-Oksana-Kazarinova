//
//  MainPresenter.swift
//  iOS HW-22 Oksana Kazarinova
//
//  Created by Oksana Kazarinova on 24/08/2024.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func setupHierarchy()
    func setupLayout()
    func setupNavigationBar()
}

protocol MainPresenterProtocol {
    init(view: MainViewProtocol, user: User)
    func addUserToCoreData()
    func configureTableView()
}

final class MainViewPresenterProtocol: MainPresenterProtocol {
    let view: MainViewProtocol
    let user: User
    init(view: any MainViewProtocol, user: User) {
        self.view = view
        self.user = user
    }

    func addUserToCoreData() {
        <#code#>
    }

    func configureTableView() {

    }
}

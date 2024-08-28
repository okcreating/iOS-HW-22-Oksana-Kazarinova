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
    func reloadTableView()
}

protocol MainPresenterProtocol {
    init(view: MainViewProtocol, user: User)
    func addUser(name: String)
    func countUsers() -> Int
    func getUserByIndex(at index: Int) -> User?
    func deleteUser(user: User)
    func fetchUsers()
}

final class MainViewPresenterProtocol: MainPresenterProtocol {

    let view: MainViewProtocol
    let user: User
    init(view: any MainViewProtocol, user: User) {
        self.view = view
        self.user = user
    }

    func addUser(name: String) {
        CoreDataManager.shared.addUser(name: name)
        view.reloadTableView()
    }

    func countUsers() -> Int {
        CoreDataManager.shared.allUsers?.count ?? 0
    }

    func getUserByIndex(at index: Int) -> User? {
        CoreDataManager.shared.allUsers?[index]
    }

    func deleteUser(user: User) {
        CoreDataManager.shared.deleteUser(user: user)
        view.reloadTableView()
    }

    func fetchUsers() {
        CoreDataManager.shared.fetchAllUsers()
        view.reloadTableView()
    }
}

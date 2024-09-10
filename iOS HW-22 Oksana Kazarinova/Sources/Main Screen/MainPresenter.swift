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
   // init(view: MainViewProtocol, user: User)
    func addUser(name: String, dateOfBirth: String?, gender: String?)
    func countUsers() -> Int
    func getUserByIndex(at index: Int) -> User?
    func deleteUser(user: User)
    func fetchUsers()
}

final class MainViewPresenter: MainPresenterProtocol {

    let view: MainViewProtocol
    init(view: any MainViewProtocol) {
        self.view = view
    }

    func addUser(name: String, dateOfBirth: String?, gender: String?) {
        CoreDataManager.shared.addUser(name: name, dateOfBirth: dateOfBirth, gender: gender)
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

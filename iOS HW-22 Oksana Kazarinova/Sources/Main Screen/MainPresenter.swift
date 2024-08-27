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
    func addUser()
    func countUsers() -> Int
    func getUserByIndex(at index: Int) -> User?
    func deleteUser(user: User)
}

final class MainViewPresenterProtocol: MainPresenterProtocol {

    
    let view: MainViewProtocol
    let user: User
    init(view: any MainViewProtocol, user: User) {
        self.view = view
        self.user = user
    }

    func addUser() {
        CoreDataManager.shared.addUser(name: <#T##String#>, dateOfBirth: ., gender: DetailViewController.GenderPickerOptions.man.rawValue )
    }

    func countUsers() -> Int {
        CoreDataManager.shared.allUsers?.count ?? 0
    }

    func getUserByIndex(at index: Int) -> User? {
        CoreDataManager.shared.allUsers?[index]
    }

    func deleteUser(user: User) {
        CoreDataManager.shared.deleteUser(user: user)
    }
}

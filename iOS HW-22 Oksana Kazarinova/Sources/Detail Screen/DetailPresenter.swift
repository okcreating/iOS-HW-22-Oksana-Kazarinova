//
//  DetailPresenter.swift
//  iOS HW-22 Oksana Kazarinova
//
//  Created by Oksana Kazarinova on 24/08/2024.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    var user: User? { get set }
    func setupHierarchy()
    func setupLayout()
    func setupNavigationBar()
}

protocol DetailPresenterProtocol {
    func setChosenUser()
    func updateUserInfo(name: String, dateOfBirth: String?, gender: String?)
}

final class DetailViewPresenter: DetailPresenterProtocol {
    let view: DetailViewProtocol?
    var user : User?
    init(view: any DetailViewProtocol, user: User) {
        self.view = view
        self.user = user
        setChosenUser()
    }

    func setChosenUser() {
        view?.user = user
    }

    func updateUserInfo(name: String, dateOfBirth: String?, gender: String?) {
        user?.name = name
        user?.dateOfBirth = dateOfBirth
        user?.gender = gender
        CoreDataManager.shared.updateUser(userToUpdate: user ?? User(), name: name, dateOfBirth: dateOfBirth, gender: gender)
    }
}

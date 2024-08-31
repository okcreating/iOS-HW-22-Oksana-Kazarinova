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
    //init(view: DetailViewProtocol, user: User)
    func setChosenUser()
    func updateUserInfo(name: String, dateOfBirth: String?, gender: String?)
}

final class DetailViewPresenterProtocol: DetailPresenterProtocol {
    let view: DetailViewProtocol
    let user: User?
    init(view: any DetailViewProtocol, user: User) {
        self.view = view
        self.user = user
    }

    func setChosenUser() {
        view.user = user
    }

    func updateUserInfo(name: String, dateOfBirth: String?, gender: String?) {
        user?.name = name
        user?.dateOfBirth = dateOfBirth
        user?.gender = gender
        //setChosenUser()
        CoreDataManager.shared.updateUser()
    }
}

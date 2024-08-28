//
//  DetailPresenter.swift
//  iOS HW-22 Oksana Kazarinova
//
//  Created by Oksana Kazarinova on 24/08/2024.
//

import Foundation

protocol DetailViewProtocol: AnyObject {
    func setupHierarchy()
    func setupLayout()
    func setupNavigationBar()
    func configureView()
}

protocol DetailPresenterProtocol {
    init(view: DetailViewProtocol, user: User)
    func updateUserInfo(userToUpdate: User, photo: Data?, name: String, dateOfBirth: String?, gender: String?)

}

final class DetailViewPresenterProtocol: DetailPresenterProtocol {
    let view: DetailViewProtocol
    let user: User?
    init(view: any DetailViewProtocol, user: User) {
        self.view = view
        self.user = user
    }

    func updateUserInfo(userToUpdate: User, photo: Data?, name: String, dateOfBirth: String?, gender: String?) {
        CoreDataManager.shared.updateUser(userToUpdate: userToUpdate, photo: photo, name: name, dateOfBirth: dateOfBirth, gender: gender)
    }
}

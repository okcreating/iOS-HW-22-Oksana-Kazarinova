//
//  DetailPresenter.swift
//  iOS HW-22 Oksana Kazarinova
//
//  Created by Oksana Kazarinova on 24/08/2024.
//

import Foundation
import UIKit

protocol DetailViewProtocol: AnyObject {
    var editButton: UIBarButtonItem { get set }
    func setupHierarchy()
    func setupLayout()
    func setupNavigationBar()
}

protocol DetailPresenterProtocol {
    init(view: DetailViewProtocol, user: User)
    func updateUserInfo(photo: String, name: String, dateOfBitrh: Date, gender: String)
    func changeButtonOutlook()
    func configurePickerView()

}

final class DetailViewPresenterProtocol: DetailPresenterProtocol {
    let view: DetailViewProtocol
    let user: User?
    init(view: any DetailViewProtocol, user: User) {
        self.view = view
        self.user = user
    }

    func updateUserInfo(photo: String, name: String, dateOfBirth: Date, gender: ) {
        user?.name = name
        user?.photo = photo
        user?.dateOfBirth = dateOfBirth
        user?.gender = gender
    }

    func changeButtonOutlook() {
        view.editButton.isSelected.toggle()
        if view.editButton.isSelected {
            view.editButton.title = "Save"
        } else {
            view.editButton.title = "Edit"
        }
    }

    func configurePickerView() {
        
    }
}

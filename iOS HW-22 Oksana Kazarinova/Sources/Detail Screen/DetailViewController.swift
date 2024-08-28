//
//  DetailViewController.swift
//  iOS HW-22 Oksana Kazarinova
//
//  Created by Oksana Kazarinova on 24/08/2024.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController, DetailViewProtocol {
    
    var detailPresenter: DetailPresenterProtocol?

    enum GenderPickerOptions: String {
        case man = "Gentleman"
        case woman = "Lady"
        case notSure = "Other"
    }
    
    // MARK: - Outlets
    
    lazy var editButton: UIBarButtonItem = {
        let editButton = UIBarButtonItem()
        editButton.title = "Edit"
        editButton.style = .plain
        editButton.customView?.layer.cornerRadius = 5
        editButton.customView?.layer.borderColor = UIColor.blue.cgColor
        editButton.customView?.layer.borderWidth = 1.5
        editButton.target = self
        editButton.action = #selector(editButtonPressed)
        return editButton
    }()
    
    lazy var avatarContainer: UIImageView = {
        let avatarContainer = UIImageView()
        avatarContainer.contentMode = .scaleToFill
        avatarContainer.layer.masksToBounds = true
        avatarContainer.clipsToBounds = true
        avatarContainer.layer.cornerRadius = 12
        return avatarContainer
    }()
    
    lazy var nameIconContainer: UIImageView = {
        let imageContainer = UIImageView()
        imageContainer.contentMode = .scaleToFill
        imageContainer.layer.masksToBounds = true
        imageContainer.clipsToBounds = true
        imageContainer.image = UIImage(systemName: "person")
        //imageContainer.tintColor = .white
        return imageContainer
    }()
    
    lazy var nameLabel: UITextField = {
        let label = UITextField()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .left
        label.isUserInteractionEnabled = false
        return label
    }()
    
    lazy var dateIconContainer: UIImageView = {
        let imageContainer = UIImageView()
        imageContainer.contentMode = .scaleToFill
        imageContainer.layer.masksToBounds = true
        imageContainer.clipsToBounds = true
        imageContainer.image = UIImage(systemName: "calendar")
        //imageContainer.tintColor = .white
        return imageContainer
    }()
    
    lazy var dateOfBirthLabel: UITextField = {
        let label = UITextField()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .left
        label.placeholder = "dd/mm/yyy"
        label.isUserInteractionEnabled = false
        label.delegate = self
        return label
    }()
    
    lazy var genderIconContainer: UIImageView = {
        let imageContainer = UIImageView()
        imageContainer.contentMode = .scaleToFill
        imageContainer.layer.masksToBounds = true
        imageContainer.clipsToBounds = true
        imageContainer.image = UIImage(systemName: "person.2.circle")
        //  imageContainer.tintColor = .white
        return imageContainer
    }()
    
    lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .left
        label.text = "Gender"
        return label
    }()
    
    lazy var genderPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        picker.isUserInteractionEnabled = false
        return picker
    }()
    
    lazy var nameStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        return view
    }()
    
    lazy var dateStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        return view
    }()
    
    lazy var genderStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        setupNavigationBar()
        configureView()
    }
    
    func setupHierarchy() {
        view.addSubview(avatarContainer)
        nameStack.addSubview(nameIconContainer)
        nameStack.addSubview(nameLabel)
        dateStack.addSubview(dateIconContainer)
        dateStack.addSubview(dateOfBirthLabel)
        genderStack.addSubview(genderIconContainer)
        genderStack.addSubview(genderLabel)
        genderStack.addSubview(genderPicker)
        view.addSubview(nameStack)
        view.addSubview(dateStack)
        view.addSubview(genderStack)
        // navigationController?.navigationBar.addSubview(editButton)
    }
    
    func setupLayout() {
        avatarContainer.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(25)
            make.width.height.equalTo(50)
        }
        nameIconContainer.snp.makeConstraints { make in
            make.leading.top.bottom.equalTo(nameStack).offset(5)
        }
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameIconContainer.snp.trailing).offset(10)
            make.top.bottom.equalTo(nameStack).offset(5)
        }
        dateIconContainer.snp.makeConstraints { make in
            make.leading.top.bottom.equalTo(dateStack).offset(5)
        }
        dateOfBirthLabel.snp.makeConstraints { make in
            make.leading.equalTo(dateIconContainer.snp.trailing).offset(10)
            make.top.bottom.equalTo(dateStack).offset(5)
        }
        genderIconContainer.snp.makeConstraints { make in
            make.leading.top.bottom.equalTo(genderStack).offset(5)
        }
        genderLabel.snp.makeConstraints { make in
            make.leading.equalTo(genderIconContainer).offset(10)
            make.top.bottom.equalTo(genderStack).offset(5)
        }
        genderPicker.snp.makeConstraints { make in
            make.trailing.top.bottom.equalTo(genderStack).offset(5)
        }
        nameStack.snp.makeConstraints { make in
            make.top.equalTo(avatarContainer.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view).offset(5)
        }
        dateStack.snp.makeConstraints { make in
            make.top.equalTo(nameStack.snp.bottom).offset(10)
            make.leading.trailing.equalTo(view).offset(5)
        }
        genderStack.snp.makeConstraints { make in
            make.top.equalTo(dateStack.snp.bottom).offset(20)
            make.leading.trailing.equalTo(view).offset(5)
        }
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = editButton
        //editButton.customView?.tintColorDidChange()
    }

    func configureView() {
        let imageURL = URL(string: "https://robohash.org/\(nameLabel.text ?? "hjfhdjdsjskdfhvy")")
        avatarContainer.kf.setImage(with: imageURL)
        detailPresenter.
    }

    @objc func editButtonPressed() {
        func changeButtonOutlook() {
            editButton.isSelected.toggle()
            if editButton.isSelected {
                editButton.title = "Save"
                editButton.customView?.layer.borderColor = UIColor.green.cgColor
                nameLabel.isUserInteractionEnabled = true
                dateOfBirthLabel.isUserInteractionEnabled = true
                genderPicker.isUserInteractionEnabled = true
            } else {
                editButton.title = "Edit"
                editButton.customView?.layer.borderColor = UIColor.blue.cgColor
                nameLabel.isUserInteractionEnabled = false
                dateOfBirthLabel.isUserInteractionEnabled = false
                genderPicker.isUserInteractionEnabled = false


                detailPresenter?.updateUserInfo(userToUpdate: <#User#>, photo: avatarContainer.image, name: nameLabel.text ?? "Name deleted", dateOfBirth: dateOfBirthLabel.text, gender: genderPicker.selectedRow(inComponent: <#T##Int#>))
            }
        }
    }
}

extension DetailViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        3
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return DetailViewController.GenderPickerOptions.man.rawValue
        }
        if component == 1 {
            return DetailViewController.GenderPickerOptions.woman.rawValue
        }
        if component == 2 {
            return DetailViewController.GenderPickerOptions.notSure.rawValue
        } else {
            return "Prefer not to say"
        }
    }

//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if component == 0 {
//            genderPicker.
//        }
//        if component == 1 {
//            return DetailViewController.GenderPickerOptions.woman.rawValue
//        }
//        if component == 2 {
//            return DetailViewController.GenderPickerOptions.notSure.rawValue
//        } else {
//            return "Prefer not to say"
//        }
//    }

    }


extension DetailViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == dateOfBirthLabel {
            if (dateOfBirthLabel.text?.count == 2) || (dateOfBirthLabel.text?.count == 5) {
                        if !(string == "") {
                            dateOfBirthLabel.text = (dateOfBirthLabel.text)! + "-"
                        }
                    }
                    return !(textField.text!.count > 9 && (string.count ) > range.length)
                }
                else {
                    return true
                }
            }
        }


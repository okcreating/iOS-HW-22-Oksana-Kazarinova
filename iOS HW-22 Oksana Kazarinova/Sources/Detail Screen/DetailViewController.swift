//
//  DetailViewController.swift
//  iOS HW-22 Oksana Kazarinova
//
//  Created by Oksana Kazarinova on 24/08/2024.
//

import UIKit
import Kingfisher

final class DetailViewController: UIViewController, DetailViewProtocol {

    var detailPresenter: DetailPresenterProtocol?

    let pickerOptions = ["Gentleman", "Lady", "Other", "Prefer not to answer"]

    var user: User?

    func configureUser() {
        nameTextField.text = user?.name
        dateOfBirthLabel.text = user?.dateOfBirth
        genderTextField.text = user?.gender
        avatarContainer.kf.setImage(with: URL(string: "https://robohash.org/\(user?.name ?? "qwj09';x")"))
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
        avatarContainer.contentMode = .scaleAspectFill
//        avatarContainer.layer.masksToBounds = true
//        avatarContainer.clipsToBounds = true
        return avatarContainer
    }()
    
    lazy var nameIconContainer: UIImageView = {
        let imageContainer = UIImageView()
        imageContainer.contentMode = .scaleToFill
        imageContainer.layer.masksToBounds = true
        imageContainer.clipsToBounds = true
        imageContainer.image = UIImage(systemName: "person")
        return imageContainer
    }()

    lazy var nameTextField: UITextField = {
        let label = UITextField()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .left
        label.placeholder = "Type your name here"
        label.returnKeyType = .done
        label.isUserInteractionEnabled = false
        return label
    }()
    
    lazy var dateIconContainer: UIImageView = {
        let imageContainer = UIImageView()
        imageContainer.contentMode = .scaleToFill
        imageContainer.layer.masksToBounds = true
        imageContainer.clipsToBounds = true
        imageContainer.image = UIImage(systemName: "calendar")
        return imageContainer
    }()
    
    lazy var dateOfBirthTextField: UITextField = {
        let label = UITextField()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .left
        label.placeholder = "dd/mm/yyy"
        label.isUserInteractionEnabled = false
        label.keyboardType = .decimalPad
        label.delegate = self
        return label
    }()
    
    lazy var genderIconContainer: UIImageView = {
        let imageContainer = UIImageView()
        imageContainer.contentMode = .scaleToFill
        imageContainer.layer.masksToBounds = true
        imageContainer.clipsToBounds = true
        imageContainer.image = UIImage(systemName: "person.2.circle")
        return imageContainer
    }()
    
    lazy var genderTextField: UITextField = {
        let label = UITextField()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .left
        label.placeholder = "Gender"
        label.inputView = genderPicker
        label.delegate = self
        label.isUserInteractionEnabled = false
        return label
    }()
    
    lazy var genderPicker: UIPickerView = {
        let picker = UIPickerView()
       // picker.dataSource = self
        picker.delegate = self
        picker.isHidden = true
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
        avatarContainer.image = nil
        configureUser()
        hideKeyboardWhenTappedAround()
        isEditing = false
        view.backgroundColor = .systemGray6
    }
    
    func setupHierarchy() {
        view.addSubview(avatarContainer)
        nameStack.addSubview(nameIconContainer)
        nameStack.addSubview(nameTextField)
        dateStack.addSubview(dateIconContainer)
        dateStack.addSubview(dateOfBirthTextField)
        genderStack.addSubview(genderIconContainer)
        genderStack.addSubview(genderTextField)
        view.addSubview(nameStack)
        view.addSubview(dateStack)
        view.addSubview(genderStack)
        view.addSubview(genderPicker)
    }
    
    func setupLayout() {
        avatarContainer.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(70)
            make.leading.equalTo(view).offset(155)
            make.trailing.equalTo(view).offset(-155)
            make.height.equalTo(70)
        }
        nameIconContainer.snp.makeConstraints { make in
            make.leading.top.bottom.equalTo(nameStack).offset(5)
        }
        nameTextField.snp.makeConstraints { make in
            make.leading.equalTo(nameIconContainer.snp.trailing).offset(10)
            make.top.bottom.equalTo(nameStack).offset(5)
        }
        dateIconContainer.snp.makeConstraints { make in
            make.leading.top.bottom.equalTo(dateStack).offset(5)
        }
        dateOfBirthTextField.snp.makeConstraints { make in
            make.leading.equalTo(dateIconContainer.snp.trailing).offset(10)
            make.top.bottom.equalTo(dateStack).offset(5)
        }
        genderIconContainer.snp.makeConstraints { make in
            make.leading.top.bottom.equalTo(genderStack).offset(5)
        }
        genderTextField.snp.makeConstraints { make in
            make.leading.equalTo(genderIconContainer.snp.trailing).offset(10)
            make.top.bottom.equalTo(genderStack).offset(5)
        }
        genderPicker.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(view)
        }
        nameStack.snp.makeConstraints { make in
            make.top.equalTo(avatarContainer.snp.bottom).offset(30)
            make.leading.trailing.equalTo(view).offset(5)
        }
        dateStack.snp.makeConstraints { make in
            make.top.equalTo(nameStack.snp.bottom).offset(30)
            make.leading.trailing.equalTo(view).offset(5)
        }
        genderStack.snp.makeConstraints { make in
            make.top.equalTo(dateStack.snp.bottom).offset(30)
            make.leading.trailing.equalTo(view).offset(5)
        }
    }
    
    func setupNavigationBar() {
        navigationItem.rightBarButtonItem = editButton
    }
    
    @objc func editButtonPressed() {
        changeButtonOutlook()
    }

        func changeButtonOutlook() {
            editButton.isSelected.toggle()
            if editButton.isSelected {
                editButton.title = "Save"
                nameTextField.isUserInteractionEnabled = true
                dateOfBirthTextField.isUserInteractionEnabled = true
                genderTextField.isUserInteractionEnabled = true

                print("\(String(describing: nameTextField.text))")

            } else {
                editButton.title = "Edit"
                editButton.customView?.layer.borderColor = UIColor.blue.cgColor
                nameTextField.isUserInteractionEnabled = false
                dateOfBirthTextField.isUserInteractionEnabled = false
                genderTextField.isUserInteractionEnabled = false
                //genderPicker.isUserInteractionEnabled = false
                detailPresenter?.updateUserInfo(name: nameTextField.text ?? "Unknown User", dateOfBirth: dateOfBirthTextField.text, gender: genderTextField.text ?? "Not chosen")
            }
        }
    }

extension DetailViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerOptions.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickerOptions[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTextField.text = pickerOptions[row]
    }
}

extension DetailViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == dateOfBirthTextField {
            if (dateOfBirthTextField.text?.count == 2) || (dateOfBirthTextField.text?.count == 5) {
                        if !(string == "") {
                            dateOfBirthTextField.text = (dateOfBirthTextField.text)! + "-"
                        }
                    }
                    return !(textField.text!.count > 9 && (string.count ) > range.length)
                }
        if textField == genderTextField {
            return false
        }
        return true
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == genderTextField {
            genderPicker.isHidden = false
        } else {
            isEditing = true
        }
        return true
        }

    func textFieldDidEndEditing(_ textField: UITextField) {
            isEditing = false
        genderPicker.isHidden = true
        }
    }



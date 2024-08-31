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

    var user: User?
//        didSet {
//            nameLabel.text = user?.name
//            dateOfBirthLabel.text = user?.dateOfBirth
//            genderLabel.text = user?.gender
//                let imageURL = URL(string: "https://robohash.org/\(nameLabel.text ?? "hjfhdjdsjskdfhvy")")
//                avatarContainer.kf.setImage(with: imageURL)
//        }
//    }

    func configureUser() {
        nameLabel.text = user?.name
        dateOfBirthLabel.text = user?.dateOfBirth
        genderLabel.text = user?.gender
           // let imageURL = URL(string: "https://robohash.org/\(nameLabel.text ?? "hjfhdjdsjskdfhvy")")
        avatarContainer.kf.setImage(with: URL(string: "https://robohash.org/\("hfjdhhjfhdjdsjskdfhvy")"))
    }

    var chosenGenderPickerOption: GenderPickerOptions.RawValue?

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
        avatarContainer.contentMode = .scaleAspectFill
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
        label.placeholder = "name here"
        //label.returnKeyType = .done
        label.isUserInteractionEnabled = false
        return label
    }()

//    lazy var nameLabel: UITextField = {
//        let label = UITextField()
//        label.font = .systemFont(ofSize: 13, weight: .regular)
//        label.textAlignment = .left
//        label.returnKeyType = .done
//        label.isUserInteractionEnabled = false
//        return label
//    }()
    
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
    
    lazy var genderLabel: UITextField = {
        let label = UITextField()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .left
        label.placeholder = "Gender"
        label.isUserInteractionEnabled = false
        return label
    }()
    
    lazy var genderPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        
        //picker.sizeToFit()
        //picker.isUserInteractionEnabled = false
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

        configureUser()
        hideKeyboardWhenTappedAround()
        isEditing = false
        view.backgroundColor = .systemGray6
    }
    
    func setupHierarchy() {
        view.addSubview(avatarContainer)
        nameStack.addSubview(nameIconContainer)
        nameStack.addSubview(nameLabel)
        dateStack.addSubview(dateIconContainer)
        dateStack.addSubview(dateOfBirthLabel)
        genderStack.addSubview(genderIconContainer)
        genderStack.addSubview(genderLabel)
       // genderStack.addSubview(genderPicker)
        view.addSubview(nameStack)
        view.addSubview(dateStack)
        view.addSubview(genderStack)
        // navigationController?.navigationBar.addSubview(editButton)
    }
    
    func setupLayout() {
        avatarContainer.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(70)
            //make.center.equalToSuperview().offset(70)
            make.leading.equalTo(view).offset(155)
            make.trailing.equalTo(view).offset(-155)
            make.height.equalTo(70)
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
            make.leading.equalTo(genderIconContainer.snp.trailing).offset(10)
            make.top.bottom.equalTo(genderStack).offset(5)
        }
//        genderPicker.snp.makeConstraints { make in
//            make.trailing.top.bottom.equalTo(genderStack).offset(5)
//        }
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
                nameLabel.isUserInteractionEnabled = true
                dateOfBirthLabel.isUserInteractionEnabled = true
                genderLabel.isUserInteractionEnabled = true
                print("\(String(describing: nameLabel.text))")

            } else {
                editButton.title = "Edit"
                editButton.customView?.layer.borderColor = UIColor.blue.cgColor
                nameLabel.isUserInteractionEnabled = false
                dateOfBirthLabel.isUserInteractionEnabled = false
                genderLabel.isUserInteractionEnabled = false
                
                detailPresenter?.updateUserInfo(name: nameLabel.text ?? "Unknown User", dateOfBirth: dateOfBirthLabel.text, gender: genderLabel.text ?? "Not chosen")
            }
        }
    }

extension DetailViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        3
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return GenderPickerOptions.man.rawValue
        }
        if row == 1 {
            return GenderPickerOptions.woman.rawValue
        }
        if row == 2 {
            return GenderPickerOptions.notSure.rawValue
        } else {
            return "Prefer not to say"
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0 {
            genderLabel.text = GenderPickerOptions.man.rawValue
        }
        if row == 1 {
            genderLabel.text = GenderPickerOptions.woman.rawValue
        }
        if row == 2 {
            genderLabel.text = GenderPickerOptions.notSure.rawValue
        } else {
            genderLabel.text = "Not Chosen"
        }
    }
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

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            isEditing = true
        return true
        }

    func textFieldDidEndEditing(_ textField: UITextField) {
            isEditing = false
        }
    }



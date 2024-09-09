//
//  ViewController.swift
//  iOS HW-22 Oksana Kazarinova
//
//  Created by Oksana Kazarinova on 24/08/2024.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController, MainViewProtocol {

    var mainPresenter: MainPresenterProtocol?
    var detailPresenter: DetailPresenterProtocol?

    // MARK: - Outlets

    lazy var mainTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemGray6
        return tableView
    }()

    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Type your name here"
        textField.returnKeyType = .send
        textField.borderStyle = .roundedRect
        textField.delegate = self
        return textField
    }()

    lazy var addUserButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add name", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(addUser), for: .touchUpInside)
        return button
    }()

    override func viewWillAppear(_ animated:Bool) {
       super.viewWillAppear(animated)
       mainTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupHierarchy()
        setupLayout()
        setupNavigationBar()
        mainPresenter?.fetchUsers()
        hideKeyboardWhenTappedAround()
    }

    func setupHierarchy() {
        view.addSubview(textField)
        view.addSubview(addUserButton)
        view.addSubview(mainTableView)
    }

    func setupLayout() {
        textField.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(7)
            make.trailing.equalTo(view).offset(-7)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
        }
        addUserButton.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(7)
            make.trailing.equalTo(view).offset(-7)
            make.top.equalTo(textField.snp.bottom).offset(7)
        }
        mainTableView.snp.makeConstraints { make in
            make.top.equalTo(addUserButton.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    func setupNavigationBar() {
        title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func reloadTableView() {
        mainTableView.reloadData()
    }

    @objc func addUser() {
        if textField.text == "" {
            return
        } else {
            mainPresenter?.addUser(name: textField.text ?? "Unknown User", dateOfBirth: nil, gender: nil)
            textField.text = ""
        }
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mainPresenter?.countUsers() ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        39
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell
        else {
            return UITableViewCell()
        }
        let user = mainPresenter?.getUserByIndex(at: indexPath.row)
        cell.name.text = user?.name
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = mainPresenter?.getUserByIndex(at: indexPath.row) else { return }
        let detailController = ModuleAssembler.createDetailModule(model: user)
        //detailPresenter?.setChosenUser()
        user.name = user.name
         navigationController?.pushViewController(detailController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
         .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let user = mainPresenter?.getUserByIndex(at: indexPath.row) else { return }
        mainPresenter?.deleteUser(user: user)
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        isEditing = true
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        isEditing = false
    }
}

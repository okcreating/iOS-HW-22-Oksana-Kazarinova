//
//  ViewController.swift
//  iOS HW-22 Oksana Kazarinova
//
//  Created by Oksana Kazarinova on 24/08/2024.
//

import UIKit
import SnapKit

class MainViewController: UIViewController, MainViewProtocol {

    var mainPresenter: MainPresenterProtocol?

    // MARK: - Outlets

    lazy var mainTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Type your name here"
        textField.returnKeyType = .send
        textField.delegate = self
        return textField
    }()

    lazy var addUserButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add name", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(addUser), for: .touchUpInside)
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .white
        setupHierarchy()
        setupLayout()
        setupNavigationBar()
    }

    func setupHierarchy() {
        view.addSubview(mainTableView)
        view.addSubview(textField)
        view.addSubview(addUserButton)
    }

    func setupLayout() {
        textField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).offset(7)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
        }

        addUserButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).offset(7)
            make.top.equalTo(textField.snp.bottom).offset(5)
        }
        mainTableView.snp.makeConstraints { make in
            make.top.equalTo(addUserButton.snp.bottom).offset(5)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    func setupNavigationBar() {
        navigationController?.navigationItem.title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    @objc func addUser() {
        mainPresenter?.addUserToCoreData()
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //presenter.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell
        else {
            return UITableViewCell()
        }

       // let user = mainPresenter.
        cell.name.text = user?.name
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = ModuleAssembler.createDetailModule(model: )
       // navigationController?.pushViewController(detailController, animated: true)
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        UITableViewCell.delete
        mainPresenter.
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        isEditing = true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        isEditing = false
    }
}

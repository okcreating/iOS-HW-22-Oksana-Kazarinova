//
//  ViewController.swift
//  iOS HW-22 Oksana Kazarinova
//
//  Created by Oksana Kazarinova on 24/08/2024.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    // MARK: - Outlets

    lazy var mainTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Type your name here"
        textField.returnKeyType = .send
        return textField
    }()

    @objc lazy var addUserButton: UIButton = {
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
        //presenter.arrayOfUsers.append(textField.text)
    }
}


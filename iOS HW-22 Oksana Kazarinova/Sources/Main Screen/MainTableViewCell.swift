//
//  MainTableViewCell.swift
//  iOS HW-22 Oksana Kazarinova
//
//  Created by Oksana Kazarinova on 24/08/2024.
//

import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {

    static let identifier = "MainTableViewCell"

    // MARK: - Outlets

    lazy var name: UILabel = {
        let name = UILabel()
        name.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        name.textAlignment = .left
        return name
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: MainTableViewCell.identifier)
        selectionStyle = .blue
        accessoryType = .disclosureIndicator
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupHierarchy() {
        contentView.addSubview(name)
    }

    func setupLayout() {
        name.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(20)
            make.trailing.equalTo(contentView).offset(-20)
            make.top.equalTo(contentView).offset(12)
            make.bottom.equalTo(contentView).offset(-12)
        }
    }
}

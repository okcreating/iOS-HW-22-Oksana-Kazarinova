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
        addSubview(name)
    }

    func setupLayout() {
        name.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(contentView.snp.leading).offset(7)
            make.top.greaterThanOrEqualTo(contentView.snp.top).offset(7)
            make.bottom.greaterThanOrEqualTo(contentView.snp.bottom).offset(-7)
        }
    }
}

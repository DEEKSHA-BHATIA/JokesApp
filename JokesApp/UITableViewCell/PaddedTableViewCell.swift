//
//  PaddedTableViewCell.swift
//  JokesApp
//
//  Created by deeksha bhatia on 09/10/23.
//

import Foundation
import UIKit
class PaddedTableViewCell: UITableViewCell {
    
    let container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 57/255, green: 255/255, blue: 20/255, alpha: 1.0)

        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCellContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellContent() {
        contentView.addSubview(container)
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.clipsToBounds = true
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3.0),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3.0),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3.0),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -3.0)
        ])
    }
}

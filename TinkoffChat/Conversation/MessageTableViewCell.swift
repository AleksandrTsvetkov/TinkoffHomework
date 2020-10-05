//
//  MessageTableViewCell.swift
//  TinkoffChat
//
//  Created by Александр Цветков on 30.09.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell, ConfigurableView {
    
    static let reuseId = "MessageTableViewCell"
    let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    private let bubbleBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.backgroundColor = .green
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(bubbleBackgroundView)
        addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            messageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            messageLabel.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.75),
            
            bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -8),
            bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 8),
            bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -8),
            bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 8),
        ])
    }
    
    func configure(with model: MessageCellModel) {
        messageLabel.text = model.text
        if model.isOutcoming {
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        } else {
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//
//  ConversationCell.swift
//  TinkoffChat
//
//  Created by Александр Цветков on 27.09.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

protocol ConfigurableView {
    associatedtype ConfigurationModel
    
    func configure(with model: ConfigurationModel)
}


class ConversationCell: UITableViewCell, ConfigurableView {
    
    static let reuseId = "ConversationCell"
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var senderNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var messageTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with model: ConversationCellModel) {
        senderNameLabel.text = model.name
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        let startDate = Calendar.current.startOfDay(for: Date())
        if model.date < startDate {
            dateFormatter.dateFormat = "dd MMM"
        } else {
            dateFormatter.dateFormat = "HH:mm"
        }
        let dateString = dateFormatter.string(from: model.date)
        dateLabel.text = dateString
        if model.message == "" {
            messageTextLabel.text = "No messages yet"
        } else {
            messageTextLabel.text = model.message
        }
        if model.hasUnreadMessages {
            messageTextLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        }
        if model.isOnline {
            contentView.backgroundColor = UIColor(displayP3Red: 0.949019607843137, green: 1, blue: 0.576470588235294, alpha: 1)
        } else {
            contentView.backgroundColor = .white
        }
        
    }
    
}

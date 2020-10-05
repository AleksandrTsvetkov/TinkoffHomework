//
//  ConversationViewController.swift
//  TinkoffChat
//
//  Created by Александр Цветков on 30.09.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController {
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 13)
        textField.textAlignment = .left
        textField.textColor = .black
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        textField.attributedPlaceholder = NSAttributedString(string: "Введите сообщение", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.642, green: 0.642, blue: 0.642, alpha: 1), NSAttributedString.Key.paragraphStyle: centeredParagraphStyle])
        textField.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor(red: 0.325, green: 0.596, blue: 1, alpha: 1).cgColor
        return textField
    }()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    private let defaults = UserDefaults.standard
    var messages: Array<MessageCellModel> = [
        MessageCellModel(text: "Multiline sample message\nMultiline sample message\nMultiline sample message", isOutcoming: false),
        MessageCellModel(text: "Multiline sample message\nMultiline sample message\nMultiline sample message", isOutcoming: true),
        MessageCellModel(text: "Multiline sample message\nMultiline sample message\nMultiline sample message", isOutcoming: false),
        MessageCellModel(text: "Short line", isOutcoming: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: MessageTableViewCell.reuseId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.transform = CGAffineTransform(scaleX: 1, y: -1)
        //setTheme()
        
        switch defaults.string(forKey: "theme") {
        case "classic":
            view.backgroundColor = UIColor(red: 0.863, green: 0.969, blue: 0.773, alpha: 1)
            tableView.backgroundColor = UIColor(red: 0.863, green: 0.969, blue: 0.773, alpha: 1)
        case "day":
            view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9921568627, alpha: 1)
            tableView.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9921568627, alpha: 1)
        case "night":
            view.backgroundColor = UIColor(red: 0.098, green: 0.21, blue: 0.379, alpha: 1)
            tableView.backgroundColor = UIColor(red: 0.098, green: 0.21, blue: 0.379, alpha: 1)
        default:
            break
        }
    }
    
    private func setupUI() {
        view.addSubview(tableView)
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            textField.widthAnchor.constraint(equalToConstant: 200),
            textField.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}

extension ConversationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.reuseId, for: indexPath) as? MessageTableViewCell else { return UITableViewCell() }
        cell.configure(with: messages.reversed()[indexPath.row])
        cell.messageLabel.transform = CGAffineTransform(scaleX: 1, y: -1)
        switch defaults.string(forKey: "theme") {
        case "classic":
            cell.backgroundColor = UIColor(red: 0.863, green: 0.969, blue: 0.773, alpha: 1)
        case "day":
            cell.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9921568627, alpha: 1)
        case "night":
            cell.backgroundColor = UIColor(red: 0.098, green: 0.21, blue: 0.379, alpha: 1)
        default:
            break
        }
        return cell
    }
}

//extension ConversationViewController: ThemePickerDelegate {
//
//    func setTheme() {
//        switch defaults.string(forKey: "theme") {
//        case "classic":
//            view.backgroundColor = UIColor(red: 0.863, green: 0.969, blue: 0.773, alpha: 1)
//            tableView.backgroundColor = UIColor(red: 0.863, green: 0.969, blue: 0.773, alpha: 1)
//        case "day":
//            view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9921568627, alpha: 1)
//            tableView.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9725490196, blue: 0.9921568627, alpha: 1)
//        case "night":
//            view.backgroundColor = UIColor(red: 0.098, green: 0.21, blue: 0.379, alpha: 1)
//            tableView.backgroundColor = UIColor(red: 0.098, green: 0.21, blue: 0.379, alpha: 1)
//        default:
//            view.backgroundColor = UIColor(red: 0.863, green: 0.969, blue: 0.773, alpha: 1)
//            tableView.backgroundColor = UIColor(red: 0.863, green: 0.969, blue: 0.773, alpha: 1)
//            defaults.set("classic", forKey: "theme")
//        }
//    }
//}

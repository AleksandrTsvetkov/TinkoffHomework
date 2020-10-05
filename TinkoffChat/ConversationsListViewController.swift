//
//  ConversationsListViewController.swift
//  TinkoffChat
//
//  Created by Александр Цветков on 27.09.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

class ConversationsListViewController: UITableViewController {
    
    private var onlineCellsModels: Array<ConversationCellModel> = {
        guard let path = Bundle.main.path(forResource: "ConversationsWithOnlineUsers", ofType: "json") else { return [] }
        return path.getModelsFromThatPath()
    }()
    private var offlineCellsModels: Array<ConversationCellModel> = {
        guard let path = Bundle.main.path(forResource: "ConversationsWithOfflineUsers", ofType: "json") else { return [] }
        return path.getModelsFromThatPath()
    }()
    private let defaults = UserDefaults.standard
    private var onlineCellsColor: UIColor!
    private var offlineCellsColor: UIColor!
    var changeTheme: (() -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: String(describing: ConversationCell.self), bundle: nil), forCellReuseIdentifier: ConversationCell.reuseId)
        let image = UIImage(named: "gearIcon")
        let gearButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(gearButtonTapped))
        self.navigationItem.leftBarButtonItem = gearButton
        navigationController?.navigationBar.backgroundColor = .white
        //setTheme()
        // Если здесь не добавить self в список захвата, возникнет retain cycle
        changeTheme = { [weak self] in
            switch self?.defaults.string(forKey: "theme") {
            case nil:
                self?.view.backgroundColor = UIColor(red: 0.863, green: 0.969, blue: 0.773, alpha: 1)
                self?.defaults.set("classic", forKey: "theme")
                self?.onlineCellsColor = UIColor(displayP3Red: 0.949019607843137, green: 1, blue: 0.576470588235294, alpha: 1)
                self?.offlineCellsColor = .white
                self?.tableView.reloadData()
            case "classic":
                self?.view.backgroundColor = UIColor(red: 0.863, green: 0.969, blue: 0.773, alpha: 1)
                self?.onlineCellsColor = UIColor(displayP3Red: 0.949019607843137, green: 1, blue: 0.576470588235294, alpha: 1)
                self?.offlineCellsColor = .white
                self?.tableView.reloadData()
            case "day":
                self?.view.backgroundColor = .white
                self?.onlineCellsColor = UIColor(displayP3Red: 0.949019607843137, green: 1, blue: 0.576470588235294, alpha: 1)
                self?.offlineCellsColor = .white
                self?.tableView.reloadData()
            case "night":
                self?.view.backgroundColor = UIColor(red: 0.098, green: 0.21, blue: 0.379, alpha: 1)
                self?.onlineCellsColor = .systemTeal
                self?.offlineCellsColor = .lightGray
                self?.tableView.reloadData()
            default:
                self?.view.backgroundColor = UIColor(red: 0.863, green: 0.969, blue: 0.773, alpha: 1)
                self?.defaults.set("classic", forKey: "theme")
                self?.onlineCellsColor = UIColor(displayP3Red: 0.949019607843137, green: 1, blue: 0.576470588235294, alpha: 1)
                self?.offlineCellsColor = .white
                self?.tableView.reloadData()
            }
        }
        changeTheme()
    }
    
    @objc private func gearButtonTapped() {
        let themesVC = ThemesViewController()
        //themesVC.delegate = self
        themesVC.changeTheme = changeTheme
        navigationController?.pushViewController(themesVC, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return onlineCellsModels.count
        case 1:
            return offlineCellsModels.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ConversationCell.reuseId, for: indexPath) as? ConversationCell else { return UITableViewCell() }
        switch indexPath.section {
        case 0:
            cell.configure(with: onlineCellsModels[indexPath.row])
            cell.contentView.backgroundColor = onlineCellsColor
        case 1:
            cell.configure(with: offlineCellsModels[indexPath.row])
            cell.contentView.backgroundColor = offlineCellsColor
        default:
            break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Online"
        case 1:
            return "History"
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let conversationVC = ConversationViewController()
        switch indexPath.section {
        case 0:
            conversationVC.title = onlineCellsModels[indexPath.row].name
            let message = MessageCellModel(text: onlineCellsModels[indexPath.row].message, isOutcoming: true)
            conversationVC.messages.append(message)
        case 1:
            conversationVC.title = offlineCellsModels[indexPath.row].name
            let message = MessageCellModel(text: offlineCellsModels[indexPath.row].message, isOutcoming: true)
            conversationVC.messages.append(message)
        default:
            break
        }
        
        navigationController?.pushViewController(conversationVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        72
    }
}

//extension ConversationsListViewController: ThemePickerDelegate {
//
//    func setTheme() {
//        switch defaults.string(forKey: "theme") {
//        case "classic":
//            view.backgroundColor = UIColor(red: 0.863, green: 0.969, blue: 0.773, alpha: 1)
//            onlineCellsColor = UIColor(displayP3Red: 0.949019607843137, green: 1, blue: 0.576470588235294, alpha: 1)
//            offlineCellsColor = .white
//            tableView.reloadData()
//        case "day":
//            view.backgroundColor = .white
//            onlineCellsColor = UIColor(displayP3Red: 0.949019607843137, green: 1, blue: 0.576470588235294, alpha: 1)
//            offlineCellsColor = .white
//            tableView.reloadData()
//        case "night":
//            view.backgroundColor = UIColor(red: 0.098, green: 0.21, blue: 0.379, alpha: 1)
//            onlineCellsColor = .systemTeal
//            offlineCellsColor = .lightGray
//            tableView.reloadData()
//        default:
//            view.backgroundColor = UIColor(red: 0.863, green: 0.969, blue: 0.773, alpha: 1)
//            defaults.set("classic", forKey: "theme")
//            onlineCellsColor = UIColor(displayP3Red: 0.949019607843137, green: 1, blue: 0.576470588235294, alpha: 1)
//            offlineCellsColor = .white
//            tableView.reloadData()
//        }
//    }
//}

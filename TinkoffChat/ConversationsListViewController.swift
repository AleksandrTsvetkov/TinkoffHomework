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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: String(describing: ConversationCell.self), bundle: nil), forCellReuseIdentifier: ConversationCell.reuseId)
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
        case 1:
            cell.configure(with: offlineCellsModels[indexPath.row])
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

//
//  ConversationCellModel.swift
//  TinkoffChat
//
//  Created by Александр Цветков on 29.09.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import Foundation

struct ConversationCellModel {
    let name: String
    let message: String
    let date: Date
    let isOnline: Bool
    let hasUnreadMessages: Bool
}

struct ConversationCellJSONModel: Decodable {
    let name: String
    let message: String
    let date: String
    let isOnline: Bool
    let hasUnreadMessages: Bool
}

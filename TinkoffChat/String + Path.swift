//
//  String + Path.swift
//  TinkoffChat
//
//  Created by Александр Цветков on 29.09.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

extension String {
    func getModelsFromThatPath() -> Array<ConversationCellModel> {
        let url = URL(fileURLWithPath: self)
        var JSONmodels: Array<ConversationCellJSONModel> = []
        do {
            let data = try Data(contentsOf: url)
            JSONmodels = try JSONDecoder().decode([ConversationCellJSONModel].self, from: data)
        } catch {
            print(error)
        }
        var newModels: Array<ConversationCellModel> = []
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        for model in JSONmodels {
            guard let date = dateFormatter.date(from: model.date) else { continue }
            let newModel = ConversationCellModel(name: model.name, message: model.message, date: date, isOnline: model.isOnline, hasUnreadMessages: model.hasUnreadMessages)
            newModels.append(newModel)
        }
        return newModels
    }
}

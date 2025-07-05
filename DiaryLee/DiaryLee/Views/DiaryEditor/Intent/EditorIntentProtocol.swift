//
//  EditorIntentProtocol.swift
//  DiaryLee
//
//  Created by 이중엽 on 7/6/25.
//

import Foundation

enum EditorIntentType {
    case titleChanged(String)
    case contentChanged(String)
    case dateChanged(Date)
    case saveButtonTapped
}

protocol EditorIntentProtocol {
    func send(_ intent: EditorIntentType)
}

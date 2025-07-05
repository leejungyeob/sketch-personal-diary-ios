//
//  EditorIntent.swift
//  DiaryLee
//
//  Created by 이중엽 on 7/6/25.
//

import Foundation

final class EditorIntent {
    
    private weak var model: EditorActionProtocol?
    
    init(model: EditorActionProtocol) {
        self.model = model
    }
}

extension EditorIntent: EditorIntentProtocol {
    
    func send(_ intent: EditorIntentType) {
        switch intent {
        case .titleChanged(let title):
            self.model?.updateTitle(title)
        case .contentChanged(let content):
            self.model?.updateContent(content)
        case .dateChanged(let date):
            self.model?.updateDate(date)
        case .saveButtonTapped:
            self.model?.saveDiary()
        }
    }
}

//
//  EditorContainer.swift
//  DiaryLee
//
//  Created by 이중엽 on 7/6/25.
//

import Foundation

enum DiaryHomeIntentType {
    case viewOnAppear
    case refreshDiaries
}

protocol DiaryHomeIntentProtocol {
    func send(_ intent: DiaryHomeIntentType)
}

final class DiaryHomeIntent: DiaryHomeIntentProtocol {
    private weak var model: DiaryHomeActionProtocol?

    init(model: DiaryHomeActionProtocol) {
        self.model = model
    }

    func send(_ intent: DiaryHomeIntentType) {
        switch intent {
        case .viewOnAppear:
            model?.fetchDiaries()
        case .refreshDiaries:
            model?.fetchDiaries()
        }
    }
}

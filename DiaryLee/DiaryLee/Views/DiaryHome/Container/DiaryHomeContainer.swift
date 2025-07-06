//
//  EditorContainer.swift
//  DiaryLee
//
//  Created by 이중엽 on 7/6/25.
//

import SwiftUI
import Combine

final class DiaryHomeContainer<Intent, Model>: ObservableObject {
    let intent: Intent
    let model: Model

    private var cancellable: Set<AnyCancellable> = []

    init(intent: Intent, model: Model, modelChangedPublisher: ObjectWillChangePublisher) {
        self.intent = intent
        self.model = model

        modelChangedPublisher
            .receive(on: RunLoop.main)
            .sink(receiveValue: objectWillChange.send)
            .store(in: &cancellable)
    }
}

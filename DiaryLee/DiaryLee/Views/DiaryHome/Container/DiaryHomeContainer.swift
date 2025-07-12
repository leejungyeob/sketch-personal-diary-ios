//
//  EditorContainer.swift
//  DiaryLee
//
//  Created by 이중엽 on 7/6/25.
//

import SwiftUI
import Combine

import Foundation
import Combine

final class DiaryHomeContainer<Intent: DiaryHomeIntentProtocol, Model: DiaryHomeModel>: ObservableObject {
    let intent: Intent
    @Published var model: Model
    
    private var cancellable: AnyCancellable?
    
    init(intent: Intent, model: Model) {
        self.intent = intent
        self.model = model
        
        cancellable = model.objectWillChange.sink(receiveValue: { [weak self] _ in
            self?.objectWillChange.send()
        })
    }
}

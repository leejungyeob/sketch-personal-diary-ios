//
//  EditorContainer.swift
//  DiaryLee
//
//  Created by 이중엽 on 7/6/25.
//

import Foundation
import Combine

final class EditorContainer<Intent, Model>: ObservableObject {
    
    let intent: Intent
    let model: Model
    
    private var cancellable: Set<AnyCancellable> = []
    
    init(intent: Intent, model: Model) {
        self.intent = intent
        self.model = model
    }
}

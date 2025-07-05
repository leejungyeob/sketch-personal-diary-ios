//
//  EditorModel.swift
//  DiaryLee
//
//  Created by 이중엽 on 7/6/25.
//

import Foundation

final class EditorModel: ObservableObject, EditorStateProtocol, EditorActionProtocol {
    @Published var title: String = ""
    @Published var content: String = ""
    @Published var date: Date = Date()
    
    func updateTitle(_ title: String) {
        self.title = title
    }
    
    func updateContent(_ content: String) {
        self.content = content
    }
    
    func updateDate(_ date: Date) {
        self.date = date
    }
    
    func saveDiary() {
        _ = Diary(title: title, date: date, content: content)
    }
}

//
//  EditorModel.swift
//  DiaryLee
//
//  Created by 이중엽 on 7/6/25.
//

import Foundation
import Combine

final class EditorModel: ObservableObject, EditorStateProtocol, EditorActionProtocol {
    @Published var title: String = ""
    @Published var content: String = ""
    @Published var date: Date = Date()
    let dismissPublisher = PassthroughSubject<Void, Never>()

    private let saveDiaryUseCase: SaveDiaryUseCase

    init(saveDiaryUseCase: SaveDiaryUseCase) {
        self.saveDiaryUseCase = saveDiaryUseCase
    }
    
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
        let newDiary = Diary(title: title, date: date, content: content)
        Task { @MainActor in
            do {
                try await saveDiaryUseCase.execute(diary: newDiary)
                dismissPublisher.send(())
            } catch {
                print("\(error.localizedDescription)")
            }
        }
    }
}

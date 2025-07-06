//
//  EditorContainer.swift
//  DiaryLee
//
//  Created by 이중엽 on 7/6/25.
//

import Foundation

class FetchDiariesUseCase {
    private let diaryRepository: DiaryRepository

    init(diaryRepository: DiaryRepository) {
        self.diaryRepository = diaryRepository
    }

    func execute() async throws -> [Diary] {
        return try await diaryRepository.fetchDiaries()
    }
}

//
//  EditorContainer.swift
//  DiaryLee
//
//  Created by 이중엽 on 7/6/25.
//

import Foundation
import Combine

class DefaultDiaryRepository: DiaryRepository {
    private let userDefaultsKey = "diaries"
    
    func save(diary: Diary) async throws {
        var diaries = await (try? fetchDiaries()) ?? []
        
        if let index = diaries.firstIndex(where: { $0.id == diary.id }) {
            diaries[index] = diary
        } else {
            diaries.append(diary)
        }
        
        if let encoded = try? JSONEncoder().encode(diaries) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        } else {
            throw RepositoryError.saveFailed
        }
    }
    
    func fetchDiaries() async throws -> [Diary] {
        if let savedDiariesData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedDiaries = try? JSONDecoder().decode([Diary].self, from: savedDiariesData) {
            return decodedDiaries.sorted(by: { $0.date > $1.date }) // 최신 날짜 순 정렬
        }
        return []
    }
}

enum RepositoryError: Error {
    case saveFailed
    case fetchFailed
}

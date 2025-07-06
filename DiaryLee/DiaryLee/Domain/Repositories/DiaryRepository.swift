//
//  EditorContainer.swift
//  DiaryLee
//
//  Created by 이중엽 on 7/6/25.
//

import Foundation
import Combine

protocol DiaryRepository {
    func save(diary: Diary) async throws
    func fetchDiaries() async throws -> [Diary]
}

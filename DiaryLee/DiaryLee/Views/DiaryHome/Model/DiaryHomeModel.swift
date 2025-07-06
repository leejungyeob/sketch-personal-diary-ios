//
//  EditorContainer.swift
//  DiaryLee
//
//  Created by 이중엽 on 7/6/25.
//

import Foundation
import Combine

protocol DiaryHomeStateProtocol {
    var diaryList: [Diary] { get }
    var isLoading: Bool { get }
    var errorMessage: String? { get }
}

protocol DiaryHomeActionProtocol: AnyObject {
    func fetchDiaries()
}

final class DiaryHomeModel: ObservableObject, DiaryHomeStateProtocol, DiaryHomeActionProtocol {
    @Published var diaryList: [Diary] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private let fetchDiariesUseCase: FetchDiariesUseCase

    init(fetchDiariesUseCase: FetchDiariesUseCase) {
        self.fetchDiariesUseCase = fetchDiariesUseCase
    }

    func fetchDiaries() {
        isLoading = true
        errorMessage = nil
        Task { @MainActor in
            do {
                let fetchedDiaries = try await fetchDiariesUseCase.execute()
                self.diaryList = fetchedDiaries
            } catch {
                self.errorMessage = error.localizedDescription
            }
            self.isLoading = false
        }
    }
}

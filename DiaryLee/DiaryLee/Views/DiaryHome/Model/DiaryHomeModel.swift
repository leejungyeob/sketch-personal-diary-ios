//
//  EditorContainer.swift
//  DiaryLee
//
//  Created by 이중엽 on 7/6/25.
//

import Foundation

// MARK: - State
struct DiaryHomeState {
    var diaryList: [Diary] = []
    var isLoading: Bool = false
    var errorMessage: String? = nil
}

// MARK: - Action Protocol
protocol DiaryHomeActionProtocol: AnyObject {
    func send(_ intent: DiaryHomeIntentType)
}

// MARK: - Model: ObservableObject, State Conformance
final class DiaryHomeModel: ObservableObject {
    @Published var state: DiaryHomeState

    init(initialState: DiaryHomeState = .init()) {
        self.state = initialState
    }
}

// MARK: - SideEffect
extension DiaryHomeModel {
    enum SideEffect {
        case fetchDiaries
    }
}

// MARK: - Reducer
extension DiaryHomeModel {
    @MainActor
    func reduce(_ intent: DiaryHomeIntentType) -> SideEffect? {
        switch intent {
        case .viewOnAppear, .refreshDiaries:
            state.isLoading = true
            state.errorMessage = nil
            return .fetchDiaries
        
        case .diariesFetched(let diaries):
            state.isLoading = false
            state.diaryList = diaries
            
        case .fetchFailed(let error):
            state.isLoading = false
            state.errorMessage = error.localizedDescription
        }
        return nil
    }
}

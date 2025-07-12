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
    // reduce 함수는 이제 static이며, 순수하게 상태를 변경하고 SideEffect를 반환합니다.
    // 이 함수 자체는 어떤 부수 효과도 직접 실행하지 않습니다.
    static func reduce(state: inout DiaryHomeState, intent: DiaryHomeIntentType) -> SideEffect? {
        var currentSideEffect: SideEffect? = nil
        switch intent {
        case .viewOnAppear, .refreshDiaries:
            state.isLoading = true
            state.errorMessage = nil
            currentSideEffect = .fetchDiaries
        
        case .diariesFetched(let diaries):
            state.isLoading = false
            state.diaryList = diaries
            
        case .fetchFailed(let error):
            state.isLoading = false
            state.errorMessage = error.localizedDescription
        }
        return currentSideEffect
    }
}

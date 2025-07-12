//
//  EditorContainer.swift
//  DiaryLee
//
//  Created by 이중엽 on 7/6/25.
//

import Foundation

enum DiaryHomeIntentType {
    case viewOnAppear
    case refreshDiaries
    case diariesFetched([Diary])
    case fetchFailed(Error)
}

@MainActor
protocol DiaryHomeIntentProtocol {
    func send(_ intent: DiaryHomeIntentType)
}

final class DiaryHomeIntent: DiaryHomeIntentProtocol {
    private var model: DiaryHomeModel
    private let fetchDiariesUseCase: FetchDiariesUseCase
    
    // 진행중인 fetch 작업을 관리하기 위한 Task
    private var fetchTask: Task<Void, Never>?

    init(model: DiaryHomeModel, fetchDiariesUseCase: FetchDiariesUseCase) {
        self.model = model
        self.fetchDiariesUseCase = fetchDiariesUseCase
    }

    @MainActor
    func send(_ intent: DiaryHomeIntentType) {
        // 1. reduce 함수를 호출하여 상태를 변경하고, 발생해야 할 SideEffect를 받습니다.
        // reduce는 이제 순수 함수이며, SideEffect를 직접 실행하지 않습니다.
        let sideEffect = DiaryHomeModel.reduce(state: &model.state, intent: intent)
        
        // 2. reduce가 반환한 SideEffect를 실제로 실행합니다.
        switch sideEffect {
        case .fetchDiaries:
            // 경쟁 상태(race condition)를 피하기 위해 이전의 fetch 작업을 취소합니다.
            fetchTask?.cancel()
            
            // 새로운 작업을 생성하고 저장합니다.
            fetchTask = Task {
                do {
                    let diaries = try await fetchDiariesUseCase.execute()
                    // 만약 fetch 도중 작업이 취소되었다면, 더 이상 진행하지 않습니다.
                    guard !Task.isCancelled else { return }
                    send(.diariesFetched(diaries))
                } catch {
                    // 작업이 취소된 경우에는 실패를 보내지 않습니다.
                    guard !Task.isCancelled else { return }
                    send(.fetchFailed(error))
                }
            }
        case .none:
            break // 처리할 SideEffect가 없음
        }
    }
}

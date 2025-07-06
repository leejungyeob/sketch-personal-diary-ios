//
//  DiaryHomeView.swift
//  DiaryLee
//
//  Created by 이중엽 on 6/29/25.
//

import SwiftUI

struct DiaryHomeView: View {
    
    @StateObject var container: DiaryHomeContainer<DiaryHomeIntent, DiaryHomeStateProtocol>
    private var intent: DiaryHomeIntentProtocol { container.intent }
    private var state: DiaryHomeStateProtocol { container.model }
    
    var body: some View {
        NavigationView {
            
            ScrollView {
                if state.isLoading {
                    ProgressView()
                } else if let errorMessage = state.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                } else if state.diaryList.isEmpty {
                    Text("아직 작성된 일기가 없습니다.")
                        .foregroundColor(.gray)
                } else {
                    ForEach(state.diaryList) { diary in
                        DiaryRowView(diary: .constant(diary))
                            .padding(.top, 10)
                    }
                }
            }
            .padding()
            .navigationTitle("hello")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        DiaryEditorView.build()
                            .onDisappear { intent.send(.refreshDiaries) }
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.black)
                            .font(.caption)
                    }
                    
                }
            }
        }
        .onAppear {
            intent.send(.viewOnAppear)
        }
    }
}

extension DiaryHomeView {
    static func build() -> some View {
        let diaryRepository = DefaultDiaryRepository()
        let fetchDiariesUseCase = FetchDiariesUseCase(diaryRepository: diaryRepository)
        let model = DiaryHomeModel(fetchDiariesUseCase: fetchDiariesUseCase)
        let intent = DiaryHomeIntent(model: model)
        let container = DiaryHomeContainer(intent: intent,
                                        model: model as DiaryHomeStateProtocol,
                                        modelChangedPublisher: model.objectWillChange)
        let view = DiaryHomeView(container: container)
        return view
    }
}

#Preview {
    DiaryHomeView.build()
}

//
//  DiaryEditorView.swift
//  DiaryLee
//
//  Created by 이중엽 on 6/29/25.
//

import SwiftUI

struct DiaryEditorView: View {
    
    @StateObject var container: EditorContainer<EditorIntent, EditorStateProtocol>
    private var intent: EditorIntentProtocol { container.intent }
    private var state: EditorStateProtocol { container.model }
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        // 배경색
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                HStack(alignment: .center) {
                    
                    Text("제목")
                        .font(.callout)
                    
                    TextField("", text: Binding(
                        get: { state.title },
                        set: { intent.send(.titleChanged($0)) }
                    ), prompt: Text("제목을 입력해주세요")
                        .font(.callout)
                        .foregroundStyle(.black.opacity(0.5))
                    )
                    .cornerRadius(5)
                    .font(.callout)
                    .foregroundStyle(.black.opacity(0.8))
                    .font(.callout)
                }
                .padding(.horizontal, 10)
                
                DatePicker("날짜", selection: Binding(
                    get: { state.date },
                    set: { intent.send(.dateChanged($0)) }))
                    .font(.callout)
                    .padding(.horizontal, 10)
                    .tint(.black)
                    .datePickerStyle(.compact)
                
                TextEditor(text: Binding(
                    get: { state.content },
                    set: { intent.send(.contentChanged($0)) }))
                    .scrollContentBackground(.hidden)
                    .background(.gray.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal, 10)
                    .tint(.gray)
                    .font(.callout)
                    .scrollIndicators(.hidden)
            }
        }
        .navigationTitle("일기 작성하기")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left") // 뒤로가기 아이콘
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(.black.opacity(0.8))
                }
            }
            
            ToolbarItem {
                Button {
                    intent.send(.saveButtonTapped)
                } label: {
                    Text("저장하기")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(.black.opacity(0.8))
                }
            }
        }
        .onReceive(state.dismissPublisher) { _ in
            dismiss()
        }
    }
}

extension DiaryEditorView {
    static func build() -> some View {
        let diaryRepository = DefaultDiaryRepository()
        let saveDiaryUseCase = SaveDiaryUseCase(diaryRepository: diaryRepository)
        let model = EditorModel(saveDiaryUseCase: saveDiaryUseCase)
        let intent = EditorIntent(model: model)
        let container = EditorContainer(intent: intent,
                                        model: model as EditorStateProtocol)
        let view = DiaryEditorView(container: container)
        return view
    }
}

#Preview {
    DiaryEditorView.build()
}

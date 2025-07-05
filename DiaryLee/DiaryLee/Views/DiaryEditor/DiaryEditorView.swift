//
//  DiaryEditorView.swift
//  DiaryLee
//
//  Created by 이중엽 on 6/29/25.
//

import SwiftUI

struct DiaryEditorView: View {
    
    @State var inputText: String = ""
    @State var inputContent: String = ""
    @State var date: Date = Date()
    @Environment(\.dismiss) var dismiss
    @Binding var diaryList: [Diary]
    
    var body: some View {
        
        // 배경색
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 10) {
                HStack(alignment: .center) {
                    
                    Text("제목")
                        .font(.callout)
                    
                    TextField("", text: $inputText,
                              prompt: Text("제목을 입력해주세요")
                        .font(.callout)
                        .foregroundStyle(.black.opacity(0.5))
                    )
                    .cornerRadius(5)
                    .font(.callout)
                    .foregroundStyle(.black.opacity(0.8))
                    .font(.callout)
                }
                .padding(.horizontal, 10)
                
                DatePicker("날짜", selection: $date)
                    .font(.callout)
                    .padding(.horizontal, 10)
                    .tint(.black)
                    .datePickerStyle(.compact)
                
                TextEditor(text: $inputContent)
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
                    let newDiary = Diary(title: inputText, date: date, content: inputContent)
                    self.diaryList.append(newDiary)
                    dismiss()
                } label: {
                    Text("저장하기")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundStyle(.black.opacity(0.8))
                }
            }
        }
    }
}

#Preview {
    DiaryEditorView(diaryList: .constant([]))
}

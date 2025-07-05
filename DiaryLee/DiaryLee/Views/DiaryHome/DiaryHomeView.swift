//
//  DiaryHomeView.swift
//  DiaryLee
//
//  Created by 이중엽 on 6/29/25.
//

import SwiftUI

struct DiaryHomeView: View {
    
    @State var diaryList: [Diary] = []
    
    var body: some View {
        NavigationView {
            
            ScrollView {
                ForEach($diaryList) { diary in
                    DiaryRowView(diary: diary)
                        .padding(.top, 10)
                }
            }
            .padding()
            .navigationTitle("hello")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        DiaryEditorView.build()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.black)
                            .font(.caption)
                    }
                    
                }
            }
        }
        .onChange(of: diaryList) { oldValue, newValue in
            dump(diaryList)
        }
    }
}

#Preview {
    DiaryHomeView()
}

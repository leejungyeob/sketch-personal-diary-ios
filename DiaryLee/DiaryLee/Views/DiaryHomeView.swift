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
                ForEach(diaryList) { diary in
                    LazyVStack(alignment: .leading, spacing: 5) {
                        Text(diary.title)
                            .font(.headline)
                        Text(diary.date, style: .date)
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                        Text(diary.content)
                            .font(.body)
                            .lineLimit(2)
                    }
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                }
            }
            .padding()
            .navigationTitle("hello")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        DiaryView(diaryList: $diaryList)
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

//
//  DiaryRowView.swift
//  DiaryLee
//
//  Created by 이중엽 on 7/6/25.
//

import SwiftUI

struct DiaryRowView: View {
    
    @Binding var diary: Diary
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Text(diary.title)
                    .font(.title)
                
                Spacer()
                
                Text(diary.date, style: .date)
                    .font(.caption)
            }
            .padding(.bottom, 10)
            
            Text(diary.content)
                .font(.callout)
        }
        .padding(10)
        .background(.yellow)
        .cornerRadius(10)
        .padding(.horizontal, 10)
        .shadow(color: .black.opacity(0.5), radius: 5)
    }
}

#Preview {
    DiaryRowView(diary: .constant(Diary(title: "제목", date: Date(), content: "123")))
}

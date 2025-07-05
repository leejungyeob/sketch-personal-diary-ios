//
//  Diary.swift
//  DiaryLee
//
//  Created by 이중엽 on 6/29/25.
//

import Foundation

struct Diary: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let date: Date
    let content: String
    
    static func == (lhs: Diary, rhs: Diary) -> Bool {
        return lhs.id == rhs.id
    }
}

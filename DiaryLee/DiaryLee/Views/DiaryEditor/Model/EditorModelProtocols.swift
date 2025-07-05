//
//  EditorModelProtocols.swift
//  DiaryLee
//
//  Created by 이중엽 on 7/6/25.
//

import Foundation

protocol EditorStateProtocol {
    var title: String { get }
    var content: String { get }
    var date: Date { get }
}

protocol EditorActionProtocol: AnyObject {
    func updateTitle(_ title: String)
    func updateContent(_ content: String)
    func updateDate(_ date: Date)
    func saveDiary()
}

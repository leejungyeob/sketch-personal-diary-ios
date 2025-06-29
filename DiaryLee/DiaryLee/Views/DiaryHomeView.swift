//
//  DiaryHomeView.swift
//  DiaryLee
//
//  Created by 이중엽 on 6/29/25.
//

import SwiftUI

struct DiaryHomeView: View {
    var body: some View {
        NavigationView {
            
            ScrollView {
                
            }
            .padding()
            .navigationTitle("hello")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        print("!@3")
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.black)
                            .font(.caption)
                    }

                }
            }
        }
    }
}

#Preview {
    DiaryHomeView()
}

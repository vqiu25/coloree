//
//  LogbookView.swift
//  coloree
//
//  Created by Victor Esther Qiu on 07/12/2024.
//

import SwiftUI

struct LogbookView: View {
    @ObservedObject var moodViewModel: MoodViewModel
    
    var body: some View {
        List {
            ForEach(moodViewModel.entries, id: \.id) { entry in
                VStack(alignment: .leading) {
                    Text(entry.mood.rawValue.capitalized)
                        .foregroundColor(entry.mood.foregroundColor)
                    Text("\(entry.timestamp, format: .dateTime.year().month().day().hour().minute())")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
                .listRowBackground(moodViewModel.currentMood.backgroundColor)
            }
        }
        .scrollContentBackground(.hidden)
        .background(moodViewModel.currentMood.backgroundColor)
    }
}

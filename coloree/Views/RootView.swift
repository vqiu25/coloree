//
//  RootView.swift
//  coloree
//
//  Created by Victor Esther Qiu on 08/12/2024.
//

import SwiftUI
import SwiftData

struct RootView: View {
    @Environment(\.modelContext) private var context
    @State private var moodViewModel: MoodViewModel? = nil

    var body: some View {
        Group {
            if let moodViewModel = moodViewModel {
                ContentView(moodViewModel: moodViewModel)
            } else {
                Color.clear
                    .onAppear {
                        let vm = MoodViewModel(context: context)
                        vm.loadEntries()
                        moodViewModel = vm
                    }
            }
        }
    }
}

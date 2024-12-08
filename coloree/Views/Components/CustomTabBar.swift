//
//  CustomTabBar.swift
//  coloree
//
//  Created by Victor Esther Qiu on 07/12/2024.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case circle
    case book
    case gearshape
}

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    @ObservedObject var moodViewModel: MoodViewModel
    
    private var fillImage: String {
        selectedTab.rawValue + ".fill"
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                        .scaleEffect(tab == selectedTab ? 1.25 : 1.0)
                        .foregroundColor(
                            moodViewModel.currentMood.foregroundColor == Color("Lavendar")
                            ? moodViewModel.currentMood.foregroundColor
                            : moodViewModel.currentMood.backgroundColor
                        )
                        .font(.system(size: 20))
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
            .frame(height: 60)
            .frame(width: UIScreen.main.bounds.width * 0.6, height: 60) 
            .background(
                moodViewModel.currentMood.backgroundColor == Color("Wisteria")
                ? moodViewModel.currentMood.backgroundColor
                : moodViewModel.currentMood.foregroundColor
            )
            .cornerRadius(20)
            .padding()
        }
    }
}


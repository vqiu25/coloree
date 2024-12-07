//
//  LogbookView.swift
//  coloree
//
//  Created by Victor Esther Qiu on 07/12/2024.
//

import SwiftUI

struct LogbookView: View {
    var body: some View {
        VStack {
            // Title Text
            HStack {
                Text("Logbook")
                    .font(.custom("Louize-MediumItalic", size: 50))
                    .font(.title)
                    .padding(.top, 40)
                Spacer()
            }
            .padding(.leading, 25)
            
            Spacer()
        }
    }
}

#Preview {
    LogbookView()
}

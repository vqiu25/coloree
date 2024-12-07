//
//  Item.swift
//  coloree
//
//  Created by Victor Esther Qiu on 07/12/2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

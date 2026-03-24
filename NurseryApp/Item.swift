//
//  Item.swift
//  NurseryApp
//
//  Created by Avishka Palamure on 2026-03-24.
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

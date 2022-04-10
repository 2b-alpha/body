//
//  Task.swift
//  adding-list-state
//
//  Created by Seongjun Kim on 21/2/22.
//

import Foundation
import SwiftUI

struct Task: Identifiable {
    
    let id = UUID()
    let name: String
    let imageURL: String
    let isSpicy: Bool
    
}


extension Task {
    
    static func all() -> [Task] {
        
        return [
        
            Task(name: "1번", imageURL: "1", isSpicy: true),
            Task(name: "2번", imageURL: "2", isSpicy: false),
            Task(name: "3번", imageURL: "3", isSpicy: true)
        
        ]
    }
    
}

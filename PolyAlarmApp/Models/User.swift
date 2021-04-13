//
//  User.swift
//  PolyAlarmApp
//
//  Created by Alina Potapova on 06.04.2021.
//

import SwiftUI

struct User: Codable, Identifiable {
    let id: UUID
    var timeBefore: String
    var nickname: String
    var groupNumber: String
    var messageText: String
    
}

extension User {
    static var defaultUserData: User {
        User(id: UUID(), timeBefore: "120", nickname: "USER", groupNumber: "3530202/90002", messageText: "Wake me up!")
    }
}

//
//  UserData.swift
//  PolyAlarmApp
//
//  Created by Alina Potapova on 06.04.2021.
//

import SwiftUI
import Combine

final class UserData: ObservableObject {
    let didChange = PassthroughSubject<UserData, Never>()
    @UserDefaultAlarm(key: "Settings", defaultValue: User.defaultUserData)
    
    var data: User {
        didSet {
            didChange.send(self)
        }
    }
}

//
//  TrustNumber.swift
//  PolyAlarmApp
//
//  Created by Alina Potapova on 06.04.2021.
//

import SwiftUI

struct TrustNumber: Codable, Identifiable {
    let id: UUID
    var name: String
    var phoneNumber: String
    var isEnabled: Bool
}

extension TrustNumber {
    static var defaultTrustNumber: [TrustNumber] {
        get {[
            TrustNumber(id: UUID(), name: "ALINA", phoneNumber: "89222893458", isEnabled: true),
            TrustNumber(id: UUID(), name: "KARINA", phoneNumber: "89223893458", isEnabled: false),
            TrustNumber(id: UUID(), name: "RENAT", phoneNumber: "89322893458", isEnabled: true),
            TrustNumber(id: UUID(), name: "DAVID", phoneNumber: "89222473823", isEnabled: true)
        ]}
    }
}

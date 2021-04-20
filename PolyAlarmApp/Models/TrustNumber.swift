//
//  TrustNumber.swift
//  PolyAlarmApp
//
//  Created by Alina Potapova on 06.04.2021.
//

import SwiftUI

class TrustNumber: Codable, Identifiable, ObservableObject {
    var id = UUID().uuidString
    @Published var name: String
    @Published var phoneNumber: String
    @Published var isEnabled: Bool {
        didSet {
        }
    }
    
    internal init(id: String = UUID().uuidString,
                  name: String = "",
                  phoneNumber: String = "",
                  isEnabled: Bool = false) {
        self.id = id
        self.name = name
        self.phoneNumber = phoneNumber
        self.isEnabled = isEnabled
    }
    
    enum CodingKeys: CodingKey {
           case id
           case name
           case phoneNumber
           case isEnabled
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        phoneNumber = try container.decode(String.self, forKey: .phoneNumber)
        isEnabled = try container.decode(Bool.self, forKey: .isEnabled)
    }

   func encode(to encoder: Encoder) throws {
       var container = encoder.container(keyedBy: CodingKeys.self)
       try container.encode(id, forKey: .id)
       try container.encode(name, forKey: .name)
       try container.encode(phoneNumber, forKey: .phoneNumber)
       try container.encode(isEnabled, forKey: .isEnabled)
   }
}

extension TrustNumber {
    static var defaultTrustNumber: [TrustNumber] {
        get {[
            TrustNumber(id: UUID().uuidString, name: "ALINA", phoneNumber: "89222893458", isEnabled: true),
            TrustNumber(id: UUID().uuidString, name: "KARINA", phoneNumber: "89223893458", isEnabled: false),
            TrustNumber(id: UUID().uuidString, name: "RENAT", phoneNumber: "89322893458", isEnabled: true),
            TrustNumber(id: UUID().uuidString, name: "DAVID", phoneNumber: "89222473823", isEnabled: true)
        ]}
    }
}


//init()
//{
//    self.id = UUID()
//    self.name = "NAME"
//    self.phoneNumber = "PHONE NUMBER"
//    self.isEnabled = false
//}
//
//init(id: UUID, name: String, phoneNumber: String, isEnabled: Bool)
//{
//    self.id = id
//    self.name = name
//    self.phoneNumber = phoneNumber
//    self.isEnabled = isEnabled
//}

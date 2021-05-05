//
//  TrustNumbersData.swift
//  PolyAlarmApp
//
//  Created by Alina Potapova on 13.04.2021.
//

import SwiftUI
import Combine

final class TrustNumberData: ObservableObject {
    let didChange = PassthroughSubject<TrustNumberData, Never>()
    @UserDefault(key: "Trust Numbers", defaultValue: TrustNumber.defaultTrustNumber)
    
    var trustNumbers: [TrustNumber] {
        didSet {
            didChange.send(self)
        }
    }
    
    // MARK: - Managing TrustNumbers
    
    func add(_ trustNumber: TrustNumber) {
        trustNumbers.append(trustNumber)
    }

    func delete(_ trustNumber: TrustNumber) {
        if let index = trustNumbers.firstIndex(where: { $0.id == trustNumber.id }) {
            trustNumbers.remove(at: index)
        }
    }
    
    func removeAllTrustNumbers() {
        trustNumbers.removeAll()
    }
}

//
//  String+Extensions.swift
//  PolyAlarmApp
//
//  Created by Alina Potapova on 08.05.2021.
//

import SwiftUI

extension String {
   var isNumeric: Bool {
     return !(self.isEmpty) && self.allSatisfy { $0.isNumber }
   }
}

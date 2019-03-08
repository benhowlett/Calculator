//
//  Float+Clean.swift
//  Calculator
//
//  Created by Benjamin Howlett on 2019-03-07.
//  Copyright © 2019 Benjamin Howlett. All rights reserved.
//

import Foundation

extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

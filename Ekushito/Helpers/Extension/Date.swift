//
//  Date.swift
//  Ekushito
//
//  Created by minato on 2020/06/24.
//  Copyright © 2020 minato. All rights reserved.
//

import Foundation

extension Date {
  func toLocalString() -> String {
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone.current
    formatter.dateFormat = "MM/dd"
    
    return formatter.string(from: self)
  }
}


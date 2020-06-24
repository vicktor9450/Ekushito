//
//  StringExtension.swift
//  Ekushito
//
//  Created by minato on 2020/06/22.
//  Copyright © 2020 minato. All rights reserved.
//

import Foundation
extension String {
  var localized: String {
    return NSLocalizedString(self, comment: "")
  }
}


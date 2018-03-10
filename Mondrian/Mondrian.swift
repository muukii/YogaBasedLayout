//
//  Mondrian.swift
//  Mondrian
//
//  Created by muukii on 3/10/18.
//  Copyright © 2018 muukii. All rights reserved.
//

import Foundation

public typealias Node = UIView

func mprint(_ items: Any...) {
  #if DEBUG
    print(items.map { "\($0)" }.joined(separator: " "))
  #endif
}

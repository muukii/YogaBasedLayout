//
//  LayoutElement.swift
//  Mondrian
//
//  Created by muukii on 3/8/18.
//  Copyright © 2018 muukii. All rights reserved.
//

import Foundation

public protocol LayoutElement {

  /// Apply Layout-rule
  ///
  /// - Parameter target: Target
  /// - Returns: Return new Node if itself create (??)
  func defineLayout(target: Node) -> Node

}

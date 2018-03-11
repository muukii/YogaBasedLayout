//
//  BackgorundLayoutSpec.swift
//  Mondrian
//
//  Created by muukii on 3/8/18.
//  Copyright © 2018 muukii. All rights reserved.
//

import Foundation

import YogaKit

public struct BackgroundLayoutSpec : LayoutSpec {

  public let child: LayoutElement

  public let background: LayoutElement

  public init(child: LayoutElement, background: LayoutElement) {
    self.child = child
    self.background = background
  }

  public func defineLayout(target: Node) -> Node {

    target.yoga.isEnabled = true

    let _background = background.defineLayout(target: target)

    _background.configureLayout { (layout) in
      layout.position = .absolute
      layout.width = YGValue.init(value: 100, unit: .percent)
      layout.height = YGValue.init(value: 100, unit: .percent)
    }

    target.addSubview(_background)
    target.addSubview(child.defineLayout(target: target))

    return target
  }

}

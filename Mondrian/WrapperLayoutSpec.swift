//
//  WrapperLayoutSpec.swift
//  Mondrian
//
//  Created by muukii on 3/8/18.
//  Copyright © 2018 muukii. All rights reserved.
//

import Foundation

import YogaKit

public struct WrapperLayoutSpec : LayoutSpec {

  public let children: [LayoutElement]

  public init(child: LayoutElement) {
    self.children = [child]
  }

  public init(children: [LayoutElement]) {
    self.children = children
  }

  public func defineLayout(target: Node) -> Node {

    target.yoga.isEnabled = true

    let nodes = children.map {
      $0.defineLayout(target: target)
    }

    nodes.forEach {
      $0.configureLayout { (layout) in
        layout.position = .absolute
        layout.width = YGValue.init(value: 100, unit: .percent)
        layout.height = YGValue.init(value: 100, unit: .percent)
      }
    }

    nodes.forEach(target.addSubview)

    return target
  }

}

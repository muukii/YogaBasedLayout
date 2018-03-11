//
//  OverlayLayoutSpec.swift
//  Mondrian
//
//  Created by muukii on 3/8/18.
//  Copyright © 2018 muukii. All rights reserved.
//

import Foundation

import YogaKit

public struct OverlayLayoutSpec : LayoutSpec {

  public let child: LayoutElement

  public let overlay: LayoutElement

  public init(child: LayoutElement, overlay: LayoutElement) {
    self.child = child
    self.overlay = overlay
  }

  public func defineLayout(target: Node) -> Node {

    target.yoga.isEnabled = true

    let overlayNode = overlay.defineLayout(target: target)

    overlayNode.configureLayout { (layout) in
      layout.position = .absolute
      layout.width = YGValue.init(value: 100, unit: .percent)
      layout.height = YGValue.init(value: 100, unit: .percent)
    }

    let childNode = child.defineLayout(target: target)
    childNode.addSubview(overlayNode)

    return target
  }

}

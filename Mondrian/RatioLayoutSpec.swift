//
//  RatioLayoutSpec.swift
//  Mondrian
//
//  Created by muukii on 3/8/18.
//  Copyright © 2018 muukii. All rights reserved.
//

import Foundation

import YogaKit

public struct RatioLayoutSpec : LayoutSpec {

  /// Width : Height = width / height
  public let ratio: CGFloat

  public let child: LayoutElement

  public init(ratio: CGFloat, child: LayoutElement) {
    self.ratio = ratio
    self.child = child
  }

  public func defineLayout(target: Node) -> Node {

    target.yoga.isEnabled = true

    let childNode = child.defineLayout(target: target)

    childNode.configureLayout { layout in
      layout.aspectRatio = self.ratio
    }

    target.addSubview(childNode)

    return childNode

  }

}

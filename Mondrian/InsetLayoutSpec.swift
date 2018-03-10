//
//  InsetLayoutSpec.swift
//  Mondrian
//
//  Created by muukii on 3/8/18.
//  Copyright © 2018 muukii. All rights reserved.
//

import Foundation

import YogaKit

public struct InsetLayoutSpec : LayoutSpecInternal {

  let view = LayoutNode()

  public let insets: UIEdgeInsets

  public let child: LayoutElement

  public init(insets: UIEdgeInsets, child: LayoutElement) {
    self.insets = insets
    self.child = child

    self.style.margin = insets
  }

  public func layout(target: Node) -> Node {

    target.yoga.isEnabled = true

    view.configureLayout { (layout) in
      self.style.apply(to: layout)      
    }

    target.addSubview(view)

    let node = child.layout(target: view)

    view.addSubview(node)

    return view
  }

}

//
//  OverlayLayoutSpec.swift
//  Mondrian
//
//  Created by muukii on 3/8/18.
//  Copyright © 2018 muukii. All rights reserved.
//

import Foundation

import YogaKit

public struct OverlayLayoutSpec : LayoutSpecInternal {

  let view: LayoutNode = .init()

  public let child: LayoutElement

  public let overlay: LayoutElement

  public init(child: LayoutElement, overlay: LayoutElement) {
    self.child = child
    self.overlay = overlay
  }

  public func layout(target: Node) -> Node {

    target.yoga.isEnabled = true

    target.addSubview(view)

    view.configureLayout { (layout) in
      self.style.apply(to: layout)
    }

    let _overlay = overlay.layout(target: view)

    _overlay.configureLayout { (layout) in
      layout.position = .absolute
      layout.width = YGValue.init(value: 100, unit: .percent)
      layout.height = YGValue.init(value: 100, unit: .percent)
    }

    view.addSubview(child.layout(target: view))
    view.addSubview(_overlay)

    return view
  }

}

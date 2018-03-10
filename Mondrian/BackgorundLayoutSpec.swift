//
//  BackgorundLayoutSpec.swift
//  Mondrian
//
//  Created by muukii on 3/8/18.
//  Copyright © 2018 muukii. All rights reserved.
//

import Foundation

import YogaKit

public struct BackgroundLayoutSpec : LayoutSpecInternal {

  let view: LayoutNode = .init()

  public let child: LayoutElement

  public let background: LayoutElement

  public init(child: LayoutElement, background: LayoutElement) {
    self.child = child
    self.background = background
  }

  public func layout(target: Node) -> Node {

    target.yoga.isEnabled = true

    target.addSubview(view)

    view.configureLayout { (layout) in
      self.style.apply(to: layout)
    }

    let _background = background.layout(target: view)

    _background.configureLayout { (layout) in
      layout.position = .absolute
      layout.width = YGValue.init(value: 100, unit: .percent)
      layout.height = YGValue.init(value: 100, unit: .percent)
    }

    view.addSubview(_background)
    view.addSubview(child.layout(target: view))

    return view
  }

}

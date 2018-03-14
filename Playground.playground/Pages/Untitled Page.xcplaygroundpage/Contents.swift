//: Playground - noun: a place where people can play

import UIKit
import Mondrian

import PlaygroundSupport

let view = UIView()

let a = UIView()
a.style.height = .points(100)
a.style.width = .points(100)

a.backgroundColor = UIColor.init(white: 0.95, alpha: 1)

let b = UIView()
b.backgroundColor = UIColor.init(white: 0.90, alpha: 1)

let c = UIView()
c.backgroundColor = UIColor.init(white: 0.85, alpha: 1)

let spec = InsetLayoutSpec(
  insets: .init(top: 4, left: 4, bottom: 4, right: 4),
  child: InsetLayoutSpec(
    insets: .init(top: 4, left: 4, bottom: 4, right: 4),
    child: InsetLayoutSpec(
      insets: .init(top: 4, left: 4, bottom: 4, right: 4),
      child: StackLayoutSpec(
        direction: .horizontal,
        justifyContent: .start,
        alignItems: .center,
        flexWrap: .noWrap,
        children: [
          a,
          b,
          c,
          ]
      )
    )
  )
)

view.frame.size = .init(width: 300, height: 300)

spec.layout(target: view)

print(view.subviews.first?.subviews)

view.relayout()

PlaygroundPage.current.liveView = view

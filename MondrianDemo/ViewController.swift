//
//  ViewController.swift
//  MondrianDemo
//
//  Created by muukii on 3/10/18.
//  Copyright © 2018 muukii. All rights reserved.
//

import UIKit

import Mondrian

enum Factory {

  static func box(color: UIColor) -> UIView {

    let box = UIView()
    box.backgroundColor = color
    return box
  }

  static func elasticLabel(text: String) -> UILabel {

    let label = UILabel()
    label.text = text
    label.numberOfLines = 0

    return label
  }
}

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    let view = UIView()

    let a = Factory.box(color: .init(white: 0.95, alpha: 1))
    a.style.height = .points(100)
    a.style.flexShrink = 1
    a.style.width = .points(100)

    let b = Factory.box(color: .init(white: 0.90, alpha: 1))
    b.style.height = .points(100)
    b.style.flexShrink = 1
    b.style.width = .points(50)

    let c = Factory.box(color: .init(white: 0.85, alpha: 1))
    c.style.height = .points(100)
    c.style.width = .points(100)

    let label = Factory.elasticLabel(text: "Hello Mondrian")
    label.style.flexShrink = 1

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
              ProfileView(),
              label,
              c,
              ]
          )
        )
      )
    )

//    view.frame.size = .init(width: 300, height: 300)

    let _view = spec.layout(target: view)

    print(view.subviews.first?.subviews)

    _view.style.width = .points(300)
    _view.style.height = .points(300)

    _view.relayout()

//    print(view.yoga.calculateLayout(with: .init(width: 1000, height: 1000)))

    self.view.addSubview(_view)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

class ProfileView : UIView, LayoutView {

  private let name: UILabel = .init()
  private let nickname: UILabel = .init()
  private let introduction: UILabel = .init()

  init() {
    super.init(frame: .zero)

    name.text = "Hiroshi Kimura"
    nickname.text = "muukii"
    introduction.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry"
    introduction.numberOfLines = 0
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func layoutSpec() -> LayoutSpec {
    
    var spec = InsetLayoutSpec(
      insets: .init(top: 10, left: 10, bottom: 10, right: 10),
      child: StackLayoutSpec(
        direction: .vertical,
        justifyContent: .start,
        alignItems: .start,
        flexWrap: .noWrap,
        children: [
          name,
          nickname,
          introduction,
        ]
      )
    )

    spec.style.flexShrink = 1

    return spec
  }

}

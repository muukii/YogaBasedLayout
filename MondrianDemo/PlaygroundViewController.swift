//
//  PlaygroundViewController.swift
//  MondrianDemo
//
//  Created by muukii on 3/11/18.
//  Copyright © 2018 muukii. All rights reserved.
//

import UIKit

import Mondrian
import Then

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

class PlaygroundViewController : UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    let view = RootView()

    view.frame.origin.y = 100
    view.frame.size = .init(width: 300, height: 300)

    view.layout(target: view)

    self.view.addSubview(view)

    view.style.width = .points(300)
    view.style.height = .points(300)

    view.relayout()

  }
}

extension PlaygroundViewController {

  class RootView : UIView, LayoutView {

    let boxes: [UIView]

    init() {

      boxes = (0..<5).map { _ in
        UIView()
      }

      super.init(frame: .zero)

      backgroundColor = UIColor.init(white: 0.95, alpha: 1)

      boxes
        .forEach {
          $0.backgroundColor = UIColor.init(white: 0.9, alpha: 1)
          $0.style.height = .points(30)
      }

    }

    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    func layoutSpec() -> LayoutSpec {

      var spec = StackLayoutSpec(
        direction: .vertical,
        spacing: 8,
        justifyContent: .spaceBetween,
        alignItems: .stretch,
        flexWrap: .noWrap,
        children: boxes + [
          WrapperLayoutSpec.init(children: [
            UILabel().then {
              $0.text = "hoge"
            },
//            UILabel().then {
//              $0.text = "fugafuga"
//            },
            ])
        ]
      )

      spec.style.flexGrow = 1

      return spec
    }

  }
}

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

    view.defineLayout(target: view)

    self.view.addSubview(view)

    view.mond.style.width = .points(300)
    view.mond.style.height = .points(300)

    view.mond.relayout()

  }
}

extension PlaygroundViewController {

  class RootView : UIView, MondrianViewType {

    let boxes1: [UIView] = (0..<5).map { _ in
      UIView()
    }

    let boxes2: [UIView] = (0..<5).map { _ in
      UIView()
    }

    let boxes3: [UIView] = (0..<5).map { _ in
      UIButton.init(type: .system).then {
        $0.setTitle("Hello", for: .normal)
      }
    }

    init() {

      super.init(frame: .zero)

      backgroundColor = UIColor.init(white: 0.95, alpha: 1)

      (boxes1 + boxes2)
        .forEach {
          $0.backgroundColor = UIColor.init(white: 0.9, alpha: 1)
          $0.mond.style.height = .points(30)
          $0.mond.style.width = .points(30)
      }

    }

    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    func layoutSpec() -> LayoutSpec {

      var stack = StackLayoutSpec(
        direction: .vertical,
        spacing: 8,
        justifyContent: .spaceBetween,
        alignItems: .stretch,
        flexWrap: .noWrap,
        children: [
          StackLayoutSpec(
            direction: .horizontal,
            spacing: 8,
            justifyContent: .start,
            alignItems: .stretch,
            flexWrap: .noWrap,
            children: boxes1
          ),
          StackLayoutSpec(
            direction: .horizontal,
            spacing: 8,
            justifyContent: .center,
            alignItems: .stretch,
            flexWrap: .noWrap,
            children: boxes2
          ),
          StackLayoutSpec(
            direction: .horizontal,
            spacing: 8,
            justifyContent: .end,
            alignItems: .stretch,
            flexWrap: .noWrap,
            children: boxes3
          )
        ]
      )

      stack.style.flexGrow = 1

      /*
       RelativeLayoutSpec(
       sizing: .minimumWidth(horizontalPosition: .end),
       child: UILabel().then {
       $0.numberOfLines = 0
       $0.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry"
       }
       )
       */

      var spec = OverlayLayoutSpec(
        child: stack,
        overlay: InsetLayoutSpec(
          insets: .init(top: .infinity, left: .infinity, bottom: 16, right: 16),
          child: UILabel().then {
            $0.numberOfLines = 0
            $0.text = (0..<100).map { String($0) }.joined()
          }
        )
      )

      return InsetLayoutSpec(
        insets: .init(top: 16, left: 16, bottom: 16, right: 16),
        child: UILabel().then {
          $0.numberOfLines = 0
          $0.text = (0..<100).map { String($0) }.joined()
        }
      )

//      var spec = OverlayLayoutSpec(
//        child: stack,
//        overlay: UILabel().then {
//          $0.numberOfLines = 0
//          $0.text = (0..<100).map { String($0) }.joined()
//        }
//      )

      return spec
    }

  }
}

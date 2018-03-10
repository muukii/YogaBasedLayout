//
//  PlaygroundTextureViewController.swift
//  MondrianDemo
//
//  Created by muukii on 3/11/18.
//  Copyright © 2018 muukii. All rights reserved.
//

import UIKit

import AsyncDisplayKit

class PlaygroundTextureViewController : UIViewController {

  override func viewDidLoad() {

    super.viewDidLoad()

    let node = RootNode()

    node.frame.origin.y = 100
    node.frame.size = .init(width: 300, height: 300)

    view.addSubnode(node)

  }
}

extension PlaygroundTextureViewController {

  class RootNode : ASDisplayNode {

    let boxes: [ASDisplayNode]

    override init() {

      boxes = (0..<5).map { _ in
        ASDisplayNode()
      }

      super.init()

      backgroundColor = UIColor.init(white: 0.95, alpha: 1)

      boxes
        .forEach {
          $0.backgroundColor = UIColor.init(white: 0.9, alpha: 1)
          $0.style.height = ASDimension.init(unit: .points, value: 30)
      }

      automaticallyManagesSubnodes = true

    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {

      return ASStackLayoutSpec(
        direction: .vertical,
        spacing: 8,
        justifyContent: .spaceBetween,
        alignItems: .stretch,
        children: boxes + [
          ASWrapperLayoutSpec(layoutElement: ASTextNode().then {
            $0.attributedText = NSAttributedString.init(string: "hoge")
          })
        ]
      )
    }
  }
}

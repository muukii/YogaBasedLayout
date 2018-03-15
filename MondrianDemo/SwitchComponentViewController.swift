//
//  SwitchComponentViewController.swift
//  MondrianDemo
//
//  Created by muukii on 3/13/18.
//  Copyright © 2018 muukii. All rights reserved.
//

import UIKit

import Mondrian

final class SwitchComponentViewController : UIViewController {

  private let customView: View = .init()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(customView)

    customView.frame.origin.y = 120
    customView.mond.style.width = .points(320)
    customView.mond.invalidateLayoutSpec()
    customView.mond.layout(mode: .flexibleHeight)
  }
}

extension SwitchComponentViewController {

  private final class View : MondrianView {

    private let button: UIButton = .init(type: .system)

    private let label: UILabel = .init()

    private var isOn: Bool = false

    init() {
      super.init(frame: .zero)

      button.setTitle("Toggle", for: .normal)
      label.text = "Hello"

      button.addTarget(self, action: #selector(toggle), for: .touchUpInside)
    }

    override func layoutSpec() -> LayoutSpec {

      if isOn {

        return StackLayoutSpec(
          direction: .vertical,
          spacing: 8,
          justifyContent: .start,
          alignItems: .stretch,
          children: [
            button,
            label
          ])

      } else {

        return StackLayoutSpec(
          direction: .vertical,
          spacing: 8,
          justifyContent: .start,
          alignItems: .stretch,
          children: [
            button,
          ])
      }

    }

    @objc
    private func toggle() {
      isOn = !isOn
      mond.invalidateLayoutSpec()
      mond.layout(mode: .flexibleHeight)
    }
  }
}

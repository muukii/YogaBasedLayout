//: [Previous](@previous)

import Mondrian
import PlaygroundSupport

class MyView : MondrianView {

  let box = UIView()

  init() {

    super.init(frame: .zero)

    backgroundColor = .white
    box.backgroundColor = .red

  }

  override func layoutSpec() -> LayoutSpec {

    return
      InsetLayoutSpec(
        insets: .init(top: 8, left: 8, bottom: 8, right: 8),
        child: RatioLayoutSpec(ratio: 0.2, child: box)
    )
  }
}

let view = MyView()
view.mond.style.width = .points(100)
view.sizeToFit()

view.yoga.intrinsicSize

PlaygroundPage.current.liveView = view

//: [Next](@next)

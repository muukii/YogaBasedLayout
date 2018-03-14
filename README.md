# Mondrian

Mondrian provides the layout interface like TetureGroup/Texture with high-optimized layout engine facebook/yoga flexbox implementation.

## Requirements

- iOS 8.0+
- Swift 4.0

## Introduction Examples

Mondrian has layout interface like [TetureGroup/Texture](http://texturegroup.org/docs/layout2-quickstart.html).

This interface makes view-structure easy to see.
It projects view-tree like the actual tree of UIView as code.

In easy use, We can make sub-class of `MondrianView`
`MondrianView` has some functions for control-flow layout.

(If we can't make sub-class of `MondrianView`, we can use `MondrianViewType` protocol.)

```swift
class MyView : MondrianView {

  let titleLabel = UILabel()
  let detailLabel = UILabel()

  init() {

    super.init(frame: .zero)

    backgroundColor = .white
    titleLabel.text = "Book Title"
    detailLabel.text = "Boot detail"

  }

  override func layoutSpec() -> LayoutSpec {

    let body = StackLayoutSpec(
      direction: .vertical,
      spacing: 8,
      justifyContent: .end,
      alignItems: .start,
      flexWrap: .noWrap,
      children: [
        titleLabel,
        detailLabel,
        ]
    )

    let inset = InsetLayoutSpec(
      insets: .init(top: 16, left: 16, bottom: 16, right: 16),
      child: body
    )

    return inset
  }
}
```

```swift
let view = MyView()
view.sizeToFit()
```

## Documentation

// TODO:

### Specs

- StackLayoutSpec
- InsetLayoutSpec
- RelativeLayoutSpec
- CenterLayoutSpec
- BackgroundLayoutSpec
- OverlayLayoutSpec
- WrapperLayoutSpec
- EntryPoint

## Installation

// TODO:

Currently, available only Carthage.
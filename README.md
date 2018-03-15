# Mondrian

Mondrian provides the layout interface like TextureGroup/Texture with high-optimized layout engine facebook/yoga flexbox implementation.

## Requirements

- iOS 8.0+
- Swift 4.0

## Introduction Examples

Mondrian has layout interface like [TextureGroup/Texture](http://texturegroup.org/docs/layout2-quickstart.html).

This interface makes view-structure easy to see.
It projects view-tree like the actual tree of UIView as code.

In easy use, We can make sub-class of `MondrianView`
`MondrianView` has some functions for control-flow layout.

(If we can't make sub-class of `MondrianView`, we can use `MondrianViewType` protocol that `MondrianView` has.)

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

### Update layout (add or remove or resize subviews)

// TODO:

### Calculate view size (for UICollectionView | UITableView)

`MondrianViewType` has `calculateSize(with rule: CalculateRule) -> CGSize`

Example for UICollectionView

```swift

// for sizing cell
let sizingCell: MyCell = .init(frame: .zero)

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

  let size = sizingCell.mond.calculateSize(with: .fixedWidth(collectionView.bounds.width))

  return size

}
```

In Cell class

```swift
final class MyCell : UICollectionViewCell, MondrianViewType {

  var targetView: UIView {
    // Specify target view that applies layout.
    // LayoutSpec from this class applies layout from contentView.
    return contentView
  }

  ...

  override func layoutSubviews() {
    super.layoutSubviews()

    mond.layout()
  }

  func layoutSpec() -> LayoutSpec {
    return ...
  }
}
```

## Performance

// TODO:

## Installation

// TODO:

Currently, available only Carthage.
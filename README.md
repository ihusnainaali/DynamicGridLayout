# DynamicGridLayout

## Overview
DynamicGridLayoutDelegate is a subclass of UICollectionViewLayout inspired by iOS Springboard.

## Usage
Simply add DynamicGridLayout.swift to your project and adopt your view controller to DynamicGridLayoutDelegate protocol by adding three variables:

```swift
var cellsPerRow: Int = 3
var cellsPerColumn: Int = 4
var cellsSpacing: Int = 10
```
- *cellsPerRow* is a number of cells per one row (x axis) 
- *cellsPerColumn* is a number of cells per one column (y axis)
- *cellsSpacing* is a spacing in a grid between cells


Set your view controller as delegate for DynamicGridLayout:

```swift
// ViewDidLoad()
if let layout = collectionView?.collectionViewLayout as? DynamicGridLayout {
    layout.delegate = self
} else {
    fatalError("DynamicGridLayout is not choosen as a layout for collectionView!")
}
```

Define DynamicGridLayout as layout for your UICollectionView in Storyboard:

![alt text][storyboard-example]


or programatically:
```swift
// ViewDidLoad()
let dynamicGridLayout = DynamicGridLayout()
self.yourCollectionView.collectionViewLayout = dynamicGridLayout
```


Don't forget to enable paging and hide scroll indicators:
```swift
// ViewDidLoad()
yourCollectionView.showsVerticalScrollIndicator = false
yourCollectionView.showsHorizontalScrollIndicator = false
yourCollectionView.isPagingEnabled = true

// Optionally set decelerationRate as .fast
yourCollectionView?.decelerationRate = UIScrollView.DecelerationRate.fast
```


Size of the cells will be calculated from grid parameters and UICollectionView bounds size. See examples below:


### 3 x 4
![alt text][3x4]

### 4 x 6
![alt text][4x6]

### 3 x 3
![alt text][3x3]

### 2 x 3
![alt text][2x3]

### or even 6 x 9
![alt text][6x9]

## Example
Example project can be found in /example directory.

## Roadmap
- [ ] Nice .gif in Overview
- [ ] Framework
- [ ] Cocoapods support
- [ ] Tests

## Author
Mikhail Kuzmin, mkuzmin231@gmail.com

## License
DynamicGridLayout is available under the MIT license. See the [LICENSE](https://github.com/ImKuz/DynamicGridLayout/blob/master/README.md) file for more info.

[storyboard-example]: https://github.com/ImKuz/DynamicGridLayout/blob/master/images/storyboard-example.png
[3x4]: https://github.com/ImKuz/DynamicGridLayout/blob/master/images/3x4.png
[4x6]: https://github.com/ImKuz/DynamicGridLayout/blob/master/images/4x6.png
[3x3]: https://github.com/ImKuz/DynamicGridLayout/blob/master/images/3x3.png
[2x3]: https://github.com/ImKuz/DynamicGridLayout/blob/master/images/2x3.png
[6x9]: https://github.com/ImKuz/DynamicGridLayout/blob/master/images/6x9.png


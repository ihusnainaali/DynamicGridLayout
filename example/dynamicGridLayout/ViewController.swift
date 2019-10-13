//
//  ViewController.swift
//  dynamicGridLayout
//
//  Created by Mikhail Kuzmin on 02/06/2019.
//  Copyright © 2019 Mikhail Kuzmin. All rights reserved.
//

import UIKit

class Cell: UICollectionViewCell {
    
    var cardCornerRadius: CGFloat = 4
    
    var shadowOffsetWidth: Int = 0
    var shadowOffsetHeight: Int = 3
    var shadowColor: UIColor? = UIColor.black
    var shadowOpacity: Float = 0.7
    
    override func layoutSubviews() {
        layer.cornerRadius = cardCornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cardCornerRadius)
        layer.backgroundColor = UIColor.gray.cgColor
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
}

class ViewController: UIViewController, DynamicGridLayoutDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    var numberOfItems = 32
    var numberOfPages = 0
    
    var cellsSpacing = 10
    var cellsPerRow = 3
    var cellsPerColumn = 4

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(Cell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView?.decelerationRate = UIScrollView.DecelerationRate.fast
        
        let itemsCount = collectionView.numberOfItems(inSection: 0)
        let cellsPerSection = Int(cellsPerRow * cellsPerColumn)
        numberOfPages = itemsCount / cellsPerSection
        
        if itemsCount % cellsPerSection > 0 {
            numberOfPages += 1
        } else if itemsCount > 0 && itemsCount < cellsPerSection {
            numberOfPages += 1
        }
        if let layout = collectionView?.collectionViewLayout as? DynamicGridLayout {
            layout.delegate = self
        } else {
            fatalError("DynamicGridLayout is not choosen as a layout for collectionView!")
        }
    }
    
    override func viewDidLayoutSubviews() {
        pageControl.numberOfPages = Int(numberOfPages)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
        for: indexPath) as! Cell
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidth = Float(UIScreen.main.bounds.width)
        let targetXContentOffset = Float(targetContentOffset.pointee.x)
        let contentWidth = Float(collectionView.contentSize.width)

        var newPage = Float(self.pageControl.currentPage)

        if velocity.x == 0 {
            newPage = floor( (targetXContentOffset - Float(pageWidth) / 2) / Float(pageWidth)) + 1.0
        } else {
            newPage = Float(velocity.x > 0 ? self.pageControl.currentPage + 1 : self.pageControl.currentPage - 1)
            if newPage < 0 {
                newPage = 0
            }
            if newPage > contentWidth / pageWidth {
                newPage = ceil(contentWidth / pageWidth) - 1.0
            }
        }
        
        self.pageControl.currentPage = Int(newPage)
        let point = CGPoint(x: CGFloat(newPage * pageWidth), y: targetContentOffset.pointee.y)
        targetContentOffset.pointee = point
    }
}

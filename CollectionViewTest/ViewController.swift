//
//  ViewController.swift
//  CollectionViewTest
//
//  Created by 段昊宇 on 16/4/15.
//  Copyright © 2016年 Desgard_Duan. All rights reserved.
//

import UIKit


final class ViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    private var array: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "CollectionViewTest"
        
        
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .Vertical
        flowlayout.itemSize = CGSize(width: UIScreen.mainScreen().bounds.width / 4, height: UIScreen.mainScreen().bounds.width /  4)
        flowlayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowlayout.minimumInteritemSpacing = 0.0;
        flowlayout.minimumLineSpacing      = 0.0;
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowlayout)
        
        for i in 0...30 {
            array.append(i)
        }
        
        // 设置代理
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        // 注册
        collectionView?.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        // 添加手势
        collectionView?.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongGesture(_:))))
        
        if let collectionView = collectionView {
            collectionView.backgroundColor = UIColor.whiteColor()
            view.addSubview(collectionView)
        }
    }
    
    func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        if let collectionView = collectionView {
            switch(gesture.state) {
                
            case UIGestureRecognizerState.Began:
                guard let selectedIndexPath = self.collectionView?.indexPathForItemAtPoint(gesture.locationInView(self.collectionView)) else {
                    break
                }
                collectionView.beginInteractiveMovementForItemAtIndexPath(selectedIndexPath)
            case UIGestureRecognizerState.Changed:
                collectionView.updateInteractiveMovementTargetPosition(gesture.locationInView(gesture.view!))
            case UIGestureRecognizerState.Ended:
                collectionView.endInteractiveMovement()
            default:
                collectionView.cancelInteractiveMovement()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: (UIScreen.mainScreen().bounds.width - 10) / 4, height: (UIScreen.mainScreen().bounds.width - 10) / 4 + 20)
    }
    
    func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
    }
    
    func collectionView(collectionView: UICollectionView, moveItemAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let temp = array.removeAtIndex(sourceIndexPath.item)
        array.insert(temp, atIndex: destinationIndexPath.item)
    }
    
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let id = "cell"
        let cell: CollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(id, forIndexPath: indexPath) as! CollectionViewCell
        cell.sizeToFit()
        
        cell.imageView?.image = UIImage(named: "logo.png")
        cell.text?.text = "\(array[indexPath.row])"
        return cell
    }
}


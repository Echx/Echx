//
//  LevelSelectorViewDesigner.swift
//  Planck
//
//  Created by NULL on 07/04/15.
//  Copyright (c) 2015年 Echx. All rights reserved.
//

import UIKit

class LevelSelectorViewDesigner: XViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private let itemsInSection = 5
    private let sectionInsets = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 20.0, right: 50.0)
    
    var levelArray:[GameLevel] = [GameLevel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadLevels()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return (levelArray.count + itemsInSection - 1) / itemsInSection
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if levelArray.count >= (section + 1) * 5 {
            // can afford #itemsInSection
            return itemsInSection
        } else {
            return levelArray.count - section * 5
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ReuseableID.LevelSelectCell , forIndexPath: indexPath) as LevelSelectCollectionViewCell
        println(indexPath.section * itemsInSection + indexPath.item)
        let game = levelArray[indexPath.section * itemsInSection + indexPath.item]
        let nameChar = ["I", "II", "III", "IV", "V"]
        
        cell.title.text = nameChar[indexPath.item]
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: ReuseableID.LevelSelectHeader, forIndexPath: indexPath) as LevelSelectHeaderView
            header.title.text = "Echx Present"
            return header
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let item = levelArray[indexPath.section * itemsInSection + indexPath.item]
        println("I'm selected! \(item.name)")
    }
    
    func collectionView(collectionView: UICollectionView!,
        layout collectionViewLayout: UICollectionViewLayout!,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return sectionInsets
    }
    
    private func loadLevels() {
        // find out the document path
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)[0] as NSString
        let fileManager = NSFileManager.defaultManager()
        let fileArray = fileManager.contentsOfDirectoryAtPath(path,
            error: nil)! as NSArray
        
        var levelFileLoader = StorageManager.defaultManager
        // iterate each filename to add
        for filename in fileArray {
            if ((filename.pathExtension) != nil) {
                if (filename.pathExtension == StorageDefault.levelDataType) {
                    let game = levelFileLoader.loadLevel(filename as NSString)
                    levelArray.append(game)
                }
            }
        }
    }

}

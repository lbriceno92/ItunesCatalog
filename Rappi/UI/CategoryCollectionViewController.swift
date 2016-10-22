//
//  CategoryCollectionViewController.swift
//  Rappi
//
//  Created by lbriceno on 10/19/16.
//  Copyright © 2016 Lbriceno. All rights reserved.
//

import UIKit

private let reuseIdentifier = "categoryCel"

protocol CategoryClicked {
    func itemClicked(item: Category)
}

class CategoryCollectionViewController: UICollectionViewController,CollectionView {
    
    var categories = Array<Category>();
    var delegate: CategoryClicked?
    
    func reloadData(){
        categories = DatabaseManager().getCategories();
        self.collectionView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.backgroundColor = UIColor.clearColor();
        self.collectionView?.backgroundView = UIView(frame: CGRect())
        
        self.collectionView!.registerClass(EntryCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        if(UIDevice.currentDevice().userInterfaceIdiom == .Phone){
            
            UIView.animateWithDuration(0.2) { () -> Void in
                self.collectionView!.collectionViewLayout.invalidateLayout()
                self.collectionView!.setCollectionViewLayout(ListFlowLayout(), animated: true)
            }
        }else{
            
            UIView.animateWithDuration(0.2) { () -> Void in
                self.collectionView!.collectionViewLayout.invalidateLayout()
                self.collectionView!.setCollectionViewLayout(GridFlowLayout(), animated: true)
            }
        }
        
    }
    override func viewWillAppear(animated: Bool) {
        self.collectionView?.performBatchUpdates({
            self.collectionView?.reloadData();
            }, completion: { (completed) in
                
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count;
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("categoryCell", forIndexPath: indexPath) as! CategoryCellCollectionViewCell
        //        cell.backgroundColor = UIColor.black
        // Configure the cell
        cell.name.text = categories[indexPath.row].term
        cell.layer.cornerRadius = 4
        let finalCellFrame = cell.frame;
        let translation = collectionView.panGestureRecognizer.translationInView(collectionView.superview);
        
        if translation.x > 0{
            cell.frame = CGRect(x: finalCellFrame.origin.x - 1000, y: -500.0, width: 0, height: 0)
        }else{
            cell.frame = CGRect(x: finalCellFrame.origin.x + 1000, y: -500.0, width: 0, height: 0)
        }
        UIView.animateWithDuration(0.4) {
            cell.frame = finalCellFrame;
        }
        
        return cell
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        
    }
    
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        var cell =  collectionView.cellForItemAtIndexPath(indexPath)! as! CategoryCellCollectionViewCell;
        var frame = cell.frame

        UIView.animateWithDuration(0.3 ,
                                   animations: {
                                    cell.backgroundColor = UIColor.lightGrayColor()
                                    cell.name.textColor = UIColor.whiteColor()
                                    frame.origin.x = cell.frame.size.width;
                                    cell.frame = frame
                                    
            },
                                   completion: { finish in
                                    UIView.animateWithDuration(0.4){
                                        cell.backgroundColor = UIColor.whiteColor()
                                        cell.name.textColor = UIColor.lightGrayColor()
                                        self.delegate?.itemClicked(self.categories[indexPath.row])
                                      
                                    }
        })
    }
    
    
    
}

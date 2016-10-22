//
//  EntryCollectionViewController.swift
//  Rappi
//
//  Created by lbriceno on 10/19/16.
//  Copyright © 2016 Lbriceno. All rights reserved.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "entryCell"

class EntryCollectionViewController: UICollectionViewController,CollectionView {
    var categoryId: String?;
    var entries:Array<Entry>?;
    var delegate: CategoryClicked?
    var selectedEntry: Entry?;
    weak var selectedCell: EntryCollectionViewCell?;
    
    let transitionDelegate: TransitioningDelegate = TransitioningDelegate()
    
    func reloadData(){
        if (self.categoryId != nil)  {
            entries = DatabaseManager().getEntries(byCategoryId: self.categoryId!);
            self.collectionView?.reloadData()
        }
        
    }
    
    func fillWithCategory(categoryId:String)-> Void {
        self.categoryId = categoryId;
        reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.backgroundColor = UIColor.clearColor();
        self.collectionView?.backgroundView = UIView(frame: CGRect())
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        entries = Array<Entry>();
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
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return entries!.count;
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! EntryCollectionViewCell;
        // Configure the cell
        cell.layer.cornerRadius = 4
        cell.logo.sd_setImageWithURL(NSURL(string:(Array(entries![indexPath.row].itemimage).first?.label)!), placeholderImage:UIImage(named: "placeholder"))
        cell.logo.layer.cornerRadius = cell.logo.bounds.size.width/2
        cell.logo.clipsToBounds = true;
        cell.desc.text = entries![indexPath.row].summary?.label
        cell.name.text = entries![indexPath.row].itemname?.label
        return cell
    }
    
    
    
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        let cell =  collectionView.cellForItemAtIndexPath(indexPath)! as! EntryCollectionViewCell;
        self.selectedCell = cell;
        let attributes = collectionView.layoutAttributesForItemAtIndexPath(indexPath)
        let attributesFrame = attributes?.frame
        let frameToOpenFrom = collectionView.convertRect(attributesFrame!, toView: collectionView.superview)
        transitionDelegate.openingFrame = frameToOpenFrom
        
    
        self.selectedEntry = entries![indexPath.row];
        UIView.animateWithDuration(0.3 ,
                                   animations: {
                                    cell.backgroundColor = UIColor.lightGrayColor()
                                    cell.name.textColor = UIColor.whiteColor()
            },
                                   completion: { finish in
                                    UIView.animateWithDuration(0.2){
                                        cell.backgroundColor = UIColor.whiteColor()
                                        cell.name.textColor = UIColor.lightGrayColor()
                                        
                                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                                        
                                        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("entryDetailController") as! EntryDetailViewController
                                        nextViewController.addEntryObject(self.selectedEntry!);
                                        nextViewController.transitioningDelegate = self.transitionDelegate
                                        nextViewController.modalPresentationStyle = .FullScreen
                                        self.presentViewController(nextViewController, animated:true, completion:nil)
                                    }
        })
    }
    
    
}

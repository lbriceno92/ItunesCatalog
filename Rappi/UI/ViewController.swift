//
//  ViewController.swift
//  Rappi
//
//  Created by lbriceno on 10/18/16.
//  Copyright © 2016 Lbriceno. All rights reserved.
//

import UIKit
import SDWebImage
class ViewController: UIViewController,CategoryClicked,UINavigationControllerDelegate{
    
    @IBOutlet weak var entryCollectionView: UIView!
    @IBOutlet weak var categoryCollectionView: UIView!
    @IBOutlet weak var appleImage: UIImageView!
    @IBOutlet weak var rights: UILabel!
    @IBOutlet weak var lastUpdate: UILabel!
    @IBOutlet weak var dataTitle: UILabel!
    @IBOutlet weak var categoryCancelButton: UIButton!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var categoryTitleView: UIView!
    @IBOutlet weak var titleView: UIView!
    
    var feed :Feed?;
    var categoryCollectionViewController : CategoryCollectionViewController?;
    var entryCollectionViewController : EntryCollectionViewController?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryCancelButton.layer.cornerRadius = categoryCancelButton.bounds.width/2;
        self.appleImage.layer.cornerRadius = self.appleImage.bounds.size.width/2
        self.appleImage.clipsToBounds = true;
        self.fillData()
        self.addGradientBackground()
        entryCollectionView.alpha = 0;
        NetworkingManager().makeFeedRequest { (response, error) in
            self.fillData()
            self.categoryCollectionViewController?.reloadData()
            self.showViewWithText(response)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentationAnimator()
    }
    
    override func viewDidAppear(animated: Bool) {
    }
    @IBAction func cancelButton(sender: AnyObject) {
        
        var frame = categoryTitleView.frame
        
        UIView.animateWithDuration(0.6, animations: {
            frame.origin.x = self.view.frame.size.width;
            self.categoryTitleView.frame = frame;
            
        }) { (completed) in
            self.categoryCollectionViewController?.reloadData()
            self.titleView.alpha = 1;
            self.categoryTitleView.alpha = 0;
            self.categoryCollectionView.alpha = 1;
            self.entryCollectionView.alpha = 0
        };
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // you can set this name in 'segue.embed' in storyboard
        if segue.identifier == "categoryViewController" {
            let vc = segue.destinationViewController as! CategoryCollectionViewController
            vc.delegate = self;
            self.categoryCollectionViewController = vc;
            
        }else if segue.identifier == "entryViewController" {
            let vc = segue.destinationViewController as! EntryCollectionViewController
            vc.delegate = self;
            self.entryCollectionViewController = vc;
        }
    }
    
    
    func fillData(){
        
        self.feed = DatabaseManager().getFeed();
        if feed != nil {
            let strTime = self.feed!.updated?.label
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssxxxxx"
            formatter.timeZone = NSTimeZone(name: "UTC")
            
            self.dataTitle.text = self.feed!.author?.name?.label
            self.rights.text = self.feed!.rights?.label
            print(self.feed!.icon?.label)
            self.appleImage.sd_setImageWithURL(NSURL(string:(self.feed!.icon?.label)!), placeholderImage:UIImage(named: "placeholder"))
           
            if let dateFromString = formatter.dateFromString(strTime!) {
                formatter.dateFormat = "MM/dd HH:mm a"
                formatter.timeZone = NSTimeZone.localTimeZone()
                self.lastUpdate.text = formatter.stringFromDate(dateFromString)
            }
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func itemClicked(item: Category) {
        DatabaseManager().getEntries(byCategoryId: item.id!)
        
        var frame = titleView.frame
        frame.origin.x = self.view.frame.size.width;
        categoryTitleView.frame = frame;
        
        self.categoryTitle.text = item.label
        self.categoryTitleView.alpha = 1;
        
        entryCollectionViewController!.fillWithCategory(item.id!)
        
        self.categoryTitleView.alpha = 1;
        
        UIView.animateWithDuration(0.6, animations: {
            frame.origin.x = self.view.frame.origin.x;
            self.categoryTitleView.frame = frame;
            
        }) { (completed) in
            self.categoryCollectionView.alpha = 0;
            self.entryCollectionView.alpha = 1
        };
    }
    
    func addGradientBackground() {
        var arrayOfColors: [AnyObject] = []
        let colorTop: AnyObject = UIColor(red: 51.0/255.0, green: 92.0/255.0, blue: 145.0/255.0, alpha: 1.0).CGColor
        let colorBottom: AnyObject = UIColor(red: 75.0/255.0, green: 140.0/255.0, blue: 202.0/255.0, alpha: 1.0).CGColor
        arrayOfColors = [colorTop, colorBottom]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.frame
        gradientLayer.colors = arrayOfColors
        gradientLayer.locations = [0.0, 1.0]
        view.layer.insertSublayer(gradientLayer, below: self.titleView?.layer)
        
    }
    
    
    func showViewWithText(text:String){
        let snackHeight = CGFloat(30.0);
        let snackView = UILabel(frame: CGRect(x: 0, y: (self.view.layer.frame.size.height + snackHeight), width: self.view.layer.frame.width, height: snackHeight));
        snackView.text = text;
        snackView.textAlignment = .Center
        snackView.textColor = UIColor.whiteColor()
        snackView.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(snackView)
        var frame = snackView.frame
        
        UIView.animateWithDuration(1, animations: {
            frame.origin.y = (self.view.layer.frame.size.height - snackHeight);
            snackView.frame = frame
        }) { (finished) in
            
            UIView.animateKeyframesWithDuration(1, delay: 4, options:.AllowUserInteraction, animations: {
                frame.origin.y = (self.view.layer.frame.size.height + snackHeight);
                snackView.frame = frame
                }, completion: nil)
            
        }
    }

}


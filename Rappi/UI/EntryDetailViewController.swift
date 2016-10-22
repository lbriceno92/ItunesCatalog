//
//  EntryDetailViewController.swift
//  Rappi
//
//  Created by lbriceno on 10/20/16.
//  Copyright © 2016 Lbriceno. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    @IBOutlet weak var getButton: UIButton!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var cancelButton: UIButton!

    @IBOutlet weak var rights: UILabel!
    @IBOutlet weak var copyright: UILabel!
    
    var entryObject: Entry!;
    override func viewDidLoad() {
        self.getButton.layer.cornerRadius = self.getButton.layer.bounds.size.width/4
        self.desc.layer.cornerRadius = 5
        self.desc.scrollEnabled = false
        self.cancelButton.layer.cornerRadius = self.cancelButton.bounds.size.width/2
    }
    override func viewDidAppear(animated: Bool) {
        self.desc.scrollRangeToVisible(NSRange(location: 0, length: 0))
        self.desc.scrollEnabled = true;
    }
    
    @IBAction func getButton(sender: AnyObject) {
        var link = self.entryObject.link?.attributes?.href;
        link = link?.stringByReplacingOccurrencesOfString("https://", withString: "itms-apps://")
        if let url = NSURL(string:"https://itunes.apple.com/us/developer/netflix-inc./id363590054?mt=8&uo=2"){
            print(url)
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.desc.text = self.entryObject.summary?.label
        self.name.text = self.entryObject.itemname?.label
        self.image.sd_setImageWithURL(NSURL(string:(self.entryObject.itemimage.first?.label)!), placeholderImage:UIImage(named: "placeholder"))
        self.image.layer.cornerRadius = self.image.bounds.size.width/2
        self.image.clipsToBounds = true;
        self.rights.text = String(format:"By:%@",(self.entryObject.itemartist?.label)!);
        self.copyright.text = self.entryObject.rights?.label!
        self.category.text = self.entryObject.category?.label
    }
    
    func addEntryObject(entry: Entry){
        print(entry)
        self.entryObject = entry;
    }
    
    @IBAction func cancelAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

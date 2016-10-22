//
//  DatabaseManager.swift
//  Rappi
//
//  Created by lbriceno on 10/18/16.
//  Copyright © 2016 Lbriceno. All rights reserved.
//

import Foundation
import RealmSwift

public class DatabaseManager{
    let realm = try! Realm()
    
    func getFeed() -> Feed?{
        return (realm.objects(Feed.self).first);
    }
    
    func saveResposneObject(object: Feed) -> Void {
        do{
            if realm.inWriteTransaction {
                realm.cancelWrite();
            }
            realm.beginWrite();
            realm.deleteAll()
            realm.add(object)
            try realm.commitWrite();
            
            print("response saved");
        }catch{
            print("response could not be saved");
        }
    }
    
    func getEntries(byCategoryId categoryId:String)->Array<Entry>{
        let predicate = NSPredicate(format: "category.id BEGINSWITH %@", categoryId);

        let r = realm.objects(Entry.self).filter(predicate);
        
//         Array<Entry>(r).forEach { (entry) in
//            print("\(entry)")
//        };
        return Array<Entry>(r)
    }
    
    func getCategories()->Array<Category>{
        
        let r = realm.objects(Category.self)
        for category in r {
            print("\(category.term)")
        }
       
        var resultArray = Array<Category>();
        
        Array<Category>(r).forEach { (category) in
            var hasCategory = false
            
            resultArray.forEach({ (addedCategory) in
                if category.id == addedCategory.id{
                    hasCategory = true;
                }
            })
            
            if !hasCategory{
                resultArray.append(category)
            }
        }
        
        return resultArray.sort({ (cat1, cat2) -> Bool in
            cat1.term < cat2.term
        });
    }
}
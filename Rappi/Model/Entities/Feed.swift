/*
Copyright (c) 2016 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
import RealmSwift
import Realm

/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Feed : Object{
	dynamic public var author : Author?
	 public var entry =  List<Entry>() ;
	dynamic public var updated : Updated?
	dynamic public var rights : Rights?
	dynamic public var title : Title?
	dynamic public var icon : Icon?
     public var link =  List<Link>() ;
	dynamic public var id : Id?
    

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let feed_list = Feed.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Feed Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Feed]
    {
        var models:[Feed] = []
        for item in array
        {
            models.append(Feed(dictionary: item as! NSDictionary)!)
        }
        return models
    }

   
/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let feed = Feed(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Feed Instance.
*/
	required public init?(dictionary: NSDictionary) {
        super.init()

		if (dictionary["author"] != nil) { author = Author(dictionary: dictionary["author"] as! NSDictionary) }
		if (dictionary["entry"] != nil) { entry.appendContentsOf(Entry.modelsFromDictionaryArray(dictionary["entry"] as! NSArray)) }
		if (dictionary["updated"] != nil) { updated = Updated(dictionary: dictionary["updated"] as! NSDictionary) }
		if (dictionary["rights"] != nil) { rights = Rights(dictionary: dictionary["rights"] as! NSDictionary) }
		if (dictionary["title"] != nil) { title = Title(dictionary: dictionary["title"] as! NSDictionary) }
		if (dictionary["icon"] != nil) { icon = Icon(dictionary: dictionary["icon"] as! NSDictionary) }
        if (dictionary["link"] != nil) { link.appendContentsOf(Link.modelsFromDictionaryArray(dictionary["link"] as! NSArray)) }
		if (dictionary["id"] != nil) { id = Id(dictionary: dictionary["id"] as! NSDictionary) }
	}

		
    required public init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required public init() {
        super.init()
    }
    
    required public init(value: AnyObject, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.author?.dictionaryRepresentation(), forKey: "author")
		dictionary.setValue(self.updated?.dictionaryRepresentation(), forKey: "updated")
		dictionary.setValue(self.rights?.dictionaryRepresentation(), forKey: "rights")
		dictionary.setValue(self.title?.dictionaryRepresentation(), forKey: "title")
		dictionary.setValue(self.icon?.dictionaryRepresentation(), forKey: "icon")
		dictionary.setValue(self.id?.dictionaryRepresentation(), forKey: "id")

		return dictionary
	}

}
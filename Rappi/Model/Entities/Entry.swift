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

public class Entry : Object{
	dynamic public var itemname : Itemname?
     public var itemimage = List<Itemimage>();
	dynamic public var summary : Summary?
	dynamic public var itemprice : Itemprice?
	dynamic public var itemcontentType : ItemcontentType?
	dynamic public var rights : Rights?
	dynamic public var title : Title?
	dynamic public var link : Link?
	dynamic public var id : Id?
	dynamic public var itemartist : Itemartist?
	dynamic public var category : Category?
	dynamic public var itemreleaseDate : ItemreleaseDate?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let entry_list = Entry.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Entry Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Entry]
    {
        var models:[Entry] = []
        for item in array
        {
            models.append(Entry(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let entry = Entry(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Entry Instance.
*/
	required public init?(dictionary: NSDictionary) {
        super.init()

		if (dictionary["im:name"] != nil) { itemname = Itemname(dictionary: dictionary["im:name"] as! NSDictionary) }
		if (dictionary["im:image"] != nil) { itemimage.appendContentsOf(Itemimage.modelsFromDictionaryArray(dictionary["im:image"] as! NSArray))}
		if (dictionary["summary"] != nil) { summary = Summary(dictionary: dictionary["summary"] as! NSDictionary) }
		if (dictionary["im:price"] != nil) { itemprice = Itemprice(dictionary: dictionary["im:price"] as! NSDictionary) }
		if (dictionary["im:contentType"] != nil) { itemcontentType = ItemcontentType(dictionary: dictionary["im:contentType"] as! NSDictionary) }
		if (dictionary["rights"] != nil) { rights = Rights(dictionary: dictionary["rights"] as! NSDictionary) }
		if (dictionary["title"] != nil) { title = Title(dictionary: dictionary["title"] as! NSDictionary) }
		if (dictionary["link"] != nil) { link = Link(dictionary: dictionary["link"] as! NSDictionary) }
		if (dictionary["id"] != nil) { id = Id(dictionary: dictionary["id"] as! NSDictionary) }
		if (dictionary["im:artist"] != nil) { itemartist = Itemartist(dictionary: dictionary["im:artist"] as! NSDictionary) }
        if (dictionary["category"] != nil) { category = Category(attributeDictionary:dictionary["category"] as! NSDictionary) }
		if (dictionary["im:releaseDate"] != nil) { itemreleaseDate = ItemreleaseDate(dictionary: dictionary["im:releaseDate"] as! NSDictionary) }
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

		dictionary.setValue(self.itemname?.dictionaryRepresentation(), forKey: "im:name")
		dictionary.setValue(self.summary?.dictionaryRepresentation(), forKey: "summary")
		dictionary.setValue(self.itemprice?.dictionaryRepresentation(), forKey: "im:price")
		dictionary.setValue(self.itemcontentType?.dictionaryRepresentation(), forKey: "im:contentType")
		dictionary.setValue(self.rights?.dictionaryRepresentation(), forKey: "rights")
		dictionary.setValue(self.title?.dictionaryRepresentation(), forKey: "title")
		dictionary.setValue(self.link?.dictionaryRepresentation(), forKey: "link")
		dictionary.setValue(self.id?.dictionaryRepresentation(), forKey: "id")
		dictionary.setValue(self.itemartist?.dictionaryRepresentation(), forKey: "im:artist")
		dictionary.setValue(self.category?.dictionaryRepresentation(), forKey: "category")
		dictionary.setValue(self.itemreleaseDate?.dictionaryRepresentation(), forKey: "im:releaseDate")

		return dictionary
	}

}
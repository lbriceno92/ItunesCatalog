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

public class Author : Object{
	dynamic public var name : Name?
	dynamic public var uri : Uri?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let author_list = Author.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Author Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Author]
    {
        var models:[Author] = []
        for item in array
        {
            models.append(Author(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let author = Author(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Author Instance.
*/
	required public init?(dictionary: NSDictionary) {
        super.init()

		if (dictionary["name"] != nil) { name = Name(dictionary: dictionary["name"] as! NSDictionary) }
		if (dictionary["uri"] != nil) { uri = Uri(dictionary: dictionary["uri"] as! NSDictionary) }
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

		dictionary.setValue(self.name?.dictionaryRepresentation(), forKey: "name")
		dictionary.setValue(self.uri?.dictionaryRepresentation(), forKey: "uri")

		return dictionary
	}

}
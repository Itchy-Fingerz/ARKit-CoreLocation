//
//  TagIconMapper.swift
//  ARKit+CoreLocation
//
//  Created by Sohail Khan on 1/2/18.
//  Copyright © 2018 Salman Khalid. All rights reserved.
//

import UIKit

class TagIconMapper: NSObject {
    
    private var searchTags : [SearchTag] = []
    
    override init() {
        super.init()
        
        if let path = Bundle.main.path(forResource: "search_tags", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let decoder = JSONDecoder()
                let decodedTags = try decoder.decode(SearchTagList.self, from: data)
                self.searchTags = decodedTags.tags!
                print("sohail")
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }        
    }
    
    func iConKeyForTag(tagString : String)-> String
    {
        
        let tags = tagsFromString(tagString: tagString)
        
        for tag in tags
        {
            for tagObj in searchTags
            {
                if tag == tagObj.tag
                {
                    if tagObj.icon_key != nil
                    {
                        return ("icon1_" + tagObj.icon_key!).lowercased()
                    }
                }
            }
        }
        
        return "icon1_pin"
    }
    
    
    func tagsFromString(tagString : String)-> [String]
    {
        let tags = tagString.components(separatedBy: " ")
        return tags;
    }

}

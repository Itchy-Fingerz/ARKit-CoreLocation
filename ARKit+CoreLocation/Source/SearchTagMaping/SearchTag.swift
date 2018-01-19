//
//  SearchTag.swift
//  ARKit+CoreLocation
//
//  Created by Sohail Khan on 1/3/18.
//  Copyright © 2018 Salman Khalid. All rights reserved.
//

import Foundation

class SearchTagList: Codable {
    var tags : [SearchTag]?
}
class SearchTag: Codable {
    var tag:String?
    var readable_tag:String?
    var icon_key:String?
}

//
//  myConstant.swift
//  SwiftPHPMySQL
//
//  Created by TST-APP-02 on 14/5/2562 BE.
//  Copyright © 2562 Hitachi. All rights reserved.
//

import Foundation

//Web Service add data to database
class Myconstant {
// Web service send value add data to database
    func findURLAddData(nameTeam: String, memberCount: String) -> String {
        let resultAddData = "http://www.hitachi-tstv.com/test_ios/myWebService/createTeam.php?nameteam=\(nameTeam)&membercount=\(memberCount)"
        return resultAddData
    }
    
    func findURLGetDataTeam(idteam: String) -> String {
//      Web service get value data from database
        let urlGetDataTeam = "http://www.hitachi-tstv.com/test_ios/myWebService/getteams.php?idteam=\(idteam)"
        return urlGetDataTeam
    }
    
}

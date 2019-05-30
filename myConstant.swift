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
    
//  web service recive value from database for check authen
    func fineJSONGetAuthen(user: String) -> String {
        let resultAuthen = "http://www.hitachi-tstv.com/test_ios/myWebService/getUserWhereUserPu.php?isAdd=true&username=\(user)"
        return resultAuthen
    }//fineJSONWhereUser
    
// Web service send value add data to database
    func findURLAddData(nameTeam: String, memberCount: String) -> String {
        let resultAddData = "http://www.hitachi-tstv.com/test_ios/myWebService/createTeam.php?nameteam=\(nameTeam)&membercount=\(memberCount)"
        return resultAddData
    }//findURLAddData
    
//  Web service get value data from database
    func findURLSaveidTeam(idTeam: String) -> String {
        let urlGetidTeam = "http://www.hitachi-tstv.com/test_ios/myWebService/updateidTeam.php?isAdd=true&idteam=\(idTeam)"
        return urlGetidTeam
    }//findURLGetDataTeam
}//My Constant

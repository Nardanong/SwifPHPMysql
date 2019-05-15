//
//  ViewController.swift
//  SwiftPHPMySQL
//
//  Created by TST-APP-02 on 14/5/2562 BE.
//  Copyright © 2562 Hitachi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//  Explicit
    var TeamName: String?
    var MemberCount: String?
    
//  TextFields declarations
    @IBOutlet weak var nameTeamTextField: UITextField!
    @IBOutlet weak var numberMemberTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }// Main Method
    
//  Upload data to database - get value from Myconstant
    func saveDataToDatabase(nameTeam: String, memberCount: String) -> Void {
        let myconstant = Myconstant()
        let urlSendDataPHP: String = myconstant.findURLAddData(nameTeam: nameTeam, memberCount: memberCount)
        print("urlSendDataPHP ==> \(urlSendDataPHP)")
        
//      Upload Process
        let url = URL(string: urlSendDataPHP)!
        let request = NSMutableURLRequest(url: url) // สร้าง Request รับค่าจาก url
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data, request, error in
//      Check nil Value
            if error != nil {
                print("Error! Have nil value")
            }else{
//              Receive value
                if  let responseData = data{
                    let canReadData = NSString(data: responseData, encoding: String.Encoding.utf8.rawValue)
                    print("Can Read Data ==> \(String(describing: canReadData))")
                    
//                  Show Show Alert Success upload or failed upload to database on control panel
                    let myResponse = canReadData
                    if ((myResponse) != nil){
                        print("Success Upload")
//                      Process pop (Back to main after add data to database success - จะต้องกำหนดชื่อ indentifier ด้วย)
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "BackMain", sender: self)
                        }
                    }else{
                        print("Cannot Upload")
                    }//if
                }//if
            }//if
        }//End task
        task.resume()
    }//saveDataToDatabase
    
//  function Show alert
    func showAlert(title: String, Message: String) -> Void {
    let objshowAlert = UIAlertController(title: title, message: Message, preferredStyle: UIAlertController.Style.alert)
        objshowAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            objshowAlert.dismiss(animated: true, completion: nil)
        }))
        self.present(objshowAlert, animated: true, completion: nil)
    }//showAlert

//  Button action method
    @IBAction func SaveButton(_ sender: UIButton) {
//  Get Value from TextField
        TeamName = nameTeamTextField.text
        MemberCount = numberMemberTextField.text
        
//   Show Log
        print("TeamName ==> \(String(describing: TeamName))")
        print("MemberCount ==> \(String(describing: MemberCount))")
        
//   Check Space
        if(TeamName?.count == 0) || (MemberCount?.count == 0) {
//      Print have space
            print("No data! Please fill data")
            showAlert(title: "No data", Message: "No data! Please fill data all every blank")
        }else{
            print("Have data")
            saveDataToDatabase(nameTeam: TeamName!, memberCount: MemberCount!)
        }//if

    }//SaveButton
}//Main Class


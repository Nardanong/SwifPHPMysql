//
//  SigninViewController.swift
//  SwiftPHPMySQL
//
//  Created by TST-APP-02 on 14/5/2562 BE.
//  Copyright © 2562 Hitachi. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController {
//  Explicit
    var user: String?
    var pass: String?
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextFielde: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }//Main Method
    
//  Fucntion Check Authen
    func CheckAuthen(user: String,pass: String) -> Void {
        let myConstant = Myconstant()
        let urlPHP = myConstant.fineJSONGetAuthen(user: user)
        print("urlPHP ==> \(urlPHP)")
        
        guard let url = URL(string: urlPHP) else {
            return
        }//Guard
        
//   Task
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            guard let dataResponse = data, error == nil else{
                print("Have Error")
                return
            }//Guard
            
            do{
//           Read Json from API
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                print("jsonResponse ==> \(jsonResponse)")
                
//           Change json to Array
                guard let jsonArray = jsonResponse as? [[String:Any]] else {
                    return
                }//guard
                print("jsonArray ==> \(jsonArray)")
                
//              Value of Dictionary
                guard let jsonDictionary: Dictionary = jsonArray[0] else{
                    return
                }//guard
                print("jsonDictionary ==> \(jsonDictionary)")
                
//              Check value true password for json dictionary
                let truePassword: String = jsonDictionary["password"] as! String
                print ("truePassword ==> \(truePassword)")
                
//              Check Password
                if pass == truePassword{
//                 password correct
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "goTeam", sender: self)
                    }//Dis
                }else{
//                 password incorrect
                   self.showAlert(title: "Password incorrect", message: "Please try again")
                }//if
            }catch let myError {
                print(myError)
//              check display username in databaase
                print("No have user1 \(user) in database")
                DispatchQueue.main.async {
                    self.showAlert(title: "No Username", message: "No have user \(user) in database")
                }//Dis
            }//do
            
        }//End task
        task.resume()
    }//CheckAuthen
    
//  Function Show Alert
    func showAlert(title: String, message: String) -> Void {
        let  alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }//showAlert
    
//  Function Check Space
    func CheckSpace(username: String, password: String) -> Bool {
        var resultCheck: Bool?
        if(username.count == 0) || (password.count == 0){
            resultCheck = true
        }else{
            resultCheck = false
        }//if
        return resultCheck!
    }//CheckSpace
    
//  Button Sign in
    @IBAction func SigninButton(_ sender: UIButton) {
//  Get Value from Text Field
        user = usernameTextField.text
        pass = passwordTextFielde.text
        
//   Call function check Space
        if(CheckSpace(username: user!, password: pass!)){
            print("Have Space")
//          call function  my Alert
            showAlert(title: "Have Space", message: "Please fill data all blank")
        }else{
            print("No Space")
//          call function check Authen for check login
            CheckAuthen(user: user!, pass: pass!)
        }//if
//   Show log
        print("username ==> \(String(describing: user))")
        print("password ==> \(String(describing: pass))")
    }//SigninButton
}//Main Class

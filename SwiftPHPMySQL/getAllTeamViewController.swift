//
//  getAllTeamViewController.swift
//  SwiftPHPMySQL
//
//  Created by TST-APP-02 on 15/5/2562 BE.
//  Copyright © 2562 Hitachi. All rights reserved.
//

import UIKit

class getAllTeamViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    var selectValue: String?
    
    @IBOutlet weak var showSelectValuePickerView: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    
    let team = ["Apple", "Banana", "Tomato", "Corn", "Bean"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }//Main Method
    
//  Function getValue from database
    func getAndSaveValuepickerView(datas: String) -> Void {
        let myConstant = Myconstant()
        let urlPickerPHP = myConstant.findURLGetDataTeam(datateam: datas)
        print("urlPickerViewPHP ==> \(urlPickerPHP)")
        
        guard let url = URL(string: urlPickerPHP) else {
            return
        }//guard
        
//    task
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data, error == nil else{
                   print("Have Error")
                return
            }//guard
            
            do{
//              Read json from API
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                print("jsonResponse ==> \(jsonResponse)")
                
//               Change json to array
                guard let jsonArray = jsonResponse as? [[String:Any]] else {
                    return
                }//guard
                print("jsonArray ==> \(jsonArray)")
                
//              Value of Dictionary
                guard let jsonDictionary: Dictionary = jsonArray[0]  else{
                    return
                }//guard
                print("jsonDictionary ==> \(jsonDictionary)")
                
//              check value from database for json Dictionary
                let dataTeam: String = jsonDictionary["NameTeam"] as! String
                print("NameTeam ==> \(dataTeam)")
            }catch let myError{
                print("Error ==>\(myError)")
                print("No have team in database")
                DispatchQueue.main.async {
                    self.showAlert(title: "No Datateam", message: "No have team in database")
                }//Dis
            }//catch
        }//task
        task.resume()
    }//getAndSaveValuepickerView
    
//  Picker View Function
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return team[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return team.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        showSelectValuePickerView.text = team[row]
    }
    
//  Function  Show Alert
    func showAlert(title: String, message: String) -> Void {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }//Show Alert
    
//  Check Space
    func checkSpace(picker: String) -> Bool {
        var resultCheck: Bool?
        if(picker.count == 0){
            resultCheck = true
        }else{
            resultCheck = false
        }//if
        return resultCheck!
    }//checkSpace
    
    
    @IBAction func SavevaluePicker(_ sender: UIButton) {
        selectValue = showSelectValuePickerView.text
        
//      Call use function checkSpace
        if(checkSpace(picker: selectValue!)){
            print("Have Space")
//          Call Function showalert
            showAlert(title: "Have Space", message: "Please select data from list below")
        }else{
            print("No Space")
//          Call function Save data to database
            //function saveDatapicker
            getAndSaveValuepickerView(datas: selectValue!)
        }//if
//   Show Log
        print("Show Log PickerView ==> \(String(describing: selectValue))")
    }// SavevaluePicker
    
}//Main Class

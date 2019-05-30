//  getAllTeamViewController.swift
//  SwiftPHPMySQL
//
//  Created by TST-APP-02 on 15/5/2562 BE.
//  Copyright © 2562 Hitachi. All rights reserved.
//

import UIKit

class getAllTeamViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate, UITextFieldDelegate {
    
    var selectValue: String?
    var saveidTeam: String?
//    var saveidUser: String?
    
    @IBOutlet weak var hiddenidTeamTextField: UITextField!
    @IBOutlet weak var showSelectValuePickerView: UITextField!
    
// Array
    var idTeam: [String] = []
    var team: [String] = []
    
    func getvaluesFromDatabaseToPickerView() {
        //get the values from sql/Json
        let url = URL(string: "http://www.hitachi-tstv.com/test_ios/myWebService/getteamPickView.php")!
        let task = URLSession.shared.dataTask(with: url) { (data, _ , error) in
            if let error = error { print(error); return }
            print("url ==>\(url)")
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data!) as? [[String:Any]] {
                    self.idTeam = jsonResponse.compactMap{$0["Id"] as? String}
                    self.team = jsonResponse.compactMap{ $0["NameTeam"] as? String }
                    DispatchQueue.main.async {
                        self.reloadInputViews()
                    }
                    print("jsonResponse \(jsonResponse)")
                } else { print("JSON is not an array") }
            } catch { print(error) }
        }//task
        task.resume()
    }//getvaluesFromDatabaseToPickerView
    
    func saveValue(idteam: String) -> Void {
        let myconstant_idTeam = Myconstant()
        let urlSaveData: String = myconstant_idTeam.findURLSaveidTeam(idTeam: idteam)
        print("urlSaveData ==>\(urlSaveData)")
        
//      Save Value Process
        let url = URL(string: urlSaveData)!
        let request = NSMutableURLRequest(url: url) // สร้าง Request รับค่าจาก url
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response, error in
//      Check nil value
            if error != nil {
               print("Error! Have nil value")
            }else{
//           Receive Value
                if let responseData = data{
                    let canReadData = NSString(data: responseData, encoding: String.Encoding.utf8.rawValue)
                    print("Can Read Data ==> \(String(describing: canReadData))")
                    
//                    Show alert save success or failed upload to database on log panel
                    let myResponse = canReadData
                    if((myResponse) != nil){
                        print("Save Success")
                        //dispatchQueue
                    }else{
                        print("Cannot Upload")
                    }//if
                }//if
            }//if
        }//End task
        task.resume()
    }//saveValue
    
//  Picker View Function
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.team.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let titleRow = (team[row] )
      return titleRow
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if team.count > 0 && team.count >= row && idTeam.count >= row{
          self.showSelectValuePickerView.text = team[row]
          self.hiddenidTeamTextField.text = idTeam[row]
          print("NameTeam database ==>\(idTeam[row]) - \(team[row])")
        }
    }
    
//  Create UI Picker View
    func createPickerView() -> Void {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        showSelectValuePickerView.inputView = pickerView
        hiddenidTeamTextField.inputView = pickerView
    }
    
//  Hide UI Picker View when click "Done" Button
    func dismissPickerView() -> Void {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(UIInputViewController.dismissKeyboard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        showSelectValuePickerView.inputAccessoryView = toolBar
    }//dismissPickerView
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }//dismissKeyboard
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createPickerView()
        dismissPickerView()
        getvaluesFromDatabaseToPickerView()
    }//Main Method
    
//  Save Button
    @IBAction func SavevaluePicker(_ sender: UIButton) {
        selectValue = showSelectValuePickerView.text
        saveidTeam = hiddenidTeamTextField.text

//      Call use function checkSpace
        if(checkSpace(picker: selectValue!)){
            print("Have Space")
//          Call Function showalert
            showAlert(title: "Have Space", message: "Please select data from list below")
        }else{
            print("No Space")
//          Call function Save data to database
            saveValue(idteam: saveidTeam!)
        }//if
//   Show Log
        print("Show Log PickerView ==> \(String(describing: saveidTeam)) - \(String(describing: selectValue))")
    }// SavevaluePicker
}//Main Class

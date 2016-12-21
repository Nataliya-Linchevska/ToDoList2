//
//  AdditionViewController.swift
//  Task-1
//
//  Created by user on 13.12.16.
//  Copyright © 2016 user. All rights reserved.
//

import UIKit

class AdditionViewController: UIViewController {

    @IBOutlet weak var tvEnterInformation: UITextView!
    @IBOutlet weak var switchDone: UISwitch!
    var tempStringOutName = ""
    var tempStringOutCheck = "true"
    var indexOfRow = 0
    var editingExRow = false
    
    var outFileInformation = [[String : String]]() //для запису в файл
    //var arrayOfStrings = [[String : String]]() // Для початкового зчитування
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvEnterInformation.text = tempStringOutName
        setChecked(bool: tempStringOutCheck)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func switchDoneChange(_ sender: UISwitch) {
    }
    
    @IBAction func btnSave(_ sender: UIBarButtonItem) {
        
        if editingExRow == false {
        // Спочатку зчитую з файлу, щоб не видаляло після перезапуску програми
            SaveClass.readFromFile()
            outFileInformation += SaveClass.arrayOfStrings
            let validDictionary = [
                "name": tvEnterInformation.text!,
                "data": NSDate().description,
                "checked": switchDone.isOn ? "true" : "false"
                ] as [String : String]
            outFileInformation.append(validDictionary)
        } else {
            outFileInformation[indexOfRow] = [
                "name": tvEnterInformation.text!,
                "data": NSDate().description,
                "checked": switchDone.isOn ? "true" : "false"
            ]
        }
        // Записую дані в файл
        SaveClass.arrayOfStrings = outFileInformation
        SaveClass.writeToFile()
        tvEnterInformation.text = ""
        outFileInformation.removeAll()
    }
    
    func setChecked(bool: String) {
        if bool == "true" {
            switchDone.setOn(true, animated: false)
        } else {
            switchDone.setOn(false, animated: false)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

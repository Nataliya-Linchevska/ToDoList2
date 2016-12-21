//
//  FirstTableViewController.swift
//  Task-1
//
//  Created by user on 13.12.16.
//  Copyright © 2016 user. All rights reserved.
//

import UIKit

class FirstTableViewController: UITableViewController {
    
    //var arrayOfStrings = [[String: String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Витягую дані з файла
            SaveClass.readFromFile()
            tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    // Кількість елементів в таблиці
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SaveClass.arrayOfStrings.count
    }
 
    // Виводжу інфу в ячейку
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "formatCell", for: indexPath) as! CustomTableViewCell
        cell.setName(name: SaveClass.arrayOfStrings[indexPath.row]["name"]!)
        cell.setData(data: SaveClass.arrayOfStrings[indexPath.row]["data"]!)
        cell.setChecked(bool: SaveClass.arrayOfStrings[indexPath.row]["checked"]!)
        return cell
    }
    
    // Функція виставляє висоту ячейки
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Видалення по свайпу
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            SaveClass.arrayOfStrings.remove(at: indexPath.row) // Видаляю з таблиці
            // Записую зміни вфайл
            SaveClass.writeToFile()
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // Редагування по тапу
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "EditView") as! AdditionViewController
        
        controller.tempStringOutName = SaveClass.arrayOfStrings[indexPath.row]["name"]!
        controller.tempStringOutCheck =  SaveClass.arrayOfStrings[indexPath.row]["checked"]!
        controller.outFileInformation = SaveClass.arrayOfStrings
        controller.indexOfRow = indexPath.row
        controller.editingExRow = true
        self.navigationController?.pushViewController(controller, animated: true)
    }

//    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func btnActionMenu(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Sorted by:", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        // Сортування по назві
        let nameAction = UIAlertAction(title: "Name", style: UIAlertActionStyle.default) {
            (ACTION) in
            SaveClass.arrayOfStrings.sort(by: { (product1, product2) -> Bool in
                product1["name"]! < product2["name"]!
            })
            self.tableView.reloadData()  //перезагрузити дані в таблиці
        }
        
        // Сортування по даті
        let dataAction = UIAlertAction(title: "Data", style: UIAlertActionStyle.default) {
            (ACTION) in
            SaveClass.arrayOfStrings.sort(by: { (product1, product2) -> Bool in
                product1["data"]! < product2["data"]!
            })
            self.tableView.reloadData()  //перезагрузити дані в таблиці        
        }
        
        // Відміна
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            (ACTION) in
        }
        
        alert.addAction(nameAction)
        alert.addAction(dataAction)
        alert.addAction(cancelAction)

        self.present(alert, animated: true, completion: nil)
    }
    
    

}














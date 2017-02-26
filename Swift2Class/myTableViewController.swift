//
//  myTableViewController.swift
//  Swift2Class
//
//  Created by mac on 16/10/21.
//  Copyright © 2016年 team. All rights reserved.
//

import UIKit

class myTableViewController: UITableViewController {
    var foods: [Food] = []
    var tempFood: [Food] = []
    var countSelected: Int? = 0

    override func viewDidLoad() {
        self.foods = self.loadFile()
        self.tempFood = self.foods
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return foods.count
    }
    
    func loadFile() -> [Food] {
        if let file = NSKeyedUnarchiver.unarchiveObject(withFile: Food.path /*Food.url.path*/) {
            return file as! [Food]
        } else {
            print("file load failed!")
            let food: [Food] = [
                Food(name: "HXH", detail: "Ugly Gay", star: "###", photo: nil),
                Food(name: "SD", detail: "DouBi", star: "####", photo: nil)
            ]
            return food
        }
    }
    
    func saveTofile() {
        let success = NSKeyedArchiver.archiveRootObject(tempFood, toFile: Food.path /*Food.url.path*/)
        if !success {
            print("file save failed!")
        } else {
            print("save Successful!")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /**
        ** 此处注释掉的为其它四种系统自带格式的视线
        ** 可以注销注释使用
        */
        // Configure the cell...
        
        /*
        let cellBasic = tableView.dequeueReusableCell(withIdentifier: "Basic", for: indexPath)
        cellBasic.textLabel?.text = dwarves[indexPath.row]
        cellBasic.textLabel?.textColor = UIColor.black
        cellBasic.textLabel?.highlightedTextColor = .red
        
         
        let cellRD = tableView.dequeueReusableCell(withIdentifier: "RightDetail", for: indexPath)
        cellRD.textLabel?.text = dwarves[indexPath.row]
        cellRD.textLabel?.textColor = UIColor.black
        cellRD.textLabel?.highlightedTextColor = .blue
        cellRD.detailTextLabel?.text = dwarves[9 - indexPath.row]
        cellLD.detailTextLabel?.textColor = .red
         
        
        let cellLD = tableView.dequeueReusableCell(withIdentifier: "LeftDetail", for: indexPath)
        cellLD.textLabel?.text = dwarves[indexPath.row]
        cellLD.textLabel?.textColor = UIColor.black
        cellLD.textLabel?.highlightedTextColor = .yellow
        cellLD.detailTextLabel?.text = dwarves[9 - indexPath.row]
        cellLD.detailTextLabel?.textColor = .gray
 
         
        let cellSub = tableView.dequeueReusableCell(withIdentifier: "Subtitle", for: indexPath)
        cellSub.textLabel?.text = foods[indexPath.row].foodName
        cellSub.textLabel?.textColor = UIColor.black
        cellSub.textLabel?.highlightedTextColor = .red
        cellSub.detailTextLabel?.text = foods[indexPath.row].foodDetail
        cellSub.detailTextLabel?.textColor = .gray
        cellSub.detailTextLabel?.highlightedTextColor = .yellow
 
        
        let cellMine = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        (cellMine.viewWithTag(1) as? UILabel)?.text = foods[indexPath.row].foodName
        (cellMine.viewWithTag(1) as? UILabel)?.highlightedTextColor = UIColor.red
        (cellMine.viewWithTag(2) as? UILabel)?.text = foods[indexPath.row].foodDetail
        (cellMine.viewWithTag(2) as? UILabel)?.highlightedTextColor = UIColor.blue
        (cellMine.viewWithTag(3) as? UILabel)?.text = foods[indexPath.row].foodStar
        */
        
        let photoCell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        photoCell.foodName.text = foods[indexPath.row].foodName
        photoCell.foodDetail.text = foods[indexPath.row].foodDetail
        photoCell.foodStar.text = foods[indexPath.row].foodStar
        photoCell.foodImage.image = foods[indexPath.row].foodImg
        
        return photoCell
    }
    
    @IBAction func searchList(_ sender: AnyObject) {
        let alertController = UIAlertController(title: "Search", message: "Please input the food name", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: {
            (textField: UITextField) in textField.placeholder = "Food Name"
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let searchAction = UIAlertAction(title: "Search", style: .default, handler: {
            (UIAlertAction) in
            let foodNameForSearch = alertController.textFields![0]
            
            for food in self.foods {
                if food.foodName == foodNameForSearch.text! {
                    self.foods.removeAll()
                    print("Search -> \(foodNameForSearch.text!)!")
                    self.foods.append(food)
                    break
                } else {
                    self.foods.removeAll()
                }
            }
            
            self.tableView.reloadData()
            self.navigationItem.title = "Search: \(alertController.textFields![0].text!)"
            let backItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.reply, target: self, action: #selector(self.backToList))
            self.navigationItem.leftBarButtonItem = backItem
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(searchAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func backToList() {
        print("backToList!")
        self.foods = self.tempFood
        self.navigationItem.title = "Food List"
        self.tableView.reloadData()
        self.navigationItem.leftBarButtonItem = nil
    }
    
    @IBAction func cancelToList(segue: UIStoryboardSegue) {
        print("cancelToList!")
    }
    
    /**
     ** 原来实现的删除算法
     ** 已用ios自带的delete替代
    @IBAction func deleteToList(segue: UIStoryboardSegue) {
        // this method can be ignore!!!
        print("deleteToList!")
        if let delete = segue.source as? AddCustomer {
            if let _ = delete.foodForAdd {
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    self.foods.remove(at: (selectedIndexPath as NSIndexPath).row)
                    self.tempFood!.remove(at: (selectedIndexPath as NSIndexPath).row)
                    tableView.reloadData()
                }
            }
        }
    }
    */
    
    @IBAction func exitToList(segue: UIStoryboardSegue) {   
        print("exitToList!")
        if let add = segue.source as? AddCustomer {
            if let foodForAdd = add.foodForAdd {
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    //self.foods[countSelected!] = foodForAdd
                    self.tempFood[countSelected!] = foodForAdd
                    self.foods[selectedIndexPath.row] = foodForAdd
                    tableView.reloadRows(at: [selectedIndexPath], with: .fade)
                } else {
                    self.foods.append(foodForAdd)
                    self.tempFood.append(foodForAdd)
                    let newIndexPath = IndexPath(row: foods.count - 1, section: 0)
                    tableView.insertRows(at: [newIndexPath], with: .fade)
                }
            }
            self.saveTofile()
        }
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let foodSelected = self.foods.remove(at: indexPath.row)
            self.countSelected = 0
            for item in tempFood {
                if item.foodName == foodSelected.foodName {
                    self.tempFood.remove(at: self.countSelected!)
                    print("Count: \(countSelected!)")
                    break
                }
                self.countSelected! += 1
            }
            //tableView.reloadData()
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.saveTofile()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeFood" {
            let addCustomerDetail = segue.destination as! AddCustomer
            
            let selectedCell = sender as! PhotoCell
            let foodNameText = selectedCell.foodName.text
            print("foodNametext: \(foodNameText!)")
            self.countSelected = 0
            for item in tempFood {
                if item.foodName == foodNameText! {
                    let selectedFood = self.tempFood[countSelected!]
                    addCustomerDetail.foodForAdd = selectedFood
                    print("Count: \(countSelected!)")
                    break
                }
                self.countSelected! += 1
            }
        }

        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}

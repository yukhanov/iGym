//
//  TrainingTableViewController.swift
//  iGym
//
//  Created by Юханов Сергей Сергеевич on 02/04/2019.
//  Copyright © 2019 Юханов Сергей Сергеевич. All rights reserved.
//

import UIKit

class TrainingTableViewController: UITableViewController {
    
    var alert: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTraining))
        navigationItem.setRightBarButton(addButton, animated: true)
        navigationItem.title = "Тренировки"
        

    
        tableView.register(TrainingCell.self, forCellReuseIdentifier: "TrainingCell")

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if LocalModel.signIn != nil {
            alert = UIAlertController(title: "Загрузка профиля", message: "Подождите...", preferredStyle: .alert)
            present(alert, animated: true, completion: nil)
            FirebaseService.instance.getLocalUserProfile(id: LocalModel.id!, view: self)
        }
    }
    
    @objc func addTraining() {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM"
        let dateString = formatter.string(from: currentDate)

        
        let alert = UIAlertController(title: "Тренировка", message: "Введите название:", preferredStyle: .alert)
        

        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            let textField = alert.textFields![0]
            if textField.text != "" {
                //Read textfield data
                print(textField.text!)
               // let trainingDate = Training.init(date: textField.text!, exerciseArray: [])
                LocalModel.currentTraining = Training.init(date: textField.text!, exerciseArray: [])
                LocalModel.trainingList.append(LocalModel.currentTraining!)
                //self.trainingArray.append(textField.text!)
                self.tableView.reloadData()
                
                
                FirebaseService.instance.saveCurrentTraining()
                
                let dayVC = TrainingMakeListViewController()
                self.show(dayVC, sender: nil)
            
               
                
            } else {
                print("TF 1 is Empty...")
            }
            NSLog("The \"OK\" alert occured.")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in }))
        
        alert.addTextField(configurationHandler: { (textField) in
            textField.placeholder = dateString
            textField.insertText(dateString)
        })
        
        self.present(alert, animated: true, completion: nil)
        
        
        
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dayVC = TrainingMakeListViewController()
        self.show(dayVC, sender: nil)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return LocalModel.trainingList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrainingCell", for: indexPath) as! TrainingCell

        //cell.textLabel?.text = trainingArray[indexPath.row]
    
        cell.dateLabel.text = LocalModel.trainingList[indexPath.row].date
        

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
           LocalModel.trainingList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}

//
//  ExerciseTableViewController.swift
//  
//
//  Created by Юханов Сергей Сергеевич on 02/04/2019.
//

import UIKit

class ExerciseTableViewController: UITableViewController {
    
    let exerciseSet = ["Shoulders", "Biceps", "Triceps", "Legs"]
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        print("test")
        navigationItem.title = "Упражнения"
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.register(ExersciseTableViewCell.self, forCellReuseIdentifier: "ExerciseCell")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return exerciseSet.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as! ExersciseTableViewCell

        cell.textLabel?.text = exerciseSet[indexPath.row]

        return cell
    }
    
}

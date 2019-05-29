//
//  SaveApproachViewController.swift
//  iGym
//
//  Created by Сергей Юханов on 18/04/2019.
//  Copyright © 2019 Юханов Сергей Сергеевич. All rights reserved.
//

import UIKit

class SaveApproachViewController: UIViewController {

    var currentExercise: String?

    var currentTrain: Exercise?
    
    
   
    
    @IBOutlet weak var repeatsTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = currentExercise
        tableView.delegate = self
        tableView.dataSource = self
        
     //   tableView.register(CurrentAndPastTrainTableViewCell.self, forCellReuseIdentifier: "CurrentPastCell")
        let cellNib = UINib(nibName: "CurrentTrainingCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "CurrentPastCell")
        
        currentTrain = Exercise(type: currentExercise!, count: [], weight: [])
        // Do any additional setup after loading the view.
        repeatsTextField.becomeFirstResponder()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)

    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
 

    @IBAction func recordButtonTapped(_ sender: Any) {
        
        
    
        if let repeats = repeatsTextField.text {
            currentTrain!.count.append(Int(repeats)!)
          //  currentTrain.count.append([Int(repeats)!]
            
        }
        
        if let weights = weightTextField.text {
            currentTrain!.weight.append(Int(weights)!)
        }
        
        LocalModel.currentTraining?.exerciseArray.append(currentTrain!)
        tableView.reloadData()
        print(currentTrain)
    
   
    }

    @IBAction func repeatTF(_ sender: UITextField) {
        if sender.text!.count == 2 {
            weightTextField.becomeFirstResponder()
        }
    }
    
}

extension SaveApproachViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocalModel.currentTraining?.exerciseArray.last?.weight.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentPastCell", for: indexPath) as! CurrentAndPastTrainTableViewCell
        cell.weightLabel?.text = String(LocalModel.currentTraining?.exerciseArray.last?.weight[indexPath.row] ?? 0)
        cell.countLabel?.text = String(LocalModel.currentTraining?.exerciseArray.last?.count[indexPath.row] ?? 0)
        return cell
    }
}

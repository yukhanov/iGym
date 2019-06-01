//
//  TrainingMakeListViewController.swift
//  iGym
//
//  Created by Сергей Юханов on 16/04/2019.
//  Copyright © 2019 Юханов Сергей Сергеевич. All rights reserved.
//

import UIKit

class TrainingMakeListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //var today: [String] = [] 
      
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(SetTableViewCell.self, forCellReuseIdentifier: "SetTrainCell")
        
     //register UINib
        let cellNib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "CollectionViewCell")
        
       
        tableView.delegate = self
        tableView.dataSource = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
    }

}

extension TrainingMakeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocalModel.currentTraining!.exerciseArray.count //LocalModel.trainingList.last!.exerciseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SetTrainCell", for: indexPath) as! SetTableViewCell
        cell.exLabel.text = LocalModel.currentTraining!.exerciseArray[indexPath.row].type
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let saveApproachVC = SaveApproachViewController()
        saveApproachVC.currentExercise = LocalModel.currentTraining!.exerciseArray[indexPath.row].type
        show(saveApproachVC, sender: nil)
    }
}

extension TrainingMakeListViewController:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ListExercise.exerciseArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       print(indexPath.row)
        var currentExercise = Exercise(type: ListExercise.exerciseArray[indexPath.row], count: [0], weight: [0])
        LocalModel.currentTraining!.exerciseArray.append(currentExercise)
        tableView.reloadData()
       print(currentExercise)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell

        cell.nameLabel.text = ListExercise.exerciseArray[indexPath.row]
        return cell
    }
    
    
}

extension TrainingMakeListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            LocalModel.currentTraining!.exerciseArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}

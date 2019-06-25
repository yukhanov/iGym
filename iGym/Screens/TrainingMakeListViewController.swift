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
        
        ListExercise.collectionList = ListExercise.group
        
        tableView.register(SetTableViewCell.self, forCellReuseIdentifier: "SetTrainCell")
        
     //register UINib
        let cellNib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "CollectionViewCell")
        print(LocalModel.trainingList[LocalModel.currentTrainingIndex])
       
        tableView.delegate = self
        tableView.dataSource = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
        
       // let navItem = UINavigationItem(title: "SomeTitle")
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(saveTraining))
        navigationItem.rightBarButtonItem = doneItem
        
       // navigationController?.navigationBar.setItems([navItem], animated: false)
      
    }

    @objc func saveTraining() {
        LocalModel.trainingList.append(LocalModel.currentTraining)

        FirebaseService.instance.saveCurrentTraining()
    
    }
}

extension TrainingMakeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocalModel.trainingList[LocalModel.currentTrainingIndex].exerciseArray.count //LocalModel.trainingList.last!.exerciseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SetTrainCell", for: indexPath) as! SetTableViewCell
        cell.exLabel.text = LocalModel.trainingList[LocalModel.currentTrainingIndex].exerciseArray[indexPath.row].type
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let saveApproachVC = SaveApproachViewController()
        saveApproachVC.currentExercise = LocalModel.trainingList[LocalModel.currentTrainingIndex].exerciseArray[indexPath.row].type
        show(saveApproachVC, sender: nil)
    }
}

extension TrainingMakeListViewController:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ListExercise.collectionList.count
    }
    
    private func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath as IndexPath)
            
            headerView.backgroundColor = UIColor.blue
            return headerView
            
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath as IndexPath)
            
            footerView.backgroundColor = UIColor.green
            return footerView
            
        default:
            
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
        
        if ListExercise.collectionList == ListExercise.group {
            ListExercise.collectionList = ListExercise.exerciseArray
            collectionView.reloadData()
        } else {
            var currentExercise = Exercise(type: ListExercise.exerciseArray[indexPath.row], count: [0], weight: [0])
            LocalModel.trainingList[LocalModel.currentTrainingIndex].exerciseArray.append(currentExercise)
            tableView.reloadData()

        }
       
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell

        cell.nameLabel.text = ListExercise.collectionList[indexPath.row]
        return cell
    }
    
    
}

extension TrainingMakeListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            LocalModel.trainingList[LocalModel.currentTrainingIndex].exerciseArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}

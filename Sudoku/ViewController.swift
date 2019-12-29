
//
//  ViewController.swift
//  Sudoku
//
//  Created by Stuart McClintock on 12/26/19.
//  Copyright © 2019 Stuart McClintock. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var del: AppDelegate!
    
    @IBOutlet weak var puzzleWindow: UIView!
    @IBAction func showNewGamePopup(_ sender: Any) {
        let popoverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "NewGamePopup")
        self.addChild(popoverVC)
        popoverVC.view.frame = self.view.frame
        self.view.addSubview(popoverVC.view)
        popoverVC.didMove(toParent: self)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let app = UIApplication.shared
        del = app.delegate as? AppDelegate
        
        
        del.solutionBoard = del.blankBoard
        
        puzzleWindow.layer.borderWidth = 4.0
        
        var boxList: [[UIView]] = []
        for superRow in 0...2{
            var currentRow: [UIView] = []
            for superCol in 0...2{
                let newView: UIView = UIView()
                newView.frame = CGRect(x:superCol*90, y:superRow*90, width:90, height:90)
                newView.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
                newView.layer.borderWidth = 2.0
                puzzleWindow.addSubview(newView)
                currentRow.append(newView)
            }
            boxList.append(currentRow)
        }
        
        del.boardButtons = []
        for row in 0...8{
            var currentRow: [UIButton] = []
            for col in 0...8{
                let currentButton: UIButton = UIButton()
                currentButton.setTitle("0", for: .normal)
                currentButton.backgroundColor = .white
                currentButton.layer.borderWidth = 1.0
                currentButton.layer.borderColor = .init(srgbRed: 0.0, green: 0.0, blue: 0.0, alpha: 1)
                currentButton.frame = CGRect(x:col%3*30, y:row%3*30, width: 30, height: 30)
                currentButton.tag = Int(String(row)+String(col))!
                currentButton.setTitleColor(.black, for: .normal)
                currentButton.setTitleColor(.darkGray, for: .highlighted)
                boxList[Int(row/3)][Int(col/3)].addSubview(currentButton)
                currentRow.append(currentButton)
            }
            del.boardButtons.append(currentRow)
        }
        
        del.currentBoardVals = del.blankBoard
        
    }


}


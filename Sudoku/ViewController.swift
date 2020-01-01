
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
    
    @IBAction func add1(_ sender: Any) {
        addValToBoard(val: 1)
    }
    @IBAction func add2(_ sender: Any) {
        addValToBoard(val: 2)
    }
    @IBAction func add3(_ sender: Any) {
        addValToBoard(val: 3)
    }
    @IBAction func add4(_ sender: Any) {
        addValToBoard(val: 4)
    }
    @IBAction func add5(_ sender: Any) {
        addValToBoard(val: 5)
    }
    @IBAction func add6(_ sender: Any) {
        addValToBoard(val: 6)
    }
    @IBAction func add7(_ sender: Any) {
        addValToBoard(val: 7)
    }
    @IBAction func add8(_ sender: Any) {
        addValToBoard(val: 8)
    }
    @IBAction func add9(_ sender: Any) {
        addValToBoard(val: 8)
    }
    @IBAction func deleteSelectedSpace(_ sender: Any) {
        addValToBoard(val: 0)
    }
    
    func addValToBoard(val: Int){
        if del.selectedRow != nil{
            del.puzzleData[del.currentGameIndex].userVals[del.selectedRow!][del.selectedCol!] = val
        }
        del.drawBoard(currentBoardVals: del.puzzleData[del.currentGameIndex].userVals)
    }
    
    func initializeBoard(){
        del.boardButtons = []
        
        var boxList: [[UIView]] = []
        for superRow in 0...2{
            var currentRow: [UIView] = []
            for superCol in 0...2{
                let newView: UIView = UIView()
                newView.frame = CGRect(x:superCol*96+4, y:superRow*96+4, width:96, height:96)
                newView.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
                newView.layer.borderWidth = 2.0
                puzzleWindow.addSubview(newView)
                currentRow.append(newView)
            }
            boxList.append(currentRow)
        }
        
        for row in 0...8{
            var currentRow: [UIButton] = []
            for col in 0...8{
                let currentButton: UIButton = UIButton()
                currentButton.setTitle("0", for: .normal)
                if del.puzzleData[del.currentGameIndex].given[row][col] == 0{
                    currentButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
                }
                else{
                    currentButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
                }
                
                currentButton.backgroundColor = .white
                currentButton.layer.borderWidth = 1.0
                currentButton.layer.borderColor = .init(srgbRed: 0.0, green: 0.0, blue: 0.0, alpha: 1)
                currentButton.frame = CGRect(x:col%3*32, y:row%3*32, width: 32, height: 32)
                currentButton.tag = Int(String(row)+String(col))!
                currentButton.setTitleColor(.black, for: .normal)
                currentButton.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
                boxList[Int(row/3)][Int(col/3)].addSubview(currentButton)
                currentRow.append(currentButton)
            }
            del.boardButtons.append(currentRow)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let app = UIApplication.shared
        del = app.delegate as? AppDelegate
        
        del.currentGameIndex = 0
        del.initPuzzleData()
        
        puzzleWindow.layer.borderWidth = 4.0
        
        initializeBoard()
        del.drawBoard(currentBoardVals: del.puzzleData[del.currentGameIndex].userVals)
        
    }

    @objc func buttonPressed(sender: UIButton){
        let strID = String(sender.tag)
        var senderRow: Int!
        var senderCol: Int!
        
        if strID.count == 1{
            senderRow = 0
            senderCol = Int(strID)
        }
        else{
            senderRow = Int(String(Array(strID)[0]))
            senderCol = Int(String(Array(strID)[1]))
        }
        
        if senderRow == del.selectedRow && senderCol == del.selectedCol{
            del.selectedRow = nil
            del.selectedCol = nil
            for row in 0...8{
                for col in 0...8{
                    del.boardButtons[row][col].backgroundColor = .white
                    del.boardButtons[row][col].setTitleColor(.black, for: .normal)
                }
            }
        }
        else if del.puzzleData[del.currentGameIndex].given[senderRow][senderCol] == 0{
            for row in 0...8{
                for col in 0...8{
                    del.boardButtons[senderRow][senderCol].backgroundColor = UIColor(red: 52/255, green: 125/255, blue: 255/255, alpha: 1.0)
                    del.boardButtons[senderRow][senderCol].setTitleColor(.white, for: .normal)
                    if row != senderRow || col != senderCol{
                        del.boardButtons[row][col].backgroundColor = .white
                        del.boardButtons[row][col].setTitleColor(.black, for: .normal)
                    }
                    if del.highlightRowAndCol && (row == senderRow || col == senderCol){
                        del.boardButtons[row][col].backgroundColor = UIColor(red: 161/255, green: 195/255, blue: 235/255, alpha: 1.0)
                    }
                }
            }
            del.selectedRow = senderRow
            del.selectedCol = senderCol
        }
        else{
            del.selectedRow = nil
            del.selectedRow = nil
        }
    }

}


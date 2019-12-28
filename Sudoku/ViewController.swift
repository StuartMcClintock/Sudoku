
//
//  ViewController.swift
//  Sudoku
//
//  Created by Stuart McClintock on 12/26/19.
//  Copyright © 2019 Stuart McClintock. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var puzzleWindow: UIView!
    @IBAction func generateNewGame(_ sender: Any) {
        fillBoard(board: &currentBoardVals)
        drawBoard()
    }
    
    var boardButtons: [[UIButton]]!
    
    var solutionBoard: [[Int]]!
    
    var currentBoardVals: [[Int]]!
    
    var numberList: [Int] = [1,2,3,4,5,6,7,8,9]
    let blankBoard: [[Int]] = [
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0]
    ]
    
    func checkBoardFull(board: [[Int]]) -> Bool{
        for row in 0...8{
            for col in 0...8{
                if board[row][col] == 0{
                    return false
                }
            }
        }
        return true
    }
    
    func fillBoard(board: inout [[Int]]) -> Bool{
        var row: Int = 0
        var col: Int = 0
        for i in 0...80{
            row = Int(i/9)
            col = i%9
            numberList.shuffle()
            for val in numberList{
                if !board[row].contains(val) && ![board[0][col], board[1][col], board[2][col], board[3][col], board[4][col], board[5][col], board[6][col], board[7][col], board[8][col]].contains(val){
                    var boxVals: [Int] = []
                    if row < 3{
                        if col < 3{
                            boxVals = Array(board[0...2][0][0...2] + board[0...2][1][0...2] + board[0...2][2][0...2])
                        }
                        else if col < 6{
                            boxVals = Array(board[0...2][0][3...5] + board[0...2][1][3...5] + board[0...2][2][3...5])
                        }
                        else{
                            boxVals = Array(board[0...2][0][6...8] + board[0...2][1][6...8] + board[0...2][2][6...8])
                        }
                    }
                    else if row < 6{
                        if col < 3{
                            boxVals = Array(board[3...5][3][0...2] + board[3...5][4][0...2] + board[3...5][5][0...2])
                        }
                        else if col < 6{
                            boxVals = Array(board[3...5][3][3...5] + board[3...5][4][3...5] + board[3...5][5][3...5])
                        }
                        else{
                            boxVals = Array(board[3...5][3][6...8] + board[3...5][4][6...8] + board[3...5][5][6...8])
                        }
                    }
                    else{
                        if col < 3{
                            boxVals = Array(board[6...8][6][0...2] + board[6...8][7][0...2] + board[6...8][8][0...2])
                        }
                        else if col < 6{
                            boxVals = Array(board[6...8][6][3...5] + board[6...8][7][3...5] + board[6...8][8][3...5])
                        }
                        else{
                            boxVals = Array(board[6...8][6][6...8] + board[6...8][7][6...8] + board[6...8][8][6...8])
                        }
                    }
                    if !boxVals.contains(val){
                        board[row][col]=val
                        if checkBoardFull(board: board){
                            return true
                        }
                        else{
                            if fillBoard(board: &board){
                                return true
                            }
                        }
                    }
                }
                break
            }
        }
        board[row][col] = 0
        return false
    }
    
    func drawBoard(){
        for row in 0...8{
            for col in 0...8{
                let newVal: String = String(currentBoardVals[row][col])
                boardButtons![row][col].setTitle(newVal, for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        solutionBoard = blankBoard
        
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
        
        boardButtons = []
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
            boardButtons.append(currentRow)
        }
        
        currentBoardVals = blankBoard
        
    }


}


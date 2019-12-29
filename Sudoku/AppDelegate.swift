//
//  AppDelegate.swift
//  Sudoku
//
//  Created by Stuart McClintock on 12/26/19.
//  Copyright © 2019 Stuart McClintock. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var boardButtons: [[UIButton]]!
    
    var solutionBoard: [[Int]]!
    
    var currentBoardVals: [[Int]]!

    var boardOptionsFound: Int = 0
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
    
    func seedBoard(){
        solutionBoard = blankBoard
        for i in 1...9{
            solutionBoard[Int.random(in: 0...8)][Int.random(in: 0...8)] = i
        }
    }
    
    func generateNewUnsolvedBoard(){
        //seedBoard()
        solutionBoard = blankBoard
        print(fillBoard(board: &solutionBoard))
        
        currentBoardVals = solutionBoard
        /*var runs: Int = 5
        while runs > 0{
            var row: Int = Int.random(in:0...8)
            var col: Int = Int.random(in:0...8)
            while currentBoardVals[row][col] == 0{
                row = Int.random(in:0...8)
                col = Int.random(in:0...8)
            }
            let originalVal: Int = currentBoardVals[row][col]
            currentBoardVals[row][col] = 0
            
            boardOptionsFound = 0
            findBoardOptions(board: currentBoardVals)
            if boardOptionsFound != 1{
                currentBoardVals[row][col] = originalVal
                runs -= 1
            }
        }*/
        
    }
    
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
            for val in 1...9{
                if !board[row].contains(val) && ![board[0][col], board[1][col], board[2][col], board[3][col], board[4][col], board[5][col], board[6][col], board[7][col], board[8][col]].contains(val){
                    var boxVals: [Int] = []
                    if row < 3{
                        if col < 3{
                            boxVals = Array(board[0][0...2] + board[1][0...2] + board[2][0...2])
                        }
                        else if col < 6{
                            boxVals = Array(board[0][3...5] + board[1][3...5] + board[2][3...5])
                        }
                        else{
                            boxVals = Array(board[0][6...8] + board[1][6...8] + board[2][6...8])
                        }
                    }
                    else if row < 6{
                        if col < 3{
                            boxVals = Array(board[3][0...2] + board[4][0...2] + board[5][0...2])
                        }
                        else if col < 6{
                            boxVals = Array(board[3][3...5] + board[4][3...5] + board[5][3...5])
                        }
                        else{
                            boxVals = Array(board[3][6...8] + board[4][6...8] + board[5][6...8])
                        }
                    }
                    else{
                        if col < 3{
                            boxVals = Array(board[6][0...2] + board[7][0...2] + board[8][0...2])
                        }
                        else if col < 6{
                            boxVals = Array(board[6][3...5] + board[7][3...5] + board[8][3...5])
                        }
                        else{
                            boxVals = Array(board[6][6...8] + board[7][6...8] + board[8][6...8])
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
            }
            break
        }
        board[row][col] = 0
        return false
    }
    
    func findBoardOptions(board: [[Int]]) -> Bool{
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
                        var boardCopy: [[Int]] = board
                        boardCopy[row][col]=val
                        if checkBoardFull(board: boardCopy){
                            boardOptionsFound += 1
                            break
                        }
                        else{
                            if findBoardOptions(board: board){
                                return true
                            }
                        }
                    }
                }
                break
            }
        }
        var boardCopy: [[Int]] = board
        boardCopy[row][col] = 0
        return false
    }
    
    func drawBoard(){
        for row in 0...8{
            for col in 0...8{
                var newVal: String = String(currentBoardVals[row][col])
                if newVal == "0"{
                    newVal = " "
                }
                boardButtons![row][col].setTitle(newVal, for: .normal)
            }
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


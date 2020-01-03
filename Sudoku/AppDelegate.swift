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

    var window : UIWindow?
    
    enum Difficulty{
        case veryEasy
        case easy
        case medium
        case hard
        case notSet
    }
    
    struct Puzzle{
        var given: [[Int]]
        var solution: [[Int]]
        var userVals: [[Int]]
        var diff: Difficulty
        var name: String
        
        func checkSolved() -> Bool{
            return solution == userVals
        }
        init(gvn: [[Int]], sol: [[Int]], uv: [[Int]], d: Difficulty, n: String){
            given = gvn
            solution = sol
            userVals = uv
            diff = d
            name = n
        }
    }
    
    
    var selectedRow: Int?
    var selectedCol: Int?
    var puzzleData: [Puzzle]!
    var currentGameIndex: Int!
    var boardButtons: [[UIButton]]!
    
    var highlightRowAndCol: Bool = true
    
    func reset(){
        puzzleData[currentGameIndex].userVals = puzzleData[currentGameIndex].given
        for row in 0...8{
            for col in 0...8{
                boardButtons[row][col].backgroundColor = .white
                if puzzleData[currentGameIndex].given[row][col] != 0{
                    boardButtons[row][col].setTitleColor(.black, for: .normal)
                }
                else{
                    boardButtons[row][col].setTitleColor(.darkGray, for: .normal)
                }
            }
        }
        
        let defaults = UserDefaults.standard
        defaults.set(nil, forKey:puzzleData[currentGameIndex].name)
        
        selectedRow = nil
        selectedCol = nil
        drawBoard()
    }
    
    func setSelectedValue(val: Int){
        puzzleData[currentGameIndex].userVals[selectedRow!][selectedCol!] = val
        let defaults = UserDefaults.standard
        defaults.set(puzzleData[currentGameIndex].userVals, forKey:puzzleData[currentGameIndex].name)
    }
    
    func getCurrentPuzzle() -> Puzzle{
        return puzzleData[currentGameIndex]
    }
    
    func initPuzzleData(){
        puzzleData = []
        var rawData: String = ""
        if let filepath = Bundle.main.path(forResource: "puzzleData", ofType: "txt") {
            do {
                rawData = try String(contentsOfFile: filepath)
            } catch {
                print("file could not be loaded")
            }
        } else {
            print("file could not be found")
        }
        
        let dataList = rawData.components(separatedBy:"*****\n")
        for puzzleInfo in dataList{
            let infoArr = puzzleInfo.components(separatedBy:"\n")
            let name = infoArr[0]
            var diff: Difficulty = .notSet
            let diffStr = infoArr[1]
            if diffStr == "veryEasy"{
                diff = .veryEasy
            }
            if diffStr == "easy"{
                diff = .easy
            }
            if diffStr == "medium"{
                diff = .medium
            }
            if diffStr == "hard"{
                diff = .hard
            }
            
            //print(infoArr)
            
            let givenVals = [(infoArr[2].components(separatedBy: ",")).map{Int($0)!},(infoArr[3].components(separatedBy: ",")).map{Int($0)!},(infoArr[4].components(separatedBy: ",")).map{Int($0)!},(infoArr[5].components(separatedBy: ",")).map{Int($0)!},(infoArr[6].components(separatedBy: ",")).map{Int($0)!},(infoArr[7].components(separatedBy: ",")).map{Int($0)!},(infoArr[8].components(separatedBy: ",")).map{Int($0)!},(infoArr[9].components(separatedBy: ",")).map{Int($0)!},(infoArr[10].components(separatedBy: ",")).map{Int($0)!}]
            
            let solutions = [infoArr[12].components(separatedBy: ",").map{Int($0)!},infoArr[13].components(separatedBy: ",").map{Int($0)!},infoArr[14].components(separatedBy: ",").map{Int($0)!},infoArr[15].components(separatedBy: ",").map{Int($0)!},infoArr[16].components(separatedBy: ",").map{Int($0)!},infoArr[17].components(separatedBy: ",").map{Int($0)!},infoArr[18].components(separatedBy: ",").map{Int($0)!},infoArr[19].components(separatedBy: ",").map{Int($0)!},infoArr[20].components(separatedBy: ",").map{Int($0)!}]
            
            let defaults = UserDefaults.standard
            var userVals: [[Int]]? = defaults.array(forKey: name) as! [[Int]]?
            if userVals == nil{
                userVals = givenVals
            }
            
            let newPuzzle = Puzzle(gvn: givenVals, sol: solutions, uv: userVals!, d: diff, n: name)
            puzzleData.append(newPuzzle)
            
            
        }
    }
    
    func findBoxVals(board: [[Int]], row: Int, col: Int) -> [Int]{
        var boxVals: [Int]
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
        return boxVals
    }
    
    
    func drawBoard(){
        let currentBoardVals = puzzleData[currentGameIndex].userVals
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

    @available(iOS 13.0, *) func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *) func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


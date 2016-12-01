//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    let questionsPerRound = 5
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    
    var gameSound: SystemSoundID = 0
    var correctSound: SystemSoundID = 0
    var wrongSound: SystemSoundID = 0
    
    let quiz = QuizModel()
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var questionThree: UIButton!
    @IBOutlet weak var questionFour: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound()
        // Start game
        playGameStartSound()
        displayQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayQuestion() {
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: quiz.quizQuestions.count)
        questionField.text = quiz.quizQuestions[indexOfSelectedQuestion].question

        trueButton.setTitle(quiz.quizQuestions[indexOfSelectedQuestion].possibleAnswers[0], for: .normal)
        falseButton.setTitle(quiz.quizQuestions[indexOfSelectedQuestion].possibleAnswers[1], for: .normal)
        questionThree.setTitle(quiz.quizQuestions[indexOfSelectedQuestion].possibleAnswers[2], for: .normal)
        if quiz.quizQuestions[indexOfSelectedQuestion].possibleAnswers.count == 4 {
            questionFour.setTitle(quiz.quizQuestions[indexOfSelectedQuestion].possibleAnswers[3], for: .normal)
        } else{
           questionFour.isHidden = true
        }
        playAgainButton.isHidden = true
    }
    
    func displayScore() {
        // Hide the answer buttons
        trueButton.isHidden = true
        falseButton.isHidden = true
        questionThree.isHidden = true
        questionFour.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        
    }
    
       @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        
        if sender.title(for: .normal) == quiz.quizQuestions[indexOfSelectedQuestion].correctAnswer {
            sender.backgroundColor = UIColor(red: 127/255.0, green: 255/255.0, blue: 0/255.0, alpha: 1.0)
            loadCorrectSounds()
            playCorrectSound()
            correctQuestions += 1
            
        } else {
            loadWrongSound()
            playWrongSound()
            sender.backgroundColor = UIColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
        }
        
     
        loadNextRoundWithDelay(seconds: 2)
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            trueButton.backgroundColor = UIColor(red: 12/255.0, green: 121/255.0, blue: 150/255.0, alpha: 1.0)
            falseButton.backgroundColor = UIColor(red: 12/255.0, green: 121/255.0, blue: 150/255.0, alpha: 1.0)
            questionThree.backgroundColor = UIColor(red: 12/255.0, green: 121/255.0, blue: 150/255.0, alpha: 1.0)
            questionFour.backgroundColor = UIColor(red: 12/255.0, green: 121/255.0, blue: 150/255.0, alpha: 1.0)
            displayQuestion()
        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        trueButton.isHidden = false
        falseButton.isHidden = false
        questionThree.isHidden = false
        questionFour.isHidden = false
        
        questionsAsked = 0
        correctQuestions = 0
        
        nextRound()
        
    }
    

    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    func loadGameStartSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }
    
    func loadCorrectSounds() {
        let pathToCorrectSoundFile = Bundle.main.path(forResource: "CorrectAnswer", ofType: "mp3")
        let correctURL = URL(fileURLWithPath: pathToCorrectSoundFile!)
        AudioServicesCreateSystemSoundID(correctURL as CFURL, &correctSound)
        
    }
    
    func loadWrongSound() {
        let pathToWrongSoundFile = Bundle.main.path(forResource: "WrongAnswer", ofType: "mp3")
        let wrongURL = URL(fileURLWithPath: pathToWrongSoundFile!)
        AudioServicesCreateSystemSoundID(wrongURL as CFURL, &wrongSound)
        
    }
    
    func playWrongSound() {
        AudioServicesPlaySystemSound(wrongSound)
    }
    
    func playCorrectSound() {
        AudioServicesPlaySystemSound(correctSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
}


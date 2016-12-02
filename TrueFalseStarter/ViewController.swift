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
    
    //Game Sound ID's
    var gameSound: SystemSoundID = 0
    var correctSound: SystemSoundID = 0
    var wrongSound: SystemSoundID = 0
    
    //Quiz Object
    var quiz = QuizModel()
    
    @IBOutlet weak var notificationLabel: UILabel!
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
        
        //Show Answer Buttons
        trueButton.setTitle(quiz.quizQuestions[indexOfSelectedQuestion].possibleAnswers[0], for: .normal)
        falseButton.setTitle(quiz.quizQuestions[indexOfSelectedQuestion].possibleAnswers[1], for: .normal)
        questionThree.setTitle(quiz.quizQuestions[indexOfSelectedQuestion].possibleAnswers[2], for: .normal)
        questionFour.setTitle(quiz.quizQuestions[indexOfSelectedQuestion].possibleAnswers[3], for: .normal)
        
        playAgainButton.isHidden = true
        notificationLabel.isHidden = true
    }
    
    func displayScore() {
        // Hide the answer buttons
        trueButton.isHidden = true
        falseButton.isHidden = true
        questionThree.isHidden = true
        questionFour.isHidden = true
        notificationLabel.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "You got \(correctQuestions) out of \(questionsPerRound) correct!"
        
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        
        if sender.title(for: .normal) == quiz.quizQuestions[indexOfSelectedQuestion].correctAnswer {
            quiz.correctAnswer(label: sender, notificationLabel: notificationLabel)
            loadCorrectSounds()
            playCorrectSound()
            correctQuestions += 1
            quiz.removeQuestion(index: indexOfSelectedQuestion)
            
        } else {
            quiz.wrongAnswer(label: sender, notificationLabel: notificationLabel)
            loadWrongSound()
            playWrongSound()
            quiz.removeQuestion(index: indexOfSelectedQuestion)
        }
        
        loadNextRoundWithDelay(seconds: 2)
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game and set buttons color back to normal
            quiz.normalButtonColor(firstButton: trueButton, secondButton: falseButton, thirdButton: questionThree, fourthButton: questionFour)
            displayQuestion()
        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        quiz.playAgain(firstButton: trueButton, secondButton: falseButton, thirdButton: questionThree, fourthButton: questionFour)
        
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

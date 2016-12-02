//
//  QuizModel.swift
//  TrueFalseStarter
//
//  Created by Cori Mims on 11/30/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//
import UIKit

struct QuizModel {
    var quizQuestions: [Question] = [Question(question: "Who sang \("\"I heard it through the grapevine\"") first?", correctAnswer: "Gladys Knight", possibleAnswers: ["Marving Gaye", "Gladys Knight", "Levi Stubbs", "Smokey Robinson"]), Question(question: "In what year was Rihanna's album \("\"Loud\"") released?", correctAnswer: "2010", possibleAnswers: ["2012", "2010", "2015", "2008"]), Question(question: "Which artist sings the song \("Hello")?", correctAnswer: "Adele", possibleAnswers: ["Miley Cyrus", "Adele", "Beyonce", "Katy Perry"]), Question(question: "Which band made the song \("We Are The Champions")", correctAnswer: "Queen", possibleAnswers: ["The Rolling Stones", "The Doors", "Queen", "Aerosmith"]), Question(question: "Which is Michael Jackson's most successful album", correctAnswer: "Thriller", possibleAnswers: ["Thriller", "Off the Wall", "Bad", "Dangerous"])]
    let secondSetOfQuestions: [Question] = [Question(question: "Who sang \("\"I heard it through the grapevine\"") first?", correctAnswer: "Gladys Knight", possibleAnswers: ["Marving Gaye", "Gladys Knight", "Levi Stubbs", "Smokey Robinson"]), Question(question: "In what year was Rihanna's album \("\"Loud\"") released?", correctAnswer: "2010", possibleAnswers: ["2012", "2010", "2015", "2008"]), Question(question: "Which artist sings the song \("Hello")?", correctAnswer: "Adele", possibleAnswers: ["Miley Cyrus", "Adele", "Beyonce", "Katy Perry"]), Question(question: "Which band made the song \("We Are The Champions")", correctAnswer: "Queen", possibleAnswers: ["The Rolling Stones", "The Doors", "Queen", "Aerosmith"]), Question(question: "Which is Michael Jackson's most successful album", correctAnswer: "Thriller", possibleAnswers: ["Thriller", "Off the Wall", "Bad", "Dangerous"])]
    
    mutating func removeQuestion(index: Int) {
        self.quizQuestions.remove(at: index)
    }
    
    func correctAnswer(label: UIButton, notificationLabel: UILabel) {
        label.backgroundColor = UIColor(red: 127/255.0, green: 255/255.0, blue: 0/255.0, alpha: 1.0)
        notificationLabel.textColor = UIColor(red: 127/255.0, green: 255/255.0, blue: 0/255.0, alpha: 1.0)
        notificationLabel.text = "Correct"
        notificationLabel.isHidden = false
    }
    
    func wrongAnswer(label: UIButton, notificationLabel: UILabel) {
        label.backgroundColor = UIColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
        notificationLabel.textColor = UIColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)
        notificationLabel.text = "Incorrect"
        notificationLabel.isHidden = false
    }
    
    func normalButtonColor(firstButton: UIButton, secondButton: UIButton, thirdButton: UIButton, fourthButton: UIButton) {
        firstButton.backgroundColor = UIColor(red: 12/255.0, green: 121/255.0, blue: 150/255.0, alpha: 1.0)
        secondButton.backgroundColor = UIColor(red: 12/255.0, green: 121/255.0, blue: 150/255.0, alpha: 1.0)
        thirdButton.backgroundColor = UIColor(red: 12/255.0, green: 121/255.0, blue: 150/255.0, alpha: 1.0)
        fourthButton.backgroundColor = UIColor(red: 12/255.0, green: 121/255.0, blue: 150/255.0, alpha: 1.0)
    }
    
    mutating func playAgain(firstButton: UIButton, secondButton: UIButton, thirdButton: UIButton, fourthButton: UIButton) {
        addQuestionsBack()
        firstButton.isHidden = false
        secondButton.isHidden = false
        thirdButton.isHidden = false
        fourthButton.isHidden = false
    }
    
    mutating func addQuestionsBack() {
        quizQuestions.append(contentsOf: secondSetOfQuestions)
    }
}

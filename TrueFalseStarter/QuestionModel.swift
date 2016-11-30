//
//  QuestionModel.swift
//  TrueFalseStarter
//
//  Created by Cori Mims on 11/30/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//



struct Question {
    let question: String
    let correctAnswer: String
    let possibleAnswers: [String]
    
    func showCorrectAnswer() -> String {
        return correctAnswer
    }
    
}




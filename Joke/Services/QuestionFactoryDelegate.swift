import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: JokeQuestionAndPunchline?)
    func didLoadDataFromServer()
    func didFailToLoadData(with error: Error)
}


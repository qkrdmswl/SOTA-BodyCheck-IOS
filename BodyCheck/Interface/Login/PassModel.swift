//
//  PassModel.swift
//  BodyCheckApp2
//
//  Created by 언지 on 2021/07/29.
//

import Foundation
import Combine

class PassModel : ObservableObject {

    @Published var firstEntry: String = "" {
        didSet {
            firstLine.send(self.firstEntry)
        }
    }
    private let firstLine = CurrentValueSubject<String, Never>("")

    @Published var secondEntry: String = "" {
        didSet {
            secondLine.send(self.secondEntry)
        }
    }
    private let secondLine = CurrentValueSubject<String, Never>("")

    @Published var validationMessages = [String]()
    private var cancellableSet: Set<AnyCancellable> = []

    var submitAllowed: AnyPublisher<Bool, Never>
    
    init() {
        let validationPipeline = Publishers.CombineLatest(firstLine, secondLine)
            .map { (arg) -> [String] in
                var diagMsgs = [String]()
                let (value, value_repeat) = arg
                if (value.count > 0){
                    if !(value_repeat == value) {
                        diagMsgs.append("비밀번호가 맞지 않습니다.")
                    }
                    if (value.count < 8) {
                        diagMsgs.append("최소 8자리여야 합니다.")
                    }
    //                if (value.isNumeric || value_repeat.isNumeric) {
    //                  diagMsgs.append("Please enter numeric values only")
    //                }
                    if (value.isAlphabeticNumeric || value_repeat.isAlphabeticNumeric) {
                      diagMsgs.append("영어와 숫자로만 이루어져야 합니다.")
                    }
    //                if (value.isAlphabetic || value_repeat.isAlphabetic) {
    //                  diagMsgs.append("Please enter letters only")
    //                }
                    if (value.atLeastOneLetter || value_repeat.atLeastOneLetter ) {
                      diagMsgs.append("대문자가 최소 하나 이상 들어가야 합니다.")
                    }
                    if (value.atLeastOneNumber || value_repeat.atLeastOneNumber ) {
                      diagMsgs.append("숫자가 최소 하나 이상 들어가야 합니다.")
                    }
                } else {
                    diagMsgs.append("비밀번호를 입력하세요")
                }
                return diagMsgs
            }

        submitAllowed = validationPipeline
            .map { stringArray in
                return stringArray.count < 1
            }
            .eraseToAnyPublisher()

        let _ = validationPipeline
            .assign(to: \.validationMessages, on: self)
            .store(in: &cancellableSet)

    }
}

extension String {
  public var atLeastOneNumber: Bool {
    return self.range(of:"(?=.*\\d+)", options: .regularExpression) == nil
  }
}

extension String {
  public var atLeastOneLetter: Bool {
    return self.range(of:"(?=.*[A-Z]+)", options: .regularExpression) == nil
  }
}

extension String {
    public var isNumeric: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) != nil
    }
}

extension String {
    public var isAlphabeticNumeric: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil
    }
}

extension String {
    public var isAlphabetic: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.letters.inverted) != nil
    }
}

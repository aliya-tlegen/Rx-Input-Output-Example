//
//  ViewModel.swift
//  RxExampleInputOutput
//
//  Created by Алия on 23.01.2023.
//
import RxSwift
import RxCocoa
import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

final class SayHelloViewModel: ViewModelType {
    struct Input {
        let name: Observable<String>
        let validate: Observable<Void>
    }
    
    struct Output {
        let greeting: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        let greeting = input.validate
            .withLatestFrom(input.name)
            .map { name in
                return "Hello \(name)!"
            }
            .startWith("")
            .asDriver(onErrorJustReturn: ":-(")
        
        return Output(greeting: greeting)
    }
}

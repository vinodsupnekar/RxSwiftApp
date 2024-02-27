//
//  ContentView.swift
//  RxSwiftApp
//
//  Created by Vinod Supnekar on 25/02/24.
//

import SwiftUI
import RxSwift

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear(perform: { 
//            testObservable()
//            testDisposable()
            testObserverEventFiringManuallyAndIts_Subscription()
        })
    }
    
    func testObservable() {
        
//        let observable = Observable.of("a", "b", "c")
//        
//        observable.subscribe { event in
//            print(event.element ?? event)
//        }
//        
//        // To ignore other events, and only read events with value, i.e. inoke  onNext
//        
//        observable.subscribe(onNext: { element in
//            print(element)
//        })
        
        let emptyObservable = Observable<Void>.empty()
        
        emptyObservable
            .subscribe(onNext: { element in
                print(element)
            },
            onCompleted: {
                print("completed")
            })
        
        /* o/p ==> completed
         
         As, empty Obervable emits only single event completed*/
        
    }
    
    func testDisposable() {
        // Using Return value from Observable.subcribe
            
        let subscription = Observable.of(1, 2, 3)
            .subscribe(onNext: { event in
                print(event)
            },
            onCompleted: {
                print("completed event")
            }
            )
        
        subscription.dispose()
        
        
        
        /* Observable may event infinite events until any error or Completed event is fired.
         To make sure to cancle the subscription after finite set of events (i.e once the work is achieved from few events ),
         Observable's subscirbe method returns Disposable.
         
         And disposed(by: disposeBag) method on it, make sure subscription stops and avoid any memory leak.
         
         */
        
        let disposeBag = DisposeBag()

        Observable.of(1, 2, 3)
            .subscribe { event in
                print(event)
            }
            .disposed(by: disposeBag)
    }
    
    // Emit Error from Observable
    
    func testObserverEventFiringManuallyAndIts_Subscription() {
        
        enum DroidError: Error {
            case OU812
        }
        
        
        let disposeBag = DisposeBag()
        
        Observable<String>.create { observer in
            
            observer.onNext("R4-WEWE")
            observer.onNext("ER445")
//            observer.onError(DroidError.OU812) // Once Error is emitted, Observable element sequence is broken, and further events are not emitted.
            observer.onNext("E@2323")
//            observer.onCompleted()
            
           return Disposables.create()
        }
        .subscribe(onNext: {
            print($0)
        },
        onError: {
            print("error \($0)")
        },
        onCompleted: {
            print("completed")
        })
//        .disposed(by: disposeBag)
        
    }
        
}

#Preview {
    ContentView()
}

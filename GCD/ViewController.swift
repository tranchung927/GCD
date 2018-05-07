//
//  ViewController.swift
//  GCD
//
//  Created by Chung on 5/3/18.
//  Copyright © 2018 Chung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //        simpleQueue()
        //        simpleConcurrentQueue()
        //        simpleRacingData()
        //        simpleAsyncAfter()
        simpleDispatchWorkItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func simpleQueue() {
        
        // Khai báo serial queue
        let serialQueue = DispatchQueue(label: "com.bigZero.serialQueue")
        
        // Vòng lặp 5 lần tượng trưng đưa 5 task vào trong serial queue
        for i in 1...5 {
            
            // Các task đưa vào sẽ được đánh dấu là Aynchronous
            serialQueue.async {
                print("Task \(i): - \(Thread.current))")
                // Vì hệ thống sẽ xử ý rất nhanh
                //nên mỗi lần chạy xong nghỉ 1s để quan sát rõ hơn.
                sleep(1)
            }
        }
        print("Complete! - \(Thread.current)")
    }
    
    func simpleConcurrentQueue() {
        // Khai báo serial queue
        let concurrentQueue = DispatchQueue(label: "com.bigZero.concurrentQueue",
                                            attributes: .concurrent)
        
        // Vòng lặp 10 lần tượng trưng đưa 5 task vào trong concurrent queue
        for i in 1...10 {
            // Các task đưa vào sẽ được đánh dấu là Aynchronous
            concurrentQueue.async {
                print("Task \(i) - \(Thread.current)")
                sleep(1)
            }
        }
        print("Complete! - \(Thread.current)")
    }
    
    func simpleRacingData() {
        let queue = DispatchQueue(label: "com.bigZero.currentQueueRacing",
                                  attributes: .concurrent)
        var count = 0
        for _ in 1...25000 {
            queue.async {
                count += 1
                print(count)
            }
        }
    }
    
    func simpleAsyncAfter() {
        let queue = DispatchQueue(label: "com.bigZero.queue")
        queue.asyncAfter(deadline: .now() + 2) {
            print("Simple asyncAfter")
        }
    }
    
    func simpleDispatchWorkItem() {
        var count = 0
        
        // Khai báo 1 DispatchWorkItem thực hiện
        // công việc tăng count lên 1 và in ra terminal
        let item = DispatchWorkItem {
            count += 1
            print(count)
        }
        for _ in 1...1000 {
            // Kiểm tra count nếu bằng 900 thì dừng
            if count == 900 {
                item.cancel()
                print("DispatchWorkItem cancel")
                break
            } else {
               item.perform()
            }
        }
    }
    
    func simpleDispatchGroup() {
        let group = DispatchGroup()
        group.enter()
        
    }
}


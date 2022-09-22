//
//  ViewController.swift
//  NASA API
//
//  Created by roman Khilchenko on 15.09.2022.
//

import UIKit

final class MainViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var explanationLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
   
    
    //MARK: - Переопределенные методы
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        fetchImage()
        setupActivitiIndicator()
    }
    
    //MARK: - IBActions
    @IBAction func actionButton(_ sender: UIButton) {
        if sender.currentTitle == "Show Info" {
            sender.setTitle("Hide Info", for: .normal)
            explanationLabel.isHidden = false
        } else {
            sender.setTitle("Show Info", for: .normal)
            explanationLabel.isHidden = true
        }
    }
    
    //MARK: - Приватные методы
    private func fetchData() {
        NetworkManager.shared.fetchNasa(from: Link.nasaURL.rawValue) { nasa in
            self.explanationLabel.text = nasa.explanation
            self.dateLabel.text = nasa.date
            
        }
    }
    
    private func fetchImage() {
        NetworkManager.shared.fetchImage(from: Link.imageUrl.rawValue) { imageUrl in
            self.imageView.image = UIImage(data: imageUrl)
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func setupActivitiIndicator() {
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
}




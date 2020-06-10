//
//  DoctorDetailsController.swift
//  Project
//
//  Created by Chan Basha on 04/05/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit

class DoctorDetailsController: UIViewController {
    
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var btnFavourite: UIButton!
    @IBOutlet weak var imgDoctor: UIImageView!
    @IBOutlet weak var labelDoctorName: UILabel!
    @IBOutlet weak var labelSpeciality: UILabel!
    @IBOutlet weak var labelQualification: UILabel!
    @IBOutlet weak var labelPercentage: UILabel!
    @IBOutlet weak var labelExp: UILabel!
    @IBOutlet weak var labelVerified: UILabel!
    @IBOutlet weak var labelAvailability: UILabel!
    @IBOutlet weak var labelMonday: UILabel!
    @IBOutlet weak var labelTue: UILabel!
    @IBOutlet weak var labelWed: UILabel!
    @IBOutlet weak var labelThu: UILabel!
    @IBOutlet weak var labelFri: UILabel!
    @IBOutlet weak var labelSat: UILabel!
    @IBOutlet weak var labelSun: UILabel!
    @IBOutlet weak var labelTiming: UILabel!
    @IBOutlet weak var labelServices: UILabel!
    @IBOutlet weak var servicesTV: UITableView!
    @IBOutlet weak var labelSpecilization: UILabel!
    @IBOutlet weak var specilizationTV: UITableView!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelClinicName: UILabel!
    @IBOutlet weak var labelLocationValue: UILabel!
    @IBOutlet weak var imgLocationPreview: UIImageView!
    @IBOutlet weak var labelPhotos: UILabel!
    @IBOutlet weak var photosCV: UICollectionView!
    @IBOutlet weak var labelReviews: UILabel!
    @IBOutlet weak var reviewsCV: UICollectionView!
    @IBOutlet weak var specilizationTVHeight: NSLayoutConstraint!
    @IBOutlet weak var serviceTVHeight: NSLayoutConstraint!
    
    //inital static Data
    var serviceList : [String] = ["Vaccination/Immunization","Adolescent Medicine","New Born Care","Infant & Child nutrition"]
    var specializationList : [String] = ["Pediatrician","General Physician","Vaccination/Immunization","Adolescent Medicine","New Born Care","Infant & Child nutrition"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //View Setup
        self.initialLoads()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.specilizationTVHeight.constant = self.specilizationTV.contentSize.height + 10
        self.serviceTVHeight.constant = self.servicesTV.contentSize.height + 10
    }
    
}

extension DoctorDetailsController{
    
    private func initialLoads() {
        setupNavigationBar()
        self.setupTableViewCell()
        self.setupCollectionViewCell()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
        let shareButton = UIBarButtonItem(image: #imageLiteral(resourceName: "share").resizeImage(newWidth: 20), style: .plain, target: self, action: #selector(shareAction))
        let infoButton = UIBarButtonItem(image: #imageLiteral(resourceName: "info").resizeImage(newWidth: 20), style: .plain, target: self, action: #selector(infoAction))
        self.navigationItem.rightBarButtonItems = [shareButton,infoButton]
            
    }
    
    @objc func shareAction() {
        print("Share action here")
    }
    
    @objc func infoAction() {
           print("Info action here")
       }
    
}

extension DoctorDetailsController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.servicesTV{
            return self.serviceList.count
        }else if tableView == self.specilizationTV{
            if self.specializationList.count > 4{
                return 4
                
            }else{
                return self.specializationList.count
            }
        }
        else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.ServiceSpecializationCell) as! ServiceSpecializationCell
        
        if tableView == self.servicesTV{
            cell.serviceLbl.text = self.serviceList[indexPath.row]
        }else if tableView == self.specilizationTV{
            cell.serviceLbl.text = self.specializationList[indexPath.row]
        }
        
        self.viewDidLayoutSubviews()
        self.view.layoutIfNeeded()
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = createViewAllButtion()
        footerView.addTap {
            print("HEllofooter")
        }
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if tableView == self.servicesTV{
            if self.serviceList.count > 4{
                return 40
            }else{
                return 0
            }
        }else if tableView == self.specilizationTV{
            if self.specializationList.count > 4{
                return 40
            }else{
                return 0
            }
        }
         return 0
    }
    
    func setupTableViewCell(){
        self.servicesTV.registerCell(withId: XIB.Names.ServiceSpecializationCell)
        self.specilizationTV.registerCell(withId: XIB.Names.ServiceSpecializationCell)
    }
    
    
    func createViewAllButtion() -> UIView{
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        customView.backgroundColor = .clear
        let viewLabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))

        Common.setFont(to: viewLabel,isTitle : true)
        viewLabel.text = "View all >"
        viewLabel.textAlignment = .center
        viewLabel.textColor = UIColor.appColor
        customView.addSubview(viewLabel)
        return customView
    }
}


extension DoctorDetailsController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.photosCV{
            return  10
        }else if collectionView == self.reviewsCV{
             return  5
        }
        return  0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.photosCV{
            let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: XIB.Names.PhotosCell, for: indexPath) as! PhotosCell
            return photoCell
        }else if collectionView == self.reviewsCV{
            let reviewCell = collectionView.dequeueReusableCell(withReuseIdentifier: XIB.Names.ReviewCell, for: indexPath) as! ReviewCell
            return reviewCell
        }
        
        let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: XIB.Names.PhotosCell, for: indexPath) as! PhotosCell
        return photoCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.photosCV{
            return CGSize(width: 100, height: 100)
        }else if collectionView == self.reviewsCV{
            return CGSize(width:  (UIScreen.main.bounds.width / 2) + 10, height: 120)
        }

        return CGSize(width: 200, height: 100)
    }
    
    func setupCollectionViewCell(){
        self.photosCV.registerCell(withId: XIB.Names.PhotosCell)
        self.reviewsCV.registerCell(withId: XIB.Names.ReviewCell)
        self.photosCV.reloadData()
         self.reviewsCV.reloadData()
    }
}

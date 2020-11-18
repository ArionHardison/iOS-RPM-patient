//
//  MedicalRecordsViewController.swift
//  MiDokter User
//
//  Created by Vinod Reddy Sure on 12/06/20.
//  Copyright © 2020 css. All rights reserved.
//

import UIKit
import ObjectMapper

class MedicalRecordsViewController: UIViewController {

    @IBOutlet weak var listTable: UITableView!
    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var downloadMedicalView: UIView!
    
     var medical : [Medical] = [Medical]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialLoads()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.getMedicalRecords()
    }

}

extension MedicalRecordsViewController {
    func initialLoads() {
        registerCell()
        setupNavigationBar()

    }
    private func setupNavigationBar() {
         self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "Medical Records"
         Common.setFont(to: self.navigationItem.title!, isTitle: true, size: 18)
         self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
         self.navigationController?.navigationBar.isTranslucent = false
         self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.02583951317, green: 0.1718649864, blue: 0.4112361372, alpha: 1)
        self.noDataLabel.text = "No Medical Records Found"
    }

    func registerCell(){
        self.listTable.registerCell(withId: XIB.Names.FavDoctorTableViewCell)
        
        self.listTable.tableFooterView = UIView()
    }
}

extension MedicalRecordsViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.medical.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.listTable.dequeueReusableCell(withIdentifier: XIB.Names.FavDoctorTableViewCell, for: indexPath) as! FavDoctorTableViewCell
        self.populateData(cell: cell, data: self.medical[indexPath.row])
        return cell
    }
    
    func populateData(cell : FavDoctorTableViewCell , data : Medical){
        cell.labelName.text = "\(data.hospital?.first_name ?? "") \(data.hospital?.last_name ?? "")"
        cell.doctorImage.setURLImage(data.hospital?.doctor_profile?.profile_pic ?? "")
        cell.labelSpeciality.text = data.hospital?.doctor_profile?.speciality?.name ?? ""
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}
//Api calls
extension MedicalRecordsViewController : PresenterOutputProtocol{
    func showSuccess(api: String, dataArray: [Mappable]?, dataDict: Mappable?, modelClass: Any) {
        switch String(describing: modelClass) {
            case model.type.MedicalRecordsModel:
                let data = dataDict as? MedicalRecordsModel
                self.medical = data?.medical ?? [Medical]()
                if self.medical.count > 0 {
                    self.downloadMedicalView.isHidden = false
                    self.listTable.isHidden = false
                    self.noDataView.isHidden = true
                }else{
                    self.downloadMedicalView.isHidden = true
                    self.listTable.isHidden = true
                    self.noDataView.isHidden = false
                }
                self.listTable.reloadData()
                break
            
            default: break
            
        }
    }
    
    func showError(error: CustomError) {
        
    }
    
    func getMedicalRecords(){
        self.presenter?.HITAPI(api: Base.medicalRecords.rawValue, params: nil, methodType: .GET, modelClass: MedicalRecordsModel.self, token: true)
    }
    
}

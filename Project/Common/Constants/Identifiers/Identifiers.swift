//
//  Identifiers.swift
//  User
//
//  Created by imac on 12/19/17.
//  Copyright © 2017 Appoets. All rights reserved.
//

import Foundation

public enum storyboardName : String{
    case main = "Main"
    case user = "User"
    
}

// MARK:- Storyboard Id
struct Storyboard {
    
    static let Ids = Storyboard()
    let DrawerController = "DrawerController"
    let HomeViewController = "HomeViewController"
    let SigninInViewController = "SigninInViewController"
    let NameAndEmailViewController = "NameAndEmailViewController"
    let EmailViewController = "EmailViewController"
    let GenderConfirmationVC = "GenderConfirmationVC"
    let DateOfBirthViewController = "DateOfBirthViewController"
    let AppointmentViewController = "AppointmentViewController"
    let SideBarTableViewController = "SideBarTableViewController"
    let LaunchNavigationController = "LaunchNavigationController"
    let UpcomingDetailsController = "UpcomingDetailsController"
    let OnlineAvailabeDoctorsController = "OnlineAvailabeDoctorsController"
    let CategoryListController = "CategoryListController"
    let DoctorsListController = "DoctorsListController"
    let DoctorDetailsController = "DoctorDetailsController"
    let VisitedDoctorsViewController = "VisitedDoctorsViewController"
    let AppointmentDetailsViewController = "AppointmentDetailsViewController"
    let ThankYouViewController = "ThankYouViewController"
    let ChatTableViewController = "ChatTableViewController"
    let SearchViewController = "SearchViewController"
    let FavouriteDoctorsListController = "FavouriteDoctorsListController"
    let MedicalRecordsViewController = "MedicalRecordsViewController"
    let WalletViewController = "WalletViewController"
    let HealthFeedViewController = "HealthFeedViewController"
    let HealthFeedDetailsViewController = "HealthFeedDetailsViewController"
    let ReminderViewController = "ReminderViewController"
    let ReminderDetailViewController = "ReminderDetailViewController"
    let ServiceListViewController = "ServiceListViewController"
    let ChatQuestionViewController = "ChatQuestionViewController"
    let SelectedProblemAreaVC = "SelectedProblemAreaVC"
    let SummaryViewController = "SummaryViewController"
    let ChatViewController = "ChatViewController"
    let AlertVC = "AlertVC"
    let BookingViewController = "BookingViewController"
    let PatientDetailViewController = "PatientDetailViewController"
    let ProfileViewController = "ProfileViewController"
}


//MARK:- XIB Cell Names
    
struct XIB {
    
    static let Names = XIB()
    let DoctorsListCell = "DoctorsListCell"
    let LogoCell = "LogoCell"
    let SideBarCell = "SideBarCell"
    let UpcomingTableviewCell = "UpcomingTableviewCell"
    let OnlineDoctorCell = "OnlineDoctorCell"
    let ArticlesCell = "ArticlesCell"
    let ReminderCell = "ReminderCell"
    let CategoryCell = "CategoryCell"
    let DoctorCell = "DoctorCell"
    let VisitedDoctorsCell = "VisitedDoctorsCell"
    let SuggestedSpecialityCell = "SuggestedSpecialityCell"
    let ChatCommentCell = "ChatCommentCell"
    let ServiceSpecializationCell = "ServiceSpecializationCell"
    let PhotosCell = "PhotosCell"
    let ReviewCell = "ReviewCell"
    let SearchCell = "SearchCell"
    let FavDoctorTableViewCell = "FavDoctorTableViewCell"
    let HealthFeedTableViewCell = "HealthFeedTableViewCell"
    let SuggestedCell = "SuggestedCell"
    let ProblemCell = "ProblemCell"
    let ChatRightCell = "ChatRightCell"
    
    
}


//MARK:- Notification

extension Notification.Name {
   //public static let reachabilityChanged = Notification.Name("reachabilityChanged")
}




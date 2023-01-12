//
//  MapCollectionViewCell.swift
//  SearchableWeatherApp
//
//  Created by Y on 2023/01/12.
//

import UIKit
import MapKit
import CoreLocation

final class MapCollectionViewCell: BaseCollectionViewCell {
    
    let locationManager = CLLocationManager()
    
    let background: UIView = {
       let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = Constants.BaseColor.cellBackgroundColor
        return view
    }()
    
    let precipitationLabel: UILabel = {
       let label = UILabel()
        label.text = "강수량"
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    let mapView: MKMapView = {
        let view = MKMapView()
        view.isMultipleTouchEnabled = false
        view.isZoomEnabled = false
        view.isPitchEnabled = false
        view.isRotateEnabled = false
        view.isScrollEnabled = false
        view.layer.cornerRadius = 5
        return view
    }()
    
    override func configure() {
        locationManager.delegate = self
        mapView.delegate = self
        
        [background, precipitationLabel, mapView].forEach {
            addSubview($0)
        }
        
        setCenter()
    }
    
    override func setConstraints() {
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        precipitationLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalTo(safeAreaLayoutGuide).offset(4)
        }
        mapView.snp.makeConstraints { make in
            make.top.equalTo(precipitationLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
}

extension MapCollectionViewCell: MKMapViewDelegate, CLLocationManagerDelegate {
    private func setRegionAndAnnotation(coordinate: CLLocationCoordinate2D) {
        
        DispatchQueue.main.async {
            let allAnnotations = self.mapView.annotations
            self.mapView.removeAnnotations(allAnnotations)
            
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000000, longitudinalMeters: 1000000)
            self.mapView.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = User.city
            self.mapView.addAnnotation(annotation)
        }
        
    }
    
    public func setCenter() {
        let center = CLLocationCoordinate2D(latitude: User.userLat, longitude: User.userLon)
        setRegionAndAnnotation(coordinate: center)
    }
    
}

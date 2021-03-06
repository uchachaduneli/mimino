package ge.mimino.travel.request;

import ge.mimino.travel.controller.TmpHotelGroup;
import ge.mimino.travel.dto.GeoObjectDTO;
import ge.mimino.travel.dto.ProductDTO;
import ge.mimino.travel.dto.ProductGuidesDTO;
import ge.mimino.travel.dto.ProductRestaurantsDTO;
import ge.mimino.travel.model.*;

import java.util.List;

public class ProductRequest {
    private List<Integer> regions;
    private List<ProductRegions> regionsList;
    private List<GeoObjectDTO> sights;
    private List<ProductSights> sightsList;
    private List<Integer> places;
    private List<ProductPlaces> placesList;
    private List<TmpHotelGroup> hotels;
    private List<ProductTransports> transports;
    private List<String> transportDays;
    private List<Integer> nonstandarts;
    private List<ProductNonstandarts> nonstandartsList;
    private List<ProductRestaurantsDTO> restaurants;
    private List<ProductGuidesDTO> guides;
    private List<String> guideDays;
    private Integer day;
    private Integer requestId;
    private ProductDTO product;

    public List<String> getGuideDays() {
        return guideDays;
    }

    public void setGuideDays(List<String> guideDays) {
        this.guideDays = guideDays;
    }

    public List<ProductGuidesDTO> getGuides() {
        return guides;
    }

    public void setGuides(List<ProductGuidesDTO> guides) {
        this.guides = guides;
    }

    public List<ProductSights> getSightsList() {
        return sightsList;
    }

    public void setSightsList(List<ProductSights> sightsList) {
        this.sightsList = sightsList;
    }

    public List<ProductRegions> getRegionsList() {
        return regionsList;
    }

    public void setRegionsList(List<ProductRegions> regionsList) {
        this.regionsList = regionsList;
    }

    public List<ProductPlaces> getPlacesList() {
        return placesList;
    }

    public void setPlacesList(List<ProductPlaces> placesList) {
        this.placesList = placesList;
    }

    public List<ProductNonstandarts> getNonstandartsList() {
        return nonstandartsList;
    }

    public void setNonstandartsList(List<ProductNonstandarts> nonstandartsList) {
        this.nonstandartsList = nonstandartsList;
    }

    public List<String> getTransportDays() {
        return transportDays;
    }

    public void setTransportDays(List<String> transportDays) {
        this.transportDays = transportDays;
    }

    public List<Integer> getRegions() {
        return regions;
    }

    public void setRegions(List<Integer> regions) {
        this.regions = regions;
    }

    public List<GeoObjectDTO> getSights() {
        return sights;
    }

    public void setSights(List<GeoObjectDTO> sights) {
        this.sights = sights;
    }

    public List<Integer> getPlaces() {
        return places;
    }

    public void setPlaces(List<Integer> places) {
        this.places = places;
    }

    public List<TmpHotelGroup> getHotels() {
        return hotels;
    }

    public void setHotels(List<TmpHotelGroup> hotels) {
        this.hotels = hotels;
    }

    public List<ProductTransports> getTransports() {
        return transports;
    }

    public void setTransports(List<ProductTransports> transports) {
        this.transports = transports;
    }

    public List<Integer> getNonstandarts() {
        return nonstandarts;
    }

    public void setNonstandarts(List<Integer> nonstandarts) {
        this.nonstandarts = nonstandarts;
    }

    public List<ProductRestaurantsDTO> getRestaurants() {
        return restaurants;
    }

    public void setRestaurants(List<ProductRestaurantsDTO> restaurants) {
        this.restaurants = restaurants;
    }

    public Integer getDay() {
        return day;
    }

    public void setDay(Integer day) {
        this.day = day;
    }

    public Integer getRequestId() {
        return requestId;
    }

    public void setRequestId(Integer requestId) {
        this.requestId = requestId;
    }

    public ProductDTO getProduct() {
        return product;
    }

    public void setProduct(ProductDTO product) {
        this.product = product;
    }
}

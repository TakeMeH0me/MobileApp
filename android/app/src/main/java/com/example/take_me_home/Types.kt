package com.example.take_me_home

import java.util.Date

import kotlinx.serialization.Serializable
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json

@Serializable
data class RouteInformation(val date: Date,
                            val route: List<RoutePart>) {
}

@Serializable
data class RoutePart(val vehicle: VehicleType,
                val lineName: String,
                val lineDestination: String,
                val entrance: String,
                val entranceTime: Date,
                val exit: String,
                val exitTime: Date) {
}

@Serializable
enum class VehicleType {
    unknown,
    walk,
    tram,
    train,
    bus,
}
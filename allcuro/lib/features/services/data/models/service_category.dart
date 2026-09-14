import 'package:flutter/material.dart';

enum ServiceGroup {
  clinical, // Category A — High-Skill Clinical
  support, // Category B — Normal / Non-Skilled Support
  addon, // Category C — Specialized Add-Ons (Partner-Sourced)
  instant, // ⚡ Express 45m
}

class ServiceCategory {
  final String id;
  final String name;
  final String shortName;
  final String subtitle;
  final String description;
  final ServiceGroup group;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String requiredDegree; // e.g. "GNM / B.Sc Nursing", "ANM", "BPT Physiotherapist", "GDA"
  final String priceRange; // e.g. "₹500–700 / visit"
  final String marketPriceRange; // e.g. "₹600–900 / visit"
  final String badge; // e.g. "⚡ 45m", "Most Booked", "Doctor Verified"
  final List<String> procedures;
  final List<String> nurseDegreeFilters; // Which nurse levels match this service

  const ServiceCategory({
    required this.id,
    required this.name,
    required this.shortName,
    required this.subtitle,
    required this.description,
    required this.group,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.requiredDegree,
    required this.priceRange,
    required this.marketPriceRange,
    required this.badge,
    required this.procedures,
    required this.nurseDegreeFilters,
  });
}

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class orders {
  final String? orderId;
  final String? orderDate;
  final String? status;
  final String? totalPrice;

  orders({
    this.orderId,
    this.orderDate,
    this.status,
    this.totalPrice,
  });
  orders copyWith({
    String? orderId,
    String? orderDate,
    String? status,
    String? totalPrice,
  }) {
    return orders(
      orderId: orderId ?? this.orderId,
      orderDate: orderDate ?? this.orderDate,
      status: status ?? this.status,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderId': orderId,
      'orderDate': orderDate,
      'status': status,
      'totalPrice': totalPrice
    };
  }

  factory orders.fromMap(Map<String, dynamic> map) {
    return orders(
      orderId: map['orderId'] != null ? map['orderId'] as String : null,
      orderDate: map['orderDate'] != null ? map['orderDate'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      totalPrice:
          map['totalPrice'] != null ? map['totalPrice'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory orders.fromJson(String source) =>
      orders.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'orders(orderId: $orderId, orderDate: $orderDate, status: $status, totalPrice: $totalPrice)';
  }

  @override
  bool operator ==(covariant orders other) {
    if (identical(this, other)) return true;
    return other.orderId == orderId &&
        other.orderDate == orderDate &&
        other.status == status &&
        other.totalPrice == totalPrice;
  }

  @override
  int get hashCode {
    return orderId.hashCode ^
        orderDate.hashCode ^
        status.hashCode ^
        totalPrice.hashCode;
  }
}

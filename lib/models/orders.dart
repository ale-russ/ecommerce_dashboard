import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Orders {
  final String? orderId;
  final String? orderDate;
  final String? status;
  final String? totalPrice;

  Orders({
    this.orderId,
    this.orderDate,
    this.status,
    this.totalPrice,
  });
  Orders copyWith({
    String? orderId,
    String? orderDate,
    String? status,
    String? totalPrice,
  }) {
    return Orders(
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

  factory Orders.fromMap(Map<String, dynamic> map) {
    return Orders(
      orderId: map['orderId'] != null ? map['orderId'] as String : null,
      orderDate: map['orderDate'] != null ? map['orderDate'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      totalPrice:
          map['totalPrice'] != null ? map['totalPrice'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Orders.fromJson(String source) =>
      Orders.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'orders(orderId: $orderId, orderDate: $orderDate, status: $status, totalPrice: $totalPrice)';
  }

  @override
  bool operator ==(covariant Orders other) {
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

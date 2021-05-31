import 'package:uuid/uuid.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:money2/money2.dart';

part 'transaction.freezed.dart';

@freezed
class Transaction with _$Transaction {
  factory Transaction(UuidValue id, String title, Money value) = _Transaction;
}

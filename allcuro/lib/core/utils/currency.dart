/// Mirrors `inr()` from `src/data/allcuro.ts`, which used
/// `n.toLocaleString("en-IN")` — Indian digit grouping (last 3 digits,
/// then pairs): 1234567 -> "12,34,567".
String inr(num amount) {
  final isNegative = amount < 0;
  final digits = amount.abs().round().toString();

  String grouped;
  if (digits.length <= 3) {
    grouped = digits;
  } else {
    final last3 = digits.substring(digits.length - 3);
    var rest = digits.substring(0, digits.length - 3);
    final parts = <String>[];
    while (rest.length > 2) {
      parts.insert(0, rest.substring(rest.length - 2));
      rest = rest.substring(0, rest.length - 2);
    }
    if (rest.isNotEmpty) parts.insert(0, rest);
    grouped = '${parts.join(',')},$last3';
  }

  return '${isNegative ? '-' : ''}₹$grouped';
}

class Product {
  final int productId;
  final String name;
  final double price;
  final double? oldPrice;
  final List<String> photoUrl;
  final int brandId;
  final double actifAreaX;
  final double actifAreaY;
  final bool isNew;
  final bool isAlmostSoldOut;
  final String? description;
  final String dimensions;
  final int connectedOS;
  final int reportRate;
  final int usbPortType;
  final String color;
  final int connectionType;
  final double resolution;

  const Product({
    required this.productId,
    required this.name,
    required this.price,
    this.photoUrl = const [],
    required this.brandId,
    required this.actifAreaX,
    required this.actifAreaY,
    this.oldPrice,
    this.isNew = false,
    this.isAlmostSoldOut = false,
    this.description,
    this.dimensions = '',
    this.connectedOS = 0,
    this.reportRate = 0,
    this.usbPortType = 0,
    this.color = '',
    this.connectionType = 0,
    this.resolution = 0.0,
  });

  static double _toDouble(dynamic v) {
    if (v == null) return 0.0;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0.0;
  }

  static int _toInt(dynamic v) {
    if (v == null) return 0;
    if (v is num) return v.toInt();
    return int.tryParse(v.toString()) ?? 0;
  }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productId: (json['productId'] as num?)?.toInt() ?? 0,
    name: (json['name'] as String?) ?? '',
    price: _toDouble(json['price']),
    photoUrl: _parsePhotoUrl(json['photoUrl']),
    brandId: (json['brandId'] as num?)?.toInt() ?? 0,
    actifAreaX: _toDouble(json['actifAreaX']),
    actifAreaY: _toDouble(json['actifAreaY']),
    oldPrice: _toDouble(json['oldPrice']),
    isNew: (json['isNew'] as bool?) ?? false,
    isAlmostSoldOut: (json['isAlmostSoldOut'] as bool?) ?? false,
    description: json['description'] as String?,
    dimensions: (json['dimentions'] as String?) ?? '', // Note: matches C# typo
    connectedOS: _toInt(json['connectedOS']),
    reportRate: _toInt(json['raportRate']), // Note: matches C# typo
    usbPortType: _toInt(json['usbPortType']),
    color: (json['color'] as String?) ?? '',
    connectionType: _toInt(json['connectionType']),
    resolution: _toDouble(json['resolution']),
  );

  static List<String> _parsePhotoUrl(dynamic photoUrlData) {
    if (photoUrlData == null) return [];

    if (photoUrlData is List) {
      // If it's already a list, convert each item to string
      return photoUrlData.map((e) => e.toString()).toList();
    } else if (photoUrlData is String) {
      // If it's a string (comma-separated), split it
      if (photoUrlData.isEmpty) return [];
      return photoUrlData.split(',').map((s) => s.trim()).toList();
    } else {
      // If it's something else, convert to string and treat as single item
      return [photoUrlData.toString()];
    }
  }

  // OS Helper Methods
  List<String> getSupportedOSList() {
    List<String> supportedOS = [];

    if ((connectedOS & 1) != 0) supportedOS.add("Windows");
    if ((connectedOS & 2) != 0) supportedOS.add("macOS");
    if ((connectedOS & 4) != 0) supportedOS.add("Linux");
    if ((connectedOS & 8) != 0) supportedOS.add("Android");
    if ((connectedOS & 16) != 0) supportedOS.add("iOS");

    return supportedOS;
  }

  bool supportsOS(int osFlag) {
    return (connectedOS & osFlag) != 0;
  }

  String getOSDisplayText() {
    List<String> osList = getSupportedOSList();
    if (osList.isEmpty) return "Not specified";
    if (osList.length == 1) return osList.first;
    if (osList.length == 2) return osList.join(" & ");
    return "${osList.take(osList.length - 1).join(", ")} & ${osList.last}";
  }

  // Connection Type Helper
  String getConnectionTypeText() {
    switch (connectionType) {
      case 1:
        return "Wired (USB)";
      case 2:
        return "Wireless";
      case 3:
        return "Wired & Wireless";
      default:
        return "Not specified";
    }
  }

  // USB Port Type Helper
  String getUSBPortTypeText() {
    switch (usbPortType) {
      case 1:
        return "USB-A";
      case 2:
        return "USB-C";
      case 3:
        return "Micro-USB";
      case 4:
        return "USB-A & USB-C";
      default:
        return "Not specified";
    }
  }

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'name': name,
    'price': price,
    'photoUrl': photoUrl,
    'brandId': brandId,
    'actifAreaX': actifAreaX,
    'actifAreaY': actifAreaY,
    'oldPrice': oldPrice,
    'isNew': isNew,
    'isAlmostSoldOut': isAlmostSoldOut,
    'description': description,
    'dimentions': dimensions, // Note: matches C# typo
    'connectedOS': connectedOS,
    'raportRate': reportRate, // Note: matches C# typo
    'usbPortType': usbPortType,
    'color': color,
    'connectionType': connectionType,
    'resolution': resolution,
  };
}

// OS Constants for easy reference
class OSFlags {
  static const int windows = 1;
  static const int macOS = 2;
  static const int linux = 4;
  static const int android = 8;
  static const int iOS = 16;
}

// Connection Type Constants
class ConnectionTypes {
  static const int wired = 1;
  static const int wireless = 2;
  static const int both = 3;
}

// USB Port Type Constants
class USBPortTypes {
  static const int usbA = 1;
  static const int usbC = 2;
  static const int microUSB = 3;
  static const int usbAAndC = 4;
}

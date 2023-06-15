import 'package:flutter/material.dart';

extension nav on BuildContext {
  pushAndRemove({required Widget view}) {
    Navigator.pushAndRemoveUntil(
        this, MaterialPageRoute(builder: (context) => view), (route) => false);
  }

  push({required Widget view}) {
    Navigator.push(
      this,
      MaterialPageRoute(builder: (context) => view),
    );
    pop({required Widget view}) {
      Navigator.pop(
        this,
        MaterialPageRoute(builder: (context) => view),
      );
    }
  }
}

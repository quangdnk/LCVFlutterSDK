enum WindownPositionSdk {
  all,
  driverSeat,
  passengerSeat,
  rearRightSeat,
  rearLeftSeat,
}

enum WindowStatusSdk { open, close }

enum DoorStatusSdk { lock, unlock }

enum SecuritySdk { on, off }

enum LightSdk { off, cancelOff }

extension LightSdkExtension on LightSdk {
  String title() {
    switch (this) {
      case LightSdk.off:
        return "Off";
      case LightSdk.cancelOff:
        return "CancelOff";
    }
  }
}

extension SecuritySdkExtension on SecuritySdk {
  String title() {
    switch (this) {
      case SecuritySdk.on:
        return "On";
      case SecuritySdk.off:
        return "Off";
    }
  }
}

extension DoorStatusSdkExtension on DoorStatusSdk {
  String title() {
    switch (this) {
      case DoorStatusSdk.lock:
        return "Lock";
      case DoorStatusSdk.unlock:
        return "UnLock";
    }
  }
}

extension WindownPositionSdkExtension on WindownPositionSdk {
  String title() {
    switch (this) {
      case WindownPositionSdk.all:
        return "All";
      case WindownPositionSdk.driverSeat:
        return "DriverSeat";
      case WindownPositionSdk.passengerSeat:
        return "PassengerSeat";
      case WindownPositionSdk.rearRightSeat:
        return "RearRightSeat";
      case WindownPositionSdk.rearLeftSeat:
        return "RearLeftSeat";
    }
  }
}

extension WindowStatusSdkExtension on WindowStatusSdk {
  String title() {
    switch (this) {
      case WindowStatusSdk.open:
        return "Open";
      case WindowStatusSdk.close:
        return "Close";
    }
  }
}

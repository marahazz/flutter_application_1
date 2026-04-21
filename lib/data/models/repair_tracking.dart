enum RepairStatus {
  pending,
  awaitingParts,
  inProgress,
  qualityCheck,
  readyForPickup,
  delivered,
}

class RepairTracking {
  final String id;
  final String car;
  final List<RepairStep> steps;
  final RepairStatus currentStatus;
  final DateTime createdAt;

  RepairTracking({
    required this.id,
    required this.car,
    required this.steps,
    required this.currentStatus,
    required this.createdAt,
  });
}

class RepairStep {
  final RepairStatus status;
  final String label;
  final String? note;
  final DateTime timestamp;

  RepairStep({
    required this.status,
    required this.label,
    this.note,
    required this.timestamp,
  });
}

# Data type for cron periodic values (hour, minute, month, monthday, weekday, or special)
type Types::Cron::Periodic = Variant[
  Array,
  Integer,
  String[1],
]

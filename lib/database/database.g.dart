// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Weekday extends DataClass implements Insertable<Weekday> {
  final int dayOfWeek;
  final String nameOfDay;
  final DateTime lastDateOccurred;
  final int rightAnswers;
  final int wrongAnswers;
  const Weekday(
      {required this.dayOfWeek,
      required this.nameOfDay,
      required this.lastDateOccurred,
      required this.rightAnswers,
      required this.wrongAnswers});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['day_of_week'] = Variable<int>(dayOfWeek);
    map['name_of_day'] = Variable<String>(nameOfDay);
    map['last_date_occurred'] = Variable<DateTime>(lastDateOccurred);
    map['right_answers'] = Variable<int>(rightAnswers);
    map['wrong_answers'] = Variable<int>(wrongAnswers);
    return map;
  }

  WeekdaysCompanion toCompanion(bool nullToAbsent) {
    return WeekdaysCompanion(
      dayOfWeek: Value(dayOfWeek),
      nameOfDay: Value(nameOfDay),
      lastDateOccurred: Value(lastDateOccurred),
      rightAnswers: Value(rightAnswers),
      wrongAnswers: Value(wrongAnswers),
    );
  }

  factory Weekday.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Weekday(
      dayOfWeek: serializer.fromJson<int>(json['day_of_week']),
      nameOfDay: serializer.fromJson<String>(json['name_of_day']),
      lastDateOccurred:
          serializer.fromJson<DateTime>(json['last_date_occurred']),
      rightAnswers: serializer.fromJson<int>(json['right_answers']),
      wrongAnswers: serializer.fromJson<int>(json['wrong_answers']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'day_of_week': serializer.toJson<int>(dayOfWeek),
      'name_of_day': serializer.toJson<String>(nameOfDay),
      'last_date_occurred': serializer.toJson<DateTime>(lastDateOccurred),
      'right_answers': serializer.toJson<int>(rightAnswers),
      'wrong_answers': serializer.toJson<int>(wrongAnswers),
    };
  }

  Weekday copyWith(
          {int? dayOfWeek,
          String? nameOfDay,
          DateTime? lastDateOccurred,
          int? rightAnswers,
          int? wrongAnswers}) =>
      Weekday(
        dayOfWeek: dayOfWeek ?? this.dayOfWeek,
        nameOfDay: nameOfDay ?? this.nameOfDay,
        lastDateOccurred: lastDateOccurred ?? this.lastDateOccurred,
        rightAnswers: rightAnswers ?? this.rightAnswers,
        wrongAnswers: wrongAnswers ?? this.wrongAnswers,
      );
  @override
  String toString() {
    return (StringBuffer('Weekday(')
          ..write('dayOfWeek: $dayOfWeek, ')
          ..write('nameOfDay: $nameOfDay, ')
          ..write('lastDateOccurred: $lastDateOccurred, ')
          ..write('rightAnswers: $rightAnswers, ')
          ..write('wrongAnswers: $wrongAnswers')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      dayOfWeek, nameOfDay, lastDateOccurred, rightAnswers, wrongAnswers);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Weekday &&
          other.dayOfWeek == this.dayOfWeek &&
          other.nameOfDay == this.nameOfDay &&
          other.lastDateOccurred == this.lastDateOccurred &&
          other.rightAnswers == this.rightAnswers &&
          other.wrongAnswers == this.wrongAnswers);
}

class WeekdaysCompanion extends UpdateCompanion<Weekday> {
  final Value<int> dayOfWeek;
  final Value<String> nameOfDay;
  final Value<DateTime> lastDateOccurred;
  final Value<int> rightAnswers;
  final Value<int> wrongAnswers;
  const WeekdaysCompanion({
    this.dayOfWeek = const Value.absent(),
    this.nameOfDay = const Value.absent(),
    this.lastDateOccurred = const Value.absent(),
    this.rightAnswers = const Value.absent(),
    this.wrongAnswers = const Value.absent(),
  });
  WeekdaysCompanion.insert({
    this.dayOfWeek = const Value.absent(),
    required String nameOfDay,
    required DateTime lastDateOccurred,
    this.rightAnswers = const Value.absent(),
    this.wrongAnswers = const Value.absent(),
  })  : nameOfDay = Value(nameOfDay),
        lastDateOccurred = Value(lastDateOccurred);
  static Insertable<Weekday> custom({
    Expression<int>? dayOfWeek,
    Expression<String>? nameOfDay,
    Expression<DateTime>? lastDateOccurred,
    Expression<int>? rightAnswers,
    Expression<int>? wrongAnswers,
  }) {
    return RawValuesInsertable({
      if (dayOfWeek != null) 'day_of_week': dayOfWeek,
      if (nameOfDay != null) 'name_of_day': nameOfDay,
      if (lastDateOccurred != null) 'last_date_occurred': lastDateOccurred,
      if (rightAnswers != null) 'right_answers': rightAnswers,
      if (wrongAnswers != null) 'wrong_answers': wrongAnswers,
    });
  }

  WeekdaysCompanion copyWith(
      {Value<int>? dayOfWeek,
      Value<String>? nameOfDay,
      Value<DateTime>? lastDateOccurred,
      Value<int>? rightAnswers,
      Value<int>? wrongAnswers}) {
    return WeekdaysCompanion(
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      nameOfDay: nameOfDay ?? this.nameOfDay,
      lastDateOccurred: lastDateOccurred ?? this.lastDateOccurred,
      rightAnswers: rightAnswers ?? this.rightAnswers,
      wrongAnswers: wrongAnswers ?? this.wrongAnswers,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (dayOfWeek.present) {
      map['day_of_week'] = Variable<int>(dayOfWeek.value);
    }
    if (nameOfDay.present) {
      map['name_of_day'] = Variable<String>(nameOfDay.value);
    }
    if (lastDateOccurred.present) {
      map['last_date_occurred'] = Variable<DateTime>(lastDateOccurred.value);
    }
    if (rightAnswers.present) {
      map['right_answers'] = Variable<int>(rightAnswers.value);
    }
    if (wrongAnswers.present) {
      map['wrong_answers'] = Variable<int>(wrongAnswers.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeekdaysCompanion(')
          ..write('dayOfWeek: $dayOfWeek, ')
          ..write('nameOfDay: $nameOfDay, ')
          ..write('lastDateOccurred: $lastDateOccurred, ')
          ..write('rightAnswers: $rightAnswers, ')
          ..write('wrongAnswers: $wrongAnswers')
          ..write(')'))
        .toString();
  }
}

class Weekdays extends Table with TableInfo<Weekdays, Weekday> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Weekdays(this.attachedDatabase, [this._alias]);
  final VerificationMeta _dayOfWeekMeta = const VerificationMeta('dayOfWeek');
  late final GeneratedColumn<int> dayOfWeek = GeneratedColumn<int>(
      'day_of_week', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameOfDayMeta = const VerificationMeta('nameOfDay');
  late final GeneratedColumn<String> nameOfDay = GeneratedColumn<String>(
      'name_of_day', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _lastDateOccurredMeta =
      const VerificationMeta('lastDateOccurred');
  late final GeneratedColumn<DateTime> lastDateOccurred =
      GeneratedColumn<DateTime>('last_date_occurred', aliasedName, false,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: true,
          $customConstraints: 'NOT NULL');
  final VerificationMeta _rightAnswersMeta =
      const VerificationMeta('rightAnswers');
  late final GeneratedColumn<int> rightAnswers = GeneratedColumn<int>(
      'right_answers', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT 0',
      defaultValue: const CustomExpression<int>('0'));
  final VerificationMeta _wrongAnswersMeta =
      const VerificationMeta('wrongAnswers');
  late final GeneratedColumn<int> wrongAnswers = GeneratedColumn<int>(
      'wrong_answers', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT 0',
      defaultValue: const CustomExpression<int>('0'));
  @override
  List<GeneratedColumn> get $columns =>
      [dayOfWeek, nameOfDay, lastDateOccurred, rightAnswers, wrongAnswers];
  @override
  String get aliasedName => _alias ?? 'weekdays';
  @override
  String get actualTableName => 'weekdays';
  @override
  VerificationContext validateIntegrity(Insertable<Weekday> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('day_of_week')) {
      context.handle(
          _dayOfWeekMeta,
          dayOfWeek.isAcceptableOrUnknown(
              data['day_of_week']!, _dayOfWeekMeta));
    }
    if (data.containsKey('name_of_day')) {
      context.handle(
          _nameOfDayMeta,
          nameOfDay.isAcceptableOrUnknown(
              data['name_of_day']!, _nameOfDayMeta));
    } else if (isInserting) {
      context.missing(_nameOfDayMeta);
    }
    if (data.containsKey('last_date_occurred')) {
      context.handle(
          _lastDateOccurredMeta,
          lastDateOccurred.isAcceptableOrUnknown(
              data['last_date_occurred']!, _lastDateOccurredMeta));
    } else if (isInserting) {
      context.missing(_lastDateOccurredMeta);
    }
    if (data.containsKey('right_answers')) {
      context.handle(
          _rightAnswersMeta,
          rightAnswers.isAcceptableOrUnknown(
              data['right_answers']!, _rightAnswersMeta));
    }
    if (data.containsKey('wrong_answers')) {
      context.handle(
          _wrongAnswersMeta,
          wrongAnswers.isAcceptableOrUnknown(
              data['wrong_answers']!, _wrongAnswersMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {dayOfWeek};
  @override
  Weekday map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Weekday(
      dayOfWeek: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}day_of_week'])!,
      nameOfDay: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}name_of_day'])!,
      lastDateOccurred: attachedDatabase.options.types.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_date_occurred'])!,
      rightAnswers: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}right_answers'])!,
      wrongAnswers: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}wrong_answers'])!,
    );
  }

  @override
  Weekdays createAlias(String alias) {
    return Weekdays(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class WeekdaysLogData extends DataClass implements Insertable<WeekdaysLogData> {
  final int logId;
  final String actionName;
  final DateTime actionTimestamp;
  final int affectedId;
  final String? nameOfDayNew;
  final DateTime? lastDateOccurredNew;
  final int? rightAnswersNew;
  final int? wrongAnswersNew;
  final String? nameOfDayOld;
  final DateTime? lastDateOccurredOld;
  final int? rightAnswersOld;
  final int? wrongAnswersOld;
  const WeekdaysLogData(
      {required this.logId,
      required this.actionName,
      required this.actionTimestamp,
      required this.affectedId,
      this.nameOfDayNew,
      this.lastDateOccurredNew,
      this.rightAnswersNew,
      this.wrongAnswersNew,
      this.nameOfDayOld,
      this.lastDateOccurredOld,
      this.rightAnswersOld,
      this.wrongAnswersOld});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['log_id'] = Variable<int>(logId);
    map['action_name'] = Variable<String>(actionName);
    map['action_timestamp'] = Variable<DateTime>(actionTimestamp);
    map['affected_id'] = Variable<int>(affectedId);
    if (!nullToAbsent || nameOfDayNew != null) {
      map['name_of_day_new'] = Variable<String>(nameOfDayNew);
    }
    if (!nullToAbsent || lastDateOccurredNew != null) {
      map['last_date_occurred_new'] = Variable<DateTime>(lastDateOccurredNew);
    }
    if (!nullToAbsent || rightAnswersNew != null) {
      map['right_answers_new'] = Variable<int>(rightAnswersNew);
    }
    if (!nullToAbsent || wrongAnswersNew != null) {
      map['wrong_answers_new'] = Variable<int>(wrongAnswersNew);
    }
    if (!nullToAbsent || nameOfDayOld != null) {
      map['name_of_day_old'] = Variable<String>(nameOfDayOld);
    }
    if (!nullToAbsent || lastDateOccurredOld != null) {
      map['last_date_occurred_old'] = Variable<DateTime>(lastDateOccurredOld);
    }
    if (!nullToAbsent || rightAnswersOld != null) {
      map['right_answers_old'] = Variable<int>(rightAnswersOld);
    }
    if (!nullToAbsent || wrongAnswersOld != null) {
      map['wrong_answers_old'] = Variable<int>(wrongAnswersOld);
    }
    return map;
  }

  WeekdaysLogCompanion toCompanion(bool nullToAbsent) {
    return WeekdaysLogCompanion(
      logId: Value(logId),
      actionName: Value(actionName),
      actionTimestamp: Value(actionTimestamp),
      affectedId: Value(affectedId),
      nameOfDayNew: nameOfDayNew == null && nullToAbsent
          ? const Value.absent()
          : Value(nameOfDayNew),
      lastDateOccurredNew: lastDateOccurredNew == null && nullToAbsent
          ? const Value.absent()
          : Value(lastDateOccurredNew),
      rightAnswersNew: rightAnswersNew == null && nullToAbsent
          ? const Value.absent()
          : Value(rightAnswersNew),
      wrongAnswersNew: wrongAnswersNew == null && nullToAbsent
          ? const Value.absent()
          : Value(wrongAnswersNew),
      nameOfDayOld: nameOfDayOld == null && nullToAbsent
          ? const Value.absent()
          : Value(nameOfDayOld),
      lastDateOccurredOld: lastDateOccurredOld == null && nullToAbsent
          ? const Value.absent()
          : Value(lastDateOccurredOld),
      rightAnswersOld: rightAnswersOld == null && nullToAbsent
          ? const Value.absent()
          : Value(rightAnswersOld),
      wrongAnswersOld: wrongAnswersOld == null && nullToAbsent
          ? const Value.absent()
          : Value(wrongAnswersOld),
    );
  }

  factory WeekdaysLogData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeekdaysLogData(
      logId: serializer.fromJson<int>(json['log_id']),
      actionName: serializer.fromJson<String>(json['action_name']),
      actionTimestamp: serializer.fromJson<DateTime>(json['action_timestamp']),
      affectedId: serializer.fromJson<int>(json['affected_id']),
      nameOfDayNew: serializer.fromJson<String?>(json['name_of_day_new']),
      lastDateOccurredNew:
          serializer.fromJson<DateTime?>(json['last_date_occurred_new']),
      rightAnswersNew: serializer.fromJson<int?>(json['right_answers_new']),
      wrongAnswersNew: serializer.fromJson<int?>(json['wrong_answers_new']),
      nameOfDayOld: serializer.fromJson<String?>(json['name_of_day_old']),
      lastDateOccurredOld:
          serializer.fromJson<DateTime?>(json['last_date_occurred_old']),
      rightAnswersOld: serializer.fromJson<int?>(json['right_answers_old']),
      wrongAnswersOld: serializer.fromJson<int?>(json['wrong_answers_old']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'log_id': serializer.toJson<int>(logId),
      'action_name': serializer.toJson<String>(actionName),
      'action_timestamp': serializer.toJson<DateTime>(actionTimestamp),
      'affected_id': serializer.toJson<int>(affectedId),
      'name_of_day_new': serializer.toJson<String?>(nameOfDayNew),
      'last_date_occurred_new':
          serializer.toJson<DateTime?>(lastDateOccurredNew),
      'right_answers_new': serializer.toJson<int?>(rightAnswersNew),
      'wrong_answers_new': serializer.toJson<int?>(wrongAnswersNew),
      'name_of_day_old': serializer.toJson<String?>(nameOfDayOld),
      'last_date_occurred_old':
          serializer.toJson<DateTime?>(lastDateOccurredOld),
      'right_answers_old': serializer.toJson<int?>(rightAnswersOld),
      'wrong_answers_old': serializer.toJson<int?>(wrongAnswersOld),
    };
  }

  WeekdaysLogData copyWith(
          {int? logId,
          String? actionName,
          DateTime? actionTimestamp,
          int? affectedId,
          Value<String?> nameOfDayNew = const Value.absent(),
          Value<DateTime?> lastDateOccurredNew = const Value.absent(),
          Value<int?> rightAnswersNew = const Value.absent(),
          Value<int?> wrongAnswersNew = const Value.absent(),
          Value<String?> nameOfDayOld = const Value.absent(),
          Value<DateTime?> lastDateOccurredOld = const Value.absent(),
          Value<int?> rightAnswersOld = const Value.absent(),
          Value<int?> wrongAnswersOld = const Value.absent()}) =>
      WeekdaysLogData(
        logId: logId ?? this.logId,
        actionName: actionName ?? this.actionName,
        actionTimestamp: actionTimestamp ?? this.actionTimestamp,
        affectedId: affectedId ?? this.affectedId,
        nameOfDayNew:
            nameOfDayNew.present ? nameOfDayNew.value : this.nameOfDayNew,
        lastDateOccurredNew: lastDateOccurredNew.present
            ? lastDateOccurredNew.value
            : this.lastDateOccurredNew,
        rightAnswersNew: rightAnswersNew.present
            ? rightAnswersNew.value
            : this.rightAnswersNew,
        wrongAnswersNew: wrongAnswersNew.present
            ? wrongAnswersNew.value
            : this.wrongAnswersNew,
        nameOfDayOld:
            nameOfDayOld.present ? nameOfDayOld.value : this.nameOfDayOld,
        lastDateOccurredOld: lastDateOccurredOld.present
            ? lastDateOccurredOld.value
            : this.lastDateOccurredOld,
        rightAnswersOld: rightAnswersOld.present
            ? rightAnswersOld.value
            : this.rightAnswersOld,
        wrongAnswersOld: wrongAnswersOld.present
            ? wrongAnswersOld.value
            : this.wrongAnswersOld,
      );
  @override
  String toString() {
    return (StringBuffer('WeekdaysLogData(')
          ..write('logId: $logId, ')
          ..write('actionName: $actionName, ')
          ..write('actionTimestamp: $actionTimestamp, ')
          ..write('affectedId: $affectedId, ')
          ..write('nameOfDayNew: $nameOfDayNew, ')
          ..write('lastDateOccurredNew: $lastDateOccurredNew, ')
          ..write('rightAnswersNew: $rightAnswersNew, ')
          ..write('wrongAnswersNew: $wrongAnswersNew, ')
          ..write('nameOfDayOld: $nameOfDayOld, ')
          ..write('lastDateOccurredOld: $lastDateOccurredOld, ')
          ..write('rightAnswersOld: $rightAnswersOld, ')
          ..write('wrongAnswersOld: $wrongAnswersOld')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      logId,
      actionName,
      actionTimestamp,
      affectedId,
      nameOfDayNew,
      lastDateOccurredNew,
      rightAnswersNew,
      wrongAnswersNew,
      nameOfDayOld,
      lastDateOccurredOld,
      rightAnswersOld,
      wrongAnswersOld);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeekdaysLogData &&
          other.logId == this.logId &&
          other.actionName == this.actionName &&
          other.actionTimestamp == this.actionTimestamp &&
          other.affectedId == this.affectedId &&
          other.nameOfDayNew == this.nameOfDayNew &&
          other.lastDateOccurredNew == this.lastDateOccurredNew &&
          other.rightAnswersNew == this.rightAnswersNew &&
          other.wrongAnswersNew == this.wrongAnswersNew &&
          other.nameOfDayOld == this.nameOfDayOld &&
          other.lastDateOccurredOld == this.lastDateOccurredOld &&
          other.rightAnswersOld == this.rightAnswersOld &&
          other.wrongAnswersOld == this.wrongAnswersOld);
}

class WeekdaysLogCompanion extends UpdateCompanion<WeekdaysLogData> {
  final Value<int> logId;
  final Value<String> actionName;
  final Value<DateTime> actionTimestamp;
  final Value<int> affectedId;
  final Value<String?> nameOfDayNew;
  final Value<DateTime?> lastDateOccurredNew;
  final Value<int?> rightAnswersNew;
  final Value<int?> wrongAnswersNew;
  final Value<String?> nameOfDayOld;
  final Value<DateTime?> lastDateOccurredOld;
  final Value<int?> rightAnswersOld;
  final Value<int?> wrongAnswersOld;
  const WeekdaysLogCompanion({
    this.logId = const Value.absent(),
    this.actionName = const Value.absent(),
    this.actionTimestamp = const Value.absent(),
    this.affectedId = const Value.absent(),
    this.nameOfDayNew = const Value.absent(),
    this.lastDateOccurredNew = const Value.absent(),
    this.rightAnswersNew = const Value.absent(),
    this.wrongAnswersNew = const Value.absent(),
    this.nameOfDayOld = const Value.absent(),
    this.lastDateOccurredOld = const Value.absent(),
    this.rightAnswersOld = const Value.absent(),
    this.wrongAnswersOld = const Value.absent(),
  });
  WeekdaysLogCompanion.insert({
    this.logId = const Value.absent(),
    required String actionName,
    this.actionTimestamp = const Value.absent(),
    required int affectedId,
    this.nameOfDayNew = const Value.absent(),
    this.lastDateOccurredNew = const Value.absent(),
    this.rightAnswersNew = const Value.absent(),
    this.wrongAnswersNew = const Value.absent(),
    this.nameOfDayOld = const Value.absent(),
    this.lastDateOccurredOld = const Value.absent(),
    this.rightAnswersOld = const Value.absent(),
    this.wrongAnswersOld = const Value.absent(),
  })  : actionName = Value(actionName),
        affectedId = Value(affectedId);
  static Insertable<WeekdaysLogData> custom({
    Expression<int>? logId,
    Expression<String>? actionName,
    Expression<DateTime>? actionTimestamp,
    Expression<int>? affectedId,
    Expression<String>? nameOfDayNew,
    Expression<DateTime>? lastDateOccurredNew,
    Expression<int>? rightAnswersNew,
    Expression<int>? wrongAnswersNew,
    Expression<String>? nameOfDayOld,
    Expression<DateTime>? lastDateOccurredOld,
    Expression<int>? rightAnswersOld,
    Expression<int>? wrongAnswersOld,
  }) {
    return RawValuesInsertable({
      if (logId != null) 'log_id': logId,
      if (actionName != null) 'action_name': actionName,
      if (actionTimestamp != null) 'action_timestamp': actionTimestamp,
      if (affectedId != null) 'affected_id': affectedId,
      if (nameOfDayNew != null) 'name_of_day_new': nameOfDayNew,
      if (lastDateOccurredNew != null)
        'last_date_occurred_new': lastDateOccurredNew,
      if (rightAnswersNew != null) 'right_answers_new': rightAnswersNew,
      if (wrongAnswersNew != null) 'wrong_answers_new': wrongAnswersNew,
      if (nameOfDayOld != null) 'name_of_day_old': nameOfDayOld,
      if (lastDateOccurredOld != null)
        'last_date_occurred_old': lastDateOccurredOld,
      if (rightAnswersOld != null) 'right_answers_old': rightAnswersOld,
      if (wrongAnswersOld != null) 'wrong_answers_old': wrongAnswersOld,
    });
  }

  WeekdaysLogCompanion copyWith(
      {Value<int>? logId,
      Value<String>? actionName,
      Value<DateTime>? actionTimestamp,
      Value<int>? affectedId,
      Value<String?>? nameOfDayNew,
      Value<DateTime?>? lastDateOccurredNew,
      Value<int?>? rightAnswersNew,
      Value<int?>? wrongAnswersNew,
      Value<String?>? nameOfDayOld,
      Value<DateTime?>? lastDateOccurredOld,
      Value<int?>? rightAnswersOld,
      Value<int?>? wrongAnswersOld}) {
    return WeekdaysLogCompanion(
      logId: logId ?? this.logId,
      actionName: actionName ?? this.actionName,
      actionTimestamp: actionTimestamp ?? this.actionTimestamp,
      affectedId: affectedId ?? this.affectedId,
      nameOfDayNew: nameOfDayNew ?? this.nameOfDayNew,
      lastDateOccurredNew: lastDateOccurredNew ?? this.lastDateOccurredNew,
      rightAnswersNew: rightAnswersNew ?? this.rightAnswersNew,
      wrongAnswersNew: wrongAnswersNew ?? this.wrongAnswersNew,
      nameOfDayOld: nameOfDayOld ?? this.nameOfDayOld,
      lastDateOccurredOld: lastDateOccurredOld ?? this.lastDateOccurredOld,
      rightAnswersOld: rightAnswersOld ?? this.rightAnswersOld,
      wrongAnswersOld: wrongAnswersOld ?? this.wrongAnswersOld,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (logId.present) {
      map['log_id'] = Variable<int>(logId.value);
    }
    if (actionName.present) {
      map['action_name'] = Variable<String>(actionName.value);
    }
    if (actionTimestamp.present) {
      map['action_timestamp'] = Variable<DateTime>(actionTimestamp.value);
    }
    if (affectedId.present) {
      map['affected_id'] = Variable<int>(affectedId.value);
    }
    if (nameOfDayNew.present) {
      map['name_of_day_new'] = Variable<String>(nameOfDayNew.value);
    }
    if (lastDateOccurredNew.present) {
      map['last_date_occurred_new'] =
          Variable<DateTime>(lastDateOccurredNew.value);
    }
    if (rightAnswersNew.present) {
      map['right_answers_new'] = Variable<int>(rightAnswersNew.value);
    }
    if (wrongAnswersNew.present) {
      map['wrong_answers_new'] = Variable<int>(wrongAnswersNew.value);
    }
    if (nameOfDayOld.present) {
      map['name_of_day_old'] = Variable<String>(nameOfDayOld.value);
    }
    if (lastDateOccurredOld.present) {
      map['last_date_occurred_old'] =
          Variable<DateTime>(lastDateOccurredOld.value);
    }
    if (rightAnswersOld.present) {
      map['right_answers_old'] = Variable<int>(rightAnswersOld.value);
    }
    if (wrongAnswersOld.present) {
      map['wrong_answers_old'] = Variable<int>(wrongAnswersOld.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeekdaysLogCompanion(')
          ..write('logId: $logId, ')
          ..write('actionName: $actionName, ')
          ..write('actionTimestamp: $actionTimestamp, ')
          ..write('affectedId: $affectedId, ')
          ..write('nameOfDayNew: $nameOfDayNew, ')
          ..write('lastDateOccurredNew: $lastDateOccurredNew, ')
          ..write('rightAnswersNew: $rightAnswersNew, ')
          ..write('wrongAnswersNew: $wrongAnswersNew, ')
          ..write('nameOfDayOld: $nameOfDayOld, ')
          ..write('lastDateOccurredOld: $lastDateOccurredOld, ')
          ..write('rightAnswersOld: $rightAnswersOld, ')
          ..write('wrongAnswersOld: $wrongAnswersOld')
          ..write(')'))
        .toString();
  }
}

class WeekdaysLog extends Table with TableInfo<WeekdaysLog, WeekdaysLogData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  WeekdaysLog(this.attachedDatabase, [this._alias]);
  final VerificationMeta _logIdMeta = const VerificationMeta('logId');
  late final GeneratedColumn<int> logId = GeneratedColumn<int>(
      'log_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _actionNameMeta = const VerificationMeta('actionName');
  late final GeneratedColumn<String> actionName = GeneratedColumn<String>(
      'action_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _actionTimestampMeta =
      const VerificationMeta('actionTimestamp');
  late final GeneratedColumn<DateTime> actionTimestamp =
      GeneratedColumn<DateTime>('action_timestamp', aliasedName, false,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          $customConstraints: 'NOT NULL DEFAULT CURRENT_TIMESTAMP',
          defaultValue: const CustomExpression<DateTime>('CURRENT_TIMESTAMP'));
  final VerificationMeta _affectedIdMeta = const VerificationMeta('affectedId');
  late final GeneratedColumn<int> affectedId = GeneratedColumn<int>(
      'affected_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _nameOfDayNewMeta =
      const VerificationMeta('nameOfDayNew');
  late final GeneratedColumn<String> nameOfDayNew = GeneratedColumn<String>(
      'name_of_day_new', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _lastDateOccurredNewMeta =
      const VerificationMeta('lastDateOccurredNew');
  late final GeneratedColumn<DateTime> lastDateOccurredNew =
      GeneratedColumn<DateTime>('last_date_occurred_new', aliasedName, true,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          $customConstraints: '');
  final VerificationMeta _rightAnswersNewMeta =
      const VerificationMeta('rightAnswersNew');
  late final GeneratedColumn<int> rightAnswersNew = GeneratedColumn<int>(
      'right_answers_new', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _wrongAnswersNewMeta =
      const VerificationMeta('wrongAnswersNew');
  late final GeneratedColumn<int> wrongAnswersNew = GeneratedColumn<int>(
      'wrong_answers_new', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _nameOfDayOldMeta =
      const VerificationMeta('nameOfDayOld');
  late final GeneratedColumn<String> nameOfDayOld = GeneratedColumn<String>(
      'name_of_day_old', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _lastDateOccurredOldMeta =
      const VerificationMeta('lastDateOccurredOld');
  late final GeneratedColumn<DateTime> lastDateOccurredOld =
      GeneratedColumn<DateTime>('last_date_occurred_old', aliasedName, true,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          $customConstraints: '');
  final VerificationMeta _rightAnswersOldMeta =
      const VerificationMeta('rightAnswersOld');
  late final GeneratedColumn<int> rightAnswersOld = GeneratedColumn<int>(
      'right_answers_old', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _wrongAnswersOldMeta =
      const VerificationMeta('wrongAnswersOld');
  late final GeneratedColumn<int> wrongAnswersOld = GeneratedColumn<int>(
      'wrong_answers_old', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [
        logId,
        actionName,
        actionTimestamp,
        affectedId,
        nameOfDayNew,
        lastDateOccurredNew,
        rightAnswersNew,
        wrongAnswersNew,
        nameOfDayOld,
        lastDateOccurredOld,
        rightAnswersOld,
        wrongAnswersOld
      ];
  @override
  String get aliasedName => _alias ?? 'weekdays_log';
  @override
  String get actualTableName => 'weekdays_log';
  @override
  VerificationContext validateIntegrity(Insertable<WeekdaysLogData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('log_id')) {
      context.handle(
          _logIdMeta, logId.isAcceptableOrUnknown(data['log_id']!, _logIdMeta));
    }
    if (data.containsKey('action_name')) {
      context.handle(
          _actionNameMeta,
          actionName.isAcceptableOrUnknown(
              data['action_name']!, _actionNameMeta));
    } else if (isInserting) {
      context.missing(_actionNameMeta);
    }
    if (data.containsKey('action_timestamp')) {
      context.handle(
          _actionTimestampMeta,
          actionTimestamp.isAcceptableOrUnknown(
              data['action_timestamp']!, _actionTimestampMeta));
    }
    if (data.containsKey('affected_id')) {
      context.handle(
          _affectedIdMeta,
          affectedId.isAcceptableOrUnknown(
              data['affected_id']!, _affectedIdMeta));
    } else if (isInserting) {
      context.missing(_affectedIdMeta);
    }
    if (data.containsKey('name_of_day_new')) {
      context.handle(
          _nameOfDayNewMeta,
          nameOfDayNew.isAcceptableOrUnknown(
              data['name_of_day_new']!, _nameOfDayNewMeta));
    }
    if (data.containsKey('last_date_occurred_new')) {
      context.handle(
          _lastDateOccurredNewMeta,
          lastDateOccurredNew.isAcceptableOrUnknown(
              data['last_date_occurred_new']!, _lastDateOccurredNewMeta));
    }
    if (data.containsKey('right_answers_new')) {
      context.handle(
          _rightAnswersNewMeta,
          rightAnswersNew.isAcceptableOrUnknown(
              data['right_answers_new']!, _rightAnswersNewMeta));
    }
    if (data.containsKey('wrong_answers_new')) {
      context.handle(
          _wrongAnswersNewMeta,
          wrongAnswersNew.isAcceptableOrUnknown(
              data['wrong_answers_new']!, _wrongAnswersNewMeta));
    }
    if (data.containsKey('name_of_day_old')) {
      context.handle(
          _nameOfDayOldMeta,
          nameOfDayOld.isAcceptableOrUnknown(
              data['name_of_day_old']!, _nameOfDayOldMeta));
    }
    if (data.containsKey('last_date_occurred_old')) {
      context.handle(
          _lastDateOccurredOldMeta,
          lastDateOccurredOld.isAcceptableOrUnknown(
              data['last_date_occurred_old']!, _lastDateOccurredOldMeta));
    }
    if (data.containsKey('right_answers_old')) {
      context.handle(
          _rightAnswersOldMeta,
          rightAnswersOld.isAcceptableOrUnknown(
              data['right_answers_old']!, _rightAnswersOldMeta));
    }
    if (data.containsKey('wrong_answers_old')) {
      context.handle(
          _wrongAnswersOldMeta,
          wrongAnswersOld.isAcceptableOrUnknown(
              data['wrong_answers_old']!, _wrongAnswersOldMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {logId};
  @override
  WeekdaysLogData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeekdaysLogData(
      logId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}log_id'])!,
      actionName: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}action_name'])!,
      actionTimestamp: attachedDatabase.options.types.read(
          DriftSqlType.dateTime, data['${effectivePrefix}action_timestamp'])!,
      affectedId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}affected_id'])!,
      nameOfDayNew: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}name_of_day_new']),
      lastDateOccurredNew: attachedDatabase.options.types.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}last_date_occurred_new']),
      rightAnswersNew: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}right_answers_new']),
      wrongAnswersNew: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}wrong_answers_new']),
      nameOfDayOld: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}name_of_day_old']),
      lastDateOccurredOld: attachedDatabase.options.types.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}last_date_occurred_old']),
      rightAnswersOld: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}right_answers_old']),
      wrongAnswersOld: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}wrong_answers_old']),
    );
  }

  @override
  WeekdaysLog createAlias(String alias) {
    return WeekdaysLog(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Category extends DataClass implements Insertable<Category> {
  final int id;
  final String categoryName;
  final String categoryLanguage;
  final DateTime dateCreated;
  final bool isFavourite;
  const Category(
      {required this.id,
      required this.categoryName,
      required this.categoryLanguage,
      required this.dateCreated,
      required this.isFavourite});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category_name'] = Variable<String>(categoryName);
    map['category_language'] = Variable<String>(categoryLanguage);
    map['date_created'] = Variable<DateTime>(dateCreated);
    map['is_favourite'] = Variable<bool>(isFavourite);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      categoryName: Value(categoryName),
      categoryLanguage: Value(categoryLanguage),
      dateCreated: Value(dateCreated),
      isFavourite: Value(isFavourite),
    );
  }

  factory Category.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<int>(json['id']),
      categoryName: serializer.fromJson<String>(json['category_name']),
      categoryLanguage: serializer.fromJson<String>(json['category_language']),
      dateCreated: serializer.fromJson<DateTime>(json['date_created']),
      isFavourite: serializer.fromJson<bool>(json['is_favourite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'category_name': serializer.toJson<String>(categoryName),
      'category_language': serializer.toJson<String>(categoryLanguage),
      'date_created': serializer.toJson<DateTime>(dateCreated),
      'is_favourite': serializer.toJson<bool>(isFavourite),
    };
  }

  Category copyWith(
          {int? id,
          String? categoryName,
          String? categoryLanguage,
          DateTime? dateCreated,
          bool? isFavourite}) =>
      Category(
        id: id ?? this.id,
        categoryName: categoryName ?? this.categoryName,
        categoryLanguage: categoryLanguage ?? this.categoryLanguage,
        dateCreated: dateCreated ?? this.dateCreated,
        isFavourite: isFavourite ?? this.isFavourite,
      );
  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('categoryName: $categoryName, ')
          ..write('categoryLanguage: $categoryLanguage, ')
          ..write('dateCreated: $dateCreated, ')
          ..write('isFavourite: $isFavourite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, categoryName, categoryLanguage, dateCreated, isFavourite);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.categoryName == this.categoryName &&
          other.categoryLanguage == this.categoryLanguage &&
          other.dateCreated == this.dateCreated &&
          other.isFavourite == this.isFavourite);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> id;
  final Value<String> categoryName;
  final Value<String> categoryLanguage;
  final Value<DateTime> dateCreated;
  final Value<bool> isFavourite;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.categoryName = const Value.absent(),
    this.categoryLanguage = const Value.absent(),
    this.dateCreated = const Value.absent(),
    this.isFavourite = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String categoryName,
    required String categoryLanguage,
    this.dateCreated = const Value.absent(),
    this.isFavourite = const Value.absent(),
  })  : categoryName = Value(categoryName),
        categoryLanguage = Value(categoryLanguage);
  static Insertable<Category> custom({
    Expression<int>? id,
    Expression<String>? categoryName,
    Expression<String>? categoryLanguage,
    Expression<DateTime>? dateCreated,
    Expression<bool>? isFavourite,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryName != null) 'category_name': categoryName,
      if (categoryLanguage != null) 'category_language': categoryLanguage,
      if (dateCreated != null) 'date_created': dateCreated,
      if (isFavourite != null) 'is_favourite': isFavourite,
    });
  }

  CategoriesCompanion copyWith(
      {Value<int>? id,
      Value<String>? categoryName,
      Value<String>? categoryLanguage,
      Value<DateTime>? dateCreated,
      Value<bool>? isFavourite}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      categoryName: categoryName ?? this.categoryName,
      categoryLanguage: categoryLanguage ?? this.categoryLanguage,
      dateCreated: dateCreated ?? this.dateCreated,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryName.present) {
      map['category_name'] = Variable<String>(categoryName.value);
    }
    if (categoryLanguage.present) {
      map['category_language'] = Variable<String>(categoryLanguage.value);
    }
    if (dateCreated.present) {
      map['date_created'] = Variable<DateTime>(dateCreated.value);
    }
    if (isFavourite.present) {
      map['is_favourite'] = Variable<bool>(isFavourite.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('categoryName: $categoryName, ')
          ..write('categoryLanguage: $categoryLanguage, ')
          ..write('dateCreated: $dateCreated, ')
          ..write('isFavourite: $isFavourite')
          ..write(')'))
        .toString();
  }
}

class Categories extends Table with TableInfo<Categories, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Categories(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _categoryNameMeta =
      const VerificationMeta('categoryName');
  late final GeneratedColumn<String> categoryName = GeneratedColumn<String>(
      'category_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _categoryLanguageMeta =
      const VerificationMeta('categoryLanguage');
  late final GeneratedColumn<String> categoryLanguage = GeneratedColumn<String>(
      'category_language', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _dateCreatedMeta =
      const VerificationMeta('dateCreated');
  late final GeneratedColumn<DateTime> dateCreated = GeneratedColumn<DateTime>(
      'date_created', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT CURRENT_TIMESTAMP',
      defaultValue: const CustomExpression<DateTime>('CURRENT_TIMESTAMP'));
  final VerificationMeta _isFavouriteMeta =
      const VerificationMeta('isFavourite');
  late final GeneratedColumn<bool> isFavourite = GeneratedColumn<bool>(
      'is_favourite', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT FALSE',
      defaultValue: const CustomExpression<bool>('FALSE'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, categoryName, categoryLanguage, dateCreated, isFavourite];
  @override
  String get aliasedName => _alias ?? 'categories';
  @override
  String get actualTableName => 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<Category> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_name')) {
      context.handle(
          _categoryNameMeta,
          categoryName.isAcceptableOrUnknown(
              data['category_name']!, _categoryNameMeta));
    } else if (isInserting) {
      context.missing(_categoryNameMeta);
    }
    if (data.containsKey('category_language')) {
      context.handle(
          _categoryLanguageMeta,
          categoryLanguage.isAcceptableOrUnknown(
              data['category_language']!, _categoryLanguageMeta));
    } else if (isInserting) {
      context.missing(_categoryLanguageMeta);
    }
    if (data.containsKey('date_created')) {
      context.handle(
          _dateCreatedMeta,
          dateCreated.isAcceptableOrUnknown(
              data['date_created']!, _dateCreatedMeta));
    }
    if (data.containsKey('is_favourite')) {
      context.handle(
          _isFavouriteMeta,
          isFavourite.isAcceptableOrUnknown(
              data['is_favourite']!, _isFavouriteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      categoryName: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}category_name'])!,
      categoryLanguage: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}category_language'])!,
      dateCreated: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date_created'])!,
      isFavourite: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favourite'])!,
    );
  }

  @override
  Categories createAlias(String alias) {
    return Categories(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Vocabulary extends DataClass implements Insertable<Vocabulary> {
  final int id;
  final String vocLocal;
  final String vocForeign;
  final int categoryId;
  final DateTime dateCreated;
  final bool isFavourite;
  final DateTime? dateLastAnswered;
  final int rightAnswers;
  final int wrongAnswers;
  const Vocabulary(
      {required this.id,
      required this.vocLocal,
      required this.vocForeign,
      required this.categoryId,
      required this.dateCreated,
      required this.isFavourite,
      this.dateLastAnswered,
      required this.rightAnswers,
      required this.wrongAnswers});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['voc_local'] = Variable<String>(vocLocal);
    map['voc_foreign'] = Variable<String>(vocForeign);
    map['category_id'] = Variable<int>(categoryId);
    map['date_created'] = Variable<DateTime>(dateCreated);
    map['is_favourite'] = Variable<bool>(isFavourite);
    if (!nullToAbsent || dateLastAnswered != null) {
      map['date_last_answered'] = Variable<DateTime>(dateLastAnswered);
    }
    map['right_answers'] = Variable<int>(rightAnswers);
    map['wrong_answers'] = Variable<int>(wrongAnswers);
    return map;
  }

  VocabulariesCompanion toCompanion(bool nullToAbsent) {
    return VocabulariesCompanion(
      id: Value(id),
      vocLocal: Value(vocLocal),
      vocForeign: Value(vocForeign),
      categoryId: Value(categoryId),
      dateCreated: Value(dateCreated),
      isFavourite: Value(isFavourite),
      dateLastAnswered: dateLastAnswered == null && nullToAbsent
          ? const Value.absent()
          : Value(dateLastAnswered),
      rightAnswers: Value(rightAnswers),
      wrongAnswers: Value(wrongAnswers),
    );
  }

  factory Vocabulary.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Vocabulary(
      id: serializer.fromJson<int>(json['id']),
      vocLocal: serializer.fromJson<String>(json['voc_local']),
      vocForeign: serializer.fromJson<String>(json['voc_foreign']),
      categoryId: serializer.fromJson<int>(json['category_id']),
      dateCreated: serializer.fromJson<DateTime>(json['date_created']),
      isFavourite: serializer.fromJson<bool>(json['is_favourite']),
      dateLastAnswered:
          serializer.fromJson<DateTime?>(json['date_last_answered']),
      rightAnswers: serializer.fromJson<int>(json['right_answers']),
      wrongAnswers: serializer.fromJson<int>(json['wrong_answers']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'voc_local': serializer.toJson<String>(vocLocal),
      'voc_foreign': serializer.toJson<String>(vocForeign),
      'category_id': serializer.toJson<int>(categoryId),
      'date_created': serializer.toJson<DateTime>(dateCreated),
      'is_favourite': serializer.toJson<bool>(isFavourite),
      'date_last_answered': serializer.toJson<DateTime?>(dateLastAnswered),
      'right_answers': serializer.toJson<int>(rightAnswers),
      'wrong_answers': serializer.toJson<int>(wrongAnswers),
    };
  }

  Vocabulary copyWith(
          {int? id,
          String? vocLocal,
          String? vocForeign,
          int? categoryId,
          DateTime? dateCreated,
          bool? isFavourite,
          Value<DateTime?> dateLastAnswered = const Value.absent(),
          int? rightAnswers,
          int? wrongAnswers}) =>
      Vocabulary(
        id: id ?? this.id,
        vocLocal: vocLocal ?? this.vocLocal,
        vocForeign: vocForeign ?? this.vocForeign,
        categoryId: categoryId ?? this.categoryId,
        dateCreated: dateCreated ?? this.dateCreated,
        isFavourite: isFavourite ?? this.isFavourite,
        dateLastAnswered: dateLastAnswered.present
            ? dateLastAnswered.value
            : this.dateLastAnswered,
        rightAnswers: rightAnswers ?? this.rightAnswers,
        wrongAnswers: wrongAnswers ?? this.wrongAnswers,
      );
  @override
  String toString() {
    return (StringBuffer('Vocabulary(')
          ..write('id: $id, ')
          ..write('vocLocal: $vocLocal, ')
          ..write('vocForeign: $vocForeign, ')
          ..write('categoryId: $categoryId, ')
          ..write('dateCreated: $dateCreated, ')
          ..write('isFavourite: $isFavourite, ')
          ..write('dateLastAnswered: $dateLastAnswered, ')
          ..write('rightAnswers: $rightAnswers, ')
          ..write('wrongAnswers: $wrongAnswers')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, vocLocal, vocForeign, categoryId,
      dateCreated, isFavourite, dateLastAnswered, rightAnswers, wrongAnswers);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Vocabulary &&
          other.id == this.id &&
          other.vocLocal == this.vocLocal &&
          other.vocForeign == this.vocForeign &&
          other.categoryId == this.categoryId &&
          other.dateCreated == this.dateCreated &&
          other.isFavourite == this.isFavourite &&
          other.dateLastAnswered == this.dateLastAnswered &&
          other.rightAnswers == this.rightAnswers &&
          other.wrongAnswers == this.wrongAnswers);
}

class VocabulariesCompanion extends UpdateCompanion<Vocabulary> {
  final Value<int> id;
  final Value<String> vocLocal;
  final Value<String> vocForeign;
  final Value<int> categoryId;
  final Value<DateTime> dateCreated;
  final Value<bool> isFavourite;
  final Value<DateTime?> dateLastAnswered;
  final Value<int> rightAnswers;
  final Value<int> wrongAnswers;
  const VocabulariesCompanion({
    this.id = const Value.absent(),
    this.vocLocal = const Value.absent(),
    this.vocForeign = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.dateCreated = const Value.absent(),
    this.isFavourite = const Value.absent(),
    this.dateLastAnswered = const Value.absent(),
    this.rightAnswers = const Value.absent(),
    this.wrongAnswers = const Value.absent(),
  });
  VocabulariesCompanion.insert({
    this.id = const Value.absent(),
    required String vocLocal,
    required String vocForeign,
    required int categoryId,
    this.dateCreated = const Value.absent(),
    this.isFavourite = const Value.absent(),
    this.dateLastAnswered = const Value.absent(),
    this.rightAnswers = const Value.absent(),
    this.wrongAnswers = const Value.absent(),
  })  : vocLocal = Value(vocLocal),
        vocForeign = Value(vocForeign),
        categoryId = Value(categoryId);
  static Insertable<Vocabulary> custom({
    Expression<int>? id,
    Expression<String>? vocLocal,
    Expression<String>? vocForeign,
    Expression<int>? categoryId,
    Expression<DateTime>? dateCreated,
    Expression<bool>? isFavourite,
    Expression<DateTime>? dateLastAnswered,
    Expression<int>? rightAnswers,
    Expression<int>? wrongAnswers,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vocLocal != null) 'voc_local': vocLocal,
      if (vocForeign != null) 'voc_foreign': vocForeign,
      if (categoryId != null) 'category_id': categoryId,
      if (dateCreated != null) 'date_created': dateCreated,
      if (isFavourite != null) 'is_favourite': isFavourite,
      if (dateLastAnswered != null) 'date_last_answered': dateLastAnswered,
      if (rightAnswers != null) 'right_answers': rightAnswers,
      if (wrongAnswers != null) 'wrong_answers': wrongAnswers,
    });
  }

  VocabulariesCompanion copyWith(
      {Value<int>? id,
      Value<String>? vocLocal,
      Value<String>? vocForeign,
      Value<int>? categoryId,
      Value<DateTime>? dateCreated,
      Value<bool>? isFavourite,
      Value<DateTime?>? dateLastAnswered,
      Value<int>? rightAnswers,
      Value<int>? wrongAnswers}) {
    return VocabulariesCompanion(
      id: id ?? this.id,
      vocLocal: vocLocal ?? this.vocLocal,
      vocForeign: vocForeign ?? this.vocForeign,
      categoryId: categoryId ?? this.categoryId,
      dateCreated: dateCreated ?? this.dateCreated,
      isFavourite: isFavourite ?? this.isFavourite,
      dateLastAnswered: dateLastAnswered ?? this.dateLastAnswered,
      rightAnswers: rightAnswers ?? this.rightAnswers,
      wrongAnswers: wrongAnswers ?? this.wrongAnswers,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (vocLocal.present) {
      map['voc_local'] = Variable<String>(vocLocal.value);
    }
    if (vocForeign.present) {
      map['voc_foreign'] = Variable<String>(vocForeign.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (dateCreated.present) {
      map['date_created'] = Variable<DateTime>(dateCreated.value);
    }
    if (isFavourite.present) {
      map['is_favourite'] = Variable<bool>(isFavourite.value);
    }
    if (dateLastAnswered.present) {
      map['date_last_answered'] = Variable<DateTime>(dateLastAnswered.value);
    }
    if (rightAnswers.present) {
      map['right_answers'] = Variable<int>(rightAnswers.value);
    }
    if (wrongAnswers.present) {
      map['wrong_answers'] = Variable<int>(wrongAnswers.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VocabulariesCompanion(')
          ..write('id: $id, ')
          ..write('vocLocal: $vocLocal, ')
          ..write('vocForeign: $vocForeign, ')
          ..write('categoryId: $categoryId, ')
          ..write('dateCreated: $dateCreated, ')
          ..write('isFavourite: $isFavourite, ')
          ..write('dateLastAnswered: $dateLastAnswered, ')
          ..write('rightAnswers: $rightAnswers, ')
          ..write('wrongAnswers: $wrongAnswers')
          ..write(')'))
        .toString();
  }
}

class Vocabularies extends Table with TableInfo<Vocabularies, Vocabulary> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Vocabularies(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _vocLocalMeta = const VerificationMeta('vocLocal');
  late final GeneratedColumn<String> vocLocal = GeneratedColumn<String>(
      'voc_local', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _vocForeignMeta = const VerificationMeta('vocForeign');
  late final GeneratedColumn<String> vocForeign = GeneratedColumn<String>(
      'voc_foreign', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _categoryIdMeta = const VerificationMeta('categoryId');
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL REFERENCES categories(id)');
  final VerificationMeta _dateCreatedMeta =
      const VerificationMeta('dateCreated');
  late final GeneratedColumn<DateTime> dateCreated = GeneratedColumn<DateTime>(
      'date_created', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT CURRENT_TIMESTAMP',
      defaultValue: const CustomExpression<DateTime>('CURRENT_TIMESTAMP'));
  final VerificationMeta _isFavouriteMeta =
      const VerificationMeta('isFavourite');
  late final GeneratedColumn<bool> isFavourite = GeneratedColumn<bool>(
      'is_favourite', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT FALSE',
      defaultValue: const CustomExpression<bool>('FALSE'));
  final VerificationMeta _dateLastAnsweredMeta =
      const VerificationMeta('dateLastAnswered');
  late final GeneratedColumn<DateTime> dateLastAnswered =
      GeneratedColumn<DateTime>('date_last_answered', aliasedName, true,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          $customConstraints: '');
  final VerificationMeta _rightAnswersMeta =
      const VerificationMeta('rightAnswers');
  late final GeneratedColumn<int> rightAnswers = GeneratedColumn<int>(
      'right_answers', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT 0',
      defaultValue: const CustomExpression<int>('0'));
  final VerificationMeta _wrongAnswersMeta =
      const VerificationMeta('wrongAnswers');
  late final GeneratedColumn<int> wrongAnswers = GeneratedColumn<int>(
      'wrong_answers', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT 0',
      defaultValue: const CustomExpression<int>('0'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        vocLocal,
        vocForeign,
        categoryId,
        dateCreated,
        isFavourite,
        dateLastAnswered,
        rightAnswers,
        wrongAnswers
      ];
  @override
  String get aliasedName => _alias ?? 'vocabularies';
  @override
  String get actualTableName => 'vocabularies';
  @override
  VerificationContext validateIntegrity(Insertable<Vocabulary> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('voc_local')) {
      context.handle(_vocLocalMeta,
          vocLocal.isAcceptableOrUnknown(data['voc_local']!, _vocLocalMeta));
    } else if (isInserting) {
      context.missing(_vocLocalMeta);
    }
    if (data.containsKey('voc_foreign')) {
      context.handle(
          _vocForeignMeta,
          vocForeign.isAcceptableOrUnknown(
              data['voc_foreign']!, _vocForeignMeta));
    } else if (isInserting) {
      context.missing(_vocForeignMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('date_created')) {
      context.handle(
          _dateCreatedMeta,
          dateCreated.isAcceptableOrUnknown(
              data['date_created']!, _dateCreatedMeta));
    }
    if (data.containsKey('is_favourite')) {
      context.handle(
          _isFavouriteMeta,
          isFavourite.isAcceptableOrUnknown(
              data['is_favourite']!, _isFavouriteMeta));
    }
    if (data.containsKey('date_last_answered')) {
      context.handle(
          _dateLastAnsweredMeta,
          dateLastAnswered.isAcceptableOrUnknown(
              data['date_last_answered']!, _dateLastAnsweredMeta));
    }
    if (data.containsKey('right_answers')) {
      context.handle(
          _rightAnswersMeta,
          rightAnswers.isAcceptableOrUnknown(
              data['right_answers']!, _rightAnswersMeta));
    }
    if (data.containsKey('wrong_answers')) {
      context.handle(
          _wrongAnswersMeta,
          wrongAnswers.isAcceptableOrUnknown(
              data['wrong_answers']!, _wrongAnswersMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Vocabulary map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Vocabulary(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      vocLocal: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}voc_local'])!,
      vocForeign: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}voc_foreign'])!,
      categoryId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}category_id'])!,
      dateCreated: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date_created'])!,
      isFavourite: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favourite'])!,
      dateLastAnswered: attachedDatabase.options.types.read(
          DriftSqlType.dateTime, data['${effectivePrefix}date_last_answered']),
      rightAnswers: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}right_answers'])!,
      wrongAnswers: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}wrong_answers'])!,
    );
  }

  @override
  Vocabularies createAlias(String alias) {
    return Vocabularies(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class VocabulariesLogData extends DataClass
    implements Insertable<VocabulariesLogData> {
  final int logId;
  final String actionName;
  final DateTime actionTimestamp;
  final int affectedId;
  final String? vocLocalNew;
  final String? vocForeignNew;
  final int? categoryIdNew;
  final DateTime? dateCreatedNew;
  final bool? isFavouriteNew;
  final DateTime? dateLastAnsweredNew;
  final int? rightAnswersNew;
  final int? wrongAnswersNew;
  final String? vocLocalOld;
  final String? vocForeignOld;
  final int? categoryIdOld;
  final DateTime? dateCreatedOld;
  final bool? isFavouriteOld;
  final DateTime? dateLastAnsweredOld;
  final int? rightAnswersOld;
  final int? wrongAnswersOld;
  const VocabulariesLogData(
      {required this.logId,
      required this.actionName,
      required this.actionTimestamp,
      required this.affectedId,
      this.vocLocalNew,
      this.vocForeignNew,
      this.categoryIdNew,
      this.dateCreatedNew,
      this.isFavouriteNew,
      this.dateLastAnsweredNew,
      this.rightAnswersNew,
      this.wrongAnswersNew,
      this.vocLocalOld,
      this.vocForeignOld,
      this.categoryIdOld,
      this.dateCreatedOld,
      this.isFavouriteOld,
      this.dateLastAnsweredOld,
      this.rightAnswersOld,
      this.wrongAnswersOld});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['log_id'] = Variable<int>(logId);
    map['action_name'] = Variable<String>(actionName);
    map['action_timestamp'] = Variable<DateTime>(actionTimestamp);
    map['affected_id'] = Variable<int>(affectedId);
    if (!nullToAbsent || vocLocalNew != null) {
      map['voc_local_new'] = Variable<String>(vocLocalNew);
    }
    if (!nullToAbsent || vocForeignNew != null) {
      map['voc_foreign_new'] = Variable<String>(vocForeignNew);
    }
    if (!nullToAbsent || categoryIdNew != null) {
      map['category_id_new'] = Variable<int>(categoryIdNew);
    }
    if (!nullToAbsent || dateCreatedNew != null) {
      map['date_created_new'] = Variable<DateTime>(dateCreatedNew);
    }
    if (!nullToAbsent || isFavouriteNew != null) {
      map['is_favourite_new'] = Variable<bool>(isFavouriteNew);
    }
    if (!nullToAbsent || dateLastAnsweredNew != null) {
      map['date_last_answered_new'] = Variable<DateTime>(dateLastAnsweredNew);
    }
    if (!nullToAbsent || rightAnswersNew != null) {
      map['right_answers_new'] = Variable<int>(rightAnswersNew);
    }
    if (!nullToAbsent || wrongAnswersNew != null) {
      map['wrong_answers_new'] = Variable<int>(wrongAnswersNew);
    }
    if (!nullToAbsent || vocLocalOld != null) {
      map['voc_local_old'] = Variable<String>(vocLocalOld);
    }
    if (!nullToAbsent || vocForeignOld != null) {
      map['voc_foreign_old'] = Variable<String>(vocForeignOld);
    }
    if (!nullToAbsent || categoryIdOld != null) {
      map['category_id_old'] = Variable<int>(categoryIdOld);
    }
    if (!nullToAbsent || dateCreatedOld != null) {
      map['date_created_old'] = Variable<DateTime>(dateCreatedOld);
    }
    if (!nullToAbsent || isFavouriteOld != null) {
      map['is_favourite_old'] = Variable<bool>(isFavouriteOld);
    }
    if (!nullToAbsent || dateLastAnsweredOld != null) {
      map['date_last_answered_old'] = Variable<DateTime>(dateLastAnsweredOld);
    }
    if (!nullToAbsent || rightAnswersOld != null) {
      map['right_answers_old'] = Variable<int>(rightAnswersOld);
    }
    if (!nullToAbsent || wrongAnswersOld != null) {
      map['wrong_answers_old'] = Variable<int>(wrongAnswersOld);
    }
    return map;
  }

  VocabulariesLogCompanion toCompanion(bool nullToAbsent) {
    return VocabulariesLogCompanion(
      logId: Value(logId),
      actionName: Value(actionName),
      actionTimestamp: Value(actionTimestamp),
      affectedId: Value(affectedId),
      vocLocalNew: vocLocalNew == null && nullToAbsent
          ? const Value.absent()
          : Value(vocLocalNew),
      vocForeignNew: vocForeignNew == null && nullToAbsent
          ? const Value.absent()
          : Value(vocForeignNew),
      categoryIdNew: categoryIdNew == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryIdNew),
      dateCreatedNew: dateCreatedNew == null && nullToAbsent
          ? const Value.absent()
          : Value(dateCreatedNew),
      isFavouriteNew: isFavouriteNew == null && nullToAbsent
          ? const Value.absent()
          : Value(isFavouriteNew),
      dateLastAnsweredNew: dateLastAnsweredNew == null && nullToAbsent
          ? const Value.absent()
          : Value(dateLastAnsweredNew),
      rightAnswersNew: rightAnswersNew == null && nullToAbsent
          ? const Value.absent()
          : Value(rightAnswersNew),
      wrongAnswersNew: wrongAnswersNew == null && nullToAbsent
          ? const Value.absent()
          : Value(wrongAnswersNew),
      vocLocalOld: vocLocalOld == null && nullToAbsent
          ? const Value.absent()
          : Value(vocLocalOld),
      vocForeignOld: vocForeignOld == null && nullToAbsent
          ? const Value.absent()
          : Value(vocForeignOld),
      categoryIdOld: categoryIdOld == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryIdOld),
      dateCreatedOld: dateCreatedOld == null && nullToAbsent
          ? const Value.absent()
          : Value(dateCreatedOld),
      isFavouriteOld: isFavouriteOld == null && nullToAbsent
          ? const Value.absent()
          : Value(isFavouriteOld),
      dateLastAnsweredOld: dateLastAnsweredOld == null && nullToAbsent
          ? const Value.absent()
          : Value(dateLastAnsweredOld),
      rightAnswersOld: rightAnswersOld == null && nullToAbsent
          ? const Value.absent()
          : Value(rightAnswersOld),
      wrongAnswersOld: wrongAnswersOld == null && nullToAbsent
          ? const Value.absent()
          : Value(wrongAnswersOld),
    );
  }

  factory VocabulariesLogData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VocabulariesLogData(
      logId: serializer.fromJson<int>(json['log_id']),
      actionName: serializer.fromJson<String>(json['action_name']),
      actionTimestamp: serializer.fromJson<DateTime>(json['action_timestamp']),
      affectedId: serializer.fromJson<int>(json['affected_id']),
      vocLocalNew: serializer.fromJson<String?>(json['voc_local_new']),
      vocForeignNew: serializer.fromJson<String?>(json['voc_foreign_new']),
      categoryIdNew: serializer.fromJson<int?>(json['category_id_new']),
      dateCreatedNew: serializer.fromJson<DateTime?>(json['date_created_new']),
      isFavouriteNew: serializer.fromJson<bool?>(json['is_favourite_new']),
      dateLastAnsweredNew:
          serializer.fromJson<DateTime?>(json['date_last_answered_new']),
      rightAnswersNew: serializer.fromJson<int?>(json['right_answers_new']),
      wrongAnswersNew: serializer.fromJson<int?>(json['wrong_answers_new']),
      vocLocalOld: serializer.fromJson<String?>(json['voc_local_old']),
      vocForeignOld: serializer.fromJson<String?>(json['voc_foreign_old']),
      categoryIdOld: serializer.fromJson<int?>(json['category_id_old']),
      dateCreatedOld: serializer.fromJson<DateTime?>(json['date_created_old']),
      isFavouriteOld: serializer.fromJson<bool?>(json['is_favourite_old']),
      dateLastAnsweredOld:
          serializer.fromJson<DateTime?>(json['date_last_answered_old']),
      rightAnswersOld: serializer.fromJson<int?>(json['right_answers_old']),
      wrongAnswersOld: serializer.fromJson<int?>(json['wrong_answers_old']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'log_id': serializer.toJson<int>(logId),
      'action_name': serializer.toJson<String>(actionName),
      'action_timestamp': serializer.toJson<DateTime>(actionTimestamp),
      'affected_id': serializer.toJson<int>(affectedId),
      'voc_local_new': serializer.toJson<String?>(vocLocalNew),
      'voc_foreign_new': serializer.toJson<String?>(vocForeignNew),
      'category_id_new': serializer.toJson<int?>(categoryIdNew),
      'date_created_new': serializer.toJson<DateTime?>(dateCreatedNew),
      'is_favourite_new': serializer.toJson<bool?>(isFavouriteNew),
      'date_last_answered_new':
          serializer.toJson<DateTime?>(dateLastAnsweredNew),
      'right_answers_new': serializer.toJson<int?>(rightAnswersNew),
      'wrong_answers_new': serializer.toJson<int?>(wrongAnswersNew),
      'voc_local_old': serializer.toJson<String?>(vocLocalOld),
      'voc_foreign_old': serializer.toJson<String?>(vocForeignOld),
      'category_id_old': serializer.toJson<int?>(categoryIdOld),
      'date_created_old': serializer.toJson<DateTime?>(dateCreatedOld),
      'is_favourite_old': serializer.toJson<bool?>(isFavouriteOld),
      'date_last_answered_old':
          serializer.toJson<DateTime?>(dateLastAnsweredOld),
      'right_answers_old': serializer.toJson<int?>(rightAnswersOld),
      'wrong_answers_old': serializer.toJson<int?>(wrongAnswersOld),
    };
  }

  VocabulariesLogData copyWith(
          {int? logId,
          String? actionName,
          DateTime? actionTimestamp,
          int? affectedId,
          Value<String?> vocLocalNew = const Value.absent(),
          Value<String?> vocForeignNew = const Value.absent(),
          Value<int?> categoryIdNew = const Value.absent(),
          Value<DateTime?> dateCreatedNew = const Value.absent(),
          Value<bool?> isFavouriteNew = const Value.absent(),
          Value<DateTime?> dateLastAnsweredNew = const Value.absent(),
          Value<int?> rightAnswersNew = const Value.absent(),
          Value<int?> wrongAnswersNew = const Value.absent(),
          Value<String?> vocLocalOld = const Value.absent(),
          Value<String?> vocForeignOld = const Value.absent(),
          Value<int?> categoryIdOld = const Value.absent(),
          Value<DateTime?> dateCreatedOld = const Value.absent(),
          Value<bool?> isFavouriteOld = const Value.absent(),
          Value<DateTime?> dateLastAnsweredOld = const Value.absent(),
          Value<int?> rightAnswersOld = const Value.absent(),
          Value<int?> wrongAnswersOld = const Value.absent()}) =>
      VocabulariesLogData(
        logId: logId ?? this.logId,
        actionName: actionName ?? this.actionName,
        actionTimestamp: actionTimestamp ?? this.actionTimestamp,
        affectedId: affectedId ?? this.affectedId,
        vocLocalNew: vocLocalNew.present ? vocLocalNew.value : this.vocLocalNew,
        vocForeignNew:
            vocForeignNew.present ? vocForeignNew.value : this.vocForeignNew,
        categoryIdNew:
            categoryIdNew.present ? categoryIdNew.value : this.categoryIdNew,
        dateCreatedNew:
            dateCreatedNew.present ? dateCreatedNew.value : this.dateCreatedNew,
        isFavouriteNew:
            isFavouriteNew.present ? isFavouriteNew.value : this.isFavouriteNew,
        dateLastAnsweredNew: dateLastAnsweredNew.present
            ? dateLastAnsweredNew.value
            : this.dateLastAnsweredNew,
        rightAnswersNew: rightAnswersNew.present
            ? rightAnswersNew.value
            : this.rightAnswersNew,
        wrongAnswersNew: wrongAnswersNew.present
            ? wrongAnswersNew.value
            : this.wrongAnswersNew,
        vocLocalOld: vocLocalOld.present ? vocLocalOld.value : this.vocLocalOld,
        vocForeignOld:
            vocForeignOld.present ? vocForeignOld.value : this.vocForeignOld,
        categoryIdOld:
            categoryIdOld.present ? categoryIdOld.value : this.categoryIdOld,
        dateCreatedOld:
            dateCreatedOld.present ? dateCreatedOld.value : this.dateCreatedOld,
        isFavouriteOld:
            isFavouriteOld.present ? isFavouriteOld.value : this.isFavouriteOld,
        dateLastAnsweredOld: dateLastAnsweredOld.present
            ? dateLastAnsweredOld.value
            : this.dateLastAnsweredOld,
        rightAnswersOld: rightAnswersOld.present
            ? rightAnswersOld.value
            : this.rightAnswersOld,
        wrongAnswersOld: wrongAnswersOld.present
            ? wrongAnswersOld.value
            : this.wrongAnswersOld,
      );
  @override
  String toString() {
    return (StringBuffer('VocabulariesLogData(')
          ..write('logId: $logId, ')
          ..write('actionName: $actionName, ')
          ..write('actionTimestamp: $actionTimestamp, ')
          ..write('affectedId: $affectedId, ')
          ..write('vocLocalNew: $vocLocalNew, ')
          ..write('vocForeignNew: $vocForeignNew, ')
          ..write('categoryIdNew: $categoryIdNew, ')
          ..write('dateCreatedNew: $dateCreatedNew, ')
          ..write('isFavouriteNew: $isFavouriteNew, ')
          ..write('dateLastAnsweredNew: $dateLastAnsweredNew, ')
          ..write('rightAnswersNew: $rightAnswersNew, ')
          ..write('wrongAnswersNew: $wrongAnswersNew, ')
          ..write('vocLocalOld: $vocLocalOld, ')
          ..write('vocForeignOld: $vocForeignOld, ')
          ..write('categoryIdOld: $categoryIdOld, ')
          ..write('dateCreatedOld: $dateCreatedOld, ')
          ..write('isFavouriteOld: $isFavouriteOld, ')
          ..write('dateLastAnsweredOld: $dateLastAnsweredOld, ')
          ..write('rightAnswersOld: $rightAnswersOld, ')
          ..write('wrongAnswersOld: $wrongAnswersOld')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      logId,
      actionName,
      actionTimestamp,
      affectedId,
      vocLocalNew,
      vocForeignNew,
      categoryIdNew,
      dateCreatedNew,
      isFavouriteNew,
      dateLastAnsweredNew,
      rightAnswersNew,
      wrongAnswersNew,
      vocLocalOld,
      vocForeignOld,
      categoryIdOld,
      dateCreatedOld,
      isFavouriteOld,
      dateLastAnsweredOld,
      rightAnswersOld,
      wrongAnswersOld);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VocabulariesLogData &&
          other.logId == this.logId &&
          other.actionName == this.actionName &&
          other.actionTimestamp == this.actionTimestamp &&
          other.affectedId == this.affectedId &&
          other.vocLocalNew == this.vocLocalNew &&
          other.vocForeignNew == this.vocForeignNew &&
          other.categoryIdNew == this.categoryIdNew &&
          other.dateCreatedNew == this.dateCreatedNew &&
          other.isFavouriteNew == this.isFavouriteNew &&
          other.dateLastAnsweredNew == this.dateLastAnsweredNew &&
          other.rightAnswersNew == this.rightAnswersNew &&
          other.wrongAnswersNew == this.wrongAnswersNew &&
          other.vocLocalOld == this.vocLocalOld &&
          other.vocForeignOld == this.vocForeignOld &&
          other.categoryIdOld == this.categoryIdOld &&
          other.dateCreatedOld == this.dateCreatedOld &&
          other.isFavouriteOld == this.isFavouriteOld &&
          other.dateLastAnsweredOld == this.dateLastAnsweredOld &&
          other.rightAnswersOld == this.rightAnswersOld &&
          other.wrongAnswersOld == this.wrongAnswersOld);
}

class VocabulariesLogCompanion extends UpdateCompanion<VocabulariesLogData> {
  final Value<int> logId;
  final Value<String> actionName;
  final Value<DateTime> actionTimestamp;
  final Value<int> affectedId;
  final Value<String?> vocLocalNew;
  final Value<String?> vocForeignNew;
  final Value<int?> categoryIdNew;
  final Value<DateTime?> dateCreatedNew;
  final Value<bool?> isFavouriteNew;
  final Value<DateTime?> dateLastAnsweredNew;
  final Value<int?> rightAnswersNew;
  final Value<int?> wrongAnswersNew;
  final Value<String?> vocLocalOld;
  final Value<String?> vocForeignOld;
  final Value<int?> categoryIdOld;
  final Value<DateTime?> dateCreatedOld;
  final Value<bool?> isFavouriteOld;
  final Value<DateTime?> dateLastAnsweredOld;
  final Value<int?> rightAnswersOld;
  final Value<int?> wrongAnswersOld;
  const VocabulariesLogCompanion({
    this.logId = const Value.absent(),
    this.actionName = const Value.absent(),
    this.actionTimestamp = const Value.absent(),
    this.affectedId = const Value.absent(),
    this.vocLocalNew = const Value.absent(),
    this.vocForeignNew = const Value.absent(),
    this.categoryIdNew = const Value.absent(),
    this.dateCreatedNew = const Value.absent(),
    this.isFavouriteNew = const Value.absent(),
    this.dateLastAnsweredNew = const Value.absent(),
    this.rightAnswersNew = const Value.absent(),
    this.wrongAnswersNew = const Value.absent(),
    this.vocLocalOld = const Value.absent(),
    this.vocForeignOld = const Value.absent(),
    this.categoryIdOld = const Value.absent(),
    this.dateCreatedOld = const Value.absent(),
    this.isFavouriteOld = const Value.absent(),
    this.dateLastAnsweredOld = const Value.absent(),
    this.rightAnswersOld = const Value.absent(),
    this.wrongAnswersOld = const Value.absent(),
  });
  VocabulariesLogCompanion.insert({
    this.logId = const Value.absent(),
    required String actionName,
    this.actionTimestamp = const Value.absent(),
    required int affectedId,
    this.vocLocalNew = const Value.absent(),
    this.vocForeignNew = const Value.absent(),
    this.categoryIdNew = const Value.absent(),
    this.dateCreatedNew = const Value.absent(),
    this.isFavouriteNew = const Value.absent(),
    this.dateLastAnsweredNew = const Value.absent(),
    this.rightAnswersNew = const Value.absent(),
    this.wrongAnswersNew = const Value.absent(),
    this.vocLocalOld = const Value.absent(),
    this.vocForeignOld = const Value.absent(),
    this.categoryIdOld = const Value.absent(),
    this.dateCreatedOld = const Value.absent(),
    this.isFavouriteOld = const Value.absent(),
    this.dateLastAnsweredOld = const Value.absent(),
    this.rightAnswersOld = const Value.absent(),
    this.wrongAnswersOld = const Value.absent(),
  })  : actionName = Value(actionName),
        affectedId = Value(affectedId);
  static Insertable<VocabulariesLogData> custom({
    Expression<int>? logId,
    Expression<String>? actionName,
    Expression<DateTime>? actionTimestamp,
    Expression<int>? affectedId,
    Expression<String>? vocLocalNew,
    Expression<String>? vocForeignNew,
    Expression<int>? categoryIdNew,
    Expression<DateTime>? dateCreatedNew,
    Expression<bool>? isFavouriteNew,
    Expression<DateTime>? dateLastAnsweredNew,
    Expression<int>? rightAnswersNew,
    Expression<int>? wrongAnswersNew,
    Expression<String>? vocLocalOld,
    Expression<String>? vocForeignOld,
    Expression<int>? categoryIdOld,
    Expression<DateTime>? dateCreatedOld,
    Expression<bool>? isFavouriteOld,
    Expression<DateTime>? dateLastAnsweredOld,
    Expression<int>? rightAnswersOld,
    Expression<int>? wrongAnswersOld,
  }) {
    return RawValuesInsertable({
      if (logId != null) 'log_id': logId,
      if (actionName != null) 'action_name': actionName,
      if (actionTimestamp != null) 'action_timestamp': actionTimestamp,
      if (affectedId != null) 'affected_id': affectedId,
      if (vocLocalNew != null) 'voc_local_new': vocLocalNew,
      if (vocForeignNew != null) 'voc_foreign_new': vocForeignNew,
      if (categoryIdNew != null) 'category_id_new': categoryIdNew,
      if (dateCreatedNew != null) 'date_created_new': dateCreatedNew,
      if (isFavouriteNew != null) 'is_favourite_new': isFavouriteNew,
      if (dateLastAnsweredNew != null)
        'date_last_answered_new': dateLastAnsweredNew,
      if (rightAnswersNew != null) 'right_answers_new': rightAnswersNew,
      if (wrongAnswersNew != null) 'wrong_answers_new': wrongAnswersNew,
      if (vocLocalOld != null) 'voc_local_old': vocLocalOld,
      if (vocForeignOld != null) 'voc_foreign_old': vocForeignOld,
      if (categoryIdOld != null) 'category_id_old': categoryIdOld,
      if (dateCreatedOld != null) 'date_created_old': dateCreatedOld,
      if (isFavouriteOld != null) 'is_favourite_old': isFavouriteOld,
      if (dateLastAnsweredOld != null)
        'date_last_answered_old': dateLastAnsweredOld,
      if (rightAnswersOld != null) 'right_answers_old': rightAnswersOld,
      if (wrongAnswersOld != null) 'wrong_answers_old': wrongAnswersOld,
    });
  }

  VocabulariesLogCompanion copyWith(
      {Value<int>? logId,
      Value<String>? actionName,
      Value<DateTime>? actionTimestamp,
      Value<int>? affectedId,
      Value<String?>? vocLocalNew,
      Value<String?>? vocForeignNew,
      Value<int?>? categoryIdNew,
      Value<DateTime?>? dateCreatedNew,
      Value<bool?>? isFavouriteNew,
      Value<DateTime?>? dateLastAnsweredNew,
      Value<int?>? rightAnswersNew,
      Value<int?>? wrongAnswersNew,
      Value<String?>? vocLocalOld,
      Value<String?>? vocForeignOld,
      Value<int?>? categoryIdOld,
      Value<DateTime?>? dateCreatedOld,
      Value<bool?>? isFavouriteOld,
      Value<DateTime?>? dateLastAnsweredOld,
      Value<int?>? rightAnswersOld,
      Value<int?>? wrongAnswersOld}) {
    return VocabulariesLogCompanion(
      logId: logId ?? this.logId,
      actionName: actionName ?? this.actionName,
      actionTimestamp: actionTimestamp ?? this.actionTimestamp,
      affectedId: affectedId ?? this.affectedId,
      vocLocalNew: vocLocalNew ?? this.vocLocalNew,
      vocForeignNew: vocForeignNew ?? this.vocForeignNew,
      categoryIdNew: categoryIdNew ?? this.categoryIdNew,
      dateCreatedNew: dateCreatedNew ?? this.dateCreatedNew,
      isFavouriteNew: isFavouriteNew ?? this.isFavouriteNew,
      dateLastAnsweredNew: dateLastAnsweredNew ?? this.dateLastAnsweredNew,
      rightAnswersNew: rightAnswersNew ?? this.rightAnswersNew,
      wrongAnswersNew: wrongAnswersNew ?? this.wrongAnswersNew,
      vocLocalOld: vocLocalOld ?? this.vocLocalOld,
      vocForeignOld: vocForeignOld ?? this.vocForeignOld,
      categoryIdOld: categoryIdOld ?? this.categoryIdOld,
      dateCreatedOld: dateCreatedOld ?? this.dateCreatedOld,
      isFavouriteOld: isFavouriteOld ?? this.isFavouriteOld,
      dateLastAnsweredOld: dateLastAnsweredOld ?? this.dateLastAnsweredOld,
      rightAnswersOld: rightAnswersOld ?? this.rightAnswersOld,
      wrongAnswersOld: wrongAnswersOld ?? this.wrongAnswersOld,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (logId.present) {
      map['log_id'] = Variable<int>(logId.value);
    }
    if (actionName.present) {
      map['action_name'] = Variable<String>(actionName.value);
    }
    if (actionTimestamp.present) {
      map['action_timestamp'] = Variable<DateTime>(actionTimestamp.value);
    }
    if (affectedId.present) {
      map['affected_id'] = Variable<int>(affectedId.value);
    }
    if (vocLocalNew.present) {
      map['voc_local_new'] = Variable<String>(vocLocalNew.value);
    }
    if (vocForeignNew.present) {
      map['voc_foreign_new'] = Variable<String>(vocForeignNew.value);
    }
    if (categoryIdNew.present) {
      map['category_id_new'] = Variable<int>(categoryIdNew.value);
    }
    if (dateCreatedNew.present) {
      map['date_created_new'] = Variable<DateTime>(dateCreatedNew.value);
    }
    if (isFavouriteNew.present) {
      map['is_favourite_new'] = Variable<bool>(isFavouriteNew.value);
    }
    if (dateLastAnsweredNew.present) {
      map['date_last_answered_new'] =
          Variable<DateTime>(dateLastAnsweredNew.value);
    }
    if (rightAnswersNew.present) {
      map['right_answers_new'] = Variable<int>(rightAnswersNew.value);
    }
    if (wrongAnswersNew.present) {
      map['wrong_answers_new'] = Variable<int>(wrongAnswersNew.value);
    }
    if (vocLocalOld.present) {
      map['voc_local_old'] = Variable<String>(vocLocalOld.value);
    }
    if (vocForeignOld.present) {
      map['voc_foreign_old'] = Variable<String>(vocForeignOld.value);
    }
    if (categoryIdOld.present) {
      map['category_id_old'] = Variable<int>(categoryIdOld.value);
    }
    if (dateCreatedOld.present) {
      map['date_created_old'] = Variable<DateTime>(dateCreatedOld.value);
    }
    if (isFavouriteOld.present) {
      map['is_favourite_old'] = Variable<bool>(isFavouriteOld.value);
    }
    if (dateLastAnsweredOld.present) {
      map['date_last_answered_old'] =
          Variable<DateTime>(dateLastAnsweredOld.value);
    }
    if (rightAnswersOld.present) {
      map['right_answers_old'] = Variable<int>(rightAnswersOld.value);
    }
    if (wrongAnswersOld.present) {
      map['wrong_answers_old'] = Variable<int>(wrongAnswersOld.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VocabulariesLogCompanion(')
          ..write('logId: $logId, ')
          ..write('actionName: $actionName, ')
          ..write('actionTimestamp: $actionTimestamp, ')
          ..write('affectedId: $affectedId, ')
          ..write('vocLocalNew: $vocLocalNew, ')
          ..write('vocForeignNew: $vocForeignNew, ')
          ..write('categoryIdNew: $categoryIdNew, ')
          ..write('dateCreatedNew: $dateCreatedNew, ')
          ..write('isFavouriteNew: $isFavouriteNew, ')
          ..write('dateLastAnsweredNew: $dateLastAnsweredNew, ')
          ..write('rightAnswersNew: $rightAnswersNew, ')
          ..write('wrongAnswersNew: $wrongAnswersNew, ')
          ..write('vocLocalOld: $vocLocalOld, ')
          ..write('vocForeignOld: $vocForeignOld, ')
          ..write('categoryIdOld: $categoryIdOld, ')
          ..write('dateCreatedOld: $dateCreatedOld, ')
          ..write('isFavouriteOld: $isFavouriteOld, ')
          ..write('dateLastAnsweredOld: $dateLastAnsweredOld, ')
          ..write('rightAnswersOld: $rightAnswersOld, ')
          ..write('wrongAnswersOld: $wrongAnswersOld')
          ..write(')'))
        .toString();
  }
}

class VocabulariesLog extends Table
    with TableInfo<VocabulariesLog, VocabulariesLogData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  VocabulariesLog(this.attachedDatabase, [this._alias]);
  final VerificationMeta _logIdMeta = const VerificationMeta('logId');
  late final GeneratedColumn<int> logId = GeneratedColumn<int>(
      'log_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _actionNameMeta = const VerificationMeta('actionName');
  late final GeneratedColumn<String> actionName = GeneratedColumn<String>(
      'action_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _actionTimestampMeta =
      const VerificationMeta('actionTimestamp');
  late final GeneratedColumn<DateTime> actionTimestamp =
      GeneratedColumn<DateTime>('action_timestamp', aliasedName, false,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          $customConstraints: 'NOT NULL DEFAULT CURRENT_TIMESTAMP',
          defaultValue: const CustomExpression<DateTime>('CURRENT_TIMESTAMP'));
  final VerificationMeta _affectedIdMeta = const VerificationMeta('affectedId');
  late final GeneratedColumn<int> affectedId = GeneratedColumn<int>(
      'affected_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _vocLocalNewMeta =
      const VerificationMeta('vocLocalNew');
  late final GeneratedColumn<String> vocLocalNew = GeneratedColumn<String>(
      'voc_local_new', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _vocForeignNewMeta =
      const VerificationMeta('vocForeignNew');
  late final GeneratedColumn<String> vocForeignNew = GeneratedColumn<String>(
      'voc_foreign_new', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _categoryIdNewMeta =
      const VerificationMeta('categoryIdNew');
  late final GeneratedColumn<int> categoryIdNew = GeneratedColumn<int>(
      'category_id_new', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES categories(id)');
  final VerificationMeta _dateCreatedNewMeta =
      const VerificationMeta('dateCreatedNew');
  late final GeneratedColumn<DateTime> dateCreatedNew =
      GeneratedColumn<DateTime>('date_created_new', aliasedName, true,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          $customConstraints: '');
  final VerificationMeta _isFavouriteNewMeta =
      const VerificationMeta('isFavouriteNew');
  late final GeneratedColumn<bool> isFavouriteNew = GeneratedColumn<bool>(
      'is_favourite_new', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _dateLastAnsweredNewMeta =
      const VerificationMeta('dateLastAnsweredNew');
  late final GeneratedColumn<DateTime> dateLastAnsweredNew =
      GeneratedColumn<DateTime>('date_last_answered_new', aliasedName, true,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          $customConstraints: '');
  final VerificationMeta _rightAnswersNewMeta =
      const VerificationMeta('rightAnswersNew');
  late final GeneratedColumn<int> rightAnswersNew = GeneratedColumn<int>(
      'right_answers_new', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _wrongAnswersNewMeta =
      const VerificationMeta('wrongAnswersNew');
  late final GeneratedColumn<int> wrongAnswersNew = GeneratedColumn<int>(
      'wrong_answers_new', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _vocLocalOldMeta =
      const VerificationMeta('vocLocalOld');
  late final GeneratedColumn<String> vocLocalOld = GeneratedColumn<String>(
      'voc_local_old', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _vocForeignOldMeta =
      const VerificationMeta('vocForeignOld');
  late final GeneratedColumn<String> vocForeignOld = GeneratedColumn<String>(
      'voc_foreign_old', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _categoryIdOldMeta =
      const VerificationMeta('categoryIdOld');
  late final GeneratedColumn<int> categoryIdOld = GeneratedColumn<int>(
      'category_id_old', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'REFERENCES categories(id)');
  final VerificationMeta _dateCreatedOldMeta =
      const VerificationMeta('dateCreatedOld');
  late final GeneratedColumn<DateTime> dateCreatedOld =
      GeneratedColumn<DateTime>('date_created_old', aliasedName, true,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          $customConstraints: '');
  final VerificationMeta _isFavouriteOldMeta =
      const VerificationMeta('isFavouriteOld');
  late final GeneratedColumn<bool> isFavouriteOld = GeneratedColumn<bool>(
      'is_favourite_old', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _dateLastAnsweredOldMeta =
      const VerificationMeta('dateLastAnsweredOld');
  late final GeneratedColumn<DateTime> dateLastAnsweredOld =
      GeneratedColumn<DateTime>('date_last_answered_old', aliasedName, true,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          $customConstraints: '');
  final VerificationMeta _rightAnswersOldMeta =
      const VerificationMeta('rightAnswersOld');
  late final GeneratedColumn<int> rightAnswersOld = GeneratedColumn<int>(
      'right_answers_old', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _wrongAnswersOldMeta =
      const VerificationMeta('wrongAnswersOld');
  late final GeneratedColumn<int> wrongAnswersOld = GeneratedColumn<int>(
      'wrong_answers_old', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [
        logId,
        actionName,
        actionTimestamp,
        affectedId,
        vocLocalNew,
        vocForeignNew,
        categoryIdNew,
        dateCreatedNew,
        isFavouriteNew,
        dateLastAnsweredNew,
        rightAnswersNew,
        wrongAnswersNew,
        vocLocalOld,
        vocForeignOld,
        categoryIdOld,
        dateCreatedOld,
        isFavouriteOld,
        dateLastAnsweredOld,
        rightAnswersOld,
        wrongAnswersOld
      ];
  @override
  String get aliasedName => _alias ?? 'vocabularies_log';
  @override
  String get actualTableName => 'vocabularies_log';
  @override
  VerificationContext validateIntegrity(
      Insertable<VocabulariesLogData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('log_id')) {
      context.handle(
          _logIdMeta, logId.isAcceptableOrUnknown(data['log_id']!, _logIdMeta));
    }
    if (data.containsKey('action_name')) {
      context.handle(
          _actionNameMeta,
          actionName.isAcceptableOrUnknown(
              data['action_name']!, _actionNameMeta));
    } else if (isInserting) {
      context.missing(_actionNameMeta);
    }
    if (data.containsKey('action_timestamp')) {
      context.handle(
          _actionTimestampMeta,
          actionTimestamp.isAcceptableOrUnknown(
              data['action_timestamp']!, _actionTimestampMeta));
    }
    if (data.containsKey('affected_id')) {
      context.handle(
          _affectedIdMeta,
          affectedId.isAcceptableOrUnknown(
              data['affected_id']!, _affectedIdMeta));
    } else if (isInserting) {
      context.missing(_affectedIdMeta);
    }
    if (data.containsKey('voc_local_new')) {
      context.handle(
          _vocLocalNewMeta,
          vocLocalNew.isAcceptableOrUnknown(
              data['voc_local_new']!, _vocLocalNewMeta));
    }
    if (data.containsKey('voc_foreign_new')) {
      context.handle(
          _vocForeignNewMeta,
          vocForeignNew.isAcceptableOrUnknown(
              data['voc_foreign_new']!, _vocForeignNewMeta));
    }
    if (data.containsKey('category_id_new')) {
      context.handle(
          _categoryIdNewMeta,
          categoryIdNew.isAcceptableOrUnknown(
              data['category_id_new']!, _categoryIdNewMeta));
    }
    if (data.containsKey('date_created_new')) {
      context.handle(
          _dateCreatedNewMeta,
          dateCreatedNew.isAcceptableOrUnknown(
              data['date_created_new']!, _dateCreatedNewMeta));
    }
    if (data.containsKey('is_favourite_new')) {
      context.handle(
          _isFavouriteNewMeta,
          isFavouriteNew.isAcceptableOrUnknown(
              data['is_favourite_new']!, _isFavouriteNewMeta));
    }
    if (data.containsKey('date_last_answered_new')) {
      context.handle(
          _dateLastAnsweredNewMeta,
          dateLastAnsweredNew.isAcceptableOrUnknown(
              data['date_last_answered_new']!, _dateLastAnsweredNewMeta));
    }
    if (data.containsKey('right_answers_new')) {
      context.handle(
          _rightAnswersNewMeta,
          rightAnswersNew.isAcceptableOrUnknown(
              data['right_answers_new']!, _rightAnswersNewMeta));
    }
    if (data.containsKey('wrong_answers_new')) {
      context.handle(
          _wrongAnswersNewMeta,
          wrongAnswersNew.isAcceptableOrUnknown(
              data['wrong_answers_new']!, _wrongAnswersNewMeta));
    }
    if (data.containsKey('voc_local_old')) {
      context.handle(
          _vocLocalOldMeta,
          vocLocalOld.isAcceptableOrUnknown(
              data['voc_local_old']!, _vocLocalOldMeta));
    }
    if (data.containsKey('voc_foreign_old')) {
      context.handle(
          _vocForeignOldMeta,
          vocForeignOld.isAcceptableOrUnknown(
              data['voc_foreign_old']!, _vocForeignOldMeta));
    }
    if (data.containsKey('category_id_old')) {
      context.handle(
          _categoryIdOldMeta,
          categoryIdOld.isAcceptableOrUnknown(
              data['category_id_old']!, _categoryIdOldMeta));
    }
    if (data.containsKey('date_created_old')) {
      context.handle(
          _dateCreatedOldMeta,
          dateCreatedOld.isAcceptableOrUnknown(
              data['date_created_old']!, _dateCreatedOldMeta));
    }
    if (data.containsKey('is_favourite_old')) {
      context.handle(
          _isFavouriteOldMeta,
          isFavouriteOld.isAcceptableOrUnknown(
              data['is_favourite_old']!, _isFavouriteOldMeta));
    }
    if (data.containsKey('date_last_answered_old')) {
      context.handle(
          _dateLastAnsweredOldMeta,
          dateLastAnsweredOld.isAcceptableOrUnknown(
              data['date_last_answered_old']!, _dateLastAnsweredOldMeta));
    }
    if (data.containsKey('right_answers_old')) {
      context.handle(
          _rightAnswersOldMeta,
          rightAnswersOld.isAcceptableOrUnknown(
              data['right_answers_old']!, _rightAnswersOldMeta));
    }
    if (data.containsKey('wrong_answers_old')) {
      context.handle(
          _wrongAnswersOldMeta,
          wrongAnswersOld.isAcceptableOrUnknown(
              data['wrong_answers_old']!, _wrongAnswersOldMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {logId};
  @override
  VocabulariesLogData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VocabulariesLogData(
      logId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}log_id'])!,
      actionName: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}action_name'])!,
      actionTimestamp: attachedDatabase.options.types.read(
          DriftSqlType.dateTime, data['${effectivePrefix}action_timestamp'])!,
      affectedId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}affected_id'])!,
      vocLocalNew: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}voc_local_new']),
      vocForeignNew: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}voc_foreign_new']),
      categoryIdNew: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}category_id_new']),
      dateCreatedNew: attachedDatabase.options.types.read(
          DriftSqlType.dateTime, data['${effectivePrefix}date_created_new']),
      isFavouriteNew: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favourite_new']),
      dateLastAnsweredNew: attachedDatabase.options.types.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}date_last_answered_new']),
      rightAnswersNew: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}right_answers_new']),
      wrongAnswersNew: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}wrong_answers_new']),
      vocLocalOld: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}voc_local_old']),
      vocForeignOld: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}voc_foreign_old']),
      categoryIdOld: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}category_id_old']),
      dateCreatedOld: attachedDatabase.options.types.read(
          DriftSqlType.dateTime, data['${effectivePrefix}date_created_old']),
      isFavouriteOld: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favourite_old']),
      dateLastAnsweredOld: attachedDatabase.options.types.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}date_last_answered_old']),
      rightAnswersOld: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}right_answers_old']),
      wrongAnswersOld: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}wrong_answers_old']),
    );
  }

  @override
  VocabulariesLog createAlias(String alias) {
    return VocabulariesLog(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class CategoriesLogData extends DataClass
    implements Insertable<CategoriesLogData> {
  final int logId;
  final String actionName;
  final DateTime actionTimestamp;
  final int affectedId;
  final String? categoryNameNew;
  final String? categoryLanguageNew;
  final DateTime? dateCreatedNew;
  final bool? isFavouriteNew;
  final String? categoryNameOld;
  final String? categoryLanguageOld;
  final DateTime? dateCreatedOld;
  final bool? isFavouriteOld;
  const CategoriesLogData(
      {required this.logId,
      required this.actionName,
      required this.actionTimestamp,
      required this.affectedId,
      this.categoryNameNew,
      this.categoryLanguageNew,
      this.dateCreatedNew,
      this.isFavouriteNew,
      this.categoryNameOld,
      this.categoryLanguageOld,
      this.dateCreatedOld,
      this.isFavouriteOld});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['log_id'] = Variable<int>(logId);
    map['action_name'] = Variable<String>(actionName);
    map['action_timestamp'] = Variable<DateTime>(actionTimestamp);
    map['affected_id'] = Variable<int>(affectedId);
    if (!nullToAbsent || categoryNameNew != null) {
      map['category_name_new'] = Variable<String>(categoryNameNew);
    }
    if (!nullToAbsent || categoryLanguageNew != null) {
      map['category_language_new'] = Variable<String>(categoryLanguageNew);
    }
    if (!nullToAbsent || dateCreatedNew != null) {
      map['date_created_new'] = Variable<DateTime>(dateCreatedNew);
    }
    if (!nullToAbsent || isFavouriteNew != null) {
      map['is_favourite_new'] = Variable<bool>(isFavouriteNew);
    }
    if (!nullToAbsent || categoryNameOld != null) {
      map['category_name_old'] = Variable<String>(categoryNameOld);
    }
    if (!nullToAbsent || categoryLanguageOld != null) {
      map['category_language_old'] = Variable<String>(categoryLanguageOld);
    }
    if (!nullToAbsent || dateCreatedOld != null) {
      map['date_created_old'] = Variable<DateTime>(dateCreatedOld);
    }
    if (!nullToAbsent || isFavouriteOld != null) {
      map['is_favourite_old'] = Variable<bool>(isFavouriteOld);
    }
    return map;
  }

  CategoriesLogCompanion toCompanion(bool nullToAbsent) {
    return CategoriesLogCompanion(
      logId: Value(logId),
      actionName: Value(actionName),
      actionTimestamp: Value(actionTimestamp),
      affectedId: Value(affectedId),
      categoryNameNew: categoryNameNew == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryNameNew),
      categoryLanguageNew: categoryLanguageNew == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryLanguageNew),
      dateCreatedNew: dateCreatedNew == null && nullToAbsent
          ? const Value.absent()
          : Value(dateCreatedNew),
      isFavouriteNew: isFavouriteNew == null && nullToAbsent
          ? const Value.absent()
          : Value(isFavouriteNew),
      categoryNameOld: categoryNameOld == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryNameOld),
      categoryLanguageOld: categoryLanguageOld == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryLanguageOld),
      dateCreatedOld: dateCreatedOld == null && nullToAbsent
          ? const Value.absent()
          : Value(dateCreatedOld),
      isFavouriteOld: isFavouriteOld == null && nullToAbsent
          ? const Value.absent()
          : Value(isFavouriteOld),
    );
  }

  factory CategoriesLogData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoriesLogData(
      logId: serializer.fromJson<int>(json['log_id']),
      actionName: serializer.fromJson<String>(json['action_name']),
      actionTimestamp: serializer.fromJson<DateTime>(json['action_timestamp']),
      affectedId: serializer.fromJson<int>(json['affected_id']),
      categoryNameNew: serializer.fromJson<String?>(json['category_name_new']),
      categoryLanguageNew:
          serializer.fromJson<String?>(json['category_language_new']),
      dateCreatedNew: serializer.fromJson<DateTime?>(json['date_created_new']),
      isFavouriteNew: serializer.fromJson<bool?>(json['is_favourite_new']),
      categoryNameOld: serializer.fromJson<String?>(json['category_name_old']),
      categoryLanguageOld:
          serializer.fromJson<String?>(json['category_language_old']),
      dateCreatedOld: serializer.fromJson<DateTime?>(json['date_created_old']),
      isFavouriteOld: serializer.fromJson<bool?>(json['is_favourite_old']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'log_id': serializer.toJson<int>(logId),
      'action_name': serializer.toJson<String>(actionName),
      'action_timestamp': serializer.toJson<DateTime>(actionTimestamp),
      'affected_id': serializer.toJson<int>(affectedId),
      'category_name_new': serializer.toJson<String?>(categoryNameNew),
      'category_language_new': serializer.toJson<String?>(categoryLanguageNew),
      'date_created_new': serializer.toJson<DateTime?>(dateCreatedNew),
      'is_favourite_new': serializer.toJson<bool?>(isFavouriteNew),
      'category_name_old': serializer.toJson<String?>(categoryNameOld),
      'category_language_old': serializer.toJson<String?>(categoryLanguageOld),
      'date_created_old': serializer.toJson<DateTime?>(dateCreatedOld),
      'is_favourite_old': serializer.toJson<bool?>(isFavouriteOld),
    };
  }

  CategoriesLogData copyWith(
          {int? logId,
          String? actionName,
          DateTime? actionTimestamp,
          int? affectedId,
          Value<String?> categoryNameNew = const Value.absent(),
          Value<String?> categoryLanguageNew = const Value.absent(),
          Value<DateTime?> dateCreatedNew = const Value.absent(),
          Value<bool?> isFavouriteNew = const Value.absent(),
          Value<String?> categoryNameOld = const Value.absent(),
          Value<String?> categoryLanguageOld = const Value.absent(),
          Value<DateTime?> dateCreatedOld = const Value.absent(),
          Value<bool?> isFavouriteOld = const Value.absent()}) =>
      CategoriesLogData(
        logId: logId ?? this.logId,
        actionName: actionName ?? this.actionName,
        actionTimestamp: actionTimestamp ?? this.actionTimestamp,
        affectedId: affectedId ?? this.affectedId,
        categoryNameNew: categoryNameNew.present
            ? categoryNameNew.value
            : this.categoryNameNew,
        categoryLanguageNew: categoryLanguageNew.present
            ? categoryLanguageNew.value
            : this.categoryLanguageNew,
        dateCreatedNew:
            dateCreatedNew.present ? dateCreatedNew.value : this.dateCreatedNew,
        isFavouriteNew:
            isFavouriteNew.present ? isFavouriteNew.value : this.isFavouriteNew,
        categoryNameOld: categoryNameOld.present
            ? categoryNameOld.value
            : this.categoryNameOld,
        categoryLanguageOld: categoryLanguageOld.present
            ? categoryLanguageOld.value
            : this.categoryLanguageOld,
        dateCreatedOld:
            dateCreatedOld.present ? dateCreatedOld.value : this.dateCreatedOld,
        isFavouriteOld:
            isFavouriteOld.present ? isFavouriteOld.value : this.isFavouriteOld,
      );
  @override
  String toString() {
    return (StringBuffer('CategoriesLogData(')
          ..write('logId: $logId, ')
          ..write('actionName: $actionName, ')
          ..write('actionTimestamp: $actionTimestamp, ')
          ..write('affectedId: $affectedId, ')
          ..write('categoryNameNew: $categoryNameNew, ')
          ..write('categoryLanguageNew: $categoryLanguageNew, ')
          ..write('dateCreatedNew: $dateCreatedNew, ')
          ..write('isFavouriteNew: $isFavouriteNew, ')
          ..write('categoryNameOld: $categoryNameOld, ')
          ..write('categoryLanguageOld: $categoryLanguageOld, ')
          ..write('dateCreatedOld: $dateCreatedOld, ')
          ..write('isFavouriteOld: $isFavouriteOld')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      logId,
      actionName,
      actionTimestamp,
      affectedId,
      categoryNameNew,
      categoryLanguageNew,
      dateCreatedNew,
      isFavouriteNew,
      categoryNameOld,
      categoryLanguageOld,
      dateCreatedOld,
      isFavouriteOld);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoriesLogData &&
          other.logId == this.logId &&
          other.actionName == this.actionName &&
          other.actionTimestamp == this.actionTimestamp &&
          other.affectedId == this.affectedId &&
          other.categoryNameNew == this.categoryNameNew &&
          other.categoryLanguageNew == this.categoryLanguageNew &&
          other.dateCreatedNew == this.dateCreatedNew &&
          other.isFavouriteNew == this.isFavouriteNew &&
          other.categoryNameOld == this.categoryNameOld &&
          other.categoryLanguageOld == this.categoryLanguageOld &&
          other.dateCreatedOld == this.dateCreatedOld &&
          other.isFavouriteOld == this.isFavouriteOld);
}

class CategoriesLogCompanion extends UpdateCompanion<CategoriesLogData> {
  final Value<int> logId;
  final Value<String> actionName;
  final Value<DateTime> actionTimestamp;
  final Value<int> affectedId;
  final Value<String?> categoryNameNew;
  final Value<String?> categoryLanguageNew;
  final Value<DateTime?> dateCreatedNew;
  final Value<bool?> isFavouriteNew;
  final Value<String?> categoryNameOld;
  final Value<String?> categoryLanguageOld;
  final Value<DateTime?> dateCreatedOld;
  final Value<bool?> isFavouriteOld;
  const CategoriesLogCompanion({
    this.logId = const Value.absent(),
    this.actionName = const Value.absent(),
    this.actionTimestamp = const Value.absent(),
    this.affectedId = const Value.absent(),
    this.categoryNameNew = const Value.absent(),
    this.categoryLanguageNew = const Value.absent(),
    this.dateCreatedNew = const Value.absent(),
    this.isFavouriteNew = const Value.absent(),
    this.categoryNameOld = const Value.absent(),
    this.categoryLanguageOld = const Value.absent(),
    this.dateCreatedOld = const Value.absent(),
    this.isFavouriteOld = const Value.absent(),
  });
  CategoriesLogCompanion.insert({
    this.logId = const Value.absent(),
    required String actionName,
    this.actionTimestamp = const Value.absent(),
    required int affectedId,
    this.categoryNameNew = const Value.absent(),
    this.categoryLanguageNew = const Value.absent(),
    this.dateCreatedNew = const Value.absent(),
    this.isFavouriteNew = const Value.absent(),
    this.categoryNameOld = const Value.absent(),
    this.categoryLanguageOld = const Value.absent(),
    this.dateCreatedOld = const Value.absent(),
    this.isFavouriteOld = const Value.absent(),
  })  : actionName = Value(actionName),
        affectedId = Value(affectedId);
  static Insertable<CategoriesLogData> custom({
    Expression<int>? logId,
    Expression<String>? actionName,
    Expression<DateTime>? actionTimestamp,
    Expression<int>? affectedId,
    Expression<String>? categoryNameNew,
    Expression<String>? categoryLanguageNew,
    Expression<DateTime>? dateCreatedNew,
    Expression<bool>? isFavouriteNew,
    Expression<String>? categoryNameOld,
    Expression<String>? categoryLanguageOld,
    Expression<DateTime>? dateCreatedOld,
    Expression<bool>? isFavouriteOld,
  }) {
    return RawValuesInsertable({
      if (logId != null) 'log_id': logId,
      if (actionName != null) 'action_name': actionName,
      if (actionTimestamp != null) 'action_timestamp': actionTimestamp,
      if (affectedId != null) 'affected_id': affectedId,
      if (categoryNameNew != null) 'category_name_new': categoryNameNew,
      if (categoryLanguageNew != null)
        'category_language_new': categoryLanguageNew,
      if (dateCreatedNew != null) 'date_created_new': dateCreatedNew,
      if (isFavouriteNew != null) 'is_favourite_new': isFavouriteNew,
      if (categoryNameOld != null) 'category_name_old': categoryNameOld,
      if (categoryLanguageOld != null)
        'category_language_old': categoryLanguageOld,
      if (dateCreatedOld != null) 'date_created_old': dateCreatedOld,
      if (isFavouriteOld != null) 'is_favourite_old': isFavouriteOld,
    });
  }

  CategoriesLogCompanion copyWith(
      {Value<int>? logId,
      Value<String>? actionName,
      Value<DateTime>? actionTimestamp,
      Value<int>? affectedId,
      Value<String?>? categoryNameNew,
      Value<String?>? categoryLanguageNew,
      Value<DateTime?>? dateCreatedNew,
      Value<bool?>? isFavouriteNew,
      Value<String?>? categoryNameOld,
      Value<String?>? categoryLanguageOld,
      Value<DateTime?>? dateCreatedOld,
      Value<bool?>? isFavouriteOld}) {
    return CategoriesLogCompanion(
      logId: logId ?? this.logId,
      actionName: actionName ?? this.actionName,
      actionTimestamp: actionTimestamp ?? this.actionTimestamp,
      affectedId: affectedId ?? this.affectedId,
      categoryNameNew: categoryNameNew ?? this.categoryNameNew,
      categoryLanguageNew: categoryLanguageNew ?? this.categoryLanguageNew,
      dateCreatedNew: dateCreatedNew ?? this.dateCreatedNew,
      isFavouriteNew: isFavouriteNew ?? this.isFavouriteNew,
      categoryNameOld: categoryNameOld ?? this.categoryNameOld,
      categoryLanguageOld: categoryLanguageOld ?? this.categoryLanguageOld,
      dateCreatedOld: dateCreatedOld ?? this.dateCreatedOld,
      isFavouriteOld: isFavouriteOld ?? this.isFavouriteOld,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (logId.present) {
      map['log_id'] = Variable<int>(logId.value);
    }
    if (actionName.present) {
      map['action_name'] = Variable<String>(actionName.value);
    }
    if (actionTimestamp.present) {
      map['action_timestamp'] = Variable<DateTime>(actionTimestamp.value);
    }
    if (affectedId.present) {
      map['affected_id'] = Variable<int>(affectedId.value);
    }
    if (categoryNameNew.present) {
      map['category_name_new'] = Variable<String>(categoryNameNew.value);
    }
    if (categoryLanguageNew.present) {
      map['category_language_new'] =
          Variable<String>(categoryLanguageNew.value);
    }
    if (dateCreatedNew.present) {
      map['date_created_new'] = Variable<DateTime>(dateCreatedNew.value);
    }
    if (isFavouriteNew.present) {
      map['is_favourite_new'] = Variable<bool>(isFavouriteNew.value);
    }
    if (categoryNameOld.present) {
      map['category_name_old'] = Variable<String>(categoryNameOld.value);
    }
    if (categoryLanguageOld.present) {
      map['category_language_old'] =
          Variable<String>(categoryLanguageOld.value);
    }
    if (dateCreatedOld.present) {
      map['date_created_old'] = Variable<DateTime>(dateCreatedOld.value);
    }
    if (isFavouriteOld.present) {
      map['is_favourite_old'] = Variable<bool>(isFavouriteOld.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesLogCompanion(')
          ..write('logId: $logId, ')
          ..write('actionName: $actionName, ')
          ..write('actionTimestamp: $actionTimestamp, ')
          ..write('affectedId: $affectedId, ')
          ..write('categoryNameNew: $categoryNameNew, ')
          ..write('categoryLanguageNew: $categoryLanguageNew, ')
          ..write('dateCreatedNew: $dateCreatedNew, ')
          ..write('isFavouriteNew: $isFavouriteNew, ')
          ..write('categoryNameOld: $categoryNameOld, ')
          ..write('categoryLanguageOld: $categoryLanguageOld, ')
          ..write('dateCreatedOld: $dateCreatedOld, ')
          ..write('isFavouriteOld: $isFavouriteOld')
          ..write(')'))
        .toString();
  }
}

class CategoriesLog extends Table
    with TableInfo<CategoriesLog, CategoriesLogData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  CategoriesLog(this.attachedDatabase, [this._alias]);
  final VerificationMeta _logIdMeta = const VerificationMeta('logId');
  late final GeneratedColumn<int> logId = GeneratedColumn<int>(
      'log_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _actionNameMeta = const VerificationMeta('actionName');
  late final GeneratedColumn<String> actionName = GeneratedColumn<String>(
      'action_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _actionTimestampMeta =
      const VerificationMeta('actionTimestamp');
  late final GeneratedColumn<DateTime> actionTimestamp =
      GeneratedColumn<DateTime>('action_timestamp', aliasedName, false,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          $customConstraints: 'NOT NULL DEFAULT CURRENT_TIMESTAMP',
          defaultValue: const CustomExpression<DateTime>('CURRENT_TIMESTAMP'));
  final VerificationMeta _affectedIdMeta = const VerificationMeta('affectedId');
  late final GeneratedColumn<int> affectedId = GeneratedColumn<int>(
      'affected_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  final VerificationMeta _categoryNameNewMeta =
      const VerificationMeta('categoryNameNew');
  late final GeneratedColumn<String> categoryNameNew = GeneratedColumn<String>(
      'category_name_new', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _categoryLanguageNewMeta =
      const VerificationMeta('categoryLanguageNew');
  late final GeneratedColumn<String> categoryLanguageNew =
      GeneratedColumn<String>('category_language_new', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          $customConstraints: '');
  final VerificationMeta _dateCreatedNewMeta =
      const VerificationMeta('dateCreatedNew');
  late final GeneratedColumn<DateTime> dateCreatedNew =
      GeneratedColumn<DateTime>('date_created_new', aliasedName, true,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          $customConstraints: '');
  final VerificationMeta _isFavouriteNewMeta =
      const VerificationMeta('isFavouriteNew');
  late final GeneratedColumn<bool> isFavouriteNew = GeneratedColumn<bool>(
      'is_favourite_new', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _categoryNameOldMeta =
      const VerificationMeta('categoryNameOld');
  late final GeneratedColumn<String> categoryNameOld = GeneratedColumn<String>(
      'category_name_old', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _categoryLanguageOldMeta =
      const VerificationMeta('categoryLanguageOld');
  late final GeneratedColumn<String> categoryLanguageOld =
      GeneratedColumn<String>('category_language_old', aliasedName, true,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          $customConstraints: '');
  final VerificationMeta _dateCreatedOldMeta =
      const VerificationMeta('dateCreatedOld');
  late final GeneratedColumn<DateTime> dateCreatedOld =
      GeneratedColumn<DateTime>('date_created_old', aliasedName, true,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          $customConstraints: '');
  final VerificationMeta _isFavouriteOldMeta =
      const VerificationMeta('isFavouriteOld');
  late final GeneratedColumn<bool> isFavouriteOld = GeneratedColumn<bool>(
      'is_favourite_old', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [
        logId,
        actionName,
        actionTimestamp,
        affectedId,
        categoryNameNew,
        categoryLanguageNew,
        dateCreatedNew,
        isFavouriteNew,
        categoryNameOld,
        categoryLanguageOld,
        dateCreatedOld,
        isFavouriteOld
      ];
  @override
  String get aliasedName => _alias ?? 'categories_log';
  @override
  String get actualTableName => 'categories_log';
  @override
  VerificationContext validateIntegrity(Insertable<CategoriesLogData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('log_id')) {
      context.handle(
          _logIdMeta, logId.isAcceptableOrUnknown(data['log_id']!, _logIdMeta));
    }
    if (data.containsKey('action_name')) {
      context.handle(
          _actionNameMeta,
          actionName.isAcceptableOrUnknown(
              data['action_name']!, _actionNameMeta));
    } else if (isInserting) {
      context.missing(_actionNameMeta);
    }
    if (data.containsKey('action_timestamp')) {
      context.handle(
          _actionTimestampMeta,
          actionTimestamp.isAcceptableOrUnknown(
              data['action_timestamp']!, _actionTimestampMeta));
    }
    if (data.containsKey('affected_id')) {
      context.handle(
          _affectedIdMeta,
          affectedId.isAcceptableOrUnknown(
              data['affected_id']!, _affectedIdMeta));
    } else if (isInserting) {
      context.missing(_affectedIdMeta);
    }
    if (data.containsKey('category_name_new')) {
      context.handle(
          _categoryNameNewMeta,
          categoryNameNew.isAcceptableOrUnknown(
              data['category_name_new']!, _categoryNameNewMeta));
    }
    if (data.containsKey('category_language_new')) {
      context.handle(
          _categoryLanguageNewMeta,
          categoryLanguageNew.isAcceptableOrUnknown(
              data['category_language_new']!, _categoryLanguageNewMeta));
    }
    if (data.containsKey('date_created_new')) {
      context.handle(
          _dateCreatedNewMeta,
          dateCreatedNew.isAcceptableOrUnknown(
              data['date_created_new']!, _dateCreatedNewMeta));
    }
    if (data.containsKey('is_favourite_new')) {
      context.handle(
          _isFavouriteNewMeta,
          isFavouriteNew.isAcceptableOrUnknown(
              data['is_favourite_new']!, _isFavouriteNewMeta));
    }
    if (data.containsKey('category_name_old')) {
      context.handle(
          _categoryNameOldMeta,
          categoryNameOld.isAcceptableOrUnknown(
              data['category_name_old']!, _categoryNameOldMeta));
    }
    if (data.containsKey('category_language_old')) {
      context.handle(
          _categoryLanguageOldMeta,
          categoryLanguageOld.isAcceptableOrUnknown(
              data['category_language_old']!, _categoryLanguageOldMeta));
    }
    if (data.containsKey('date_created_old')) {
      context.handle(
          _dateCreatedOldMeta,
          dateCreatedOld.isAcceptableOrUnknown(
              data['date_created_old']!, _dateCreatedOldMeta));
    }
    if (data.containsKey('is_favourite_old')) {
      context.handle(
          _isFavouriteOldMeta,
          isFavouriteOld.isAcceptableOrUnknown(
              data['is_favourite_old']!, _isFavouriteOldMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {logId};
  @override
  CategoriesLogData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoriesLogData(
      logId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}log_id'])!,
      actionName: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}action_name'])!,
      actionTimestamp: attachedDatabase.options.types.read(
          DriftSqlType.dateTime, data['${effectivePrefix}action_timestamp'])!,
      affectedId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}affected_id'])!,
      categoryNameNew: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}category_name_new']),
      categoryLanguageNew: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}category_language_new']),
      dateCreatedNew: attachedDatabase.options.types.read(
          DriftSqlType.dateTime, data['${effectivePrefix}date_created_new']),
      isFavouriteNew: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favourite_new']),
      categoryNameOld: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}category_name_old']),
      categoryLanguageOld: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}category_language_old']),
      dateCreatedOld: attachedDatabase.options.types.read(
          DriftSqlType.dateTime, data['${effectivePrefix}date_created_old']),
      isFavouriteOld: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favourite_old']),
    );
  }

  @override
  CategoriesLog createAlias(String alias) {
    return CategoriesLog(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  late final Weekdays weekdays = Weekdays(this);
  late final WeekdaysLog weekdaysLog = WeekdaysLog(this);
  late final Trigger afterWeekdaysInsert = Trigger(
      'CREATE TRIGGER after_weekdays_insert AFTER INSERT ON weekdays BEGIN INSERT INTO weekdays_log (action_name, affected_id, name_of_day_new, last_date_occurred_new, right_answers_new, wrong_answers_new) VALUES (\'INSERT\', NEW.day_of_week, NEW.name_of_day, NEW.last_date_occurred, NEW.right_answers, NEW.wrong_answers);END',
      'after_weekdays_insert');
  late final Trigger afterWeekdaysUpdate = Trigger(
      'CREATE TRIGGER after_weekdays_update AFTER UPDATE ON weekdays BEGIN INSERT INTO weekdays_log (action_name, affected_id, name_of_day_new, last_date_occurred_new, right_answers_new, wrong_answers_new, name_of_day_old, last_date_occurred_old, right_answers_old, wrong_answers_old) VALUES (\'UPDATE\', NEW.day_of_week, NEW.name_of_day, NEW.last_date_occurred, NEW.right_answers, NEW.wrong_answers, OLD.name_of_day, OLD.last_date_occurred, OLD.right_answers, OLD.wrong_answers);END',
      'after_weekdays_update');
  late final Trigger afterWeekdaysDelete = Trigger(
      'CREATE TRIGGER after_weekdays_delete AFTER DELETE ON weekdays BEGIN INSERT INTO weekdays_log (action_name, affected_id, name_of_day_old, last_date_occurred_old, right_answers_old, wrong_answers_old) VALUES (\'DELETE\', OLD.day_of_week, OLD.name_of_day, OLD.last_date_occurred, OLD.right_answers, OLD.wrong_answers);END',
      'after_weekdays_delete');
  late final Categories categories = Categories(this);
  late final Vocabularies vocabularies = Vocabularies(this);
  late final VocabulariesLog vocabulariesLog = VocabulariesLog(this);
  late final Trigger afterVocabulariesInsert = Trigger(
      'CREATE TRIGGER after_vocabularies_insert AFTER INSERT ON vocabularies BEGIN INSERT INTO vocabularies_log (action_name, affected_id, voc_local_new, voc_foreign_new, category_id_new, date_created_new, is_favourite_new, date_last_answered_new, right_answers_new, wrong_answers_new) VALUES (\'INSERT\', NEW.id, NEW.voc_local, NEW.voc_foreign, NEW.category_id, NEW.date_created, NEW.is_favourite, NEW.date_last_answered, NEW.right_answers, NEW.wrong_answers);END',
      'after_vocabularies_insert');
  late final Trigger afterVocabulariesUpdate = Trigger(
      'CREATE TRIGGER after_vocabularies_update AFTER UPDATE ON vocabularies BEGIN INSERT INTO vocabularies_log (action_name, affected_id, voc_local_new, voc_foreign_new, category_id_new, date_created_new, is_favourite_new, date_last_answered_new, right_answers_new, wrong_answers_new, voc_local_old, voc_foreign_old, category_id_old, date_created_old, is_favourite_old, date_last_answered_old, right_answers_old, wrong_answers_old) VALUES (\'UPDATE\', NEW.id, NEW.voc_local, NEW.voc_foreign, NEW.category_id, NEW.date_created, NEW.is_favourite, NEW.date_last_answered, NEW.right_answers, NEW.wrong_answers, OLD.voc_local, OLD.voc_foreign, OLD.category_id, OLD.date_created, OLD.is_favourite, OLD.date_last_answered, OLD.right_answers, OLD.wrong_answers);END',
      'after_vocabularies_update');
  late final Trigger afterVocabulariesDelete = Trigger(
      'CREATE TRIGGER after_vocabularies_delete AFTER DELETE ON vocabularies BEGIN INSERT INTO vocabularies_log (action_name, affected_id, voc_local_old, voc_foreign_old, category_id_old, date_created_old, is_favourite_old, date_last_answered_old, right_answers_old, wrong_answers_old) VALUES (\'DELETE\', OLD.id, OLD.voc_local, OLD.voc_foreign, OLD.category_id, OLD.date_created, OLD.is_favourite, OLD.date_last_answered, OLD.right_answers, OLD.wrong_answers);END',
      'after_vocabularies_delete');
  late final Index catLang = Index('cat_lang',
      'CREATE INDEX IF NOT EXISTS cat_lang ON categories (category_language)');
  late final CategoriesLog categoriesLog = CategoriesLog(this);
  late final Trigger afterCategoryInsert = Trigger(
      'CREATE TRIGGER after_category_insert AFTER INSERT ON categories BEGIN INSERT INTO categories_log (action_name, affected_id, category_name_new, category_language_new, date_created_new, is_favourite_new) VALUES (\'INSERT\', NEW.id, NEW.category_name, NEW.category_language, NEW.date_created, NEW.is_favourite);END',
      'after_category_insert');
  late final Trigger afterCategoryUpdate = Trigger(
      'CREATE TRIGGER after_category_update AFTER UPDATE ON categories BEGIN INSERT INTO categories_log (action_name, affected_id, category_name_new, category_language_new, date_created_new, is_favourite_new, category_name_old, category_language_old, date_created_old, is_favourite_old) VALUES (\'UPDATE\', NEW.id, NEW.category_name, NEW.category_language, NEW.date_created, NEW.is_favourite, OLD.category_name, OLD.category_language, OLD.date_created, OLD.is_favourite);END',
      'after_category_update');
  late final Trigger afterCategoryDelete = Trigger(
      'CREATE TRIGGER after_category_delete AFTER DELETE ON categories BEGIN INSERT INTO categories_log (action_name, affected_id, category_name_old, category_language_old, date_created_old, is_favourite_old) VALUES (\'DELETE\', OLD.id, OLD.category_name, OLD.category_language, OLD.date_created, OLD.is_favourite);DELETE FROM vocabularies WHERE vocabularies.category_id = OLD.id;END',
      'after_category_delete');
  Selectable<AllVocabulariesResult> allVocabularies() {
    return customSelect(
        'SELECT v.*, c.category_name, c.category_language, CASE WHEN v.right_answers > v.wrong_answers THEN TRUE ELSE FALSE END AS is_learned FROM vocabularies AS v INNER JOIN categories AS c ON v.category_id = c.id',
        variables: [],
        readsFrom: {
          categories,
          vocabularies,
        }).map((QueryRow row) {
      return AllVocabulariesResult(
        id: row.read<int>('id'),
        vocLocal: row.read<String>('voc_local'),
        vocForeign: row.read<String>('voc_foreign'),
        categoryId: row.read<int>('category_id'),
        dateCreated: row.read<DateTime>('date_created'),
        isFavourite: row.read<bool>('is_favourite'),
        dateLastAnswered: row.readNullable<DateTime>('date_last_answered'),
        rightAnswers: row.read<int>('right_answers'),
        wrongAnswers: row.read<int>('wrong_answers'),
        categoryName: row.read<String>('category_name'),
        categoryLanguage: row.read<String>('category_language'),
        isLearned: row.read<bool>('is_learned'),
      );
    });
  }

  Selectable<Vocabulary> allCategoryVocabularies(int targetCategoryId) {
    return customSelect(
        'SELECT * FROM vocabularies AS v WHERE v.category_id = ?1',
        variables: [
          Variable<int>(targetCategoryId)
        ],
        readsFrom: {
          vocabularies,
        }).asyncMap(vocabularies.mapFromRow);
  }

  Selectable<CategoryLearnInfoResult> categoryLearnInfo(int targetCategoryId) {
    return customSelect(
        'SELECT COUNT(is_learned) AS category_vocabs_total, SUM(is_learned) AS amount_learned FROM (SELECT CASE WHEN right_answers > wrong_answers THEN 1 ELSE 0 END AS is_learned FROM vocabularies WHERE category_id = ?1) LIMIT 1',
        variables: [
          Variable<int>(targetCategoryId)
        ],
        readsFrom: {
          vocabularies,
        }).map((QueryRow row) {
      return CategoryLearnInfoResult(
        categoryVocabsTotal: row.read<int>('category_vocabs_total'),
        amountLearned: row.read<int>('amount_learned'),
      );
    });
  }

  Future<int> createVocabulary(
      String vocLocal, String vocForeign, int categoryId, bool isFavourite) {
    return customInsert(
      'INSERT INTO vocabularies (voc_local, voc_foreign, category_id, is_favourite) VALUES (?1, ?2, ?3, ?4)',
      variables: [
        Variable<String>(vocLocal),
        Variable<String>(vocForeign),
        Variable<int>(categoryId),
        Variable<bool>(isFavourite)
      ],
      updates: {vocabularies},
    );
  }

  Future<int> addRightAnswer(int targetId) {
    return customUpdate(
      'UPDATE vocabularies SET right_answers = right_answers + 1, date_last_answered = CURRENT_TIMESTAMP WHERE id = ?1',
      variables: [Variable<int>(targetId)],
      updates: {vocabularies},
      updateKind: UpdateKind.update,
    );
  }

  Future<int> addWrongAnswer(int targetId) {
    return customUpdate(
      'UPDATE vocabularies SET wrong_answers = wrong_answers + 1, date_last_answered = CURRENT_TIMESTAMP WHERE id = ?1',
      variables: [Variable<int>(targetId)],
      updates: {vocabularies},
      updateKind: UpdateKind.update,
    );
  }

  Future<int> changeVocLocal(String vocLocalNew, int targetId) {
    return customUpdate(
      'UPDATE vocabularies SET voc_local = ?1 WHERE id = ?2',
      variables: [Variable<String>(vocLocalNew), Variable<int>(targetId)],
      updates: {vocabularies},
      updateKind: UpdateKind.update,
    );
  }

  Future<int> changeVocForeign(String vocForeignNew, int targetId) {
    return customUpdate(
      'UPDATE vocabularies SET voc_foreign = ?1 WHERE id = ?2',
      variables: [Variable<String>(vocForeignNew), Variable<int>(targetId)],
      updates: {vocabularies},
      updateKind: UpdateKind.update,
    );
  }

  Future<int> toggleFavouriteStatus(int targetId) {
    return customUpdate(
      'UPDATE vocabularies SET is_favourite = NOT is_favourite WHERE id = ?1',
      variables: [Variable<int>(targetId)],
      updates: {vocabularies},
      updateKind: UpdateKind.update,
    );
  }

  Future<int> deleteVocabulary(int targetId) {
    return customUpdate(
      'DELETE FROM vocabularies WHERE id = ?1',
      variables: [Variable<int>(targetId)],
      updates: {vocabularies},
      updateKind: UpdateKind.delete,
    );
  }

  Selectable<Category> allCategories() {
    return customSelect('SELECT * FROM categories', variables: [], readsFrom: {
      categories,
    }).asyncMap(categories.mapFromRow);
  }

  Selectable<Category> allCategoriesWithLang(String targetLanguage) {
    return customSelect('SELECT * FROM categories WHERE category_language = ?1',
        variables: [
          Variable<String>(targetLanguage)
        ],
        readsFrom: {
          categories,
        }).asyncMap(categories.mapFromRow);
  }

  Selectable<AllCategoryDataResult> allCategoryData() {
    return customSelect(
        'SELECT id, category_name, category_language, is_favourite FROM categories',
        variables: [],
        readsFrom: {
          categories,
        }).map((QueryRow row) {
      return AllCategoryDataResult(
        id: row.read<int>('id'),
        categoryName: row.read<String>('category_name'),
        categoryLanguage: row.read<String>('category_language'),
        isFavourite: row.read<bool>('is_favourite'),
      );
    });
  }

  Selectable<Category> categoryWithId(int targetId) {
    return customSelect('SELECT * FROM categories WHERE id = ?1', variables: [
      Variable<int>(targetId)
    ], readsFrom: {
      categories,
    }).asyncMap(categories.mapFromRow);
  }

  Selectable<Category> lastlyInsertedCategory() {
    return customSelect('SELECT * FROM categories ORDER BY id DESC LIMIT 1',
        variables: [],
        readsFrom: {
          categories,
        }).asyncMap(categories.mapFromRow);
  }

  Future<int> createCategory(String categoryName, String language) {
    return customInsert(
      'INSERT INTO categories (category_name, category_language) VALUES (?1, ?2)',
      variables: [Variable<String>(categoryName), Variable<String>(language)],
      updates: {categories},
    );
  }

  Future<int> renameCategory(String newCategoryName, int id) {
    return customUpdate(
      'UPDATE categories SET category_name = ?1 WHERE id = ?2',
      variables: [Variable<String>(newCategoryName), Variable<int>(id)],
      updates: {categories},
      updateKind: UpdateKind.update,
    );
  }

  Future<int> deleteCategory(int targetId) {
    return customUpdate(
      'DELETE FROM categories WHERE id = ?1',
      variables: [Variable<int>(targetId)],
      updates: {categories},
      updateKind: UpdateKind.delete,
    );
  }

  Selectable<CategoriesLogData> fullLog() {
    return customSelect('SELECT * FROM categories_log',
        variables: [],
        readsFrom: {
          categoriesLog,
        }).asyncMap(categoriesLog.mapFromRow);
  }

  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        weekdays,
        weekdaysLog,
        afterWeekdaysInsert,
        afterWeekdaysUpdate,
        afterWeekdaysDelete,
        categories,
        vocabularies,
        vocabulariesLog,
        afterVocabulariesInsert,
        afterVocabulariesUpdate,
        afterVocabulariesDelete,
        catLang,
        categoriesLog,
        afterCategoryInsert,
        afterCategoryUpdate,
        afterCategoryDelete
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('weekdays',
                limitUpdateKind: UpdateKind.insert),
            result: [
              TableUpdate('weekdays_log', kind: UpdateKind.insert),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('weekdays',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('weekdays_log', kind: UpdateKind.insert),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('weekdays',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('weekdays_log', kind: UpdateKind.insert),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('vocabularies',
                limitUpdateKind: UpdateKind.insert),
            result: [
              TableUpdate('vocabularies_log', kind: UpdateKind.insert),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('vocabularies',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('vocabularies_log', kind: UpdateKind.insert),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('vocabularies',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('vocabularies_log', kind: UpdateKind.insert),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('categories',
                limitUpdateKind: UpdateKind.insert),
            result: [
              TableUpdate('categories_log', kind: UpdateKind.insert),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('categories',
                limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('categories_log', kind: UpdateKind.insert),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('categories',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('categories_log', kind: UpdateKind.insert),
              TableUpdate('vocabularies', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

class AllVocabulariesResult {
  final int id;
  final String vocLocal;
  final String vocForeign;
  final int categoryId;
  final DateTime dateCreated;
  final bool isFavourite;
  final DateTime? dateLastAnswered;
  final int rightAnswers;
  final int wrongAnswers;
  final String categoryName;
  final String categoryLanguage;
  final bool isLearned;
  AllVocabulariesResult({
    required this.id,
    required this.vocLocal,
    required this.vocForeign,
    required this.categoryId,
    required this.dateCreated,
    required this.isFavourite,
    this.dateLastAnswered,
    required this.rightAnswers,
    required this.wrongAnswers,
    required this.categoryName,
    required this.categoryLanguage,
    required this.isLearned,
  });
}

class CategoryLearnInfoResult {
  final int categoryVocabsTotal;
  final int amountLearned;
  CategoryLearnInfoResult({
    required this.categoryVocabsTotal,
    required this.amountLearned,
  });
}

class AllCategoryDataResult {
  final int id;
  final String categoryName;
  final String categoryLanguage;
  final bool isFavourite;
  AllCategoryDataResult({
    required this.id,
    required this.categoryName,
    required this.categoryLanguage,
    required this.isFavourite,
  });
}

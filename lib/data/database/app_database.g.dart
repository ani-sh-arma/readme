// GENERATED CODE - DO NOT MODIFY BY HAND
// Run `dart run build_runner build` to regenerate.

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BooksTable extends Books with TableInfo<$BooksTable, Book> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BooksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
    'author',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Unknown'),
  );
  static const VerificationMeta _filePathMeta = const VerificationMeta('filePath');
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coverPathMeta = const VerificationMeta('coverPath');
  @override
  late final GeneratedColumn<String> coverPath = GeneratedColumn<String>(
    'cover_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _formatMeta = const VerificationMeta('format');
  @override
  late final GeneratedColumn<String> format = GeneratedColumn<String>(
    'format',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('unknown'),
  );
  static const VerificationMeta _dateAddedMeta = const VerificationMeta('dateAdded');
  @override
  late final GeneratedColumn<DateTime> dateAdded = GeneratedColumn<DateTime>(
    'date_added',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _lastOpenedAtMeta = const VerificationMeta('lastOpenedAt');
  @override
  late final GeneratedColumn<DateTime> lastOpenedAt = GeneratedColumn<DateTime>(
    'last_opened_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalPagesMeta = const VerificationMeta('totalPages');
  @override
  late final GeneratedColumn<int> totalPages = GeneratedColumn<int>(
    'total_pages',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _currentPositionMeta = const VerificationMeta('currentPosition');
  @override
  late final GeneratedColumn<String> currentPosition = GeneratedColumn<String>(
    'current_position',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("is_favorite" IN (0, 1))'),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isReadMeta = const VerificationMeta('isRead');
  @override
  late final GeneratedColumn<bool> isRead = GeneratedColumn<bool>(
    'is_read',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("is_read" IN (0, 1))'),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isInReadListMeta = const VerificationMeta('isInReadList');
  @override
  late final GeneratedColumn<bool> isInReadList = GeneratedColumn<bool>(
    'is_in_read_list',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("is_in_read_list" IN (0, 1))'),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<double> rating = GeneratedColumn<double>(
    'rating',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fileSizeMeta = const VerificationMeta('fileSize');
  @override
  late final GeneratedColumn<int> fileSize = GeneratedColumn<int>(
    'file_size',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _genreMeta = const VerificationMeta('genre');
  @override
  late final GeneratedColumn<String> genre = GeneratedColumn<String>(
    'genre',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );

  @override
  List<GeneratedColumn> get $columns => [
    id, title, author, filePath, coverPath, format, dateAdded,
    lastOpenedAt, totalPages, currentPosition, isFavorite, isRead,
    isInReadList, rating, fileSize, genre,
  ];

  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => r'books';

  @override
  VerificationContext validateIntegrity(Insertable<Book> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    if (data.containsKey('title')) context.handle(_titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    else if (isInserting) context.missing(_titleMeta);
    if (data.containsKey('author')) context.handle(_authorMeta, author.isAcceptableOrUnknown(data['author']!, _authorMeta));
    if (data.containsKey('file_path')) context.handle(_filePathMeta, filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta));
    else if (isInserting) context.missing(_filePathMeta);
    if (data.containsKey('cover_path')) context.handle(_coverPathMeta, coverPath.isAcceptableOrUnknown(data['cover_path']!, _coverPathMeta));
    if (data.containsKey('format')) context.handle(_formatMeta, format.isAcceptableOrUnknown(data['format']!, _formatMeta));
    if (data.containsKey('date_added')) context.handle(_dateAddedMeta, dateAdded.isAcceptableOrUnknown(data['date_added']!, _dateAddedMeta));
    if (data.containsKey('last_opened_at')) context.handle(_lastOpenedAtMeta, lastOpenedAt.isAcceptableOrUnknown(data['last_opened_at']!, _lastOpenedAtMeta));
    if (data.containsKey('total_pages')) context.handle(_totalPagesMeta, totalPages.isAcceptableOrUnknown(data['total_pages']!, _totalPagesMeta));
    if (data.containsKey('current_position')) context.handle(_currentPositionMeta, currentPosition.isAcceptableOrUnknown(data['current_position']!, _currentPositionMeta));
    if (data.containsKey('is_favorite')) context.handle(_isFavoriteMeta, isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta));
    if (data.containsKey('is_read')) context.handle(_isReadMeta, isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta));
    if (data.containsKey('is_in_read_list')) context.handle(_isInReadListMeta, isInReadList.isAcceptableOrUnknown(data['is_in_read_list']!, _isInReadListMeta));
    if (data.containsKey('rating')) context.handle(_ratingMeta, rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta));
    if (data.containsKey('file_size')) context.handle(_fileSizeMeta, fileSize.isAcceptableOrUnknown(data['file_size']!, _fileSizeMeta));
    if (data.containsKey('genre')) context.handle(_genreMeta, genre.isAcceptableOrUnknown(data['genre']!, _genreMeta));
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};

  @override
  Book map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Book(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      author: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}author'])!,
      filePath: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}file_path'])!,
      coverPath: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}cover_path']),
      format: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}format'])!,
      dateAdded: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}date_added'])!,
      lastOpenedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}last_opened_at']),
      totalPages: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}total_pages'])!,
      currentPosition: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}current_position'])!,
      isFavorite: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
      isRead: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}is_read'])!,
      isInReadList: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}is_in_read_list'])!,
      rating: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}rating']),
      fileSize: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}file_size'])!,
      genre: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}genre']),
    );
  }

  @override
  $BooksTable createAlias(String alias) {
    return $BooksTable(attachedDatabase, alias);
  }
}

class Book extends DataClass implements Insertable<Book> {
  final int id;
  final String title;
  final String author;
  final String filePath;
  final String? coverPath;
  final String format;
  final DateTime dateAdded;
  final DateTime? lastOpenedAt;
  final int totalPages;
  final String currentPosition;
  final bool isFavorite;
  final bool isRead;
  final bool isInReadList;
  final double? rating;
  final int fileSize;
  final String? genre;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.filePath,
    this.coverPath,
    required this.format,
    required this.dateAdded,
    this.lastOpenedAt,
    required this.totalPages,
    required this.currentPosition,
    required this.isFavorite,
    required this.isRead,
    required this.isInReadList,
    this.rating,
    required this.fileSize,
    this.genre,
  });

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['author'] = Variable<String>(author);
    map['file_path'] = Variable<String>(filePath);
    if (!nullToAbsent || coverPath != null) map['cover_path'] = Variable<String>(coverPath);
    map['format'] = Variable<String>(format);
    map['date_added'] = Variable<DateTime>(dateAdded);
    if (!nullToAbsent || lastOpenedAt != null) map['last_opened_at'] = Variable<DateTime>(lastOpenedAt);
    map['total_pages'] = Variable<int>(totalPages);
    map['current_position'] = Variable<String>(currentPosition);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['is_read'] = Variable<bool>(isRead);
    map['is_in_read_list'] = Variable<bool>(isInReadList);
    if (!nullToAbsent || rating != null) map['rating'] = Variable<double>(rating);
    map['file_size'] = Variable<int>(fileSize);
    if (!nullToAbsent || genre != null) map['genre'] = Variable<String>(genre);
    return map;
  }

  BooksCompanion toCompanion(bool nullToAbsent) {
    return BooksCompanion(
      id: Value(id),
      title: Value(title),
      author: Value(author),
      filePath: Value(filePath),
      coverPath: coverPath == null && nullToAbsent ? const Value.absent() : Value(coverPath),
      format: Value(format),
      dateAdded: Value(dateAdded),
      lastOpenedAt: lastOpenedAt == null && nullToAbsent ? const Value.absent() : Value(lastOpenedAt),
      totalPages: Value(totalPages),
      currentPosition: Value(currentPosition),
      isFavorite: Value(isFavorite),
      isRead: Value(isRead),
      isInReadList: Value(isInReadList),
      rating: rating == null && nullToAbsent ? const Value.absent() : Value(rating),
      fileSize: Value(fileSize),
      genre: genre == null && nullToAbsent ? const Value.absent() : Value(genre),
    );
  }

  factory Book.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Book(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      author: serializer.fromJson<String>(json['author']),
      filePath: serializer.fromJson<String>(json['filePath']),
      coverPath: serializer.fromJson<String?>(json['coverPath']),
      format: serializer.fromJson<String>(json['format']),
      dateAdded: serializer.fromJson<DateTime>(json['dateAdded']),
      lastOpenedAt: serializer.fromJson<DateTime?>(json['lastOpenedAt']),
      totalPages: serializer.fromJson<int>(json['totalPages']),
      currentPosition: serializer.fromJson<String>(json['currentPosition']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      isRead: serializer.fromJson<bool>(json['isRead']),
      isInReadList: serializer.fromJson<bool>(json['isInReadList']),
      rating: serializer.fromJson<double?>(json['rating']),
      fileSize: serializer.fromJson<int>(json['fileSize']),
      genre: serializer.fromJson<String?>(json['genre']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'author': serializer.toJson<String>(author),
      'filePath': serializer.toJson<String>(filePath),
      'coverPath': serializer.toJson<String?>(coverPath),
      'format': serializer.toJson<String>(format),
      'dateAdded': serializer.toJson<DateTime>(dateAdded),
      'lastOpenedAt': serializer.toJson<DateTime?>(lastOpenedAt),
      'totalPages': serializer.toJson<int>(totalPages),
      'currentPosition': serializer.toJson<String>(currentPosition),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'isRead': serializer.toJson<bool>(isRead),
      'isInReadList': serializer.toJson<bool>(isInReadList),
      'rating': serializer.toJson<double?>(rating),
      'fileSize': serializer.toJson<int>(fileSize),
      'genre': serializer.toJson<String?>(genre),
    };
  }

  Book copyWith({
    int? id,
    String? title,
    String? author,
    String? filePath,
    Value<String?> coverPath = const Value.absent(),
    String? format,
    DateTime? dateAdded,
    Value<DateTime?> lastOpenedAt = const Value.absent(),
    int? totalPages,
    String? currentPosition,
    bool? isFavorite,
    bool? isRead,
    bool? isInReadList,
    Value<double?> rating = const Value.absent(),
    int? fileSize,
    Value<String?> genre = const Value.absent(),
  }) => Book(
    id: id ?? this.id,
    title: title ?? this.title,
    author: author ?? this.author,
    filePath: filePath ?? this.filePath,
    coverPath: coverPath.present ? coverPath.value : this.coverPath,
    format: format ?? this.format,
    dateAdded: dateAdded ?? this.dateAdded,
    lastOpenedAt: lastOpenedAt.present ? lastOpenedAt.value : this.lastOpenedAt,
    totalPages: totalPages ?? this.totalPages,
    currentPosition: currentPosition ?? this.currentPosition,
    isFavorite: isFavorite ?? this.isFavorite,
    isRead: isRead ?? this.isRead,
    isInReadList: isInReadList ?? this.isInReadList,
    rating: rating.present ? rating.value : this.rating,
    fileSize: fileSize ?? this.fileSize,
    genre: genre.present ? genre.value : this.genre,
  );

  @override
  String toString() {
    return (StringBuffer('Book(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('filePath: $filePath, ')
          ..write('coverPath: $coverPath, ')
          ..write('format: $format, ')
          ..write('dateAdded: $dateAdded, ')
          ..write('lastOpenedAt: $lastOpenedAt, ')
          ..write('totalPages: $totalPages, ')
          ..write('currentPosition: $currentPosition, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isRead: $isRead, ')
          ..write('isInReadList: $isInReadList, ')
          ..write('rating: $rating, ')
          ..write('fileSize: $fileSize, ')
          ..write('genre: $genre')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id, title, author, filePath, coverPath, format, dateAdded,
    lastOpenedAt, totalPages, currentPosition, isFavorite, isRead,
    isInReadList, rating, fileSize, genre,
  );

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    (other is Book &&
      other.id == id &&
      other.title == title &&
      other.author == author &&
      other.filePath == filePath &&
      other.coverPath == coverPath &&
      other.format == format &&
      other.dateAdded == dateAdded &&
      other.lastOpenedAt == lastOpenedAt &&
      other.totalPages == totalPages &&
      other.currentPosition == currentPosition &&
      other.isFavorite == isFavorite &&
      other.isRead == isRead &&
      other.isInReadList == isInReadList &&
      other.rating == rating &&
      other.fileSize == fileSize &&
      other.genre == genre);
}

class BooksCompanion extends UpdateCompanion<Book> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> author;
  final Value<String> filePath;
  final Value<String?> coverPath;
  final Value<String> format;
  final Value<DateTime> dateAdded;
  final Value<DateTime?> lastOpenedAt;
  final Value<int> totalPages;
  final Value<String> currentPosition;
  final Value<bool> isFavorite;
  final Value<bool> isRead;
  final Value<bool> isInReadList;
  final Value<double?> rating;
  final Value<int> fileSize;
  final Value<String?> genre;
  final Value<int> rowid;

  const BooksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.author = const Value.absent(),
    this.filePath = const Value.absent(),
    this.coverPath = const Value.absent(),
    this.format = const Value.absent(),
    this.dateAdded = const Value.absent(),
    this.lastOpenedAt = const Value.absent(),
    this.totalPages = const Value.absent(),
    this.currentPosition = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.isRead = const Value.absent(),
    this.isInReadList = const Value.absent(),
    this.rating = const Value.absent(),
    this.fileSize = const Value.absent(),
    this.genre = const Value.absent(),
    this.rowid = const Value.absent(),
  });

  BooksCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.author = const Value.absent(),
    required String filePath,
    this.coverPath = const Value.absent(),
    this.format = const Value.absent(),
    this.dateAdded = const Value.absent(),
    this.lastOpenedAt = const Value.absent(),
    this.totalPages = const Value.absent(),
    this.currentPosition = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.isRead = const Value.absent(),
    this.isInReadList = const Value.absent(),
    this.rating = const Value.absent(),
    this.fileSize = const Value.absent(),
    this.genre = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : title = Value(title),
        filePath = Value(filePath);

  static Insertable<Book> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? author,
    Expression<String>? filePath,
    Expression<String>? coverPath,
    Expression<String>? format,
    Expression<DateTime>? dateAdded,
    Expression<DateTime>? lastOpenedAt,
    Expression<int>? totalPages,
    Expression<String>? currentPosition,
    Expression<bool>? isFavorite,
    Expression<bool>? isRead,
    Expression<bool>? isInReadList,
    Expression<double>? rating,
    Expression<int>? fileSize,
    Expression<String>? genre,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (author != null) 'author': author,
      if (filePath != null) 'file_path': filePath,
      if (coverPath != null) 'cover_path': coverPath,
      if (format != null) 'format': format,
      if (dateAdded != null) 'date_added': dateAdded,
      if (lastOpenedAt != null) 'last_opened_at': lastOpenedAt,
      if (totalPages != null) 'total_pages': totalPages,
      if (currentPosition != null) 'current_position': currentPosition,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (isRead != null) 'is_read': isRead,
      if (isInReadList != null) 'is_in_read_list': isInReadList,
      if (rating != null) 'rating': rating,
      if (fileSize != null) 'file_size': fileSize,
      if (genre != null) 'genre': genre,
    });
  }

  BooksCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? author,
    Value<String>? filePath,
    Value<String?>? coverPath,
    Value<String>? format,
    Value<DateTime>? dateAdded,
    Value<DateTime?>? lastOpenedAt,
    Value<int>? totalPages,
    Value<String>? currentPosition,
    Value<bool>? isFavorite,
    Value<bool>? isRead,
    Value<bool>? isInReadList,
    Value<double?>? rating,
    Value<int>? fileSize,
    Value<String?>? genre,
    Value<int>? rowid,
  }) {
    return BooksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      filePath: filePath ?? this.filePath,
      coverPath: coverPath ?? this.coverPath,
      format: format ?? this.format,
      dateAdded: dateAdded ?? this.dateAdded,
      lastOpenedAt: lastOpenedAt ?? this.lastOpenedAt,
      totalPages: totalPages ?? this.totalPages,
      currentPosition: currentPosition ?? this.currentPosition,
      isFavorite: isFavorite ?? this.isFavorite,
      isRead: isRead ?? this.isRead,
      isInReadList: isInReadList ?? this.isInReadList,
      rating: rating ?? this.rating,
      fileSize: fileSize ?? this.fileSize,
      genre: genre ?? this.genre,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) map['id'] = Variable<int>(id.value);
    if (title.present) map['title'] = Variable<String>(title.value);
    if (author.present) map['author'] = Variable<String>(author.value);
    if (filePath.present) map['file_path'] = Variable<String>(filePath.value);
    if (coverPath.present) map['cover_path'] = Variable<String>(coverPath.value);
    if (format.present) map['format'] = Variable<String>(format.value);
    if (dateAdded.present) map['date_added'] = Variable<DateTime>(dateAdded.value);
    if (lastOpenedAt.present) map['last_opened_at'] = Variable<DateTime>(lastOpenedAt.value);
    if (totalPages.present) map['total_pages'] = Variable<int>(totalPages.value);
    if (currentPosition.present) map['current_position'] = Variable<String>(currentPosition.value);
    if (isFavorite.present) map['is_favorite'] = Variable<bool>(isFavorite.value);
    if (isRead.present) map['is_read'] = Variable<bool>(isRead.value);
    if (isInReadList.present) map['is_in_read_list'] = Variable<bool>(isInReadList.value);
    if (rating.present) map['rating'] = Variable<double>(rating.value);
    if (fileSize.present) map['file_size'] = Variable<int>(fileSize.value);
    if (genre.present) map['genre'] = Variable<String>(genre.value);
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BooksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('filePath: $filePath, ')
          ..write('coverPath: $coverPath, ')
          ..write('format: $format, ')
          ..write('dateAdded: $dateAdded, ')
          ..write('lastOpenedAt: $lastOpenedAt, ')
          ..write('totalPages: $totalPages, ')
          ..write('currentPosition: $currentPosition, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isRead: $isRead, ')
          ..write('isInReadList: $isInReadList, ')
          ..write('rating: $rating, ')
          ..write('fileSize: $fileSize, ')
          ..write('genre: $genre')
          ..write(')'))
        .toString();
  }
}

class $ShelvesTable extends Shelves with TableInfo<$ShelvesTable, Shelf> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShelvesTable(this.attachedDatabase, [this._alias]);

  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id', aliasedName, false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true,
  );
  static const VerificationMeta _dirPathMeta = const VerificationMeta('dirPath');
  @override
  late final GeneratedColumn<String> dirPath = GeneratedColumn<String>(
    'dir_path', aliasedName, false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _parentShelfIdMeta = const VerificationMeta('parentShelfId');
  @override
  late final GeneratedColumn<int> parentShelfId = GeneratedColumn<int>(
    'parent_shelf_id', aliasedName, true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES shelves (id)'),
  );
  static const VerificationMeta _scanRecursiveMeta = const VerificationMeta('scanRecursive');
  @override
  late final GeneratedColumn<bool> scanRecursive = GeneratedColumn<bool>(
    'scan_recursive', aliasedName, false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("scan_recursive" IN (0, 1))'),
    defaultValue: const Constant(true),
  );

  @override
  List<GeneratedColumn> get $columns => [id, name, dirPath, parentShelfId, scanRecursive];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => r'shelves';

  @override
  VerificationContext validateIntegrity(Insertable<Shelf> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    if (data.containsKey('name')) context.handle(_nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    else if (isInserting) context.missing(_nameMeta);
    if (data.containsKey('dir_path')) context.handle(_dirPathMeta, dirPath.isAcceptableOrUnknown(data['dir_path']!, _dirPathMeta));
    else if (isInserting) context.missing(_dirPathMeta);
    if (data.containsKey('parent_shelf_id')) context.handle(_parentShelfIdMeta, parentShelfId.isAcceptableOrUnknown(data['parent_shelf_id']!, _parentShelfIdMeta));
    if (data.containsKey('scan_recursive')) context.handle(_scanRecursiveMeta, scanRecursive.isAcceptableOrUnknown(data['scan_recursive']!, _scanRecursiveMeta));
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};

  @override
  Shelf map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Shelf(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      dirPath: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}dir_path'])!,
      parentShelfId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}parent_shelf_id']),
      scanRecursive: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}scan_recursive'])!,
    );
  }

  @override
  $ShelvesTable createAlias(String alias) => $ShelvesTable(attachedDatabase, alias);
}

class Shelf extends DataClass implements Insertable<Shelf> {
  final int id;
  final String name;
  final String dirPath;
  final int? parentShelfId;
  final bool scanRecursive;

  const Shelf({
    required this.id,
    required this.name,
    required this.dirPath,
    this.parentShelfId,
    required this.scanRecursive,
  });

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['dir_path'] = Variable<String>(dirPath);
    if (!nullToAbsent || parentShelfId != null) map['parent_shelf_id'] = Variable<int>(parentShelfId);
    map['scan_recursive'] = Variable<bool>(scanRecursive);
    return map;
  }

  ShelvesCompanion toCompanion(bool nullToAbsent) {
    return ShelvesCompanion(
      id: Value(id),
      name: Value(name),
      dirPath: Value(dirPath),
      parentShelfId: parentShelfId == null && nullToAbsent ? const Value.absent() : Value(parentShelfId),
      scanRecursive: Value(scanRecursive),
    );
  }

  factory Shelf.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Shelf(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      dirPath: serializer.fromJson<String>(json['dirPath']),
      parentShelfId: serializer.fromJson<int?>(json['parentShelfId']),
      scanRecursive: serializer.fromJson<bool>(json['scanRecursive']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'dirPath': serializer.toJson<String>(dirPath),
      'parentShelfId': serializer.toJson<int?>(parentShelfId),
      'scanRecursive': serializer.toJson<bool>(scanRecursive),
    };
  }

  Shelf copyWith({
    int? id,
    String? name,
    String? dirPath,
    Value<int?> parentShelfId = const Value.absent(),
    bool? scanRecursive,
  }) => Shelf(
    id: id ?? this.id,
    name: name ?? this.name,
    dirPath: dirPath ?? this.dirPath,
    parentShelfId: parentShelfId.present ? parentShelfId.value : this.parentShelfId,
    scanRecursive: scanRecursive ?? this.scanRecursive,
  );

  @override
  String toString() {
    return (StringBuffer('Shelf(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('dirPath: $dirPath, ')
          ..write('parentShelfId: $parentShelfId, ')
          ..write('scanRecursive: $scanRecursive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, dirPath, parentShelfId, scanRecursive);

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    (other is Shelf &&
      other.id == id &&
      other.name == name &&
      other.dirPath == dirPath &&
      other.parentShelfId == parentShelfId &&
      other.scanRecursive == scanRecursive);
}

class ShelvesCompanion extends UpdateCompanion<Shelf> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> dirPath;
  final Value<int?> parentShelfId;
  final Value<bool> scanRecursive;
  final Value<int> rowid;

  const ShelvesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.dirPath = const Value.absent(),
    this.parentShelfId = const Value.absent(),
    this.scanRecursive = const Value.absent(),
    this.rowid = const Value.absent(),
  });

  ShelvesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String dirPath,
    this.parentShelfId = const Value.absent(),
    this.scanRecursive = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : name = Value(name),
        dirPath = Value(dirPath);

  ShelvesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? dirPath,
    Value<int?>? parentShelfId,
    Value<bool>? scanRecursive,
    Value<int>? rowid,
  }) {
    return ShelvesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      dirPath: dirPath ?? this.dirPath,
      parentShelfId: parentShelfId ?? this.parentShelfId,
      scanRecursive: scanRecursive ?? this.scanRecursive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) map['id'] = Variable<int>(id.value);
    if (name.present) map['name'] = Variable<String>(name.value);
    if (dirPath.present) map['dir_path'] = Variable<String>(dirPath.value);
    if (parentShelfId.present) map['parent_shelf_id'] = Variable<int>(parentShelfId.value);
    if (scanRecursive.present) map['scan_recursive'] = Variable<bool>(scanRecursive.value);
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShelvesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('dirPath: $dirPath, ')
          ..write('parentShelfId: $parentShelfId, ')
          ..write('scanRecursive: $scanRecursive')
          ..write(')'))
        .toString();
  }
}

class $BookmarksTable extends Bookmarks with TableInfo<$BookmarksTable, Bookmark> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookmarksTable(this.attachedDatabase, [this._alias]);

  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id', aliasedName, false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<int> bookId = GeneratedColumn<int>(
    'book_id', aliasedName, false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES books (id) ON DELETE CASCADE'),
  );
  static const VerificationMeta _positionMeta = const VerificationMeta('position');
  @override
  late final GeneratedColumn<String> position = GeneratedColumn<String>(
    'position', aliasedName, false, type: DriftSqlType.string, requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label', aliasedName, false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at', aliasedName, false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );

  @override
  List<GeneratedColumn> get $columns => [id, bookId, position, label, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => r'bookmarks';

  @override
  VerificationContext validateIntegrity(Insertable<Bookmark> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    if (data.containsKey('book_id')) context.handle(_bookIdMeta, bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta));
    else if (isInserting) context.missing(_bookIdMeta);
    if (data.containsKey('position')) context.handle(_positionMeta, position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    else if (isInserting) context.missing(_positionMeta);
    if (data.containsKey('label')) context.handle(_labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    if (data.containsKey('created_at')) context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};

  @override
  Bookmark map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Bookmark(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      bookId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}book_id'])!,
      position: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}position'])!,
      label: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}label'])!,
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $BookmarksTable createAlias(String alias) => $BookmarksTable(attachedDatabase, alias);
}

class Bookmark extends DataClass implements Insertable<Bookmark> {
  final int id;
  final int bookId;
  final String position;
  final String label;
  final DateTime createdAt;

  const Bookmark({
    required this.id,
    required this.bookId,
    required this.position,
    required this.label,
    required this.createdAt,
  });

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['book_id'] = Variable<int>(bookId);
    map['position'] = Variable<String>(position);
    map['label'] = Variable<String>(label);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BookmarksCompanion toCompanion(bool nullToAbsent) {
    return BookmarksCompanion(
      id: Value(id),
      bookId: Value(bookId),
      position: Value(position),
      label: Value(label),
      createdAt: Value(createdAt),
    );
  }

  factory Bookmark.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bookmark(
      id: serializer.fromJson<int>(json['id']),
      bookId: serializer.fromJson<int>(json['bookId']),
      position: serializer.fromJson<String>(json['position']),
      label: serializer.fromJson<String>(json['label']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bookId': serializer.toJson<int>(bookId),
      'position': serializer.toJson<String>(position),
      'label': serializer.toJson<String>(label),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Bookmark copyWith({int? id, int? bookId, String? position, String? label, DateTime? createdAt}) => Bookmark(
    id: id ?? this.id,
    bookId: bookId ?? this.bookId,
    position: position ?? this.position,
    label: label ?? this.label,
    createdAt: createdAt ?? this.createdAt,
  );

  @override
  String toString() {
    return (StringBuffer('Bookmark(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('position: $position, ')
          ..write('label: $label, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, bookId, position, label, createdAt);

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    (other is Bookmark &&
      other.id == id &&
      other.bookId == bookId &&
      other.position == position &&
      other.label == label &&
      other.createdAt == createdAt);
}

class BookmarksCompanion extends UpdateCompanion<Bookmark> {
  final Value<int> id;
  final Value<int> bookId;
  final Value<String> position;
  final Value<String> label;
  final Value<DateTime> createdAt;
  final Value<int> rowid;

  const BookmarksCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.position = const Value.absent(),
    this.label = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });

  BookmarksCompanion.insert({
    this.id = const Value.absent(),
    required int bookId,
    required String position,
    this.label = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : bookId = Value(bookId),
        position = Value(position);

  BookmarksCompanion copyWith({
    Value<int>? id,
    Value<int>? bookId,
    Value<String>? position,
    Value<String>? label,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return BookmarksCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      position: position ?? this.position,
      label: label ?? this.label,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) map['id'] = Variable<int>(id.value);
    if (bookId.present) map['book_id'] = Variable<int>(bookId.value);
    if (position.present) map['position'] = Variable<String>(position.value);
    if (label.present) map['label'] = Variable<String>(label.value);
    if (createdAt.present) map['created_at'] = Variable<DateTime>(createdAt.value);
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookmarksCompanion(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('position: $position, ')
          ..write('label: $label, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $BookSettingsTable extends BookSettings with TableInfo<$BookSettingsTable, BookSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookSettingsTable(this.attachedDatabase, [this._alias]);

  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<int> bookId = GeneratedColumn<int>(
    'book_id', aliasedName, false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES books (id) ON DELETE CASCADE'),
  );
  static const VerificationMeta _fontSizeMeta = const VerificationMeta('fontSize');
  @override
  late final GeneratedColumn<double> fontSize = GeneratedColumn<double>(
    'font_size', aliasedName, false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(16.0),
  );
  static const VerificationMeta _fontFamilyMeta = const VerificationMeta('fontFamily');
  @override
  late final GeneratedColumn<String> fontFamily = GeneratedColumn<String>(
    'font_family', aliasedName, false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Default'),
  );
  static const VerificationMeta _lineHeightMeta = const VerificationMeta('lineHeight');
  @override
  late final GeneratedColumn<double> lineHeight = GeneratedColumn<double>(
    'line_height', aliasedName, false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.5),
  );
  static const VerificationMeta _themeMeta = const VerificationMeta('theme');
  @override
  late final GeneratedColumn<String> theme = GeneratedColumn<String>(
    'theme', aliasedName, false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Light'),
  );
  static const VerificationMeta _brightnessMeta = const VerificationMeta('brightness');
  @override
  late final GeneratedColumn<double> brightness = GeneratedColumn<double>(
    'brightness', aliasedName, false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _scrollModeMeta = const VerificationMeta('scrollMode');
  @override
  late final GeneratedColumn<String> scrollMode = GeneratedColumn<String>(
    'scroll_mode', aliasedName, false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('paged'),
  );
  static const VerificationMeta _customBgMeta = const VerificationMeta('customBg');
  @override
  late final GeneratedColumn<String> customBg = GeneratedColumn<String>(
    'custom_bg', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false,
  );
  static const VerificationMeta _customFgMeta = const VerificationMeta('customFg');
  @override
  late final GeneratedColumn<String> customFg = GeneratedColumn<String>(
    'custom_fg', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false,
  );
  static const VerificationMeta _customAccentMeta = const VerificationMeta('customAccent');
  @override
  late final GeneratedColumn<String> customAccent = GeneratedColumn<String>(
    'custom_accent', aliasedName, true, type: DriftSqlType.string, requiredDuringInsert: false,
  );

  @override
  List<GeneratedColumn> get $columns => [
    bookId, fontSize, fontFamily, lineHeight, theme, brightness, scrollMode,
    customBg, customFg, customAccent,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => r'book_settings';

  @override
  VerificationContext validateIntegrity(Insertable<BookSetting> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('book_id')) context.handle(_bookIdMeta, bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta));
    else if (isInserting) context.missing(_bookIdMeta);
    if (data.containsKey('font_size')) context.handle(_fontSizeMeta, fontSize.isAcceptableOrUnknown(data['font_size']!, _fontSizeMeta));
    if (data.containsKey('font_family')) context.handle(_fontFamilyMeta, fontFamily.isAcceptableOrUnknown(data['font_family']!, _fontFamilyMeta));
    if (data.containsKey('line_height')) context.handle(_lineHeightMeta, lineHeight.isAcceptableOrUnknown(data['line_height']!, _lineHeightMeta));
    if (data.containsKey('theme')) context.handle(_themeMeta, theme.isAcceptableOrUnknown(data['theme']!, _themeMeta));
    if (data.containsKey('brightness')) context.handle(_brightnessMeta, brightness.isAcceptableOrUnknown(data['brightness']!, _brightnessMeta));
    if (data.containsKey('scroll_mode')) context.handle(_scrollModeMeta, scrollMode.isAcceptableOrUnknown(data['scroll_mode']!, _scrollModeMeta));
    if (data.containsKey('custom_bg')) context.handle(_customBgMeta, customBg.isAcceptableOrUnknown(data['custom_bg']!, _customBgMeta));
    if (data.containsKey('custom_fg')) context.handle(_customFgMeta, customFg.isAcceptableOrUnknown(data['custom_fg']!, _customFgMeta));
    if (data.containsKey('custom_accent')) context.handle(_customAccentMeta, customAccent.isAcceptableOrUnknown(data['custom_accent']!, _customAccentMeta));
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {bookId};

  @override
  BookSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BookSetting(
      bookId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}book_id'])!,
      fontSize: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}font_size'])!,
      fontFamily: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}font_family'])!,
      lineHeight: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}line_height'])!,
      theme: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}theme'])!,
      brightness: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}brightness'])!,
      scrollMode: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}scroll_mode'])!,
      customBg: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}custom_bg']),
      customFg: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}custom_fg']),
      customAccent: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}custom_accent']),
    );
  }

  @override
  $BookSettingsTable createAlias(String alias) => $BookSettingsTable(attachedDatabase, alias);
}

class BookSetting extends DataClass implements Insertable<BookSetting> {
  final int bookId;
  final double fontSize;
  final String fontFamily;
  final double lineHeight;
  final String theme;
  final double brightness;
  final String scrollMode;
  final String? customBg;
  final String? customFg;
  final String? customAccent;

  const BookSetting({
    required this.bookId,
    required this.fontSize,
    required this.fontFamily,
    required this.lineHeight,
    required this.theme,
    required this.brightness,
    required this.scrollMode,
    this.customBg,
    this.customFg,
    this.customAccent,
  });

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['book_id'] = Variable<int>(bookId);
    map['font_size'] = Variable<double>(fontSize);
    map['font_family'] = Variable<String>(fontFamily);
    map['line_height'] = Variable<double>(lineHeight);
    map['theme'] = Variable<String>(theme);
    map['brightness'] = Variable<double>(brightness);
    map['scroll_mode'] = Variable<String>(scrollMode);
    if (!nullToAbsent || customBg != null) map['custom_bg'] = Variable<String>(customBg);
    if (!nullToAbsent || customFg != null) map['custom_fg'] = Variable<String>(customFg);
    if (!nullToAbsent || customAccent != null) map['custom_accent'] = Variable<String>(customAccent);
    return map;
  }

  BookSettingsCompanion toCompanion(bool nullToAbsent) {
    return BookSettingsCompanion(
      bookId: Value(bookId),
      fontSize: Value(fontSize),
      fontFamily: Value(fontFamily),
      lineHeight: Value(lineHeight),
      theme: Value(theme),
      brightness: Value(brightness),
      scrollMode: Value(scrollMode),
      customBg: customBg == null && nullToAbsent ? const Value.absent() : Value(customBg),
      customFg: customFg == null && nullToAbsent ? const Value.absent() : Value(customFg),
      customAccent: customAccent == null && nullToAbsent ? const Value.absent() : Value(customAccent),
    );
  }

  factory BookSetting.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BookSetting(
      bookId: serializer.fromJson<int>(json['bookId']),
      fontSize: serializer.fromJson<double>(json['fontSize']),
      fontFamily: serializer.fromJson<String>(json['fontFamily']),
      lineHeight: serializer.fromJson<double>(json['lineHeight']),
      theme: serializer.fromJson<String>(json['theme']),
      brightness: serializer.fromJson<double>(json['brightness']),
      scrollMode: serializer.fromJson<String>(json['scrollMode']),
      customBg: serializer.fromJson<String?>(json['customBg']),
      customFg: serializer.fromJson<String?>(json['customFg']),
      customAccent: serializer.fromJson<String?>(json['customAccent']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'bookId': serializer.toJson<int>(bookId),
      'fontSize': serializer.toJson<double>(fontSize),
      'fontFamily': serializer.toJson<String>(fontFamily),
      'lineHeight': serializer.toJson<double>(lineHeight),
      'theme': serializer.toJson<String>(theme),
      'brightness': serializer.toJson<double>(brightness),
      'scrollMode': serializer.toJson<String>(scrollMode),
      'customBg': serializer.toJson<String?>(customBg),
      'customFg': serializer.toJson<String?>(customFg),
      'customAccent': serializer.toJson<String?>(customAccent),
    };
  }

  BookSetting copyWith({
    int? bookId,
    double? fontSize,
    String? fontFamily,
    double? lineHeight,
    String? theme,
    double? brightness,
    String? scrollMode,
    Value<String?> customBg = const Value.absent(),
    Value<String?> customFg = const Value.absent(),
    Value<String?> customAccent = const Value.absent(),
  }) => BookSetting(
    bookId: bookId ?? this.bookId,
    fontSize: fontSize ?? this.fontSize,
    fontFamily: fontFamily ?? this.fontFamily,
    lineHeight: lineHeight ?? this.lineHeight,
    theme: theme ?? this.theme,
    brightness: brightness ?? this.brightness,
    scrollMode: scrollMode ?? this.scrollMode,
    customBg: customBg.present ? customBg.value : this.customBg,
    customFg: customFg.present ? customFg.value : this.customFg,
    customAccent: customAccent.present ? customAccent.value : this.customAccent,
  );

  @override
  String toString() {
    return (StringBuffer('BookSetting(')
          ..write('bookId: $bookId, ')
          ..write('fontSize: $fontSize, ')
          ..write('fontFamily: $fontFamily, ')
          ..write('lineHeight: $lineHeight, ')
          ..write('theme: $theme, ')
          ..write('brightness: $brightness, ')
          ..write('scrollMode: $scrollMode, ')
          ..write('customBg: $customBg, ')
          ..write('customFg: $customFg, ')
          ..write('customAccent: $customAccent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(bookId, fontSize, fontFamily, lineHeight, theme, brightness, scrollMode, customBg, customFg, customAccent);

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    (other is BookSetting &&
      other.bookId == bookId &&
      other.fontSize == fontSize &&
      other.fontFamily == fontFamily &&
      other.lineHeight == lineHeight &&
      other.theme == theme &&
      other.brightness == brightness &&
      other.scrollMode == scrollMode &&
      other.customBg == customBg &&
      other.customFg == customFg &&
      other.customAccent == customAccent);
}

class BookSettingsCompanion extends UpdateCompanion<BookSetting> {
  final Value<int> bookId;
  final Value<double> fontSize;
  final Value<String> fontFamily;
  final Value<double> lineHeight;
  final Value<String> theme;
  final Value<double> brightness;
  final Value<String> scrollMode;
  final Value<String?> customBg;
  final Value<String?> customFg;
  final Value<String?> customAccent;
  final Value<int> rowid;

  const BookSettingsCompanion({
    this.bookId = const Value.absent(),
    this.fontSize = const Value.absent(),
    this.fontFamily = const Value.absent(),
    this.lineHeight = const Value.absent(),
    this.theme = const Value.absent(),
    this.brightness = const Value.absent(),
    this.scrollMode = const Value.absent(),
    this.customBg = const Value.absent(),
    this.customFg = const Value.absent(),
    this.customAccent = const Value.absent(),
    this.rowid = const Value.absent(),
  });

  BookSettingsCompanion.insert({
    required int bookId,
    this.fontSize = const Value.absent(),
    this.fontFamily = const Value.absent(),
    this.lineHeight = const Value.absent(),
    this.theme = const Value.absent(),
    this.brightness = const Value.absent(),
    this.scrollMode = const Value.absent(),
    this.customBg = const Value.absent(),
    this.customFg = const Value.absent(),
    this.customAccent = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : bookId = Value(bookId);

  BookSettingsCompanion copyWith({
    Value<int>? bookId,
    Value<double>? fontSize,
    Value<String>? fontFamily,
    Value<double>? lineHeight,
    Value<String>? theme,
    Value<double>? brightness,
    Value<String>? scrollMode,
    Value<String?>? customBg,
    Value<String?>? customFg,
    Value<String?>? customAccent,
    Value<int>? rowid,
  }) {
    return BookSettingsCompanion(
      bookId: bookId ?? this.bookId,
      fontSize: fontSize ?? this.fontSize,
      fontFamily: fontFamily ?? this.fontFamily,
      lineHeight: lineHeight ?? this.lineHeight,
      theme: theme ?? this.theme,
      brightness: brightness ?? this.brightness,
      scrollMode: scrollMode ?? this.scrollMode,
      customBg: customBg ?? this.customBg,
      customFg: customFg ?? this.customFg,
      customAccent: customAccent ?? this.customAccent,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (bookId.present) map['book_id'] = Variable<int>(bookId.value);
    if (fontSize.present) map['font_size'] = Variable<double>(fontSize.value);
    if (fontFamily.present) map['font_family'] = Variable<String>(fontFamily.value);
    if (lineHeight.present) map['line_height'] = Variable<double>(lineHeight.value);
    if (theme.present) map['theme'] = Variable<String>(theme.value);
    if (brightness.present) map['brightness'] = Variable<double>(brightness.value);
    if (scrollMode.present) map['scroll_mode'] = Variable<String>(scrollMode.value);
    if (customBg.present) map['custom_bg'] = Variable<String>(customBg.value);
    if (customFg.present) map['custom_fg'] = Variable<String>(customFg.value);
    if (customAccent.present) map['custom_accent'] = Variable<String>(customAccent.value);
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookSettingsCompanion(')
          ..write('bookId: $bookId, ')
          ..write('fontSize: $fontSize, ')
          ..write('fontFamily: $fontFamily, ')
          ..write('lineHeight: $lineHeight, ')
          ..write('theme: $theme, ')
          ..write('brightness: $brightness, ')
          ..write('scrollMode: $scrollMode, ')
          ..write('customBg: $customBg, ')
          ..write('customFg: $customFg, ')
          ..write('customAccent: $customAccent')
          ..write(')'))
        .toString();
  }
}

class $ReadingSessionsTable extends ReadingSessions with TableInfo<$ReadingSessionsTable, ReadingSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReadingSessionsTable(this.attachedDatabase, [this._alias]);

  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id', aliasedName, false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<int> bookId = GeneratedColumn<int>(
    'book_id', aliasedName, false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES books (id) ON DELETE CASCADE'),
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta('startedAt');
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at', aliasedName, false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta('endedAt');
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at', aliasedName, true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pagesReadMeta = const VerificationMeta('pagesRead');
  @override
  late final GeneratedColumn<int> pagesRead = GeneratedColumn<int>(
    'pages_read', aliasedName, false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );

  @override
  List<GeneratedColumn> get $columns => [id, bookId, startedAt, endedAt, pagesRead];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => r'reading_sessions';

  @override
  VerificationContext validateIntegrity(Insertable<ReadingSession> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    if (data.containsKey('book_id')) context.handle(_bookIdMeta, bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta));
    else if (isInserting) context.missing(_bookIdMeta);
    if (data.containsKey('started_at')) context.handle(_startedAtMeta, startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));
    else if (isInserting) context.missing(_startedAtMeta);
    if (data.containsKey('ended_at')) context.handle(_endedAtMeta, endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta));
    if (data.containsKey('pages_read')) context.handle(_pagesReadMeta, pagesRead.isAcceptableOrUnknown(data['pages_read']!, _pagesReadMeta));
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};

  @override
  ReadingSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReadingSession(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      bookId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}book_id'])!,
      startedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}started_at'])!,
      endedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}ended_at']),
      pagesRead: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}pages_read'])!,
    );
  }

  @override
  $ReadingSessionsTable createAlias(String alias) => $ReadingSessionsTable(attachedDatabase, alias);
}

class ReadingSession extends DataClass implements Insertable<ReadingSession> {
  final int id;
  final int bookId;
  final DateTime startedAt;
  final DateTime? endedAt;
  final int pagesRead;

  const ReadingSession({
    required this.id,
    required this.bookId,
    required this.startedAt,
    this.endedAt,
    required this.pagesRead,
  });

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['book_id'] = Variable<int>(bookId);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || endedAt != null) map['ended_at'] = Variable<DateTime>(endedAt);
    map['pages_read'] = Variable<int>(pagesRead);
    return map;
  }

  ReadingSessionsCompanion toCompanion(bool nullToAbsent) {
    return ReadingSessionsCompanion(
      id: Value(id),
      bookId: Value(bookId),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent ? const Value.absent() : Value(endedAt),
      pagesRead: Value(pagesRead),
    );
  }

  factory ReadingSession.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReadingSession(
      id: serializer.fromJson<int>(json['id']),
      bookId: serializer.fromJson<int>(json['bookId']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
      pagesRead: serializer.fromJson<int>(json['pagesRead']),
    );
  }

  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bookId': serializer.toJson<int>(bookId),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
      'pagesRead': serializer.toJson<int>(pagesRead),
    };
  }

  ReadingSession copyWith({
    int? id,
    int? bookId,
    DateTime? startedAt,
    Value<DateTime?> endedAt = const Value.absent(),
    int? pagesRead,
  }) => ReadingSession(
    id: id ?? this.id,
    bookId: bookId ?? this.bookId,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    pagesRead: pagesRead ?? this.pagesRead,
  );

  @override
  String toString() {
    return (StringBuffer('ReadingSession(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('pagesRead: $pagesRead')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, bookId, startedAt, endedAt, pagesRead);

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    (other is ReadingSession &&
      other.id == id &&
      other.bookId == bookId &&
      other.startedAt == startedAt &&
      other.endedAt == endedAt &&
      other.pagesRead == pagesRead);
}

class ReadingSessionsCompanion extends UpdateCompanion<ReadingSession> {
  final Value<int> id;
  final Value<int> bookId;
  final Value<DateTime> startedAt;
  final Value<DateTime?> endedAt;
  final Value<int> pagesRead;
  final Value<int> rowid;

  const ReadingSessionsCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.pagesRead = const Value.absent(),
    this.rowid = const Value.absent(),
  });

  ReadingSessionsCompanion.insert({
    this.id = const Value.absent(),
    required int bookId,
    required DateTime startedAt,
    this.endedAt = const Value.absent(),
    this.pagesRead = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : bookId = Value(bookId),
        startedAt = Value(startedAt);

  ReadingSessionsCompanion copyWith({
    Value<int>? id,
    Value<int>? bookId,
    Value<DateTime>? startedAt,
    Value<DateTime?>? endedAt,
    Value<int>? pagesRead,
    Value<int>? rowid,
  }) {
    return ReadingSessionsCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      pagesRead: pagesRead ?? this.pagesRead,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) map['id'] = Variable<int>(id.value);
    if (bookId.present) map['book_id'] = Variable<int>(bookId.value);
    if (startedAt.present) map['started_at'] = Variable<DateTime>(startedAt.value);
    if (endedAt.present) map['ended_at'] = Variable<DateTime>(endedAt.value);
    if (pagesRead.present) map['pages_read'] = Variable<int>(pagesRead.value);
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReadingSessionsCompanion(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('pagesRead: $pagesRead')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);

  late final $BooksTable books = $BooksTable(this);
  late final $ShelvesTable shelves = $ShelvesTable(this);
  late final $BookmarksTable bookmarks = $BookmarksTable(this);
  late final $BookSettingsTable bookSettings = $BookSettingsTable(this);
  late final $ReadingSessionsTable readingSessions = $ReadingSessionsTable(this);

  late final BooksDao booksDao = BooksDao(this as AppDatabase);
  late final ShelvesDao shelvesDao = ShelvesDao(this as AppDatabase);
  late final BookmarksDao bookmarksDao = BookmarksDao(this as AppDatabase);
  late final BookSettingsDao bookSettingsDao = BookSettingsDao(this as AppDatabase);
  late final ReadingSessionsDao readingSessionsDao = ReadingSessionsDao(this as AppDatabase);

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();

  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [books, shelves, bookmarks, bookSettings, readingSessions];
}

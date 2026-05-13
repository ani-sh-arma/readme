// GENERATED CODE - DO NOT MODIFY BY HAND

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
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
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
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coverPathMeta = const VerificationMeta(
    'coverPath',
  );
  @override
  late final GeneratedColumn<String> coverPath = GeneratedColumn<String>(
    'cover_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coverSourceMeta = const VerificationMeta(
    'coverSource',
  );
  @override
  late final GeneratedColumn<String> coverSource = GeneratedColumn<String>(
    'cover_source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('generated'),
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
  static const VerificationMeta _dateAddedMeta = const VerificationMeta(
    'dateAdded',
  );
  @override
  late final GeneratedColumn<DateTime> dateAdded = GeneratedColumn<DateTime>(
    'date_added',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _lastOpenedAtMeta = const VerificationMeta(
    'lastOpenedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastOpenedAt = GeneratedColumn<DateTime>(
    'last_opened_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalPagesMeta = const VerificationMeta(
    'totalPages',
  );
  @override
  late final GeneratedColumn<int> totalPages = GeneratedColumn<int>(
    'total_pages',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _currentPositionMeta = const VerificationMeta(
    'currentPosition',
  );
  @override
  late final GeneratedColumn<String> currentPosition = GeneratedColumn<String>(
    'current_position',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _lastReadProgressMeta = const VerificationMeta(
    'lastReadProgress',
  );
  @override
  late final GeneratedColumn<double> lastReadProgress = GeneratedColumn<double>(
    'last_read_progress',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
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
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_read" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isInReadListMeta = const VerificationMeta(
    'isInReadList',
  );
  @override
  late final GeneratedColumn<bool> isInReadList = GeneratedColumn<bool>(
    'is_in_read_list',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_in_read_list" IN (0, 1))',
    ),
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
  static const VerificationMeta _fileSizeMeta = const VerificationMeta(
    'fileSize',
  );
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
    id,
    title,
    author,
    filePath,
    coverPath,
    coverSource,
    format,
    dateAdded,
    lastOpenedAt,
    totalPages,
    currentPosition,
    lastReadProgress,
    isFavorite,
    isRead,
    isInReadList,
    rating,
    fileSize,
    genre,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'books';
  @override
  VerificationContext validateIntegrity(
    Insertable<Book> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('author')) {
      context.handle(
        _authorMeta,
        author.isAcceptableOrUnknown(data['author']!, _authorMeta),
      );
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('cover_path')) {
      context.handle(
        _coverPathMeta,
        coverPath.isAcceptableOrUnknown(data['cover_path']!, _coverPathMeta),
      );
    }
    if (data.containsKey('cover_source')) {
      context.handle(
        _coverSourceMeta,
        coverSource.isAcceptableOrUnknown(
          data['cover_source']!,
          _coverSourceMeta,
        ),
      );
    }
    if (data.containsKey('format')) {
      context.handle(
        _formatMeta,
        format.isAcceptableOrUnknown(data['format']!, _formatMeta),
      );
    }
    if (data.containsKey('date_added')) {
      context.handle(
        _dateAddedMeta,
        dateAdded.isAcceptableOrUnknown(data['date_added']!, _dateAddedMeta),
      );
    }
    if (data.containsKey('last_opened_at')) {
      context.handle(
        _lastOpenedAtMeta,
        lastOpenedAt.isAcceptableOrUnknown(
          data['last_opened_at']!,
          _lastOpenedAtMeta,
        ),
      );
    }
    if (data.containsKey('total_pages')) {
      context.handle(
        _totalPagesMeta,
        totalPages.isAcceptableOrUnknown(data['total_pages']!, _totalPagesMeta),
      );
    }
    if (data.containsKey('current_position')) {
      context.handle(
        _currentPositionMeta,
        currentPosition.isAcceptableOrUnknown(
          data['current_position']!,
          _currentPositionMeta,
        ),
      );
    }
    if (data.containsKey('last_read_progress')) {
      context.handle(
        _lastReadProgressMeta,
        lastReadProgress.isAcceptableOrUnknown(
          data['last_read_progress']!,
          _lastReadProgressMeta,
        ),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('is_read')) {
      context.handle(
        _isReadMeta,
        isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta),
      );
    }
    if (data.containsKey('is_in_read_list')) {
      context.handle(
        _isInReadListMeta,
        isInReadList.isAcceptableOrUnknown(
          data['is_in_read_list']!,
          _isInReadListMeta,
        ),
      );
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    }
    if (data.containsKey('file_size')) {
      context.handle(
        _fileSizeMeta,
        fileSize.isAcceptableOrUnknown(data['file_size']!, _fileSizeMeta),
      );
    }
    if (data.containsKey('genre')) {
      context.handle(
        _genreMeta,
        genre.isAcceptableOrUnknown(data['genre']!, _genreMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Book map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Book(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      author: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}author'],
      )!,
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      )!,
      coverPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_path'],
      ),
      coverSource: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_source'],
      )!,
      format: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}format'],
      )!,
      dateAdded: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_added'],
      )!,
      lastOpenedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_opened_at'],
      ),
      totalPages: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_pages'],
      )!,
      currentPosition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_position'],
      )!,
      lastReadProgress: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}last_read_progress'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      isRead: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_read'],
      )!,
      isInReadList: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_in_read_list'],
      )!,
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rating'],
      ),
      fileSize: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}file_size'],
      )!,
      genre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}genre'],
      ),
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
  final String coverSource;
  final String format;
  final DateTime dateAdded;
  final DateTime? lastOpenedAt;
  final int totalPages;
  final String currentPosition;
  final double lastReadProgress;
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
    required this.coverSource,
    required this.format,
    required this.dateAdded,
    this.lastOpenedAt,
    required this.totalPages,
    required this.currentPosition,
    required this.lastReadProgress,
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
    if (!nullToAbsent || coverPath != null) {
      map['cover_path'] = Variable<String>(coverPath);
    }
    map['cover_source'] = Variable<String>(coverSource);
    map['format'] = Variable<String>(format);
    map['date_added'] = Variable<DateTime>(dateAdded);
    if (!nullToAbsent || lastOpenedAt != null) {
      map['last_opened_at'] = Variable<DateTime>(lastOpenedAt);
    }
    map['total_pages'] = Variable<int>(totalPages);
    map['current_position'] = Variable<String>(currentPosition);
    map['last_read_progress'] = Variable<double>(lastReadProgress);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['is_read'] = Variable<bool>(isRead);
    map['is_in_read_list'] = Variable<bool>(isInReadList);
    if (!nullToAbsent || rating != null) {
      map['rating'] = Variable<double>(rating);
    }
    map['file_size'] = Variable<int>(fileSize);
    if (!nullToAbsent || genre != null) {
      map['genre'] = Variable<String>(genre);
    }
    return map;
  }

  BooksCompanion toCompanion(bool nullToAbsent) {
    return BooksCompanion(
      id: Value(id),
      title: Value(title),
      author: Value(author),
      filePath: Value(filePath),
      coverPath: coverPath == null && nullToAbsent
          ? const Value.absent()
          : Value(coverPath),
      coverSource: Value(coverSource),
      format: Value(format),
      dateAdded: Value(dateAdded),
      lastOpenedAt: lastOpenedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastOpenedAt),
      totalPages: Value(totalPages),
      currentPosition: Value(currentPosition),
      lastReadProgress: Value(lastReadProgress),
      isFavorite: Value(isFavorite),
      isRead: Value(isRead),
      isInReadList: Value(isInReadList),
      rating: rating == null && nullToAbsent
          ? const Value.absent()
          : Value(rating),
      fileSize: Value(fileSize),
      genre: genre == null && nullToAbsent
          ? const Value.absent()
          : Value(genre),
    );
  }

  factory Book.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Book(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      author: serializer.fromJson<String>(json['author']),
      filePath: serializer.fromJson<String>(json['filePath']),
      coverPath: serializer.fromJson<String?>(json['coverPath']),
      coverSource: serializer.fromJson<String>(json['coverSource']),
      format: serializer.fromJson<String>(json['format']),
      dateAdded: serializer.fromJson<DateTime>(json['dateAdded']),
      lastOpenedAt: serializer.fromJson<DateTime?>(json['lastOpenedAt']),
      totalPages: serializer.fromJson<int>(json['totalPages']),
      currentPosition: serializer.fromJson<String>(json['currentPosition']),
      lastReadProgress: serializer.fromJson<double>(json['lastReadProgress']),
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
      'coverSource': serializer.toJson<String>(coverSource),
      'format': serializer.toJson<String>(format),
      'dateAdded': serializer.toJson<DateTime>(dateAdded),
      'lastOpenedAt': serializer.toJson<DateTime?>(lastOpenedAt),
      'totalPages': serializer.toJson<int>(totalPages),
      'currentPosition': serializer.toJson<String>(currentPosition),
      'lastReadProgress': serializer.toJson<double>(lastReadProgress),
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
    String? coverSource,
    String? format,
    DateTime? dateAdded,
    Value<DateTime?> lastOpenedAt = const Value.absent(),
    int? totalPages,
    String? currentPosition,
    double? lastReadProgress,
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
    coverSource: coverSource ?? this.coverSource,
    format: format ?? this.format,
    dateAdded: dateAdded ?? this.dateAdded,
    lastOpenedAt: lastOpenedAt.present ? lastOpenedAt.value : this.lastOpenedAt,
    totalPages: totalPages ?? this.totalPages,
    currentPosition: currentPosition ?? this.currentPosition,
    lastReadProgress: lastReadProgress ?? this.lastReadProgress,
    isFavorite: isFavorite ?? this.isFavorite,
    isRead: isRead ?? this.isRead,
    isInReadList: isInReadList ?? this.isInReadList,
    rating: rating.present ? rating.value : this.rating,
    fileSize: fileSize ?? this.fileSize,
    genre: genre.present ? genre.value : this.genre,
  );
  Book copyWithCompanion(BooksCompanion data) {
    return Book(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      author: data.author.present ? data.author.value : this.author,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      coverPath: data.coverPath.present ? data.coverPath.value : this.coverPath,
      coverSource: data.coverSource.present
          ? data.coverSource.value
          : this.coverSource,
      format: data.format.present ? data.format.value : this.format,
      dateAdded: data.dateAdded.present ? data.dateAdded.value : this.dateAdded,
      lastOpenedAt: data.lastOpenedAt.present
          ? data.lastOpenedAt.value
          : this.lastOpenedAt,
      totalPages: data.totalPages.present
          ? data.totalPages.value
          : this.totalPages,
      currentPosition: data.currentPosition.present
          ? data.currentPosition.value
          : this.currentPosition,
      lastReadProgress: data.lastReadProgress.present
          ? data.lastReadProgress.value
          : this.lastReadProgress,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      isRead: data.isRead.present ? data.isRead.value : this.isRead,
      isInReadList: data.isInReadList.present
          ? data.isInReadList.value
          : this.isInReadList,
      rating: data.rating.present ? data.rating.value : this.rating,
      fileSize: data.fileSize.present ? data.fileSize.value : this.fileSize,
      genre: data.genre.present ? data.genre.value : this.genre,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Book(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('filePath: $filePath, ')
          ..write('coverPath: $coverPath, ')
          ..write('coverSource: $coverSource, ')
          ..write('format: $format, ')
          ..write('dateAdded: $dateAdded, ')
          ..write('lastOpenedAt: $lastOpenedAt, ')
          ..write('totalPages: $totalPages, ')
          ..write('currentPosition: $currentPosition, ')
          ..write('lastReadProgress: $lastReadProgress, ')
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
    id,
    title,
    author,
    filePath,
    coverPath,
    coverSource,
    format,
    dateAdded,
    lastOpenedAt,
    totalPages,
    currentPosition,
    lastReadProgress,
    isFavorite,
    isRead,
    isInReadList,
    rating,
    fileSize,
    genre,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Book &&
          other.id == this.id &&
          other.title == this.title &&
          other.author == this.author &&
          other.filePath == this.filePath &&
          other.coverPath == this.coverPath &&
          other.coverSource == this.coverSource &&
          other.format == this.format &&
          other.dateAdded == this.dateAdded &&
          other.lastOpenedAt == this.lastOpenedAt &&
          other.totalPages == this.totalPages &&
          other.currentPosition == this.currentPosition &&
          other.lastReadProgress == this.lastReadProgress &&
          other.isFavorite == this.isFavorite &&
          other.isRead == this.isRead &&
          other.isInReadList == this.isInReadList &&
          other.rating == this.rating &&
          other.fileSize == this.fileSize &&
          other.genre == this.genre);
}

class BooksCompanion extends UpdateCompanion<Book> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> author;
  final Value<String> filePath;
  final Value<String?> coverPath;
  final Value<String> coverSource;
  final Value<String> format;
  final Value<DateTime> dateAdded;
  final Value<DateTime?> lastOpenedAt;
  final Value<int> totalPages;
  final Value<String> currentPosition;
  final Value<double> lastReadProgress;
  final Value<bool> isFavorite;
  final Value<bool> isRead;
  final Value<bool> isInReadList;
  final Value<double?> rating;
  final Value<int> fileSize;
  final Value<String?> genre;
  const BooksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.author = const Value.absent(),
    this.filePath = const Value.absent(),
    this.coverPath = const Value.absent(),
    this.coverSource = const Value.absent(),
    this.format = const Value.absent(),
    this.dateAdded = const Value.absent(),
    this.lastOpenedAt = const Value.absent(),
    this.totalPages = const Value.absent(),
    this.currentPosition = const Value.absent(),
    this.lastReadProgress = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.isRead = const Value.absent(),
    this.isInReadList = const Value.absent(),
    this.rating = const Value.absent(),
    this.fileSize = const Value.absent(),
    this.genre = const Value.absent(),
  });
  BooksCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.author = const Value.absent(),
    required String filePath,
    this.coverPath = const Value.absent(),
    this.coverSource = const Value.absent(),
    this.format = const Value.absent(),
    this.dateAdded = const Value.absent(),
    this.lastOpenedAt = const Value.absent(),
    this.totalPages = const Value.absent(),
    this.currentPosition = const Value.absent(),
    this.lastReadProgress = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.isRead = const Value.absent(),
    this.isInReadList = const Value.absent(),
    this.rating = const Value.absent(),
    this.fileSize = const Value.absent(),
    this.genre = const Value.absent(),
  }) : title = Value(title),
       filePath = Value(filePath);
  static Insertable<Book> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? author,
    Expression<String>? filePath,
    Expression<String>? coverPath,
    Expression<String>? coverSource,
    Expression<String>? format,
    Expression<DateTime>? dateAdded,
    Expression<DateTime>? lastOpenedAt,
    Expression<int>? totalPages,
    Expression<String>? currentPosition,
    Expression<double>? lastReadProgress,
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
      if (coverSource != null) 'cover_source': coverSource,
      if (format != null) 'format': format,
      if (dateAdded != null) 'date_added': dateAdded,
      if (lastOpenedAt != null) 'last_opened_at': lastOpenedAt,
      if (totalPages != null) 'total_pages': totalPages,
      if (currentPosition != null) 'current_position': currentPosition,
      if (lastReadProgress != null) 'last_read_progress': lastReadProgress,
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
    Value<String>? coverSource,
    Value<String>? format,
    Value<DateTime>? dateAdded,
    Value<DateTime?>? lastOpenedAt,
    Value<int>? totalPages,
    Value<String>? currentPosition,
    Value<double>? lastReadProgress,
    Value<bool>? isFavorite,
    Value<bool>? isRead,
    Value<bool>? isInReadList,
    Value<double?>? rating,
    Value<int>? fileSize,
    Value<String?>? genre,
  }) {
    return BooksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      filePath: filePath ?? this.filePath,
      coverPath: coverPath ?? this.coverPath,
      coverSource: coverSource ?? this.coverSource,
      format: format ?? this.format,
      dateAdded: dateAdded ?? this.dateAdded,
      lastOpenedAt: lastOpenedAt ?? this.lastOpenedAt,
      totalPages: totalPages ?? this.totalPages,
      currentPosition: currentPosition ?? this.currentPosition,
      lastReadProgress: lastReadProgress ?? this.lastReadProgress,
      isFavorite: isFavorite ?? this.isFavorite,
      isRead: isRead ?? this.isRead,
      isInReadList: isInReadList ?? this.isInReadList,
      rating: rating ?? this.rating,
      fileSize: fileSize ?? this.fileSize,
      genre: genre ?? this.genre,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (coverPath.present) {
      map['cover_path'] = Variable<String>(coverPath.value);
    }
    if (coverSource.present) {
      map['cover_source'] = Variable<String>(coverSource.value);
    }
    if (format.present) {
      map['format'] = Variable<String>(format.value);
    }
    if (dateAdded.present) {
      map['date_added'] = Variable<DateTime>(dateAdded.value);
    }
    if (lastOpenedAt.present) {
      map['last_opened_at'] = Variable<DateTime>(lastOpenedAt.value);
    }
    if (totalPages.present) {
      map['total_pages'] = Variable<int>(totalPages.value);
    }
    if (currentPosition.present) {
      map['current_position'] = Variable<String>(currentPosition.value);
    }
    if (lastReadProgress.present) {
      map['last_read_progress'] = Variable<double>(lastReadProgress.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (isRead.present) {
      map['is_read'] = Variable<bool>(isRead.value);
    }
    if (isInReadList.present) {
      map['is_in_read_list'] = Variable<bool>(isInReadList.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    if (fileSize.present) {
      map['file_size'] = Variable<int>(fileSize.value);
    }
    if (genre.present) {
      map['genre'] = Variable<String>(genre.value);
    }
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
          ..write('coverSource: $coverSource, ')
          ..write('format: $format, ')
          ..write('dateAdded: $dateAdded, ')
          ..write('lastOpenedAt: $lastOpenedAt, ')
          ..write('totalPages: $totalPages, ')
          ..write('currentPosition: $currentPosition, ')
          ..write('lastReadProgress: $lastReadProgress, ')
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

class $ShelvesTable extends Shelves with TableInfo<$ShelvesTable, Shelve> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShelvesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dirPathMeta = const VerificationMeta(
    'dirPath',
  );
  @override
  late final GeneratedColumn<String> dirPath = GeneratedColumn<String>(
    'dir_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _parentShelfIdMeta = const VerificationMeta(
    'parentShelfId',
  );
  @override
  late final GeneratedColumn<int> parentShelfId = GeneratedColumn<int>(
    'parent_shelf_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES shelves (id)',
    ),
  );
  static const VerificationMeta _scanRecursiveMeta = const VerificationMeta(
    'scanRecursive',
  );
  @override
  late final GeneratedColumn<bool> scanRecursive = GeneratedColumn<bool>(
    'scan_recursive',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("scan_recursive" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isRootMeta = const VerificationMeta('isRoot');
  @override
  late final GeneratedColumn<bool> isRoot = GeneratedColumn<bool>(
    'is_root',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_root" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastScannedAtMeta = const VerificationMeta(
    'lastScannedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastScannedAt =
      GeneratedColumn<DateTime>(
        'last_scanned_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _displayOrderMeta = const VerificationMeta(
    'displayOrder',
  );
  @override
  late final GeneratedColumn<int> displayOrder = GeneratedColumn<int>(
    'display_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    dirPath,
    parentShelfId,
    scanRecursive,
    isRoot,
    lastScannedAt,
    displayOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shelves';
  @override
  VerificationContext validateIntegrity(
    Insertable<Shelve> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('dir_path')) {
      context.handle(
        _dirPathMeta,
        dirPath.isAcceptableOrUnknown(data['dir_path']!, _dirPathMeta),
      );
    } else if (isInserting) {
      context.missing(_dirPathMeta);
    }
    if (data.containsKey('parent_shelf_id')) {
      context.handle(
        _parentShelfIdMeta,
        parentShelfId.isAcceptableOrUnknown(
          data['parent_shelf_id']!,
          _parentShelfIdMeta,
        ),
      );
    }
    if (data.containsKey('scan_recursive')) {
      context.handle(
        _scanRecursiveMeta,
        scanRecursive.isAcceptableOrUnknown(
          data['scan_recursive']!,
          _scanRecursiveMeta,
        ),
      );
    }
    if (data.containsKey('is_root')) {
      context.handle(
        _isRootMeta,
        isRoot.isAcceptableOrUnknown(data['is_root']!, _isRootMeta),
      );
    }
    if (data.containsKey('last_scanned_at')) {
      context.handle(
        _lastScannedAtMeta,
        lastScannedAt.isAcceptableOrUnknown(
          data['last_scanned_at']!,
          _lastScannedAtMeta,
        ),
      );
    }
    if (data.containsKey('display_order')) {
      context.handle(
        _displayOrderMeta,
        displayOrder.isAcceptableOrUnknown(
          data['display_order']!,
          _displayOrderMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Shelve map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Shelve(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      dirPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dir_path'],
      )!,
      parentShelfId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}parent_shelf_id'],
      ),
      scanRecursive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}scan_recursive'],
      )!,
      isRoot: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_root'],
      )!,
      lastScannedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_scanned_at'],
      ),
      displayOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}display_order'],
      )!,
    );
  }

  @override
  $ShelvesTable createAlias(String alias) {
    return $ShelvesTable(attachedDatabase, alias);
  }
}

class Shelve extends DataClass implements Insertable<Shelve> {
  final int id;
  final String name;
  final String dirPath;
  final int? parentShelfId;
  final bool scanRecursive;
  final bool isRoot;
  final DateTime? lastScannedAt;
  final int displayOrder;
  const Shelve({
    required this.id,
    required this.name,
    required this.dirPath,
    this.parentShelfId,
    required this.scanRecursive,
    required this.isRoot,
    this.lastScannedAt,
    required this.displayOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['dir_path'] = Variable<String>(dirPath);
    if (!nullToAbsent || parentShelfId != null) {
      map['parent_shelf_id'] = Variable<int>(parentShelfId);
    }
    map['scan_recursive'] = Variable<bool>(scanRecursive);
    map['is_root'] = Variable<bool>(isRoot);
    if (!nullToAbsent || lastScannedAt != null) {
      map['last_scanned_at'] = Variable<DateTime>(lastScannedAt);
    }
    map['display_order'] = Variable<int>(displayOrder);
    return map;
  }

  ShelvesCompanion toCompanion(bool nullToAbsent) {
    return ShelvesCompanion(
      id: Value(id),
      name: Value(name),
      dirPath: Value(dirPath),
      parentShelfId: parentShelfId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentShelfId),
      scanRecursive: Value(scanRecursive),
      isRoot: Value(isRoot),
      lastScannedAt: lastScannedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastScannedAt),
      displayOrder: Value(displayOrder),
    );
  }

  factory Shelve.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Shelve(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      dirPath: serializer.fromJson<String>(json['dirPath']),
      parentShelfId: serializer.fromJson<int?>(json['parentShelfId']),
      scanRecursive: serializer.fromJson<bool>(json['scanRecursive']),
      isRoot: serializer.fromJson<bool>(json['isRoot']),
      lastScannedAt: serializer.fromJson<DateTime?>(json['lastScannedAt']),
      displayOrder: serializer.fromJson<int>(json['displayOrder']),
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
      'isRoot': serializer.toJson<bool>(isRoot),
      'lastScannedAt': serializer.toJson<DateTime?>(lastScannedAt),
      'displayOrder': serializer.toJson<int>(displayOrder),
    };
  }

  Shelve copyWith({
    int? id,
    String? name,
    String? dirPath,
    Value<int?> parentShelfId = const Value.absent(),
    bool? scanRecursive,
    bool? isRoot,
    Value<DateTime?> lastScannedAt = const Value.absent(),
    int? displayOrder,
  }) => Shelve(
    id: id ?? this.id,
    name: name ?? this.name,
    dirPath: dirPath ?? this.dirPath,
    parentShelfId: parentShelfId.present
        ? parentShelfId.value
        : this.parentShelfId,
    scanRecursive: scanRecursive ?? this.scanRecursive,
    isRoot: isRoot ?? this.isRoot,
    lastScannedAt: lastScannedAt.present
        ? lastScannedAt.value
        : this.lastScannedAt,
    displayOrder: displayOrder ?? this.displayOrder,
  );
  Shelve copyWithCompanion(ShelvesCompanion data) {
    return Shelve(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      dirPath: data.dirPath.present ? data.dirPath.value : this.dirPath,
      parentShelfId: data.parentShelfId.present
          ? data.parentShelfId.value
          : this.parentShelfId,
      scanRecursive: data.scanRecursive.present
          ? data.scanRecursive.value
          : this.scanRecursive,
      isRoot: data.isRoot.present ? data.isRoot.value : this.isRoot,
      lastScannedAt: data.lastScannedAt.present
          ? data.lastScannedAt.value
          : this.lastScannedAt,
      displayOrder: data.displayOrder.present
          ? data.displayOrder.value
          : this.displayOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Shelve(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('dirPath: $dirPath, ')
          ..write('parentShelfId: $parentShelfId, ')
          ..write('scanRecursive: $scanRecursive, ')
          ..write('isRoot: $isRoot, ')
          ..write('lastScannedAt: $lastScannedAt, ')
          ..write('displayOrder: $displayOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    dirPath,
    parentShelfId,
    scanRecursive,
    isRoot,
    lastScannedAt,
    displayOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Shelve &&
          other.id == this.id &&
          other.name == this.name &&
          other.dirPath == this.dirPath &&
          other.parentShelfId == this.parentShelfId &&
          other.scanRecursive == this.scanRecursive &&
          other.isRoot == this.isRoot &&
          other.lastScannedAt == this.lastScannedAt &&
          other.displayOrder == this.displayOrder);
}

class ShelvesCompanion extends UpdateCompanion<Shelve> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> dirPath;
  final Value<int?> parentShelfId;
  final Value<bool> scanRecursive;
  final Value<bool> isRoot;
  final Value<DateTime?> lastScannedAt;
  final Value<int> displayOrder;
  const ShelvesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.dirPath = const Value.absent(),
    this.parentShelfId = const Value.absent(),
    this.scanRecursive = const Value.absent(),
    this.isRoot = const Value.absent(),
    this.lastScannedAt = const Value.absent(),
    this.displayOrder = const Value.absent(),
  });
  ShelvesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String dirPath,
    this.parentShelfId = const Value.absent(),
    this.scanRecursive = const Value.absent(),
    this.isRoot = const Value.absent(),
    this.lastScannedAt = const Value.absent(),
    this.displayOrder = const Value.absent(),
  }) : name = Value(name),
       dirPath = Value(dirPath);
  static Insertable<Shelve> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? dirPath,
    Expression<int>? parentShelfId,
    Expression<bool>? scanRecursive,
    Expression<bool>? isRoot,
    Expression<DateTime>? lastScannedAt,
    Expression<int>? displayOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (dirPath != null) 'dir_path': dirPath,
      if (parentShelfId != null) 'parent_shelf_id': parentShelfId,
      if (scanRecursive != null) 'scan_recursive': scanRecursive,
      if (isRoot != null) 'is_root': isRoot,
      if (lastScannedAt != null) 'last_scanned_at': lastScannedAt,
      if (displayOrder != null) 'display_order': displayOrder,
    });
  }

  ShelvesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? dirPath,
    Value<int?>? parentShelfId,
    Value<bool>? scanRecursive,
    Value<bool>? isRoot,
    Value<DateTime?>? lastScannedAt,
    Value<int>? displayOrder,
  }) {
    return ShelvesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      dirPath: dirPath ?? this.dirPath,
      parentShelfId: parentShelfId ?? this.parentShelfId,
      scanRecursive: scanRecursive ?? this.scanRecursive,
      isRoot: isRoot ?? this.isRoot,
      lastScannedAt: lastScannedAt ?? this.lastScannedAt,
      displayOrder: displayOrder ?? this.displayOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (dirPath.present) {
      map['dir_path'] = Variable<String>(dirPath.value);
    }
    if (parentShelfId.present) {
      map['parent_shelf_id'] = Variable<int>(parentShelfId.value);
    }
    if (scanRecursive.present) {
      map['scan_recursive'] = Variable<bool>(scanRecursive.value);
    }
    if (isRoot.present) {
      map['is_root'] = Variable<bool>(isRoot.value);
    }
    if (lastScannedAt.present) {
      map['last_scanned_at'] = Variable<DateTime>(lastScannedAt.value);
    }
    if (displayOrder.present) {
      map['display_order'] = Variable<int>(displayOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShelvesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('dirPath: $dirPath, ')
          ..write('parentShelfId: $parentShelfId, ')
          ..write('scanRecursive: $scanRecursive, ')
          ..write('isRoot: $isRoot, ')
          ..write('lastScannedAt: $lastScannedAt, ')
          ..write('displayOrder: $displayOrder')
          ..write(')'))
        .toString();
  }
}

class $BookmarksTable extends Bookmarks
    with TableInfo<$BookmarksTable, Bookmark> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookmarksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<int> bookId = GeneratedColumn<int>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES books (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<String> position = GeneratedColumn<String>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bookId,
    position,
    label,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookmarks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Bookmark> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Bookmark map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Bookmark(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      bookId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}book_id'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}position'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $BookmarksTable createAlias(String alias) {
    return $BookmarksTable(attachedDatabase, alias);
  }
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

  factory Bookmark.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
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

  Bookmark copyWith({
    int? id,
    int? bookId,
    String? position,
    String? label,
    DateTime? createdAt,
  }) => Bookmark(
    id: id ?? this.id,
    bookId: bookId ?? this.bookId,
    position: position ?? this.position,
    label: label ?? this.label,
    createdAt: createdAt ?? this.createdAt,
  );
  Bookmark copyWithCompanion(BookmarksCompanion data) {
    return Bookmark(
      id: data.id.present ? data.id.value : this.id,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      position: data.position.present ? data.position.value : this.position,
      label: data.label.present ? data.label.value : this.label,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

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
          other.id == this.id &&
          other.bookId == this.bookId &&
          other.position == this.position &&
          other.label == this.label &&
          other.createdAt == this.createdAt);
}

class BookmarksCompanion extends UpdateCompanion<Bookmark> {
  final Value<int> id;
  final Value<int> bookId;
  final Value<String> position;
  final Value<String> label;
  final Value<DateTime> createdAt;
  const BookmarksCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.position = const Value.absent(),
    this.label = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BookmarksCompanion.insert({
    this.id = const Value.absent(),
    required int bookId,
    required String position,
    this.label = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : bookId = Value(bookId),
       position = Value(position);
  static Insertable<Bookmark> custom({
    Expression<int>? id,
    Expression<int>? bookId,
    Expression<String>? position,
    Expression<String>? label,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookId != null) 'book_id': bookId,
      if (position != null) 'position': position,
      if (label != null) 'label': label,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BookmarksCompanion copyWith({
    Value<int>? id,
    Value<int>? bookId,
    Value<String>? position,
    Value<String>? label,
    Value<DateTime>? createdAt,
  }) {
    return BookmarksCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      position: position ?? this.position,
      label: label ?? this.label,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<int>(bookId.value);
    }
    if (position.present) {
      map['position'] = Variable<String>(position.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
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

class $BookSettingsTable extends BookSettings
    with TableInfo<$BookSettingsTable, BookSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<int> bookId = GeneratedColumn<int>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES books (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _fontSizeMeta = const VerificationMeta(
    'fontSize',
  );
  @override
  late final GeneratedColumn<double> fontSize = GeneratedColumn<double>(
    'font_size',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(16.0),
  );
  static const VerificationMeta _fontFamilyMeta = const VerificationMeta(
    'fontFamily',
  );
  @override
  late final GeneratedColumn<String> fontFamily = GeneratedColumn<String>(
    'font_family',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Default'),
  );
  static const VerificationMeta _lineHeightMeta = const VerificationMeta(
    'lineHeight',
  );
  @override
  late final GeneratedColumn<double> lineHeight = GeneratedColumn<double>(
    'line_height',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.5),
  );
  static const VerificationMeta _themeMeta = const VerificationMeta('theme');
  @override
  late final GeneratedColumn<String> theme = GeneratedColumn<String>(
    'theme',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Light'),
  );
  static const VerificationMeta _brightnessMeta = const VerificationMeta(
    'brightness',
  );
  @override
  late final GeneratedColumn<double> brightness = GeneratedColumn<double>(
    'brightness',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _scrollModeMeta = const VerificationMeta(
    'scrollMode',
  );
  @override
  late final GeneratedColumn<String> scrollMode = GeneratedColumn<String>(
    'scroll_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('paged'),
  );
  static const VerificationMeta _autoScrollEnabledMeta = const VerificationMeta(
    'autoScrollEnabled',
  );
  @override
  late final GeneratedColumn<bool> autoScrollEnabled = GeneratedColumn<bool>(
    'auto_scroll_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("auto_scroll_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _autoScrollSpeedMeta = const VerificationMeta(
    'autoScrollSpeed',
  );
  @override
  late final GeneratedColumn<double> autoScrollSpeed = GeneratedColumn<double>(
    'auto_scroll_speed',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(24.0),
  );
  static const VerificationMeta _sleepTimerMinutesMeta = const VerificationMeta(
    'sleepTimerMinutes',
  );
  @override
  late final GeneratedColumn<int> sleepTimerMinutes = GeneratedColumn<int>(
    'sleep_timer_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _readingDirectionMeta = const VerificationMeta(
    'readingDirection',
  );
  @override
  late final GeneratedColumn<String> readingDirection = GeneratedColumn<String>(
    'reading_direction',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('ltr'),
  );
  static const VerificationMeta _doublePageSpreadMeta = const VerificationMeta(
    'doublePageSpread',
  );
  @override
  late final GeneratedColumn<bool> doublePageSpread = GeneratedColumn<bool>(
    'double_page_spread',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("double_page_spread" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _customBgMeta = const VerificationMeta(
    'customBg',
  );
  @override
  late final GeneratedColumn<String> customBg = GeneratedColumn<String>(
    'custom_bg',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customFgMeta = const VerificationMeta(
    'customFg',
  );
  @override
  late final GeneratedColumn<String> customFg = GeneratedColumn<String>(
    'custom_fg',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customAccentMeta = const VerificationMeta(
    'customAccent',
  );
  @override
  late final GeneratedColumn<String> customAccent = GeneratedColumn<String>(
    'custom_accent',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    bookId,
    fontSize,
    fontFamily,
    lineHeight,
    theme,
    brightness,
    scrollMode,
    autoScrollEnabled,
    autoScrollSpeed,
    sleepTimerMinutes,
    readingDirection,
    doublePageSpread,
    customBg,
    customFg,
    customAccent,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'book_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<BookSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    }
    if (data.containsKey('font_size')) {
      context.handle(
        _fontSizeMeta,
        fontSize.isAcceptableOrUnknown(data['font_size']!, _fontSizeMeta),
      );
    }
    if (data.containsKey('font_family')) {
      context.handle(
        _fontFamilyMeta,
        fontFamily.isAcceptableOrUnknown(data['font_family']!, _fontFamilyMeta),
      );
    }
    if (data.containsKey('line_height')) {
      context.handle(
        _lineHeightMeta,
        lineHeight.isAcceptableOrUnknown(data['line_height']!, _lineHeightMeta),
      );
    }
    if (data.containsKey('theme')) {
      context.handle(
        _themeMeta,
        theme.isAcceptableOrUnknown(data['theme']!, _themeMeta),
      );
    }
    if (data.containsKey('brightness')) {
      context.handle(
        _brightnessMeta,
        brightness.isAcceptableOrUnknown(data['brightness']!, _brightnessMeta),
      );
    }
    if (data.containsKey('scroll_mode')) {
      context.handle(
        _scrollModeMeta,
        scrollMode.isAcceptableOrUnknown(data['scroll_mode']!, _scrollModeMeta),
      );
    }
    if (data.containsKey('auto_scroll_enabled')) {
      context.handle(
        _autoScrollEnabledMeta,
        autoScrollEnabled.isAcceptableOrUnknown(
          data['auto_scroll_enabled']!,
          _autoScrollEnabledMeta,
        ),
      );
    }
    if (data.containsKey('auto_scroll_speed')) {
      context.handle(
        _autoScrollSpeedMeta,
        autoScrollSpeed.isAcceptableOrUnknown(
          data['auto_scroll_speed']!,
          _autoScrollSpeedMeta,
        ),
      );
    }
    if (data.containsKey('sleep_timer_minutes')) {
      context.handle(
        _sleepTimerMinutesMeta,
        sleepTimerMinutes.isAcceptableOrUnknown(
          data['sleep_timer_minutes']!,
          _sleepTimerMinutesMeta,
        ),
      );
    }
    if (data.containsKey('reading_direction')) {
      context.handle(
        _readingDirectionMeta,
        readingDirection.isAcceptableOrUnknown(
          data['reading_direction']!,
          _readingDirectionMeta,
        ),
      );
    }
    if (data.containsKey('double_page_spread')) {
      context.handle(
        _doublePageSpreadMeta,
        doublePageSpread.isAcceptableOrUnknown(
          data['double_page_spread']!,
          _doublePageSpreadMeta,
        ),
      );
    }
    if (data.containsKey('custom_bg')) {
      context.handle(
        _customBgMeta,
        customBg.isAcceptableOrUnknown(data['custom_bg']!, _customBgMeta),
      );
    }
    if (data.containsKey('custom_fg')) {
      context.handle(
        _customFgMeta,
        customFg.isAcceptableOrUnknown(data['custom_fg']!, _customFgMeta),
      );
    }
    if (data.containsKey('custom_accent')) {
      context.handle(
        _customAccentMeta,
        customAccent.isAcceptableOrUnknown(
          data['custom_accent']!,
          _customAccentMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {bookId};
  @override
  BookSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BookSetting(
      bookId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}book_id'],
      )!,
      fontSize: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}font_size'],
      )!,
      fontFamily: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}font_family'],
      )!,
      lineHeight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}line_height'],
      )!,
      theme: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme'],
      )!,
      brightness: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}brightness'],
      )!,
      scrollMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scroll_mode'],
      )!,
      autoScrollEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}auto_scroll_enabled'],
      )!,
      autoScrollSpeed: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}auto_scroll_speed'],
      )!,
      sleepTimerMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sleep_timer_minutes'],
      )!,
      readingDirection: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reading_direction'],
      )!,
      doublePageSpread: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}double_page_spread'],
      )!,
      customBg: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_bg'],
      ),
      customFg: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_fg'],
      ),
      customAccent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_accent'],
      ),
    );
  }

  @override
  $BookSettingsTable createAlias(String alias) {
    return $BookSettingsTable(attachedDatabase, alias);
  }
}

class BookSetting extends DataClass implements Insertable<BookSetting> {
  final int bookId;
  final double fontSize;
  final String fontFamily;
  final double lineHeight;
  final String theme;
  final double brightness;
  final String scrollMode;
  final bool autoScrollEnabled;
  final double autoScrollSpeed;
  final int sleepTimerMinutes;
  final String readingDirection;
  final bool doublePageSpread;
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
    required this.autoScrollEnabled,
    required this.autoScrollSpeed,
    required this.sleepTimerMinutes,
    required this.readingDirection,
    required this.doublePageSpread,
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
    map['auto_scroll_enabled'] = Variable<bool>(autoScrollEnabled);
    map['auto_scroll_speed'] = Variable<double>(autoScrollSpeed);
    map['sleep_timer_minutes'] = Variable<int>(sleepTimerMinutes);
    map['reading_direction'] = Variable<String>(readingDirection);
    map['double_page_spread'] = Variable<bool>(doublePageSpread);
    if (!nullToAbsent || customBg != null) {
      map['custom_bg'] = Variable<String>(customBg);
    }
    if (!nullToAbsent || customFg != null) {
      map['custom_fg'] = Variable<String>(customFg);
    }
    if (!nullToAbsent || customAccent != null) {
      map['custom_accent'] = Variable<String>(customAccent);
    }
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
      autoScrollEnabled: Value(autoScrollEnabled),
      autoScrollSpeed: Value(autoScrollSpeed),
      sleepTimerMinutes: Value(sleepTimerMinutes),
      readingDirection: Value(readingDirection),
      doublePageSpread: Value(doublePageSpread),
      customBg: customBg == null && nullToAbsent
          ? const Value.absent()
          : Value(customBg),
      customFg: customFg == null && nullToAbsent
          ? const Value.absent()
          : Value(customFg),
      customAccent: customAccent == null && nullToAbsent
          ? const Value.absent()
          : Value(customAccent),
    );
  }

  factory BookSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BookSetting(
      bookId: serializer.fromJson<int>(json['bookId']),
      fontSize: serializer.fromJson<double>(json['fontSize']),
      fontFamily: serializer.fromJson<String>(json['fontFamily']),
      lineHeight: serializer.fromJson<double>(json['lineHeight']),
      theme: serializer.fromJson<String>(json['theme']),
      brightness: serializer.fromJson<double>(json['brightness']),
      scrollMode: serializer.fromJson<String>(json['scrollMode']),
      autoScrollEnabled: serializer.fromJson<bool>(json['autoScrollEnabled']),
      autoScrollSpeed: serializer.fromJson<double>(json['autoScrollSpeed']),
      sleepTimerMinutes: serializer.fromJson<int>(json['sleepTimerMinutes']),
      readingDirection: serializer.fromJson<String>(json['readingDirection']),
      doublePageSpread: serializer.fromJson<bool>(json['doublePageSpread']),
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
      'autoScrollEnabled': serializer.toJson<bool>(autoScrollEnabled),
      'autoScrollSpeed': serializer.toJson<double>(autoScrollSpeed),
      'sleepTimerMinutes': serializer.toJson<int>(sleepTimerMinutes),
      'readingDirection': serializer.toJson<String>(readingDirection),
      'doublePageSpread': serializer.toJson<bool>(doublePageSpread),
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
    bool? autoScrollEnabled,
    double? autoScrollSpeed,
    int? sleepTimerMinutes,
    String? readingDirection,
    bool? doublePageSpread,
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
    autoScrollEnabled: autoScrollEnabled ?? this.autoScrollEnabled,
    autoScrollSpeed: autoScrollSpeed ?? this.autoScrollSpeed,
    sleepTimerMinutes: sleepTimerMinutes ?? this.sleepTimerMinutes,
    readingDirection: readingDirection ?? this.readingDirection,
    doublePageSpread: doublePageSpread ?? this.doublePageSpread,
    customBg: customBg.present ? customBg.value : this.customBg,
    customFg: customFg.present ? customFg.value : this.customFg,
    customAccent: customAccent.present ? customAccent.value : this.customAccent,
  );
  BookSetting copyWithCompanion(BookSettingsCompanion data) {
    return BookSetting(
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      fontSize: data.fontSize.present ? data.fontSize.value : this.fontSize,
      fontFamily: data.fontFamily.present
          ? data.fontFamily.value
          : this.fontFamily,
      lineHeight: data.lineHeight.present
          ? data.lineHeight.value
          : this.lineHeight,
      theme: data.theme.present ? data.theme.value : this.theme,
      brightness: data.brightness.present
          ? data.brightness.value
          : this.brightness,
      scrollMode: data.scrollMode.present
          ? data.scrollMode.value
          : this.scrollMode,
      autoScrollEnabled: data.autoScrollEnabled.present
          ? data.autoScrollEnabled.value
          : this.autoScrollEnabled,
      autoScrollSpeed: data.autoScrollSpeed.present
          ? data.autoScrollSpeed.value
          : this.autoScrollSpeed,
      sleepTimerMinutes: data.sleepTimerMinutes.present
          ? data.sleepTimerMinutes.value
          : this.sleepTimerMinutes,
      readingDirection: data.readingDirection.present
          ? data.readingDirection.value
          : this.readingDirection,
      doublePageSpread: data.doublePageSpread.present
          ? data.doublePageSpread.value
          : this.doublePageSpread,
      customBg: data.customBg.present ? data.customBg.value : this.customBg,
      customFg: data.customFg.present ? data.customFg.value : this.customFg,
      customAccent: data.customAccent.present
          ? data.customAccent.value
          : this.customAccent,
    );
  }

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
          ..write('autoScrollEnabled: $autoScrollEnabled, ')
          ..write('autoScrollSpeed: $autoScrollSpeed, ')
          ..write('sleepTimerMinutes: $sleepTimerMinutes, ')
          ..write('readingDirection: $readingDirection, ')
          ..write('doublePageSpread: $doublePageSpread, ')
          ..write('customBg: $customBg, ')
          ..write('customFg: $customFg, ')
          ..write('customAccent: $customAccent')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    bookId,
    fontSize,
    fontFamily,
    lineHeight,
    theme,
    brightness,
    scrollMode,
    autoScrollEnabled,
    autoScrollSpeed,
    sleepTimerMinutes,
    readingDirection,
    doublePageSpread,
    customBg,
    customFg,
    customAccent,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BookSetting &&
          other.bookId == this.bookId &&
          other.fontSize == this.fontSize &&
          other.fontFamily == this.fontFamily &&
          other.lineHeight == this.lineHeight &&
          other.theme == this.theme &&
          other.brightness == this.brightness &&
          other.scrollMode == this.scrollMode &&
          other.autoScrollEnabled == this.autoScrollEnabled &&
          other.autoScrollSpeed == this.autoScrollSpeed &&
          other.sleepTimerMinutes == this.sleepTimerMinutes &&
          other.readingDirection == this.readingDirection &&
          other.doublePageSpread == this.doublePageSpread &&
          other.customBg == this.customBg &&
          other.customFg == this.customFg &&
          other.customAccent == this.customAccent);
}

class BookSettingsCompanion extends UpdateCompanion<BookSetting> {
  final Value<int> bookId;
  final Value<double> fontSize;
  final Value<String> fontFamily;
  final Value<double> lineHeight;
  final Value<String> theme;
  final Value<double> brightness;
  final Value<String> scrollMode;
  final Value<bool> autoScrollEnabled;
  final Value<double> autoScrollSpeed;
  final Value<int> sleepTimerMinutes;
  final Value<String> readingDirection;
  final Value<bool> doublePageSpread;
  final Value<String?> customBg;
  final Value<String?> customFg;
  final Value<String?> customAccent;
  const BookSettingsCompanion({
    this.bookId = const Value.absent(),
    this.fontSize = const Value.absent(),
    this.fontFamily = const Value.absent(),
    this.lineHeight = const Value.absent(),
    this.theme = const Value.absent(),
    this.brightness = const Value.absent(),
    this.scrollMode = const Value.absent(),
    this.autoScrollEnabled = const Value.absent(),
    this.autoScrollSpeed = const Value.absent(),
    this.sleepTimerMinutes = const Value.absent(),
    this.readingDirection = const Value.absent(),
    this.doublePageSpread = const Value.absent(),
    this.customBg = const Value.absent(),
    this.customFg = const Value.absent(),
    this.customAccent = const Value.absent(),
  });
  BookSettingsCompanion.insert({
    this.bookId = const Value.absent(),
    this.fontSize = const Value.absent(),
    this.fontFamily = const Value.absent(),
    this.lineHeight = const Value.absent(),
    this.theme = const Value.absent(),
    this.brightness = const Value.absent(),
    this.scrollMode = const Value.absent(),
    this.autoScrollEnabled = const Value.absent(),
    this.autoScrollSpeed = const Value.absent(),
    this.sleepTimerMinutes = const Value.absent(),
    this.readingDirection = const Value.absent(),
    this.doublePageSpread = const Value.absent(),
    this.customBg = const Value.absent(),
    this.customFg = const Value.absent(),
    this.customAccent = const Value.absent(),
  });
  static Insertable<BookSetting> custom({
    Expression<int>? bookId,
    Expression<double>? fontSize,
    Expression<String>? fontFamily,
    Expression<double>? lineHeight,
    Expression<String>? theme,
    Expression<double>? brightness,
    Expression<String>? scrollMode,
    Expression<bool>? autoScrollEnabled,
    Expression<double>? autoScrollSpeed,
    Expression<int>? sleepTimerMinutes,
    Expression<String>? readingDirection,
    Expression<bool>? doublePageSpread,
    Expression<String>? customBg,
    Expression<String>? customFg,
    Expression<String>? customAccent,
  }) {
    return RawValuesInsertable({
      if (bookId != null) 'book_id': bookId,
      if (fontSize != null) 'font_size': fontSize,
      if (fontFamily != null) 'font_family': fontFamily,
      if (lineHeight != null) 'line_height': lineHeight,
      if (theme != null) 'theme': theme,
      if (brightness != null) 'brightness': brightness,
      if (scrollMode != null) 'scroll_mode': scrollMode,
      if (autoScrollEnabled != null) 'auto_scroll_enabled': autoScrollEnabled,
      if (autoScrollSpeed != null) 'auto_scroll_speed': autoScrollSpeed,
      if (sleepTimerMinutes != null) 'sleep_timer_minutes': sleepTimerMinutes,
      if (readingDirection != null) 'reading_direction': readingDirection,
      if (doublePageSpread != null) 'double_page_spread': doublePageSpread,
      if (customBg != null) 'custom_bg': customBg,
      if (customFg != null) 'custom_fg': customFg,
      if (customAccent != null) 'custom_accent': customAccent,
    });
  }

  BookSettingsCompanion copyWith({
    Value<int>? bookId,
    Value<double>? fontSize,
    Value<String>? fontFamily,
    Value<double>? lineHeight,
    Value<String>? theme,
    Value<double>? brightness,
    Value<String>? scrollMode,
    Value<bool>? autoScrollEnabled,
    Value<double>? autoScrollSpeed,
    Value<int>? sleepTimerMinutes,
    Value<String>? readingDirection,
    Value<bool>? doublePageSpread,
    Value<String?>? customBg,
    Value<String?>? customFg,
    Value<String?>? customAccent,
  }) {
    return BookSettingsCompanion(
      bookId: bookId ?? this.bookId,
      fontSize: fontSize ?? this.fontSize,
      fontFamily: fontFamily ?? this.fontFamily,
      lineHeight: lineHeight ?? this.lineHeight,
      theme: theme ?? this.theme,
      brightness: brightness ?? this.brightness,
      scrollMode: scrollMode ?? this.scrollMode,
      autoScrollEnabled: autoScrollEnabled ?? this.autoScrollEnabled,
      autoScrollSpeed: autoScrollSpeed ?? this.autoScrollSpeed,
      sleepTimerMinutes: sleepTimerMinutes ?? this.sleepTimerMinutes,
      readingDirection: readingDirection ?? this.readingDirection,
      doublePageSpread: doublePageSpread ?? this.doublePageSpread,
      customBg: customBg ?? this.customBg,
      customFg: customFg ?? this.customFg,
      customAccent: customAccent ?? this.customAccent,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (bookId.present) {
      map['book_id'] = Variable<int>(bookId.value);
    }
    if (fontSize.present) {
      map['font_size'] = Variable<double>(fontSize.value);
    }
    if (fontFamily.present) {
      map['font_family'] = Variable<String>(fontFamily.value);
    }
    if (lineHeight.present) {
      map['line_height'] = Variable<double>(lineHeight.value);
    }
    if (theme.present) {
      map['theme'] = Variable<String>(theme.value);
    }
    if (brightness.present) {
      map['brightness'] = Variable<double>(brightness.value);
    }
    if (scrollMode.present) {
      map['scroll_mode'] = Variable<String>(scrollMode.value);
    }
    if (autoScrollEnabled.present) {
      map['auto_scroll_enabled'] = Variable<bool>(autoScrollEnabled.value);
    }
    if (autoScrollSpeed.present) {
      map['auto_scroll_speed'] = Variable<double>(autoScrollSpeed.value);
    }
    if (sleepTimerMinutes.present) {
      map['sleep_timer_minutes'] = Variable<int>(sleepTimerMinutes.value);
    }
    if (readingDirection.present) {
      map['reading_direction'] = Variable<String>(readingDirection.value);
    }
    if (doublePageSpread.present) {
      map['double_page_spread'] = Variable<bool>(doublePageSpread.value);
    }
    if (customBg.present) {
      map['custom_bg'] = Variable<String>(customBg.value);
    }
    if (customFg.present) {
      map['custom_fg'] = Variable<String>(customFg.value);
    }
    if (customAccent.present) {
      map['custom_accent'] = Variable<String>(customAccent.value);
    }
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
          ..write('autoScrollEnabled: $autoScrollEnabled, ')
          ..write('autoScrollSpeed: $autoScrollSpeed, ')
          ..write('sleepTimerMinutes: $sleepTimerMinutes, ')
          ..write('readingDirection: $readingDirection, ')
          ..write('doublePageSpread: $doublePageSpread, ')
          ..write('customBg: $customBg, ')
          ..write('customFg: $customFg, ')
          ..write('customAccent: $customAccent')
          ..write(')'))
        .toString();
  }
}

class $ReadingSessionsTable extends ReadingSessions
    with TableInfo<$ReadingSessionsTable, ReadingSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReadingSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<int> bookId = GeneratedColumn<int>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES books (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pagesReadMeta = const VerificationMeta(
    'pagesRead',
  );
  @override
  late final GeneratedColumn<int> pagesRead = GeneratedColumn<int>(
    'pages_read',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bookId,
    startedAt,
    endedAt,
    pagesRead,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reading_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReadingSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    if (data.containsKey('pages_read')) {
      context.handle(
        _pagesReadMeta,
        pagesRead.isAcceptableOrUnknown(data['pages_read']!, _pagesReadMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReadingSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReadingSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      bookId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}book_id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
      pagesRead: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pages_read'],
      )!,
    );
  }

  @override
  $ReadingSessionsTable createAlias(String alias) {
    return $ReadingSessionsTable(attachedDatabase, alias);
  }
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
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    map['pages_read'] = Variable<int>(pagesRead);
    return map;
  }

  ReadingSessionsCompanion toCompanion(bool nullToAbsent) {
    return ReadingSessionsCompanion(
      id: Value(id),
      bookId: Value(bookId),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      pagesRead: Value(pagesRead),
    );
  }

  factory ReadingSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
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
  ReadingSession copyWithCompanion(ReadingSessionsCompanion data) {
    return ReadingSession(
      id: data.id.present ? data.id.value : this.id,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      pagesRead: data.pagesRead.present ? data.pagesRead.value : this.pagesRead,
    );
  }

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
          other.id == this.id &&
          other.bookId == this.bookId &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.pagesRead == this.pagesRead);
}

class ReadingSessionsCompanion extends UpdateCompanion<ReadingSession> {
  final Value<int> id;
  final Value<int> bookId;
  final Value<DateTime> startedAt;
  final Value<DateTime?> endedAt;
  final Value<int> pagesRead;
  const ReadingSessionsCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.pagesRead = const Value.absent(),
  });
  ReadingSessionsCompanion.insert({
    this.id = const Value.absent(),
    required int bookId,
    required DateTime startedAt,
    this.endedAt = const Value.absent(),
    this.pagesRead = const Value.absent(),
  }) : bookId = Value(bookId),
       startedAt = Value(startedAt);
  static Insertable<ReadingSession> custom({
    Expression<int>? id,
    Expression<int>? bookId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<int>? pagesRead,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookId != null) 'book_id': bookId,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (pagesRead != null) 'pages_read': pagesRead,
    });
  }

  ReadingSessionsCompanion copyWith({
    Value<int>? id,
    Value<int>? bookId,
    Value<DateTime>? startedAt,
    Value<DateTime?>? endedAt,
    Value<int>? pagesRead,
  }) {
    return ReadingSessionsCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      pagesRead: pagesRead ?? this.pagesRead,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<int>(bookId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (pagesRead.present) {
      map['pages_read'] = Variable<int>(pagesRead.value);
    }
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

class $HighlightsTable extends Highlights
    with TableInfo<$HighlightsTable, Highlight> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HighlightsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _bookIdMeta = const VerificationMeta('bookId');
  @override
  late final GeneratedColumn<int> bookId = GeneratedColumn<int>(
    'book_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES books (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _cfiRangeMeta = const VerificationMeta(
    'cfiRange',
  );
  @override
  late final GeneratedColumn<String> cfiRange = GeneratedColumn<String>(
    'cfi_range',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _selectedTextMeta = const VerificationMeta(
    'selectedText',
  );
  @override
  late final GeneratedColumn<String> selectedText = GeneratedColumn<String>(
    'selected_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('yellow'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    bookId,
    cfiRange,
    selectedText,
    color,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'highlights';
  @override
  VerificationContext validateIntegrity(
    Insertable<Highlight> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('book_id')) {
      context.handle(
        _bookIdMeta,
        bookId.isAcceptableOrUnknown(data['book_id']!, _bookIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bookIdMeta);
    }
    if (data.containsKey('cfi_range')) {
      context.handle(
        _cfiRangeMeta,
        cfiRange.isAcceptableOrUnknown(data['cfi_range']!, _cfiRangeMeta),
      );
    } else if (isInserting) {
      context.missing(_cfiRangeMeta);
    }
    if (data.containsKey('selected_text')) {
      context.handle(
        _selectedTextMeta,
        selectedText.isAcceptableOrUnknown(
          data['selected_text']!,
          _selectedTextMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_selectedTextMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Highlight map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Highlight(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      bookId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}book_id'],
      )!,
      cfiRange: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cfi_range'],
      )!,
      selectedText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}selected_text'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $HighlightsTable createAlias(String alias) {
    return $HighlightsTable(attachedDatabase, alias);
  }
}

class Highlight extends DataClass implements Insertable<Highlight> {
  final int id;
  final int bookId;
  final String cfiRange;
  final String selectedText;
  final String color;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Highlight({
    required this.id,
    required this.bookId,
    required this.cfiRange,
    required this.selectedText,
    required this.color,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['book_id'] = Variable<int>(bookId);
    map['cfi_range'] = Variable<String>(cfiRange);
    map['selected_text'] = Variable<String>(selectedText);
    map['color'] = Variable<String>(color);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  HighlightsCompanion toCompanion(bool nullToAbsent) {
    return HighlightsCompanion(
      id: Value(id),
      bookId: Value(bookId),
      cfiRange: Value(cfiRange),
      selectedText: Value(selectedText),
      color: Value(color),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Highlight.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Highlight(
      id: serializer.fromJson<int>(json['id']),
      bookId: serializer.fromJson<int>(json['bookId']),
      cfiRange: serializer.fromJson<String>(json['cfiRange']),
      selectedText: serializer.fromJson<String>(json['selectedText']),
      color: serializer.fromJson<String>(json['color']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'bookId': serializer.toJson<int>(bookId),
      'cfiRange': serializer.toJson<String>(cfiRange),
      'selectedText': serializer.toJson<String>(selectedText),
      'color': serializer.toJson<String>(color),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Highlight copyWith({
    int? id,
    int? bookId,
    String? cfiRange,
    String? selectedText,
    String? color,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Highlight(
    id: id ?? this.id,
    bookId: bookId ?? this.bookId,
    cfiRange: cfiRange ?? this.cfiRange,
    selectedText: selectedText ?? this.selectedText,
    color: color ?? this.color,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Highlight copyWithCompanion(HighlightsCompanion data) {
    return Highlight(
      id: data.id.present ? data.id.value : this.id,
      bookId: data.bookId.present ? data.bookId.value : this.bookId,
      cfiRange: data.cfiRange.present ? data.cfiRange.value : this.cfiRange,
      selectedText: data.selectedText.present
          ? data.selectedText.value
          : this.selectedText,
      color: data.color.present ? data.color.value : this.color,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Highlight(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('cfiRange: $cfiRange, ')
          ..write('selectedText: $selectedText, ')
          ..write('color: $color, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    bookId,
    cfiRange,
    selectedText,
    color,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Highlight &&
          other.id == this.id &&
          other.bookId == this.bookId &&
          other.cfiRange == this.cfiRange &&
          other.selectedText == this.selectedText &&
          other.color == this.color &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class HighlightsCompanion extends UpdateCompanion<Highlight> {
  final Value<int> id;
  final Value<int> bookId;
  final Value<String> cfiRange;
  final Value<String> selectedText;
  final Value<String> color;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const HighlightsCompanion({
    this.id = const Value.absent(),
    this.bookId = const Value.absent(),
    this.cfiRange = const Value.absent(),
    this.selectedText = const Value.absent(),
    this.color = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  HighlightsCompanion.insert({
    this.id = const Value.absent(),
    required int bookId,
    required String cfiRange,
    required String selectedText,
    this.color = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : bookId = Value(bookId),
       cfiRange = Value(cfiRange),
       selectedText = Value(selectedText);
  static Insertable<Highlight> custom({
    Expression<int>? id,
    Expression<int>? bookId,
    Expression<String>? cfiRange,
    Expression<String>? selectedText,
    Expression<String>? color,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (bookId != null) 'book_id': bookId,
      if (cfiRange != null) 'cfi_range': cfiRange,
      if (selectedText != null) 'selected_text': selectedText,
      if (color != null) 'color': color,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  HighlightsCompanion copyWith({
    Value<int>? id,
    Value<int>? bookId,
    Value<String>? cfiRange,
    Value<String>? selectedText,
    Value<String>? color,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return HighlightsCompanion(
      id: id ?? this.id,
      bookId: bookId ?? this.bookId,
      cfiRange: cfiRange ?? this.cfiRange,
      selectedText: selectedText ?? this.selectedText,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (bookId.present) {
      map['book_id'] = Variable<int>(bookId.value);
    }
    if (cfiRange.present) {
      map['cfi_range'] = Variable<String>(cfiRange.value);
    }
    if (selectedText.present) {
      map['selected_text'] = Variable<String>(selectedText.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HighlightsCompanion(')
          ..write('id: $id, ')
          ..write('bookId: $bookId, ')
          ..write('cfiRange: $cfiRange, ')
          ..write('selectedText: $selectedText, ')
          ..write('color: $color, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BooksTable books = $BooksTable(this);
  late final $ShelvesTable shelves = $ShelvesTable(this);
  late final $BookmarksTable bookmarks = $BookmarksTable(this);
  late final $BookSettingsTable bookSettings = $BookSettingsTable(this);
  late final $ReadingSessionsTable readingSessions = $ReadingSessionsTable(
    this,
  );
  late final $HighlightsTable highlights = $HighlightsTable(this);
  late final BooksDao booksDao = BooksDao(this as AppDatabase);
  late final ShelvesDao shelvesDao = ShelvesDao(this as AppDatabase);
  late final BookmarksDao bookmarksDao = BookmarksDao(this as AppDatabase);
  late final BookSettingsDao bookSettingsDao = BookSettingsDao(
    this as AppDatabase,
  );
  late final ReadingSessionsDao readingSessionsDao = ReadingSessionsDao(
    this as AppDatabase,
  );
  late final HighlightsDao highlightsDao = HighlightsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    books,
    shelves,
    bookmarks,
    bookSettings,
    readingSessions,
    highlights,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'books',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('bookmarks', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'books',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('book_settings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'books',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('reading_sessions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'books',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('highlights', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$BooksTableCreateCompanionBuilder =
    BooksCompanion Function({
      Value<int> id,
      required String title,
      Value<String> author,
      required String filePath,
      Value<String?> coverPath,
      Value<String> coverSource,
      Value<String> format,
      Value<DateTime> dateAdded,
      Value<DateTime?> lastOpenedAt,
      Value<int> totalPages,
      Value<String> currentPosition,
      Value<double> lastReadProgress,
      Value<bool> isFavorite,
      Value<bool> isRead,
      Value<bool> isInReadList,
      Value<double?> rating,
      Value<int> fileSize,
      Value<String?> genre,
    });
typedef $$BooksTableUpdateCompanionBuilder =
    BooksCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> author,
      Value<String> filePath,
      Value<String?> coverPath,
      Value<String> coverSource,
      Value<String> format,
      Value<DateTime> dateAdded,
      Value<DateTime?> lastOpenedAt,
      Value<int> totalPages,
      Value<String> currentPosition,
      Value<double> lastReadProgress,
      Value<bool> isFavorite,
      Value<bool> isRead,
      Value<bool> isInReadList,
      Value<double?> rating,
      Value<int> fileSize,
      Value<String?> genre,
    });

final class $$BooksTableReferences
    extends BaseReferences<_$AppDatabase, $BooksTable, Book> {
  $$BooksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BookmarksTable, List<Bookmark>>
  _bookmarksRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.bookmarks,
    aliasName: $_aliasNameGenerator(db.books.id, db.bookmarks.bookId),
  );

  $$BookmarksTableProcessedTableManager get bookmarksRefs {
    final manager = $$BookmarksTableTableManager(
      $_db,
      $_db.bookmarks,
    ).filter((f) => f.bookId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_bookmarksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BookSettingsTable, List<BookSetting>>
  _bookSettingsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.bookSettings,
    aliasName: $_aliasNameGenerator(db.books.id, db.bookSettings.bookId),
  );

  $$BookSettingsTableProcessedTableManager get bookSettingsRefs {
    final manager = $$BookSettingsTableTableManager(
      $_db,
      $_db.bookSettings,
    ).filter((f) => f.bookId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_bookSettingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReadingSessionsTable, List<ReadingSession>>
  _readingSessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.readingSessions,
    aliasName: $_aliasNameGenerator(db.books.id, db.readingSessions.bookId),
  );

  $$ReadingSessionsTableProcessedTableManager get readingSessionsRefs {
    final manager = $$ReadingSessionsTableTableManager(
      $_db,
      $_db.readingSessions,
    ).filter((f) => f.bookId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _readingSessionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$HighlightsTable, List<Highlight>>
  _highlightsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.highlights,
    aliasName: $_aliasNameGenerator(db.books.id, db.highlights.bookId),
  );

  $$HighlightsTableProcessedTableManager get highlightsRefs {
    final manager = $$HighlightsTableTableManager(
      $_db,
      $_db.highlights,
    ).filter((f) => f.bookId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_highlightsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BooksTableFilterComposer extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverPath => $composableBuilder(
    column: $table.coverPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverSource => $composableBuilder(
    column: $table.coverSource,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get format => $composableBuilder(
    column: $table.format,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateAdded => $composableBuilder(
    column: $table.dateAdded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastOpenedAt => $composableBuilder(
    column: $table.lastOpenedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalPages => $composableBuilder(
    column: $table.totalPages,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currentPosition => $composableBuilder(
    column: $table.currentPosition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lastReadProgress => $composableBuilder(
    column: $table.lastReadProgress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isInReadList => $composableBuilder(
    column: $table.isInReadList,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fileSize => $composableBuilder(
    column: $table.fileSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get genre => $composableBuilder(
    column: $table.genre,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> bookmarksRefs(
    Expression<bool> Function($$BookmarksTableFilterComposer f) f,
  ) {
    final $$BookmarksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bookmarks,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookmarksTableFilterComposer(
            $db: $db,
            $table: $db.bookmarks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> bookSettingsRefs(
    Expression<bool> Function($$BookSettingsTableFilterComposer f) f,
  ) {
    final $$BookSettingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bookSettings,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookSettingsTableFilterComposer(
            $db: $db,
            $table: $db.bookSettings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> readingSessionsRefs(
    Expression<bool> Function($$ReadingSessionsTableFilterComposer f) f,
  ) {
    final $$ReadingSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.readingSessions,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReadingSessionsTableFilterComposer(
            $db: $db,
            $table: $db.readingSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> highlightsRefs(
    Expression<bool> Function($$HighlightsTableFilterComposer f) f,
  ) {
    final $$HighlightsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.highlights,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HighlightsTableFilterComposer(
            $db: $db,
            $table: $db.highlights,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BooksTableOrderingComposer
    extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get author => $composableBuilder(
    column: $table.author,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverPath => $composableBuilder(
    column: $table.coverPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverSource => $composableBuilder(
    column: $table.coverSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get format => $composableBuilder(
    column: $table.format,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateAdded => $composableBuilder(
    column: $table.dateAdded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastOpenedAt => $composableBuilder(
    column: $table.lastOpenedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalPages => $composableBuilder(
    column: $table.totalPages,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currentPosition => $composableBuilder(
    column: $table.currentPosition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lastReadProgress => $composableBuilder(
    column: $table.lastReadProgress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isInReadList => $composableBuilder(
    column: $table.isInReadList,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fileSize => $composableBuilder(
    column: $table.fileSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get genre => $composableBuilder(
    column: $table.genre,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BooksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BooksTable> {
  $$BooksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<String> get coverPath =>
      $composableBuilder(column: $table.coverPath, builder: (column) => column);

  GeneratedColumn<String> get coverSource => $composableBuilder(
    column: $table.coverSource,
    builder: (column) => column,
  );

  GeneratedColumn<String> get format =>
      $composableBuilder(column: $table.format, builder: (column) => column);

  GeneratedColumn<DateTime> get dateAdded =>
      $composableBuilder(column: $table.dateAdded, builder: (column) => column);

  GeneratedColumn<DateTime> get lastOpenedAt => $composableBuilder(
    column: $table.lastOpenedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalPages => $composableBuilder(
    column: $table.totalPages,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currentPosition => $composableBuilder(
    column: $table.currentPosition,
    builder: (column) => column,
  );

  GeneratedColumn<double> get lastReadProgress => $composableBuilder(
    column: $table.lastReadProgress,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isRead =>
      $composableBuilder(column: $table.isRead, builder: (column) => column);

  GeneratedColumn<bool> get isInReadList => $composableBuilder(
    column: $table.isInReadList,
    builder: (column) => column,
  );

  GeneratedColumn<double> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<int> get fileSize =>
      $composableBuilder(column: $table.fileSize, builder: (column) => column);

  GeneratedColumn<String> get genre =>
      $composableBuilder(column: $table.genre, builder: (column) => column);

  Expression<T> bookmarksRefs<T extends Object>(
    Expression<T> Function($$BookmarksTableAnnotationComposer a) f,
  ) {
    final $$BookmarksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bookmarks,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookmarksTableAnnotationComposer(
            $db: $db,
            $table: $db.bookmarks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> bookSettingsRefs<T extends Object>(
    Expression<T> Function($$BookSettingsTableAnnotationComposer a) f,
  ) {
    final $$BookSettingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bookSettings,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BookSettingsTableAnnotationComposer(
            $db: $db,
            $table: $db.bookSettings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> readingSessionsRefs<T extends Object>(
    Expression<T> Function($$ReadingSessionsTableAnnotationComposer a) f,
  ) {
    final $$ReadingSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.readingSessions,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReadingSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.readingSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> highlightsRefs<T extends Object>(
    Expression<T> Function($$HighlightsTableAnnotationComposer a) f,
  ) {
    final $$HighlightsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.highlights,
      getReferencedColumn: (t) => t.bookId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HighlightsTableAnnotationComposer(
            $db: $db,
            $table: $db.highlights,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BooksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BooksTable,
          Book,
          $$BooksTableFilterComposer,
          $$BooksTableOrderingComposer,
          $$BooksTableAnnotationComposer,
          $$BooksTableCreateCompanionBuilder,
          $$BooksTableUpdateCompanionBuilder,
          (Book, $$BooksTableReferences),
          Book,
          PrefetchHooks Function({
            bool bookmarksRefs,
            bool bookSettingsRefs,
            bool readingSessionsRefs,
            bool highlightsRefs,
          })
        > {
  $$BooksTableTableManager(_$AppDatabase db, $BooksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BooksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BooksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BooksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> author = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<String?> coverPath = const Value.absent(),
                Value<String> coverSource = const Value.absent(),
                Value<String> format = const Value.absent(),
                Value<DateTime> dateAdded = const Value.absent(),
                Value<DateTime?> lastOpenedAt = const Value.absent(),
                Value<int> totalPages = const Value.absent(),
                Value<String> currentPosition = const Value.absent(),
                Value<double> lastReadProgress = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<bool> isInReadList = const Value.absent(),
                Value<double?> rating = const Value.absent(),
                Value<int> fileSize = const Value.absent(),
                Value<String?> genre = const Value.absent(),
              }) => BooksCompanion(
                id: id,
                title: title,
                author: author,
                filePath: filePath,
                coverPath: coverPath,
                coverSource: coverSource,
                format: format,
                dateAdded: dateAdded,
                lastOpenedAt: lastOpenedAt,
                totalPages: totalPages,
                currentPosition: currentPosition,
                lastReadProgress: lastReadProgress,
                isFavorite: isFavorite,
                isRead: isRead,
                isInReadList: isInReadList,
                rating: rating,
                fileSize: fileSize,
                genre: genre,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<String> author = const Value.absent(),
                required String filePath,
                Value<String?> coverPath = const Value.absent(),
                Value<String> coverSource = const Value.absent(),
                Value<String> format = const Value.absent(),
                Value<DateTime> dateAdded = const Value.absent(),
                Value<DateTime?> lastOpenedAt = const Value.absent(),
                Value<int> totalPages = const Value.absent(),
                Value<String> currentPosition = const Value.absent(),
                Value<double> lastReadProgress = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<bool> isInReadList = const Value.absent(),
                Value<double?> rating = const Value.absent(),
                Value<int> fileSize = const Value.absent(),
                Value<String?> genre = const Value.absent(),
              }) => BooksCompanion.insert(
                id: id,
                title: title,
                author: author,
                filePath: filePath,
                coverPath: coverPath,
                coverSource: coverSource,
                format: format,
                dateAdded: dateAdded,
                lastOpenedAt: lastOpenedAt,
                totalPages: totalPages,
                currentPosition: currentPosition,
                lastReadProgress: lastReadProgress,
                isFavorite: isFavorite,
                isRead: isRead,
                isInReadList: isInReadList,
                rating: rating,
                fileSize: fileSize,
                genre: genre,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$BooksTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                bookmarksRefs = false,
                bookSettingsRefs = false,
                readingSessionsRefs = false,
                highlightsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (bookmarksRefs) db.bookmarks,
                    if (bookSettingsRefs) db.bookSettings,
                    if (readingSessionsRefs) db.readingSessions,
                    if (highlightsRefs) db.highlights,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (bookmarksRefs)
                        await $_getPrefetchedData<Book, $BooksTable, Bookmark>(
                          currentTable: table,
                          referencedTable: $$BooksTableReferences
                              ._bookmarksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BooksTableReferences(
                                db,
                                table,
                                p0,
                              ).bookmarksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.bookId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (bookSettingsRefs)
                        await $_getPrefetchedData<
                          Book,
                          $BooksTable,
                          BookSetting
                        >(
                          currentTable: table,
                          referencedTable: $$BooksTableReferences
                              ._bookSettingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BooksTableReferences(
                                db,
                                table,
                                p0,
                              ).bookSettingsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.bookId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (readingSessionsRefs)
                        await $_getPrefetchedData<
                          Book,
                          $BooksTable,
                          ReadingSession
                        >(
                          currentTable: table,
                          referencedTable: $$BooksTableReferences
                              ._readingSessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BooksTableReferences(
                                db,
                                table,
                                p0,
                              ).readingSessionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.bookId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (highlightsRefs)
                        await $_getPrefetchedData<Book, $BooksTable, Highlight>(
                          currentTable: table,
                          referencedTable: $$BooksTableReferences
                              ._highlightsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BooksTableReferences(
                                db,
                                table,
                                p0,
                              ).highlightsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.bookId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BooksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BooksTable,
      Book,
      $$BooksTableFilterComposer,
      $$BooksTableOrderingComposer,
      $$BooksTableAnnotationComposer,
      $$BooksTableCreateCompanionBuilder,
      $$BooksTableUpdateCompanionBuilder,
      (Book, $$BooksTableReferences),
      Book,
      PrefetchHooks Function({
        bool bookmarksRefs,
        bool bookSettingsRefs,
        bool readingSessionsRefs,
        bool highlightsRefs,
      })
    >;
typedef $$ShelvesTableCreateCompanionBuilder =
    ShelvesCompanion Function({
      Value<int> id,
      required String name,
      required String dirPath,
      Value<int?> parentShelfId,
      Value<bool> scanRecursive,
      Value<bool> isRoot,
      Value<DateTime?> lastScannedAt,
      Value<int> displayOrder,
    });
typedef $$ShelvesTableUpdateCompanionBuilder =
    ShelvesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> dirPath,
      Value<int?> parentShelfId,
      Value<bool> scanRecursive,
      Value<bool> isRoot,
      Value<DateTime?> lastScannedAt,
      Value<int> displayOrder,
    });

final class $$ShelvesTableReferences
    extends BaseReferences<_$AppDatabase, $ShelvesTable, Shelve> {
  $$ShelvesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ShelvesTable _parentShelfIdTable(_$AppDatabase db) =>
      db.shelves.createAlias(
        $_aliasNameGenerator(db.shelves.parentShelfId, db.shelves.id),
      );

  $$ShelvesTableProcessedTableManager? get parentShelfId {
    final $_column = $_itemColumn<int>('parent_shelf_id');
    if ($_column == null) return null;
    final manager = $$ShelvesTableTableManager(
      $_db,
      $_db.shelves,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parentShelfIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ShelvesTableFilterComposer
    extends Composer<_$AppDatabase, $ShelvesTable> {
  $$ShelvesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dirPath => $composableBuilder(
    column: $table.dirPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get scanRecursive => $composableBuilder(
    column: $table.scanRecursive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRoot => $composableBuilder(
    column: $table.isRoot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastScannedAt => $composableBuilder(
    column: $table.lastScannedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$ShelvesTableFilterComposer get parentShelfId {
    final $$ShelvesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentShelfId,
      referencedTable: $db.shelves,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShelvesTableFilterComposer(
            $db: $db,
            $table: $db.shelves,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ShelvesTableOrderingComposer
    extends Composer<_$AppDatabase, $ShelvesTable> {
  $$ShelvesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dirPath => $composableBuilder(
    column: $table.dirPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get scanRecursive => $composableBuilder(
    column: $table.scanRecursive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRoot => $composableBuilder(
    column: $table.isRoot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastScannedAt => $composableBuilder(
    column: $table.lastScannedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$ShelvesTableOrderingComposer get parentShelfId {
    final $$ShelvesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentShelfId,
      referencedTable: $db.shelves,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShelvesTableOrderingComposer(
            $db: $db,
            $table: $db.shelves,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ShelvesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShelvesTable> {
  $$ShelvesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get dirPath =>
      $composableBuilder(column: $table.dirPath, builder: (column) => column);

  GeneratedColumn<bool> get scanRecursive => $composableBuilder(
    column: $table.scanRecursive,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isRoot =>
      $composableBuilder(column: $table.isRoot, builder: (column) => column);

  GeneratedColumn<DateTime> get lastScannedAt => $composableBuilder(
    column: $table.lastScannedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => column,
  );

  $$ShelvesTableAnnotationComposer get parentShelfId {
    final $$ShelvesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.parentShelfId,
      referencedTable: $db.shelves,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ShelvesTableAnnotationComposer(
            $db: $db,
            $table: $db.shelves,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ShelvesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShelvesTable,
          Shelve,
          $$ShelvesTableFilterComposer,
          $$ShelvesTableOrderingComposer,
          $$ShelvesTableAnnotationComposer,
          $$ShelvesTableCreateCompanionBuilder,
          $$ShelvesTableUpdateCompanionBuilder,
          (Shelve, $$ShelvesTableReferences),
          Shelve,
          PrefetchHooks Function({bool parentShelfId})
        > {
  $$ShelvesTableTableManager(_$AppDatabase db, $ShelvesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShelvesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShelvesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShelvesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> dirPath = const Value.absent(),
                Value<int?> parentShelfId = const Value.absent(),
                Value<bool> scanRecursive = const Value.absent(),
                Value<bool> isRoot = const Value.absent(),
                Value<DateTime?> lastScannedAt = const Value.absent(),
                Value<int> displayOrder = const Value.absent(),
              }) => ShelvesCompanion(
                id: id,
                name: name,
                dirPath: dirPath,
                parentShelfId: parentShelfId,
                scanRecursive: scanRecursive,
                isRoot: isRoot,
                lastScannedAt: lastScannedAt,
                displayOrder: displayOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String dirPath,
                Value<int?> parentShelfId = const Value.absent(),
                Value<bool> scanRecursive = const Value.absent(),
                Value<bool> isRoot = const Value.absent(),
                Value<DateTime?> lastScannedAt = const Value.absent(),
                Value<int> displayOrder = const Value.absent(),
              }) => ShelvesCompanion.insert(
                id: id,
                name: name,
                dirPath: dirPath,
                parentShelfId: parentShelfId,
                scanRecursive: scanRecursive,
                isRoot: isRoot,
                lastScannedAt: lastScannedAt,
                displayOrder: displayOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ShelvesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({parentShelfId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (parentShelfId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.parentShelfId,
                                referencedTable: $$ShelvesTableReferences
                                    ._parentShelfIdTable(db),
                                referencedColumn: $$ShelvesTableReferences
                                    ._parentShelfIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ShelvesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShelvesTable,
      Shelve,
      $$ShelvesTableFilterComposer,
      $$ShelvesTableOrderingComposer,
      $$ShelvesTableAnnotationComposer,
      $$ShelvesTableCreateCompanionBuilder,
      $$ShelvesTableUpdateCompanionBuilder,
      (Shelve, $$ShelvesTableReferences),
      Shelve,
      PrefetchHooks Function({bool parentShelfId})
    >;
typedef $$BookmarksTableCreateCompanionBuilder =
    BookmarksCompanion Function({
      Value<int> id,
      required int bookId,
      required String position,
      Value<String> label,
      Value<DateTime> createdAt,
    });
typedef $$BookmarksTableUpdateCompanionBuilder =
    BookmarksCompanion Function({
      Value<int> id,
      Value<int> bookId,
      Value<String> position,
      Value<String> label,
      Value<DateTime> createdAt,
    });

final class $$BookmarksTableReferences
    extends BaseReferences<_$AppDatabase, $BookmarksTable, Bookmark> {
  $$BookmarksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BooksTable _bookIdTable(_$AppDatabase db) => db.books.createAlias(
    $_aliasNameGenerator(db.bookmarks.bookId, db.books.id),
  );

  $$BooksTableProcessedTableManager get bookId {
    final $_column = $_itemColumn<int>('book_id')!;

    final manager = $$BooksTableTableManager(
      $_db,
      $_db.books,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bookIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BookmarksTableFilterComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$BooksTableFilterComposer get bookId {
    final $$BooksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableFilterComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BookmarksTableOrderingComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$BooksTableOrderingComposer get bookId {
    final $$BooksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableOrderingComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BookmarksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$BooksTableAnnotationComposer get bookId {
    final $$BooksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableAnnotationComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BookmarksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BookmarksTable,
          Bookmark,
          $$BookmarksTableFilterComposer,
          $$BookmarksTableOrderingComposer,
          $$BookmarksTableAnnotationComposer,
          $$BookmarksTableCreateCompanionBuilder,
          $$BookmarksTableUpdateCompanionBuilder,
          (Bookmark, $$BookmarksTableReferences),
          Bookmark,
          PrefetchHooks Function({bool bookId})
        > {
  $$BookmarksTableTableManager(_$AppDatabase db, $BookmarksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BookmarksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BookmarksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BookmarksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> bookId = const Value.absent(),
                Value<String> position = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => BookmarksCompanion(
                id: id,
                bookId: bookId,
                position: position,
                label: label,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int bookId,
                required String position,
                Value<String> label = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => BookmarksCompanion.insert(
                id: id,
                bookId: bookId,
                position: position,
                label: label,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BookmarksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({bookId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (bookId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.bookId,
                                referencedTable: $$BookmarksTableReferences
                                    ._bookIdTable(db),
                                referencedColumn: $$BookmarksTableReferences
                                    ._bookIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$BookmarksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BookmarksTable,
      Bookmark,
      $$BookmarksTableFilterComposer,
      $$BookmarksTableOrderingComposer,
      $$BookmarksTableAnnotationComposer,
      $$BookmarksTableCreateCompanionBuilder,
      $$BookmarksTableUpdateCompanionBuilder,
      (Bookmark, $$BookmarksTableReferences),
      Bookmark,
      PrefetchHooks Function({bool bookId})
    >;
typedef $$BookSettingsTableCreateCompanionBuilder =
    BookSettingsCompanion Function({
      Value<int> bookId,
      Value<double> fontSize,
      Value<String> fontFamily,
      Value<double> lineHeight,
      Value<String> theme,
      Value<double> brightness,
      Value<String> scrollMode,
      Value<bool> autoScrollEnabled,
      Value<double> autoScrollSpeed,
      Value<int> sleepTimerMinutes,
      Value<String> readingDirection,
      Value<bool> doublePageSpread,
      Value<String?> customBg,
      Value<String?> customFg,
      Value<String?> customAccent,
    });
typedef $$BookSettingsTableUpdateCompanionBuilder =
    BookSettingsCompanion Function({
      Value<int> bookId,
      Value<double> fontSize,
      Value<String> fontFamily,
      Value<double> lineHeight,
      Value<String> theme,
      Value<double> brightness,
      Value<String> scrollMode,
      Value<bool> autoScrollEnabled,
      Value<double> autoScrollSpeed,
      Value<int> sleepTimerMinutes,
      Value<String> readingDirection,
      Value<bool> doublePageSpread,
      Value<String?> customBg,
      Value<String?> customFg,
      Value<String?> customAccent,
    });

final class $$BookSettingsTableReferences
    extends BaseReferences<_$AppDatabase, $BookSettingsTable, BookSetting> {
  $$BookSettingsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BooksTable _bookIdTable(_$AppDatabase db) => db.books.createAlias(
    $_aliasNameGenerator(db.bookSettings.bookId, db.books.id),
  );

  $$BooksTableProcessedTableManager get bookId {
    final $_column = $_itemColumn<int>('book_id')!;

    final manager = $$BooksTableTableManager(
      $_db,
      $_db.books,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bookIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BookSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $BookSettingsTable> {
  $$BookSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<double> get fontSize => $composableBuilder(
    column: $table.fontSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fontFamily => $composableBuilder(
    column: $table.fontFamily,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lineHeight => $composableBuilder(
    column: $table.lineHeight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get theme => $composableBuilder(
    column: $table.theme,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get brightness => $composableBuilder(
    column: $table.brightness,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scrollMode => $composableBuilder(
    column: $table.scrollMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get autoScrollEnabled => $composableBuilder(
    column: $table.autoScrollEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get autoScrollSpeed => $composableBuilder(
    column: $table.autoScrollSpeed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sleepTimerMinutes => $composableBuilder(
    column: $table.sleepTimerMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get readingDirection => $composableBuilder(
    column: $table.readingDirection,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get doublePageSpread => $composableBuilder(
    column: $table.doublePageSpread,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customBg => $composableBuilder(
    column: $table.customBg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customFg => $composableBuilder(
    column: $table.customFg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customAccent => $composableBuilder(
    column: $table.customAccent,
    builder: (column) => ColumnFilters(column),
  );

  $$BooksTableFilterComposer get bookId {
    final $$BooksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableFilterComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BookSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $BookSettingsTable> {
  $$BookSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<double> get fontSize => $composableBuilder(
    column: $table.fontSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fontFamily => $composableBuilder(
    column: $table.fontFamily,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lineHeight => $composableBuilder(
    column: $table.lineHeight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get theme => $composableBuilder(
    column: $table.theme,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get brightness => $composableBuilder(
    column: $table.brightness,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scrollMode => $composableBuilder(
    column: $table.scrollMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get autoScrollEnabled => $composableBuilder(
    column: $table.autoScrollEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get autoScrollSpeed => $composableBuilder(
    column: $table.autoScrollSpeed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sleepTimerMinutes => $composableBuilder(
    column: $table.sleepTimerMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get readingDirection => $composableBuilder(
    column: $table.readingDirection,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get doublePageSpread => $composableBuilder(
    column: $table.doublePageSpread,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customBg => $composableBuilder(
    column: $table.customBg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customFg => $composableBuilder(
    column: $table.customFg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customAccent => $composableBuilder(
    column: $table.customAccent,
    builder: (column) => ColumnOrderings(column),
  );

  $$BooksTableOrderingComposer get bookId {
    final $$BooksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableOrderingComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BookSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookSettingsTable> {
  $$BookSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<double> get fontSize =>
      $composableBuilder(column: $table.fontSize, builder: (column) => column);

  GeneratedColumn<String> get fontFamily => $composableBuilder(
    column: $table.fontFamily,
    builder: (column) => column,
  );

  GeneratedColumn<double> get lineHeight => $composableBuilder(
    column: $table.lineHeight,
    builder: (column) => column,
  );

  GeneratedColumn<String> get theme =>
      $composableBuilder(column: $table.theme, builder: (column) => column);

  GeneratedColumn<double> get brightness => $composableBuilder(
    column: $table.brightness,
    builder: (column) => column,
  );

  GeneratedColumn<String> get scrollMode => $composableBuilder(
    column: $table.scrollMode,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get autoScrollEnabled => $composableBuilder(
    column: $table.autoScrollEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<double> get autoScrollSpeed => $composableBuilder(
    column: $table.autoScrollSpeed,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sleepTimerMinutes => $composableBuilder(
    column: $table.sleepTimerMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get readingDirection => $composableBuilder(
    column: $table.readingDirection,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get doublePageSpread => $composableBuilder(
    column: $table.doublePageSpread,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customBg =>
      $composableBuilder(column: $table.customBg, builder: (column) => column);

  GeneratedColumn<String> get customFg =>
      $composableBuilder(column: $table.customFg, builder: (column) => column);

  GeneratedColumn<String> get customAccent => $composableBuilder(
    column: $table.customAccent,
    builder: (column) => column,
  );

  $$BooksTableAnnotationComposer get bookId {
    final $$BooksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableAnnotationComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BookSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BookSettingsTable,
          BookSetting,
          $$BookSettingsTableFilterComposer,
          $$BookSettingsTableOrderingComposer,
          $$BookSettingsTableAnnotationComposer,
          $$BookSettingsTableCreateCompanionBuilder,
          $$BookSettingsTableUpdateCompanionBuilder,
          (BookSetting, $$BookSettingsTableReferences),
          BookSetting,
          PrefetchHooks Function({bool bookId})
        > {
  $$BookSettingsTableTableManager(_$AppDatabase db, $BookSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BookSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BookSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BookSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> bookId = const Value.absent(),
                Value<double> fontSize = const Value.absent(),
                Value<String> fontFamily = const Value.absent(),
                Value<double> lineHeight = const Value.absent(),
                Value<String> theme = const Value.absent(),
                Value<double> brightness = const Value.absent(),
                Value<String> scrollMode = const Value.absent(),
                Value<bool> autoScrollEnabled = const Value.absent(),
                Value<double> autoScrollSpeed = const Value.absent(),
                Value<int> sleepTimerMinutes = const Value.absent(),
                Value<String> readingDirection = const Value.absent(),
                Value<bool> doublePageSpread = const Value.absent(),
                Value<String?> customBg = const Value.absent(),
                Value<String?> customFg = const Value.absent(),
                Value<String?> customAccent = const Value.absent(),
              }) => BookSettingsCompanion(
                bookId: bookId,
                fontSize: fontSize,
                fontFamily: fontFamily,
                lineHeight: lineHeight,
                theme: theme,
                brightness: brightness,
                scrollMode: scrollMode,
                autoScrollEnabled: autoScrollEnabled,
                autoScrollSpeed: autoScrollSpeed,
                sleepTimerMinutes: sleepTimerMinutes,
                readingDirection: readingDirection,
                doublePageSpread: doublePageSpread,
                customBg: customBg,
                customFg: customFg,
                customAccent: customAccent,
              ),
          createCompanionCallback:
              ({
                Value<int> bookId = const Value.absent(),
                Value<double> fontSize = const Value.absent(),
                Value<String> fontFamily = const Value.absent(),
                Value<double> lineHeight = const Value.absent(),
                Value<String> theme = const Value.absent(),
                Value<double> brightness = const Value.absent(),
                Value<String> scrollMode = const Value.absent(),
                Value<bool> autoScrollEnabled = const Value.absent(),
                Value<double> autoScrollSpeed = const Value.absent(),
                Value<int> sleepTimerMinutes = const Value.absent(),
                Value<String> readingDirection = const Value.absent(),
                Value<bool> doublePageSpread = const Value.absent(),
                Value<String?> customBg = const Value.absent(),
                Value<String?> customFg = const Value.absent(),
                Value<String?> customAccent = const Value.absent(),
              }) => BookSettingsCompanion.insert(
                bookId: bookId,
                fontSize: fontSize,
                fontFamily: fontFamily,
                lineHeight: lineHeight,
                theme: theme,
                brightness: brightness,
                scrollMode: scrollMode,
                autoScrollEnabled: autoScrollEnabled,
                autoScrollSpeed: autoScrollSpeed,
                sleepTimerMinutes: sleepTimerMinutes,
                readingDirection: readingDirection,
                doublePageSpread: doublePageSpread,
                customBg: customBg,
                customFg: customFg,
                customAccent: customAccent,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BookSettingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({bookId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (bookId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.bookId,
                                referencedTable: $$BookSettingsTableReferences
                                    ._bookIdTable(db),
                                referencedColumn: $$BookSettingsTableReferences
                                    ._bookIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$BookSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BookSettingsTable,
      BookSetting,
      $$BookSettingsTableFilterComposer,
      $$BookSettingsTableOrderingComposer,
      $$BookSettingsTableAnnotationComposer,
      $$BookSettingsTableCreateCompanionBuilder,
      $$BookSettingsTableUpdateCompanionBuilder,
      (BookSetting, $$BookSettingsTableReferences),
      BookSetting,
      PrefetchHooks Function({bool bookId})
    >;
typedef $$ReadingSessionsTableCreateCompanionBuilder =
    ReadingSessionsCompanion Function({
      Value<int> id,
      required int bookId,
      required DateTime startedAt,
      Value<DateTime?> endedAt,
      Value<int> pagesRead,
    });
typedef $$ReadingSessionsTableUpdateCompanionBuilder =
    ReadingSessionsCompanion Function({
      Value<int> id,
      Value<int> bookId,
      Value<DateTime> startedAt,
      Value<DateTime?> endedAt,
      Value<int> pagesRead,
    });

final class $$ReadingSessionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $ReadingSessionsTable, ReadingSession> {
  $$ReadingSessionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $BooksTable _bookIdTable(_$AppDatabase db) => db.books.createAlias(
    $_aliasNameGenerator(db.readingSessions.bookId, db.books.id),
  );

  $$BooksTableProcessedTableManager get bookId {
    final $_column = $_itemColumn<int>('book_id')!;

    final manager = $$BooksTableTableManager(
      $_db,
      $_db.books,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bookIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReadingSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $ReadingSessionsTable> {
  $$ReadingSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pagesRead => $composableBuilder(
    column: $table.pagesRead,
    builder: (column) => ColumnFilters(column),
  );

  $$BooksTableFilterComposer get bookId {
    final $$BooksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableFilterComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReadingSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReadingSessionsTable> {
  $$ReadingSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pagesRead => $composableBuilder(
    column: $table.pagesRead,
    builder: (column) => ColumnOrderings(column),
  );

  $$BooksTableOrderingComposer get bookId {
    final $$BooksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableOrderingComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReadingSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReadingSessionsTable> {
  $$ReadingSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<int> get pagesRead =>
      $composableBuilder(column: $table.pagesRead, builder: (column) => column);

  $$BooksTableAnnotationComposer get bookId {
    final $$BooksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableAnnotationComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReadingSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReadingSessionsTable,
          ReadingSession,
          $$ReadingSessionsTableFilterComposer,
          $$ReadingSessionsTableOrderingComposer,
          $$ReadingSessionsTableAnnotationComposer,
          $$ReadingSessionsTableCreateCompanionBuilder,
          $$ReadingSessionsTableUpdateCompanionBuilder,
          (ReadingSession, $$ReadingSessionsTableReferences),
          ReadingSession,
          PrefetchHooks Function({bool bookId})
        > {
  $$ReadingSessionsTableTableManager(
    _$AppDatabase db,
    $ReadingSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReadingSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReadingSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReadingSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> bookId = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<int> pagesRead = const Value.absent(),
              }) => ReadingSessionsCompanion(
                id: id,
                bookId: bookId,
                startedAt: startedAt,
                endedAt: endedAt,
                pagesRead: pagesRead,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int bookId,
                required DateTime startedAt,
                Value<DateTime?> endedAt = const Value.absent(),
                Value<int> pagesRead = const Value.absent(),
              }) => ReadingSessionsCompanion.insert(
                id: id,
                bookId: bookId,
                startedAt: startedAt,
                endedAt: endedAt,
                pagesRead: pagesRead,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ReadingSessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({bookId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (bookId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.bookId,
                                referencedTable:
                                    $$ReadingSessionsTableReferences
                                        ._bookIdTable(db),
                                referencedColumn:
                                    $$ReadingSessionsTableReferences
                                        ._bookIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ReadingSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReadingSessionsTable,
      ReadingSession,
      $$ReadingSessionsTableFilterComposer,
      $$ReadingSessionsTableOrderingComposer,
      $$ReadingSessionsTableAnnotationComposer,
      $$ReadingSessionsTableCreateCompanionBuilder,
      $$ReadingSessionsTableUpdateCompanionBuilder,
      (ReadingSession, $$ReadingSessionsTableReferences),
      ReadingSession,
      PrefetchHooks Function({bool bookId})
    >;
typedef $$HighlightsTableCreateCompanionBuilder =
    HighlightsCompanion Function({
      Value<int> id,
      required int bookId,
      required String cfiRange,
      required String selectedText,
      Value<String> color,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$HighlightsTableUpdateCompanionBuilder =
    HighlightsCompanion Function({
      Value<int> id,
      Value<int> bookId,
      Value<String> cfiRange,
      Value<String> selectedText,
      Value<String> color,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$HighlightsTableReferences
    extends BaseReferences<_$AppDatabase, $HighlightsTable, Highlight> {
  $$HighlightsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BooksTable _bookIdTable(_$AppDatabase db) => db.books.createAlias(
    $_aliasNameGenerator(db.highlights.bookId, db.books.id),
  );

  $$BooksTableProcessedTableManager get bookId {
    final $_column = $_itemColumn<int>('book_id')!;

    final manager = $$BooksTableTableManager(
      $_db,
      $_db.books,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bookIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HighlightsTableFilterComposer
    extends Composer<_$AppDatabase, $HighlightsTable> {
  $$HighlightsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cfiRange => $composableBuilder(
    column: $table.cfiRange,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get selectedText => $composableBuilder(
    column: $table.selectedText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$BooksTableFilterComposer get bookId {
    final $$BooksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableFilterComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HighlightsTableOrderingComposer
    extends Composer<_$AppDatabase, $HighlightsTable> {
  $$HighlightsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cfiRange => $composableBuilder(
    column: $table.cfiRange,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get selectedText => $composableBuilder(
    column: $table.selectedText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$BooksTableOrderingComposer get bookId {
    final $$BooksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableOrderingComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HighlightsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HighlightsTable> {
  $$HighlightsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get cfiRange =>
      $composableBuilder(column: $table.cfiRange, builder: (column) => column);

  GeneratedColumn<String> get selectedText => $composableBuilder(
    column: $table.selectedText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$BooksTableAnnotationComposer get bookId {
    final $$BooksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bookId,
      referencedTable: $db.books,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BooksTableAnnotationComposer(
            $db: $db,
            $table: $db.books,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HighlightsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HighlightsTable,
          Highlight,
          $$HighlightsTableFilterComposer,
          $$HighlightsTableOrderingComposer,
          $$HighlightsTableAnnotationComposer,
          $$HighlightsTableCreateCompanionBuilder,
          $$HighlightsTableUpdateCompanionBuilder,
          (Highlight, $$HighlightsTableReferences),
          Highlight,
          PrefetchHooks Function({bool bookId})
        > {
  $$HighlightsTableTableManager(_$AppDatabase db, $HighlightsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HighlightsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HighlightsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HighlightsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> bookId = const Value.absent(),
                Value<String> cfiRange = const Value.absent(),
                Value<String> selectedText = const Value.absent(),
                Value<String> color = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => HighlightsCompanion(
                id: id,
                bookId: bookId,
                cfiRange: cfiRange,
                selectedText: selectedText,
                color: color,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int bookId,
                required String cfiRange,
                required String selectedText,
                Value<String> color = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => HighlightsCompanion.insert(
                id: id,
                bookId: bookId,
                cfiRange: cfiRange,
                selectedText: selectedText,
                color: color,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$HighlightsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({bookId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (bookId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.bookId,
                                referencedTable: $$HighlightsTableReferences
                                    ._bookIdTable(db),
                                referencedColumn: $$HighlightsTableReferences
                                    ._bookIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$HighlightsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HighlightsTable,
      Highlight,
      $$HighlightsTableFilterComposer,
      $$HighlightsTableOrderingComposer,
      $$HighlightsTableAnnotationComposer,
      $$HighlightsTableCreateCompanionBuilder,
      $$HighlightsTableUpdateCompanionBuilder,
      (Highlight, $$HighlightsTableReferences),
      Highlight,
      PrefetchHooks Function({bool bookId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BooksTableTableManager get books =>
      $$BooksTableTableManager(_db, _db.books);
  $$ShelvesTableTableManager get shelves =>
      $$ShelvesTableTableManager(_db, _db.shelves);
  $$BookmarksTableTableManager get bookmarks =>
      $$BookmarksTableTableManager(_db, _db.bookmarks);
  $$BookSettingsTableTableManager get bookSettings =>
      $$BookSettingsTableTableManager(_db, _db.bookSettings);
  $$ReadingSessionsTableTableManager get readingSessions =>
      $$ReadingSessionsTableTableManager(_db, _db.readingSessions);
  $$HighlightsTableTableManager get highlights =>
      $$HighlightsTableTableManager(_db, _db.highlights);
}

import 'package:equatable/equatable.dart';

class Season extends Equatable {
  int episodeCount;
  int id;
  String name;
  String overview;
  String posterPath;
  int seasonNumber;

  Season(
      {required this.episodeCount,
      required this.id,
      required this.name,
      required this.overview,
      required this.posterPath,
      required this.seasonNumber});

  @override
  List<Object?> get props => [
    episodeCount,
    id,
    name,
    overview,
    posterPath,
    seasonNumber,
  ];
}

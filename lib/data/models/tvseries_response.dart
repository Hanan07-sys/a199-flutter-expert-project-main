
import 'package:ditonton/data/models/tvseries_model.dart';
import 'package:equatable/equatable.dart';

class TvSeriesResponse extends Equatable{
  final List<TvSeriesModel> tvList;
  TvSeriesResponse({required this.tvList});

  factory TvSeriesResponse.fromJson(Map<String,dynamic> json) =>
      TvSeriesResponse(
        tvList: List<TvSeriesModel>.from((json["results"] as List)
            .map((x) => TvSeriesModel.fromJson(x))
            .where((element) => element.posterPath != null)),
      );
  Map<String,dynamic> toJson() =>{
    "results": List<dynamic>.from(tvList.map((e) => e.toJson())),
  };

  @override
  List<Object> get props => [tvList];

}
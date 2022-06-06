import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/datasources/tvseries_local_data_source.dart';
import 'package:ditonton/data/datasources/tvseries_remote_data_source.dart';
import 'package:ditonton/data/models/tvseries_table.dart';
import 'package:ditonton/domain/entities/tvseries.dart';
import 'package:ditonton/domain/entities/tvseries_detail.dart';
import 'package:ditonton/domain/repositories/tvseries_repository.dart';

class TvRepositoryImpl implements TvSeriesRepository {
  final TvSeriesRemoteDataSource remoteDataSource;
  final TvSeriesLocalDataSource localDataSource;

  TvRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<Either<Failure,List<TvSeries>>> getNowPlayingTvSeries() async{
    try{
      final result = await remoteDataSource.getNowPlayingTvSeries();
      return Right(result.map((model)=>model.toEntity()).toList());
    } on ServerException{
      return Left(ServerFailure(''));
    } on SocketException{
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure,TvSeriesDetail>> getTvSeriesDetail(int id) async{
    try{
      final result = await remoteDataSource.getTvSeriesDetail(id);
      return Right(result.toEntity());
    } on ServerException{
      return Left(ServerFailure(''));
    } on SocketException{
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure,List<TvSeries>>> getTvSeriesRecommendations(int id) async{
    try{
      final result = await remoteDataSource.getTvSeriesRecommendations(id);
      return Right(result.map((model)=>model.toEntity()).toList());
    } on ServerException{
      return Left(ServerFailure(''));
    } on SocketException{
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure,List<TvSeries>>> getTopRatedTvSeries() async{
    try{
      final result = await remoteDataSource.getTopRatedTvSeries();
      return Right(result.map((model)=>model.toEntity()).toList());
    } on ServerException{
      return Left(ServerFailure(''));
    } on SocketException{
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure,List<TvSeries>>> searchTvSeries(String query) async{
    try{
      final result = await remoteDataSource.searchTvSeries(query);
      return Right(result.map((model)=>model.toEntity()).toList());
    } on ServerException{
      return Left(ServerFailure(''));
    } on SocketException{
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure,List<TvSeries>>> getPopularTv() async{
    try{
      final result = await remoteDataSource.getPopularTvSeries();
      return Right(result.map((model)=>model.toEntity()).toList());
    } on ServerException{
      return Left(ServerFailure(''));
    } on SocketException{
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure,String>> saveTvSeriesWatchlist(TvSeriesDetail series) async{
    try{
      final result = await localDataSource.insertTvSeriesWatchlist(TvSeriesTable.fromEntity(series));
      return Right(result);
    } on DatabaseException catch (e){
      return Left(DatabaseFailure(e.message));
    } catch (e){
      throw e;
    }
  }

  @override
  Future<Either<Failure,String>> removeTvSeriesWatchlist(TvSeriesDetail series) async{
    try{
      final result = await localDataSource.removeTvSeriesWatchlist(TvSeriesTable.fromEntity(series));
      return Right(result);
    } on DatabaseException catch (e){
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> tvSeriesIsAddedToWatchlist(int id) async{
    final result = await localDataSource.getTvSeriesById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getWatchlistTvSeries() async {
    final result = await localDataSource.getWatchlistTvSeries();
    return Right(result.map((data) => data.toEntity()).toList());
  }

}

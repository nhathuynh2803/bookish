import 'base_model.dart';

class GalleryStats extends Model<GalleryStats> {
  int totalVisits;

  int? allTimeRanking;
  int? allTimeScore;
  int? yearRanking;
  int? yearScore;
  int? monthRanking;
  int? monthScore;
  int? dayRanking;
  int? dayScore;

  List<VisitStat> yearlyStats;
  List<VisitStat> monthlyStats;
  List<VisitStat> dailyStats;

  GalleryStats({
    required this.totalVisits,
    this.allTimeRanking,
    this.allTimeScore,
    this.yearRanking,
    this.yearScore,
    this.monthRanking,
    this.monthScore,
    this.dayRanking,
    this.dayScore,
    required this.yearlyStats,
    required this.monthlyStats,
    required this.dailyStats,
  });

  @override
  GalleryStats fromJson(Map<String, dynamic> map) {
    totalVisits = map['total_visits'];
    allTimeRanking = map['all_time_ranking'];
    allTimeScore = map['all_time_score'];
    yearRanking = map['year_ranking'];
    yearScore = map['year_score'];
    monthRanking = map['month_ranking'];
    monthScore = map['month_score'];
    dayRanking = map['day_ranking'];
    dayScore = map['day_score'];
    yearlyStats = List<VisitStat>.from(map['yearly_stats'].map(VisitStat.fromJson));
    monthlyStats = List<VisitStat>.from(map['monthly_stats'].map(VisitStat.fromJson));
    dailyStats = List<VisitStat>.from(map['daily_stats'].map(VisitStat.fromJson));
    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['total_visits'] = totalVisits;
    data['all_time_ranking'] = allTimeRanking;
    data['all_time_score'] = allTimeScore;
    data['year_ranking'] = yearRanking;
    data['year_score'] = yearScore;
    data['month_ranking'] = monthRanking;
    data['month_score'] = monthScore;
    data['day_ranking'] = dayRanking;
    data['day_score'] = dayScore;
    data['yearly_stats'] = yearlyStats.map((e) => e.toJson()).toList();
    data['monthly_stats'] = monthlyStats.map((e) => e.toJson()).toList();
    data['daily_stats'] = dailyStats.map((e) => e.toJson()).toList();
    return data;
  }
}

class VisitStat extends Model<VisitStat> {
  /// 1. 2013
  /// 2. January
  /// 3. 1st
  String period;

  /// 1. 16.2M
  /// 2. 570K
  /// 3. 5731
  double visits;

  /// 1. 16.2M
  /// 2. 570K
  /// 3. 5731
  double hits;

  VisitStat({
    required this.period,
    required this.visits,
    required this.hits,
  });

  factory VisitStat.fromJson(Map<String, dynamic> map) {
    return VisitStat(
      period: map['period'],
      visits: map['visits'],
      hits: map['hits'],
    );
  }

  @override
  VisitStat fromJson(Map<String, dynamic> map) {
    period = map['period'];
    visits = map['visits'];
    hits = map['hits'];
    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['period'] = period;
    data['visits'] = visits;
    data['hits'] = hits;
    return data;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healmeumpapp/core/handling_service_response/response_validation.dart';
import 'package:healmeumpapp/features/home/presentation/bloc/home_bloc.dart';
import 'package:healmeumpapp/features/home/presentation/bloc/home_event.dart';
import 'package:healmeumpapp/features/home/presentation/bloc/home_state.dart';
import 'package:healmeumpapp/global/constant/colors_pick.dart';
import 'package:healmeumpapp/global/constant/size.dart';
import 'package:healmeumpapp/shared/local_datasource.dart';
import 'package:sizer/sizer.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late HomeBloc _bloc;
  late Future<String> username;
  final Map<String, bool> _expandedScores = {};

  @override
  void initState() {
    super.initState();
    _bloc = context.read<HomeBloc>();
    username = LocalDataSource().getUsername();
    _loadAllTestHistory();
  }

  Future<void> _loadAllTestHistory() async {
    final userId = await username;
    _bloc.add(GetScoreHistoryEvent(userId: userId, questionnaireCode: ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBackground,
      appBar: AppBar(
        backgroundColor: cPrimary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Riwayat Tes',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.loadingScoreHistory == ResponseValidation.LOADING) {
            return _buildLoadingState();
          }

          if (state.statusScoreHistory == ResponseValidation.FAIL) {
            return _buildErrorState(state.messageScoreHistory ?? 'Gagal memuat riwayat tes');
          }

          if (state.dataScoreHistory?.dataScore.scores.isEmpty ?? true) {
            return _buildEmptyState();
          }

          return _buildHistoryList(state);
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(cPrimary),
          ),
          SizedBox(height: 2.h),
          Text(
            'Memuat riwayat tes...',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64.sp,
              color: Colors.red[400],
            ),
            SizedBox(height: 2.h),
            Text(
              'Terjadi Kesalahan',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: cPrimaryText,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              message,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 3.h),
            ElevatedButton(
              onPressed: () => _loadAllTestHistory(),
              style: ElevatedButton.styleFrom(
                backgroundColor: cPrimary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Coba Lagi',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.quiz_outlined,
              size: 80.sp,
              color: Colors.grey[400],
            ),
            SizedBox(height: 3.h),
            Text(
              'Belum Ada Riwayat Tes',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: cPrimaryText,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              'Mulai lakukan tes untuk melihat riwayat hasil tes Anda di sini.',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 3.h),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: cPrimary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Kembali ke Beranda',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryList(HomeState state) {
    final dataScoreHistory = state.dataScoreHistory;
    if (dataScoreHistory == null) {
      return _buildEmptyState();
    }
    
    final scores = dataScoreHistory.dataScore.scores;
    final summary = dataScoreHistory.dataScore.summary;

    return RefreshIndicator(
      onRefresh: _loadAllTestHistory,
      color: cPrimary,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Card
            Container(
              width: sWidthFull(context),
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ringkasan',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: cPrimaryText,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSummaryItem(
                          'Total Tes',
                          '${summary.totalResponses}',
                          Icons.quiz,
                          cPrimary,
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: _buildSummaryItem(
                          'Jenis Tes',
                          '${summary.questionnaires.length}',
                          Icons.category,
                          Colors.blue[600]!,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  _buildSummaryItem(
                    'Tes Terakhir',
                    _formatDate(summary.latestSubmission),
                    Icons.schedule,
                    Colors.green[600]!,
                  ),
                ],
              ),
            ),
            SizedBox(height: 3.h),

            // Test History List
            Text(
              'Semua Riwayat Tes',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: cPrimaryText,
              ),
            ),
            SizedBox(height: 2.h),

            // Sort and Filter Options
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.sort, size: 16.sp, color: Colors.grey[600]),
                        SizedBox(width: 2.w),
                        Text(
                          'Terbaru',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 2.w),
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Icon(Icons.filter_list, size: 16.sp, color: Colors.grey[600]),
                ),
              ],
            ),
            SizedBox(height: 2.h),

            // History Items
            ...scores.map((score) => _buildScoreGroup(score)).toList(),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20.sp),
          SizedBox(width: 2.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreGroup(score) {
    final isExpanded = _expandedScores[score.id] ?? false;
    
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header - Clickable to expand/collapse
          InkWell(
            onTap: () {
              setState(() {
                _expandedScores[score.id] = !isExpanded;
              });
            },
            borderRadius: BorderRadius.circular(15),
            child: Container(
              padding: EdgeInsets.all(4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 12.w,
                        height: 6.h,
                        decoration: BoxDecoration(
                          color: cPrimary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          _getScoreIcon(score.questionnaireCode),
                          color: cPrimary,
                          size: 24.sp,
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _getTestName(score.questionnaireCode),
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: cPrimaryText,
                              ),
                            ),
                            SizedBox(height: 0.5.h),
                            Text(
                              '${_formatDate(score.submittedAt)}',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        color: Colors.grey[600],
                        size: 24.sp,
                      ),
                    ],
                  ),
                  
                  // Domain summary - always visible
                  SizedBox(height: 2.h),
                  _buildDomainSummary(score.domains),
                ],
              ),
            ),
          ),
          
          // Expandable detailed scores
          if (isExpanded) ...[
            Divider(height: 1, color: Colors.grey[200]),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Detail Skor',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: cPrimaryText,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  ...score.domains.map((domain) => _buildDetailedDomainItem(domain)).toList(),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDomainSummary(List domains) {
    return Row(
      children: domains.map((domain) => Expanded(
        child: Container(
          margin: EdgeInsets.only(right: 1.w),
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.5.h),
          decoration: BoxDecoration(
            color: _getScoreColor(domain.category).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _getScoreColor(domain.category).withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Text(
                domain.domain,
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: cPrimaryText,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 0.5.h),
              Text(
                domain.category,
                style: TextStyle(
                  fontSize: 9.sp,
                  fontWeight: FontWeight.w500,
                  color: _getScoreColor(domain.category),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 0.3.h),
              Text(
                '${domain.finalScore}',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: _getScoreColor(domain.category),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildDetailedDomainItem(domain) {
    return Container(
      margin: EdgeInsets.only(bottom: 1.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(
            color: _getScoreColor(domain.category),
            width: 3,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  domain.domain,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: cPrimaryText,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: _getScoreColor(domain.category).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  domain.category,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: _getScoreColor(domain.category),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Row(
            children: [
              Expanded(
                child: _buildScoreDetail('Raw Score', domain.rawScore, Colors.blue[600]!),
              ),
              SizedBox(width: 2.w),
              Expanded(
                child: _buildScoreDetail('Final Score', domain.finalScore, _getScoreColor(domain.category)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScoreDetail(String label, int score, Color color) {
    return Container(
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 0.3.h),
          Text(
            '$score',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }


  Color _getScoreColor(String category) {
    switch (category.toLowerCase()) {
      case 'tidak depresi':
      case 'normal':
      case 'ringan':
        return Colors.green[600]!;
      case 'sedang':
      case 'berisiko':
        return Colors.orange[600]!;
      case 'berat':
      case 'sangat berat':
        return Colors.red[600]!;
      default:
        return Colors.grey[600]!;
    }
  }

  IconData _getScoreIcon(String questionnaireCode) {
    switch (questionnaireCode) {
      case 'DASS21':
        return Icons.psychology;
      case 'BDI2':
        return Icons.favorite;
      default:
        return Icons.quiz;
    }
  }

  String _getTestName(String questionnaireCode) {
    switch (questionnaireCode) {
      case 'DASS21':
        return 'Tes Kesehatan Mental';
      case 'BDI2':
        return 'Tes Depresi';
      default:
        return 'Tes Lainnya';
    }
  }

  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      return 'Hari ini';
    } else if (difference.inDays == 1) {
      return 'Kemarin';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} hari yang lalu';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return weeks == 1 ? '1 minggu yang lalu' : '$weeks minggu yang lalu';
    } else {
      final months = (difference.inDays / 30).floor();
      return months == 1 ? '1 bulan yang lalu' : '$months bulan yang lalu';
    }
  }
}

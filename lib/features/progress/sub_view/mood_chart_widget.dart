// fl_chart ile çizgi grafik bileşenleri
part of '../progress_view.dart';

// Grafiği saran container ve temel stil
class _MoodChartWidget extends StatelessWidget {
  final bool isSevenDays;
  final List<FlSpot>? spots;
  final double? maxX;

  const _MoodChartWidget({required this.isSevenDays, this.spots, this.maxX});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: WidgetSizesEnum.progressChartContainerHeight.value,
      padding: Paddings.paddingInstance.chatHistoryWidgetAllPadding,
      decoration: _MoodChartContainerDecoration(),
      //LineChart - Çizgi grafik , BarChart - Çubuk grafik, PieChart - Pasta grafik, ScatterChart - Dağılım grafik, RadarChart - Radar grafik
      // fl_chart paketinden gelen çizgi grafik widget'ı
      child: _LineChartWidget(
        isSevenDays: isSevenDays,
        spots: spots,
        maxX: maxX,
      ),
    );
  }

  BoxDecoration _MoodChartContainerDecoration() {
    return BoxDecoration(
      color: ColorName.loginInputColor,
      borderRadius: BorderRadius.circular(WidgetSizesEnum.borderRadius.value),
    );
  }
}

// Asıl çizgi grafik: eksen, grid, başlık ve veri konfigürasyonu
class _LineChartWidget extends StatelessWidget {
  final bool isSevenDays;
  final List<FlSpot>? spots;
  final double? maxX;
  const _LineChartWidget({required this.isSevenDays, this.spots, this.maxX});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          getTouchedSpotIndicator:
              (LineChartBarData barData, List<int> spotIndexes) {
                return spotIndexes.map((int index) {
                  final FlSpot spot = barData.spots[index];
                  final Color c = _moodColorForY(spot.y);
                  return TouchedSpotIndicatorData(
                    FlLine(color: c, strokeWidth: 2),
                    FlDotData(
                      show: true,
                      getDotPainter: (s, p, b, i) => FlDotCirclePainter(
                        radius: 6,
                        color: c,
                        strokeWidth: 2,
                        strokeColor: ColorName.whiteColor,
                      ),
                    ),
                  );
                }).toList();
              },
        ),
        // Izgara (Grid) ayarları - Arka plandaki yatay çizgiler
        gridData: _GridData(),

        // Grafik başlıkları ve etiketleri ayarları
        titlesData: _TitlesData(),
        // Grafik kenarlık ayarları
        borderData: _BorderData(),

        // X ekseni minimum ve maksimum değerleri (gün sayısına göre)
        minX: 0, // Başlangıç noktası
        maxX: maxX ?? (isSevenDays ? 6 : 29), // 7 gün ise 0-6, 30 gün ise 0-29
        // Y ekseni minimum ve maximum değerleri
        minY: 1, // En düşük mood: Çok Üzgün
        maxY: 5, // En yüksek mood: Çok Mutlu
        // Çizgi verisi - Grafikte gösterilecek çizgiler (tek bir seri)
        //grafikte gösterilecek çizgilerin verilerini ve stillerini tutan bir listedir.
        lineBarsData: [_ChartBarData()],
      ),
    );
  }

  // Çizgi verisi (tek bir seri) için ayarlar
  LineChartBarData _ChartBarData() {
    return LineChartBarData(
      // Grafik noktaları: varsa dışarıdan geleni kullan, yoksa dummy
      spots:
          spots ??
          const [
            // Basit fallback verisi
            FlSpot(0, 3),
            FlSpot(3, 3.5),
            FlSpot(6, 4),
          ],
      isCurved: true, // Çizgiyi eğri yap (smooth)
      // Çizgi renk geçişi (gradient)
      gradient: const LinearGradient(
        colors: [ColorName.yellowColor, ColorName.orangeColor],
      ),
      barWidth: 4, // Çizgi kalınlığı
      isStrokeCapRound: true, // Çizgi uçlarını yuvarlak yap
      // Grafik noktalarının görünümü (dots)
      dotData: FlDotData(
        show: true, // Noktaları göster
        getDotPainter: (spot, percent, barData, index) {
          // Mood değerine göre renk: 1..5 → verySad..veryHappy
          final int mood = spot.y.round().clamp(1, 5);
          final Color fill = () {
            switch (mood) {
              case 1:
                return ColorName.moodVerySadColor;
              case 2:
                return ColorName.moodSadColor;
              case 3:
                return ColorName.moodNeutralColor;
              case 4:
                return ColorName.moodHappyColor;
              default:
                return ColorName.moodVeryHappyColor;
            }
          }();
          return FlDotCirclePainter(
            radius: 6,
            color: fill,
            strokeWidth: 2,
            strokeColor: ColorName.whiteColor,
          );
        },
      ),

      // Çizginin altındaki alan (gradient fill)
      belowBarData: BarAreaData(
        show: true, // Alt alanı göster
        gradient: LinearGradient(
          colors: [
            ColorName.yellowColor.withOpacity(0.3), // Üstte koyu
            ColorName.yellowColor.withOpacity(0.0), // Altta şeffaf
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  FlBorderData _BorderData() {
    return FlBorderData(
      show: true, // Kenarlık göster
      border: Border.all(color: ColorName.loginGreyTextColor.withOpacity(0.3)),
    );
  }

  Color _moodColorForY(double y) {
    final int mood = y.round().clamp(1, 5);
    switch (mood) {
      case 1:
        return ColorName.moodVerySadColor;
      case 2:
        return ColorName.moodSadColor;
      case 3:
        return ColorName.moodNeutralColor;
      case 4:
        return ColorName.moodHappyColor;
      default:
        return ColorName.moodVeryHappyColor;
    }
  }

  FlTitlesData _TitlesData() {
    return FlTitlesData(
      show: true, // Başlıkları göster
      // Sağ taraf başlıklarını gizle
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      // Üst taraf başlıklarını gizle
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      // Alt eksen başlıkları (X ekseni) - Günler veya tarihler
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true, // Alt başlıkları göster
          reservedSize: 30, // Başlıklar için ayrılan alan
          interval: 1, // Her değerde başlık göster
          // Her değer için custom widget oluştur
          getTitlesWidget: (double value, TitleMeta meta) {
            const style = TextStyle(
              color: ColorName.loginGreyTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            );
            final int x = value.toInt();
            final DateTime today = DateTime.now();
            if (isSevenDays) {
              // Dinamik: x=0 → 6 gün önce, x=6 → bugün
              final DateTime target = today.subtract(Duration(days: 6 - x));
              final weekdays = [
                StringsEnum.monday.value, // 1
                StringsEnum.tuesday.value, // 2
                StringsEnum.wednesday.value, // 3
                StringsEnum.thursday.value, // 4
                StringsEnum.friday.value, // 5
                StringsEnum.saturday.value, // 6
                StringsEnum.sunday.value, // 7
              ];
              final String label = weekdays[target.weekday - 1];
              return Text(label, style: style);
            } else {
              // 30 gün: x=0 → 29 gün önce, x=29 → bugün
              final DateTime target = today.subtract(Duration(days: 29 - x));
              if (x % 7 == 0) {
                return Text(
                  target.day.toString().padLeft(2, '0'),
                  style: style,
                );
              }
            }
            return const Text(''); // Boş başlık
          },
        ),
      ),
      // Sol eksen başlıkları (Y ekseni) - Mood seviyeleri
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true, // Sol başlıkları göster
          interval: 1, // Her mood seviyesinde başlık
          reservedSize: 45, // Başlıklar için ayrılan genişlik
          // Her mood seviyesi için etiket oluştur
          getTitlesWidget: (double value, TitleMeta meta) {
            const style = TextStyle(
              color: ColorName.loginGreyTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            );
            // Mood seviyeleri: 1=Çok Üzgün, 2=Üzgün, 3=Normal, 4=Mutlu, 5=Çok Mutlu
            final moods = [
              StringsEnum.verySad.value, // 1
              StringsEnum.sad.value, // 2
              StringsEnum.neutral.value, // 3
              StringsEnum.happy.value, // 4
              StringsEnum.veryHappy.value, // 5
            ];
            if (value.toInt() >= 1 && value.toInt() <= 5) {
              return Text(
                moods[value.toInt() - 1],
                style: style,
                textAlign: TextAlign.center,
              );
            }
            return const Text('');
          },
        ),
      ),
    );
  }

  FlGridData _GridData() {
    return FlGridData(
      show: true, // Izgarayı göster
      drawVerticalLine: false, // Dikey çizgileri gösterme
      horizontalInterval: 1, // Her 1 birimde bir yatay çizgi çiz
      getDrawingHorizontalLine: (value) {
        // Her yatay çizginin stil ayarları
        return FlLine(
          color: ColorName.loginGreyTextColor.withOpacity(0.2),
          strokeWidth: 1, // Çizgi kalınlığı
        );
      },
    );
  }
}

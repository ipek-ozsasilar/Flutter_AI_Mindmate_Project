part of '../progress_view.dart';

class _MoodChartWidget extends StatelessWidget {
  final bool isSevenDays;

  const _MoodChartWidget({required this.isSevenDays});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: WidgetSizesEnum.progressChartContainerHeight.value,
      padding: Paddings.paddingInstance.chatHistoryWidgetAllPadding,
      decoration: _MoodChartContainerDecoration(),
      //LineChart - Çizgi grafik , BarChart - Çubuk grafik, PieChart - Pasta grafik, ScatterChart - Dağılım grafik, RadarChart - Radar grafik
      // fl_chart paketinden gelen çizgi grafik widget'ı
      child: _LineChartWidget(isSevenDays: isSevenDays),
    );
  }

  BoxDecoration _MoodChartContainerDecoration() {
    return BoxDecoration(
      color: ColorName.loginInputColor,
      borderRadius: BorderRadius.circular(WidgetSizesEnum.borderRadius.value),
    );
  }
}

class _LineChartWidget extends StatelessWidget {
  final bool isSevenDays;
  const _LineChartWidget({required this.isSevenDays});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        // Izgara (Grid) ayarları - Arka plandaki yatay çizgiler
        gridData: _GridData(),

        // Grafik başlıkları ve etiketleri ayarları
        titlesData: _TitlesData(),
        // Grafik kenarlık ayarları
        borderData: _BorderData(),

        // X ekseni minimum ve maximum değerleri
        minX: 0, // Başlangıç noktası
        maxX: isSevenDays ? 6 : 29, // 7 gün ise 0-6, 30 gün ise 0-29
        // Y ekseni minimum ve maximum değerleri
        minY: 1, // En düşük mood: Çok Üzgün
        maxY: 5, // En yüksek mood: Çok Mutlu
        // Çizgi verisi - Grafikte gösterilecek çizgiler
        lineBarsData: [_ChartBarData()],
      ),
    );
  }

  LineChartBarData _ChartBarData() {
    return LineChartBarData(
      spots: _getDummyData(), // Grafik noktaları (dummy data)
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
          // Her nokta için custom boyama
          return FlDotCirclePainter(
            radius: 6, // Nokta yarıçapı
            color: ColorName.yellowColor, // Nokta rengi
            strokeWidth: 2, // Nokta kenarlık kalınlığı
            strokeColor: ColorName.whiteColor, // Kenarlık rengi
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
            if (isSevenDays) {
              // Son 7 gün için günlerin isimlerini göster
              final days = [
                StringsEnum.monday.value, // Pazartesi
                StringsEnum.tuesday.value, // Salı
                StringsEnum.wednesday.value, // Çarşamba
                StringsEnum.thursday.value, // Perşembe
                StringsEnum.friday.value, // Cuma
                StringsEnum.saturday.value, // Cumartesi
                StringsEnum.sunday.value, // Pazar
              ];
              if (value.toInt() >= 0 && value.toInt() < days.length) {
                return Text(days[value.toInt()], style: style);
              }
            } else {
              // Son 30 gün için her 7 günde bir numara göster
              if (value.toInt() % 7 == 0) {
                return Text('${value.toInt() + 1}', style: style);
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
          reservedSize: 42, // Başlıklar için ayrılan genişlik
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

  List<FlSpot> _getDummyData() {
    if (isSevenDays) {
      // Son 7 günlük dummy data
      //FlSpot fl_chart paketinde grafik üzerindeki bir noktayı temsil eder.
      //ilki x digeri y koordinatı

      return const [
        FlSpot(0, 2.5), // Pazartesi - Üzgün
        FlSpot(1, 3), // Salı - Normal
        FlSpot(2, 3.5), // Çarşamba - Normal-Mutlu arası
        FlSpot(3, 3), // Perşembe - Normal
        FlSpot(4, 4), // Cuma - Mutlu
        FlSpot(5, 4.5), // Cumartesi - Mutlu-Çok Mutlu arası
        FlSpot(6, 4), // Pazar - Mutlu
      ];
    } else {
      // Son 30 günlük dummy data (her 3 günde bir nokta)
      return const [
        FlSpot(0, 2),
        FlSpot(3, 2.5),
        FlSpot(6, 3),
        FlSpot(9, 3),
        FlSpot(12, 3.5),
        FlSpot(15, 3.8),
        FlSpot(18, 4),
        FlSpot(21, 4.2),
        FlSpot(24, 4),
        FlSpot(27, 4.5),
        FlSpot(29, 4.3),
      ];
    }
  }
}

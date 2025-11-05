// Progress ekranı için state yönetimi
// - Bu dosya sadece UI'da kullanılacak durumları tutar (ör: seçili tarih aralığı)
import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/legacy.dart';

// Dışarıdan ProgressState'e erişmek ve güncellemek için provider
final progressProvider = StateNotifierProvider<ProgressProvider, ProgressState>(
  (ref) => ProgressProvider(),
);

// UI'da gösterilecek basit durum modeli
class ProgressState extends Equatable {
  const ProgressState({required this.isSevenDays});

  // Son 7 gün mü, 30 gün mü? (true → 7 gün, false → 30 gün)
  final bool isSevenDays;

  ProgressState copyWith({bool? isSevenDays}) {
    return ProgressState(isSevenDays: isSevenDays ?? this.isSevenDays);
  }

  @override
  List<Object?> get props => [isSevenDays];
}

// State değişimlerini yöneten sınıf (iş mantığı yok; sadece UI state)
class ProgressProvider extends StateNotifier<ProgressState> {
  // Varsayılan: Son 7 gün seçili başlat
  ProgressProvider() : super(const ProgressState(isSevenDays: true));

  // Seçili tarih aralığını doğrudan set eder
  void setSevenDays(bool value) {
    state = state.copyWith(isSevenDays: value);
  }

  // 7 ↔ 30 şeklinde değiştirir
  void toggleRange() {
    state = state.copyWith(isSevenDays: !state.isSevenDays);
  }
}

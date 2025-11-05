// Uygulama genelinde ortak mood tanımı (5 seviye)
// Çok Üzgün=1, Üzgün=2, Nötr=3, Mutlu=4, Çok Mutlu=5

enum MoodEnum {
  verySad(1, '😢', 'very sad'),
  sad(2, '☹️', 'sad'),
  neutral(3, '😐', 'neutral'),
  happy(4, '😊', 'happy'),
  veryHappy(5, '😄', 'very happy');

  const MoodEnum(this.value, this.emoji, this.key);
  final int value; // grafik için sayısal karşılık
  final String emoji; // UI'da seçim için gösterilecek emoji
  final String key; // string anahtar (gerekirse JSON/label)

  static MoodEnum? fromEmoji(String emoji) {
    for (final m in MoodEnum.values) {
      if (m.emoji == emoji) return m;
    }
    return null;
  }
}

class NoteModel {
  final int? id;
  final String positon;
  final String skill;
  final String date;

  NoteModel({
    required this.id,
    required this.positon,
    required this.skill,
    required this.date,
  });
  // covert data from NoteModel to map
  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'],
      positon: map['position'],
      skill: map['skill'],
      date: map['date'],
    );
  }
  // covert data from map to noteModel
  Map<String, dynamic> toMap() {
    return {'id': id, 'position': positon, 'skill': skill, 'date': date};
  }
}

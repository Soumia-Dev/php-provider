class Note {
  int noteId;
  int userId;
  String noteTitle;
  String noteContent;
  String noteImage;

  Note({
    required this.noteId,
    required this.userId,
    required this.noteTitle,
    required this.noteContent,
    required this.noteImage,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      noteId: json['note_id'],
      userId: json['user_id'],
      noteTitle: json['note_title'],
      noteContent: json['note_content'],
      noteImage: json['note_image'],
    );
  }
}

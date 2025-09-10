class SaveAnswersRequestModel {
  final List<Answer> answers;

  SaveAnswersRequestModel({
    required this.answers,
  });

  Map<String, dynamic> toJson() => {
        "answers": answers.map((answer) => answer.toJson()).toList(),
      };
}

class Answer {
  final String questionId;
  final int questionNo;
  final int score;

  Answer({
    required this.questionId,
    required this.questionNo,
    required this.score,
  });

  Map<String, dynamic> toJson() => {
        "questionId": questionId,
        "questionNo": questionNo,
        "score": score,
      };
}

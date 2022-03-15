import 'package:healthy_me/src/defaults/conditions_list.dart';
import 'package:healthy_me/src/defaults/diseases.dart';
import 'package:healthy_me/src/model/conditions_model.dart';
import 'package:healthy_me/src/model/diseases_model.dart';
import 'package:healthy_me/src/model/diseases_probability.dart';
import 'package:healthy_me/src/model/drugs_model.dart';

List<DiseaseProbability> percentages(List ids) {
  List<DiseaseProbability> list = [];
  int numberConditions = 0;
  if (ids.length > 1) {
    for (int i = 0; i < ids.length; i++) {
      for (int j = 0; j < diseases.length; j++) {
        for (int k = 0; k <= diseases[j].conditions.length - 1; k++) {
          if (ids[i] == diseases[j].conditions[k]) {
            diseases[j].sum++;
          }
        }
      }
    }
    List<Diseases> _selectedDiseases = [];
    for (int i = 0; i < diseases.length; i++) {
      numberConditions += diseases[i].sum;
      if (diseases[i].sum > 0) {
        _selectedDiseases.add(diseases[i]);
      }
    }
    for (int i = 0; i <= _selectedDiseases.length - 1; i++) {
      list.add(
        DiseaseProbability(
          percentage: _selectedDiseases.length > 1
              ? (_selectedDiseases[i].sum * 100 / numberConditions)
              : numberConditions * 100 / _selectedDiseases[i].conditions.length,
          disease: _selectedDiseases[i].name,
          text: _selectedDiseases[i].intro,
          diagnose: _selectedDiseases[i].diagnose,
          rec: _selectedDiseases[i].recommendation,
          drugs: _selectedDiseases[i].drugs,
        ),
      );
    }
  } else {
    ConditionsModel _selected =
        conditions.firstWhere((element) => ids[0] == element.id);
    list.add(
      DiseaseProbability(
        percentage: 0,
        disease: _selected.name,
        text: _selected.intro,
        diagnose: [_selected.text],
        rec: _selected.intro,
        drugs: [
          DrugsModel(
            img: '',
            title: 'Vitamins',
            text: '',
          ),
        ],
      ),
    );
  }
  print(numberConditions);
  return list;
}

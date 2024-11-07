import 'dart:math';
import 'dart:io';

class Monster {
  String name1; // 몹 이름
  int h; // 체력
  int a; // 공격력
  int b; // 방어력

  Monster(this.name1, this.h, this.a, this.b);

  void Attack(Character c) {
    int Attack2 = max(a - c.B2, 0);
    c.H2 -= Attack2;
    print('$name1이(가) ${c.name2}에게 $Attack2의 피해를 입혔습니다!');
  }

  bool die() => h <= 0;

  void State1() {
    print('몬스터: $name1, 체력: $h, 공격력: $a, 방어력: $b');
  }
}

class Character {
  String name2; // 캐릭터 이름
  int H2; // 체력
  int A2; // 공격력
  int B2; // 방어력

  Character(this.name2, this.H2, this.A2, this.B2);

  static String Ename() {
    final Pname = RegExp(r'^[가-힣a-zA-Z]+$');
    String? ename1;
    while (true) {
      print("플레이어의 이름을 입력하세요 (한글 또는 영문 대소문자만 허용):");
      ename1 = stdin.readLineSync();
      if (ename1 == null || ename1.isEmpty) {
        print("이름은 빈 문자열일 수 없습니다. 다시 입력해주세요.");
      } else if (!Pname.hasMatch(ename1)) {
        print("이름에 특수 문자나 숫자는 포함될 수 없습니다. 다시 입력해주세요.");
      } else {
        break;
      }
    }
    return ename1;
  }

  void Attack2(Monster m) {
    int Character = max(A2 - m.b, 0);
    m.h -= Character;
    print('$name2(가) ${m.name1}에게 $Character의 피해를 입혔습니다!');
  }

  void State2() {
    print('플레이어: $name2, 체력: $H2, 공격력: $A2, 방어력: $B2');
  }

  bool run() {
    print('$name2이(가) 도망쳤습니다! 전투가 종료됩니다.');
    return true;
  }

  void drain(Monster monster) {
    print('${monster.name1}의 능력치를 흡수합니다.');
  }

  void saveResult(Character user, String result) {
    print("결과를 저장하시겠습니까? (y/n)");
    String? input = stdin.readLineSync();
    if (input != null && input.toLowerCase() == 'y') {
      final file = File('result.txt');
      file.writeAsStringSync('플레이어 이름: ${user.name2}\n');
      file.writeAsStringSync('남은 체력: ${user.H2}\n', mode: FileMode.append);
      file.writeAsStringSync('게임 결과: $result\n', mode: FileMode.append);
      print("결과가 result.txt에 저장되었습니다.");
    } else {
      print("결과를 저장하지 않았습니다.");
    }
  }
}

void main() {
  // 캐릭터 정보 초기화
  String pname2 = Character.Ename();
  Character user;
  try {
    final file = File('characters.txt');
    List<String> lines = file.readAsLinesSync();

    if (lines.isNotEmpty) {
      List<String> parts = lines[0].split(',');
      if (parts.length == 3) {
        int health = int.parse(parts[0].trim());
        int attack = int.parse(parts[1].trim());
        int defense = int.parse(parts[2].trim());
        user = Character(pname2, health, attack, defense);
      } else {
        print("characters.txt의 데이터 형식이 잘못되었습니다.");
        return;
      }
    } else {
      print("characters.txt 파일이 비어 있습니다.");
      return;
    }
  } catch (e) {
    print("characters.txt 파일을 읽는 중 오류가 발생했습니다: $e");
    return;
  }

  print(
      "캐릭터가 생성되었습니다: ${user.name2}, 체력: ${user.H2}, 공격력: ${user.A2}, 방어력: ${user.B2}");

  // 몬스터 리스트 초기화
  List<Monster> listm = [];
  try {
    final file = File('monsters.txt');
    List<String> lines = file.readAsLinesSync();

    for (var line in lines) {
      List<String> parts = line.split(',');
      if (parts.length == 4) {
        String name = parts[0].trim();
        int health = int.parse(parts[1].trim());
        int attack = int.parse(parts[2].trim());
        int defense = int.parse(parts[3].trim());
        listm.add(Monster(name, health, attack, defense));
      }
    }
  } catch (e) {
    print("monsters.txt 파일을 읽는 중 오류가 발생했습니다: $e");
    return;
  }

  while (listm.isNotEmpty && user.H2 > 0) {
    Monster m2 = listm[Random().nextInt(listm.length)];
    print("\n=== ${m2.name1}이(가) 나타났습니다! ===");

    while (!m2.die() && user.H2 > 0) {
      user.Attack2(m2);
      if (m2.die()) {
        print("${m2.name1}을(를) 쓰러뜨렸습니다!");
        user.drain(m2);
        listm.remove(m2);
        break;
      }

      print("\n=== ${m2.name1}의 턴 ===");
      m2.Attack(user);
      if (user.H2 <= 0) {
        print("${user.name2}이(가) 쓰러졌습니다...");
        user.saveResult(user, "패배");
        return;
      }
    }

    if (listm.isNotEmpty) {
      print("다음 몬스터와 대결하시겠습니까? (y/n)");
      String? choice = stdin.readLineSync();
      if (choice == null || choice.toLowerCase() != 'y') {
        print("게임이 종료되었습니다.");
        user.saveResult(user, "도망");
        return;
      }
    }
  }

  if (user.H2 > 0) {
    print("${user.name2}이(가) 모든 몬스터를 처치했습니다! 승리!");
    user.saveResult(user, "승리");
  }
}

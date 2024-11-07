#### 몬스터 클래스
<br/>
<br/>
class Monster {
<br/>
  String name1; // 몹 이름
  <br/>
  int h; // 체력
  <br/>
  int a; // 공격력
  <br/>
  int b; // 방어력
<br/>
  Monster(this.name1, this.h, this.a, this.b);
<br/>
  void Attack(Character c) {
  <br/>
    int Attack2 = max(a - c.B2, 0);
    <br/>
    c.H2 -= Attack2;
    <br/>
    print('$name1이(가) ${c.name2}에게 $Attack2의 피해를 입혔습니다!');
    <br/>
  }

  bool die() => h <= 0;
<br/>
  void State1() {
  <br/>
    print('몬스터: $name1, 체력: $h, 공격력: $a, 방어력: $b');
    <br/>
  }
  <br/>
}
<br/>
<br/>

몬스터의 능력치가 들어갈 변수 타입과 이름을 정했습니다. 
<br/>
플레이어를 공격할때 공격력은 텍스트 파일에 적힌 값 안에서 랜덤 하게 정하게 만들엇습니다.
<br/>
몬스터의 생존 유무를 파악한후 몬스터의 현재 상태를 출력합니다.
<br/>
<br/>
<br/>
#### 캐릭터 클래스
<br/>
<br/>
<br/>
class Character {
<br/>
<br/>
  String name2; // 캐릭터 이름
  <br/>
  int H2; // 체력
  <br/>
  int A2; // 공격력
  <br/>
  int B2; // 방어력
<br/>
<br/>
<br/>
  Character(this.name2, this.H2, this.A2, this.B2);
<br/>
  static String Ename() {
  <br/>
    final Pname = RegExp(r'^[가-힣a-zA-Z]+$');
    <br/>
    String? ename1;
    <br/>
    while (true) {
    <br/>
      print("플레이어의 이름을 입력하세요 (한글 또는 영문 대소문자만 허용):");
      <br/>
      ename1 = stdin.readLineSync();
      <br/>
      if (ename1 == null || ename1.isEmpty) {
      <br/>
        print("이름은 빈 문자열일 수 없습니다. 다시 입력해주세요.");
        <br/>
      } else if (!Pname.hasMatch(ename1)) {
      <br/>
        print("이름에 특수 문자나 숫자는 포함될 수 없습니다. 다시 입력해주세요.");
        <br/>
      } else {
      <br/>
        break;
      }
      <br/>
    }
    <br/>
    return ename1;
    <br/>
    <br/>
    <br/>
    캐릭터 클래스를 정의하고 능력치가 들어갈 변수를 지정하였습니다
    <br/>
    <br/>
    <br/>
    게임이 시작되면 플레이어가 이름을 정하게 만들었습니다.
    <br/>
    <br/>
    <br/>
  }
<br/>
  void Attack2(Monster m) {
  <br/>
    int Character = max(A2 - m.b, 0);
    <br/>
    m.h -= Character;
    <br/>
    print('$name2(가) ${m.name1}에게 $Character의 피해를 입혔습니다!');
    <br/>
  }
<br/>
  void State2() {
  <br/>
    print('플레이어: $name2, 체력: $H2, 공격력: $A2, 방어력: $B2');
    <br/>
  }
<br/>
  bool run() {
  <br/>
    print('$name2이(가) 도망쳤습니다! 전투가 종료됩니다.');
    <br/>
    return true;
    <br/>
  }
<br/>
  void drain(Monster monster) {
  <br/>
    print('${monster.name1}의 능력치를 흡수합니다.');
    <br/>
  }
<br/><br/>
<br/>
<br/>
캐릭터가 공격하게 되면 텍스트 파일에서 정한 값 안에서 랜덤하게 피해를 주게 만들었습니다.
<br/>
<br/>
<br/>
방어 대신 도주를 선택하게 만들었습니다.
<br/>
<br/>
<br/>
도주를 하게 되면 전투가 종료되게 만들었습니다.
<br/>
<br/>
<br/>
처치시 능력치를 흡수하게 만들려고 했는데 어려워서 잘 안됬네요
<br/>
<br/>
<br/>
  void saveResult(Character user, String result) {
  <br/>
    print("결과를 저장하시겠습니까? (y/n)");
    <br/>
    String? input = stdin.readLineSync();
    <br/>
    if (input != null && input.toLowerCase() == 'y') {
    <br/>
      final file = File('result.txt');
      <br/>
      file.writeAsStringSync('플레이어 이름: ${user.name2}\n');
      <br/>
      file.writeAsStringSync('남은 체력: ${user.H2}\n', mode: FileMode.append);
      <br/>
      file.writeAsStringSync('게임 결과: $result\n', mode: FileMode.append);
      <br/>
      print("결과가 result.txt에 저장되었습니다.");
      <br/>
    } else {
    
      print("결과를 저장하지 않았습니다.");
      
    
    }
    
  }
  <br/>
}
<br/>
<br/>
<br/>
전투 승리시 파일을 저장할것인지 선택하게 만들었습니다.
<br/>
<br/>
<br/>
<br/>
<br/>
#### 캐릭터 텍스트 파일 불러오기
<br/>
<br/>
<br/>
void main() {
<br/>
  String pname2 = Character.Ename();
<br/>
  Character user;
  <br/>
  try {
  <br/>
    final file = File('characters.txt');
    <br/>
    List<String> lines = file.readAsLinesSync();
<br/>
    if (lines.isNotEmpty) {
     <br/>
      List<String> parts = lines[0].split(','); 
      <br/>
      if (parts.length == 3) {
      <br/>
        int health = int.parse(parts[0].trim());
        <br/>
        int attack = int.parse(parts[1].trim());
        <br/>
        int defense = int.parse(parts[2].trim());
        <br/>
        user = Character(pname2, health, attack, defense);
        <br/>
      } else {
      <br/>
        print("characters.txt의 데이터 형식이 잘못되었습니다.");
        <br/>
        return;
      }
    } else {
      print("characters.txt 파일이 비어 있습니다.");
      <br/>
      return;
      <br/>
    }
  } catch (e) {
  <br/>
    print("characters.txt 파일을 읽는 중 오류가 발생했습니다: $e");
    <br/>
    return;
    <br/>
  }
<br/>
<br/>
<br/>
<br/>
몬스터 택스트파일 불러오기
<br/>
<br/>
<br/>
<br/>
List<Monster> listm = [];
<br/>
  try {
  <br/>
    final file = File('monsters.txt');
    <br/>
    List<String> lines = file.readAsLinesSync();
<br/>
    for (var line in lines) {
    <br/>
      List<String> parts = line.split(',');
      <br/>
      if (parts.length == 4) {
      <br/>
        String name = parts[0].trim();
        <br/>
        int health = int.parse(parts[1].trim());
        <br/>
        int attack = int.parse(parts[2].trim());
        <br/>
        int defense = int.parse(parts[3].trim());
        <br/>
        listm.add(Monster(name, health, attack, defense));
        <br/>
      }
    }
  
  } catch (e) {
  <br/>
    print("monsters.txt 파일을 읽는 중 오류가 발생했습니다: $e");
    <br/>
    return;
    <br/>
  }
<br/>
<br/>
<br/>
<br/>
<br/>
전투부분
<br/>
<br/>
<br/>
<br/>
while (listm.isNotEmpty && user.H2 > 0) {
<br/>
    Monster m2 = listm[Random().nextInt(listm.length)];
    <br/>
    print("\n=== ${m2.name1}이(가) 나타났습니다! ===");
<br/>
    while (!m2.die() && user.H2 > 0) {
    <br/>
      user.Attack2(m2);
      <br/>
      if (m2.die()) {
      <br/>
        print("${m2.name1}을(를) 쓰러뜨렸습니다!");
        <br/>
        user.drain(m2);
        <br/>
        listm.remove(m2);
        <br/>
        break;
        <br/>
      }
<br/>
      print("\n=== ${m2.name1}의 턴 ===");
      <br/>
      m2.Attack(user);
      <br/>
      if (user.H2 <= 0) {
      <br/>
        print("${user.name2}이(가) 쓰러졌습니다...");
        <br/>
        user.saveResult(user, "패배");
        <br/>
        return;
        <br/>
      }
    }

    if (listm.isNotEmpty) { 
     print("다음 몬스터와 대결하시겠습니까? (y/n)");
     String? choice = stdin.readLineSync();<br/>
     if (choice == null || choice.toLowerCase() != 'y') {
       print("게임이 종료되었습니다.");
       user.saveResult(user, "도망");
      return;
      }
    }
  }

<br/>  if (user.H2 > 0) {
  <br/>  print("${user.name2}이(가) 모든 몬스터를 처치했습니다! 승리!");
 <br/>   user.saveResult(user, "승리");
  }
}
<br/>
<br/>
몬스터와 턴을 주고 받고 자동으로 전투가 진행되게 만들었습니다
<br/>
<br/>
다음 몬스터와 대결하지 않으면 종료되게 만들었습니다.
<br/>
<br/>

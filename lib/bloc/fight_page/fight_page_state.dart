part of 'fight_page_bloc.dart';

const maxLives = 5;

@immutable
class FightPageState {
  final BodyPart? defendingBodyPart;
  final BodyPart? attackingBodyPart;
  final int yourLives;
  final int enemyLives;
  final String youFightInfoText;
  final String enemyFightInfoText;
  final String gameOverText;
  final BodyPart? whatEnemyAttacks;
  final BodyPart? whatEnemyDefends;

  FightPageState({
    this.defendingBodyPart,
    this.attackingBodyPart,
    this.yourLives = maxLives,
    this.enemyLives = maxLives,
    this.youFightInfoText = '',
    this.enemyFightInfoText = '',
    this.gameOverText = '',
    this.whatEnemyAttacks,
    this.whatEnemyDefends,
  });

  FightPageState copyWith({
    BodyPart? defendingBodyPart,
    BodyPart? attackingBodyPart,
    int? yourLives,
    int? enemyLives,
    String? youFightInfoText,
    String? enemyFightInfoText,
    String? gameOverText,
    BodyPart? whatEnemyAttacks,
    BodyPart? whatEnemyDefends,
  }) {
    return FightPageState(
        defendingBodyPart: defendingBodyPart ?? this.defendingBodyPart,
        attackingBodyPart: attackingBodyPart ?? this.attackingBodyPart,
        yourLives: yourLives ?? this.yourLives,
        enemyLives: enemyLives ?? this.enemyLives,
        youFightInfoText: youFightInfoText ?? this.youFightInfoText,
        enemyFightInfoText: enemyFightInfoText ?? this.enemyFightInfoText,
        gameOverText: gameOverText ?? this.gameOverText,
        whatEnemyAttacks: whatEnemyAttacks ?? this.whatEnemyAttacks,
        whatEnemyDefends: whatEnemyDefends ?? this.whatEnemyDefends);
  }
}

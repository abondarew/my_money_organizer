/*
Модель характеров расхода для категорий.
характер расхода -дополнительная аналитика, отслеживающая траты по характеристикам, например: "нежелательные траты,
желательные покупки, необходимые, обязательные" и пр.
 */
class NatureOfCostsDomainModel{
  String id;
  String name;
  UriData ico;

  NatureOfCostsDomainModel({
    this.id,
    this.name,
    this.ico
});
}
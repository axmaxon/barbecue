// Функция ymaps.ready() будет вызвана, когда
// загрузятся все компоненты API, а также когда будет готово DOM-дерево.
ymaps.ready(init);
var myMap;

function init(){
    // Переменной address присваиваем значение атрибута data-address из application.html.erb
    var address = document.getElementById('map').getAttribute('data-address');
    console.log(address)
    // Создание карты
    myMap = new ymaps.Map("map", {
        center: [51.76, 55.09],
        zoom: 10
    });

    // Осуществляет поиск объекта с заданным именем (address).
    // Полученный результат сразу отображается на карте.
    myGeocoder = ymaps.geocode(address);

    myGeocoder.then(
        function (res) {
            var coordinates = res.geoObjects.get(0).geometry.getCoordinates();

            // Размещение геообъекта на карте с помощью вспомогательного класса Placemark
            myMap.geoObjects.add(
                new ymaps.Placemark(
                    coordinates,
                    {iconContent: address},
                    {preset: 'islands#blueStretchyIcon'}
                )
            );

            myMap.setCenter(coordinates);
            myMap.setZoom(15);
        },
        function (err) {
            alert('Ошибка при определении местоположения');
        }
    );
}

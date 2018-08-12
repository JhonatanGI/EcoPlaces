<?php
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

$app = new \Slim\App;

$app->get('/api/data', function (Request $request, Response $response) {
    
    $sql = 'SELECT * FROM ecp_data';

    try{
        //inicializa clase cde conexion db
        $db = new db();
        //conectar a db
         $db = $db->conectar();

         $stm = $db->query($sql);
         $data = $stm->fetchAll(PDO::FETCH_OBJ);
         
         $db = null;

         echo json_encode($data);

     }catch(PDOException $ex){
        echo '{"error": {"text": '.$ex->getMessage().'}';
     }
});

//Metodo POST para añadir la datos generados por los sensores en un base de datos
$app->post('/api/Adddata', function (Request $request, Response $response) {

    $aire = $request->getParam('aire');
    $temperatura = $request->getParam('temperatura');
    $sonido = $request->getParam('sonido');
    $longitud = $request->getParam('longitud');
    $latitud = $request->getParam('latitud');
    $lugar = $request->getParam('lugar');
    $iddispositivo = $request->getParam('iddevice');
    
    $sql = ' INSERT INTO ephistoric (Aire, Temperatura, Ruido, Longitud, Latitud,Lugar,id_dispositivo) 
            VALUES (:aire,:temperatura,:sonido,:longitud,:latitud,:lugar,:iddevice) ';

    try{
        //inicializa clase cde conexion db
        $db = new db();
        //conectar a db
        $db = $db->conectar();
        $stm = $db->prepare($sql);
        $stm->bindParam(':aire', $aire);         
        $stm->bindParam(':temperatura', $temperatura);
        $stm->bindParam(':sonido', $sonido);
        $stm->bindParam(':longitud', $longitud);
        $stm->bindParam(':latitud', $latitud);
        $stm->bindParam(':lugar', $lugar);
        $stm->bindParam(':iddevice', $iddispositivo);
        //ejecucion de query
        $stm->execute();
        echo '{"notice": {"text": "data actualizada"}';

      }catch(PDOException $ex){
        echo '{"error": {"text": '.$ex->getMessage().'}';
      }
});


?>
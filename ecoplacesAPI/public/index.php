<?php
use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;

//importacion de modulos de framework Slim y clases para el control y gestion en la DB
require '../vendor/autoload.php';
require '../scr/config/db.php';

//Codigo ejemplo de api rest
$app = new \Slim\App;
$app->get('/hello/{name}', function (Request $request, Response $response, array $args) {
    $name = $request->getAttribute('name');
    $response->getBody()->write("Hello, $name");

    return $response;
});

//importacion de metodos api rest
require '../scr/routes/Data.php';

$app->run();
?>
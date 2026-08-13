<?php

declare(strict_types=1);

use Symfony\Component\Routing\Loader\Configurator\RoutingConfigurator;

return static function (RoutingConfigurator $routes): void {
    $routes->import('@Ad2210MonitoringBundle/Resources/config/routes.php');
    $routes->import('../src/Controller/', 'attribute');
};

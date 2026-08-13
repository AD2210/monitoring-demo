<?php

declare(strict_types=1);

namespace App\Controller;

use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

/**
 * Provides deterministic scenarios for monitoring integration tests.
 */
final class DemoController
{
    /**
     * Returns a normal application response.
     */
    #[Route('/demo/ok', name: 'demo_ok', methods: ['GET'])]
    public function ok(): Response
    {
        return new Response('demo-ok');
    }

    /**
     * Produces a controlled server failure for alert testing.
     */
    #[Route('/demo/fail', name: 'demo_fail', methods: ['GET'])]
    public function fail(): never
    {
        throw new \RuntimeException('Intentional monitoring demo failure.');
    }

    /**
     * Produces deterministic latency for threshold testing.
     */
    #[Route('/demo/slow', name: 'demo_slow', methods: ['GET'])]
    public function slow(): Response
    {
        usleep(250_000);

        return new Response('demo-slow');
    }
}

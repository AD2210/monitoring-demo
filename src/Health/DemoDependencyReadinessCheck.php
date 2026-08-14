<?php

declare(strict_types=1);

namespace App\Health;

use Ad2210\MonitoringBundle\Health\ReadinessCheckInterface;
use Ad2210\MonitoringBundle\Health\ReadinessCheckResult;

/**
 * Simulates an external dependency for deterministic readiness scenarios.
 */
final readonly class DemoDependencyReadinessCheck implements ReadinessCheckInterface
{
    public function __construct(private bool $dependencyDown)
    {
    }

    /**
     * Returns the stable check name exposed by the demo application.
     */
    public function getName(): string
    {
        return 'demo_dependency';
    }

    /**
     * Simulates dependency availability without requiring an external service.
     */
    public function check(): ReadinessCheckResult
    {
        return $this->dependencyDown
            ? new ReadinessCheckResult('error')
            : new ReadinessCheckResult('ok');
    }
}

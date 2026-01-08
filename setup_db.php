<?php
require_once 'config/db.php';

header('Content-Type: application/json');

try {
    $sql = file_get_contents('database.sql');
    $pdo->exec($sql);
    echo json_encode([
        "status" => "success",
        "message" => "Database schema created and seeded successfully."
    ]);
} catch (Exception $e) {
    echo json_encode([
        "status" => "error",
        "message" => "Failed to setup database: " . $e->getMessage()
    ]);
}
?>

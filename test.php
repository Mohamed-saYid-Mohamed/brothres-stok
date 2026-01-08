<?php


require_once 'config/db.php';

header('Content-Type: application/json');

if (isset($pdo)) {
    echo json_encode([
        "status" => "success",
        "message" => "Connected to the database 'brothres_stok' successfully."
    ]);
} else {
    echo json_encode([
        "status" => "error",
        "message" => "PDO instance not found."
    ]);
}
?>

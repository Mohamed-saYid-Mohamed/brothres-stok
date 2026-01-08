<?php
/**
 * Authentication API for Brothers Stock
 * Handles Login and Registration
 */

require_once '../config/db.php';

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With');

$method = $_SERVER['REQUEST_METHOD'];
$input = json_decode(file_get_contents('php://input'), true);

if ($method == 'OPTIONS') {
    http_response_code(200);
    exit;
}

if ($method != 'POST') {
    echo json_encode(["status" => "error", "message" => "Only POST method is allowed"]);
    exit;
}

$action = $_GET['action'] ?? $input['action'] ?? '';

switch ($action) {
    case 'register':
        handleRegister($pdo, $input);
        break;
    case 'login':
        handleLogin($pdo, $input);
        break;
    default:
        echo json_encode(["status" => "error", "message" => "Invalid action"]);
        break;
}

function handleRegister($pdo, $input) {
    if (empty($input['fullname']) || empty($input['email']) || empty($input['password'])) {
        echo json_encode(["status" => "error", "message" => "All fields are required"]);
        return;
    }

    // Check if email already exists
    $stmt = $pdo->prepare("SELECT id FROM users WHERE email = ?");
    $stmt->execute([$input['email']]);
    if ($stmt->fetch()) {
        echo json_encode(["status" => "error", "message" => "Email already exists"]);
        return;
    }

    // Hash the password
    $hashedPassword = password_hash($input['password'], PASSWORD_DEFAULT);

    $sql = "INSERT INTO users (fullname, email, password) VALUES (?, ?, ?)";
    $stmt = $pdo->prepare($sql);
    try {
        $stmt->execute([
            $input['fullname'],
            $input['email'],
            $hashedPassword
        ]);
        echo json_encode([
            "status" => "success",
            "message" => "User registered successfully",
            "user" => [
                "id" => $pdo->lastInsertId(),
                "fullname" => $input['fullname'],
                "email" => $input['email']
            ]
        ]);
    } catch (Exception $e) {
        echo json_encode(["status" => "error", "message" => $e->getMessage()]);
    }
}

function handleLogin($pdo, $input) {
    if (empty($input['email']) || empty($input['password'])) {
        echo json_encode(["status" => "error", "message" => "Email and password are required"]);
        return;
    }

    $stmt = $pdo->prepare("SELECT * FROM users WHERE email = ?");
    $stmt->execute([$input['email']]);
    $user = $stmt->fetch();

    if ($user && password_verify($input['password'], $user['password'])) {
        // Remove password from response
        unset($user['password']);
        echo json_encode([
            "status" => "success",
            "message" => "Login successful",
            "user" => $user
        ]);
    } else {
        echo json_encode(["status" => "error", "message" => "Invalid email or password"]);
    }
}
?>

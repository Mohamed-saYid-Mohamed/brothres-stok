<?php
/**
 * Products API for Brothers Stock
 * Handles CRUD operations via JSON
 */

require_once 'config/db.php';

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With');

$method = $_SERVER['REQUEST_METHOD'];
$input = json_decode(file_get_contents('php://input'), true);

switch ($method) {
    case 'GET':
        handleGet($pdo);
        break;
    case 'POST':
        handlePost($pdo, $input);
        break;
    case 'PUT':
        handlePut($pdo, $input);
        break;
    case 'DELETE':
        handleDelete($pdo, $input);
        break;
    case 'OPTIONS':
        // Handle preflight requests
        http_response_code(200);
        break;
    default:
        echo json_encode(["status" => "error", "message" => "Method not allowed"]);
        break;
}

function handleGet($pdo) {
    if (isset($_GET['id'])) {
        $stmt = $pdo->prepare("SELECT * FROM products WHERE id = ?");
        $stmt->execute([$_GET['id']]);
        $product = $stmt->fetch();
        if ($product) {
            echo json_encode(["status" => "success", "data" => $product]);
        } else {
            echo json_encode(["status" => "error", "message" => "Product not found"]);
        }
    } else {
        $stmt = $pdo->query("SELECT * FROM products ORDER BY created_at DESC");
        $products = $stmt->fetchAll();
        echo json_encode(["status" => "success", "data" => $products]);
    }
}

function handlePost($pdo, $input) {
    if (empty($input['name']) || empty($input['price'])) {
        echo json_encode(["status" => "error", "message" => "Name and price are required"]);
        return;
    }

    $sql = "INSERT INTO products (name, description, price, image_url, category) VALUES (?, ?, ?, ?, ?)";
    $stmt = $pdo->prepare($sql);
    try {
        $stmt->execute([
            $input['name'],
            $input['description'] ?? '',
            $input['price'],
            $input['image_url'] ?? '',
            $input['category'] ?? ''
        ]);
        echo json_encode([
            "status" => "success",
            "message" => "Product created successfully",
            "id" => $pdo->lastInsertId()
        ]);
    } catch (Exception $e) {
        echo json_encode(["status" => "error", "message" => $e->getMessage()]);
    }
}

function handlePut($pdo, $input) {
    if (empty($input['id'])) {
        echo json_encode(["status" => "error", "message" => "Product ID is required"]);
        return;
    }

    $sql = "UPDATE products SET name = ?, description = ?, price = ?, image_url = ?, category = ? WHERE id = ?";
    $stmt = $pdo->prepare($sql);
    try {
        $stmt->execute([
            $input['name'],
            $input['description'],
            $input['price'],
            $input['image_url'],
            $input['category'],
            $input['id']
        ]);
        echo json_encode(["status" => "success", "message" => "Product updated successfully"]);
    } catch (Exception $e) {
        echo json_encode(["status" => "error", "message" => $e->getMessage()]);
    }
}

function handleDelete($pdo, $input) {
    $id = $_GET['id'] ?? $input['id'] ?? null;
    if (!$id) {
        echo json_encode(["status" => "error", "message" => "Product ID is required"]);
        return;
    }

    $stmt = $pdo->prepare("DELETE FROM products WHERE id = ?");
    try {
        $stmt->execute([$id]);
        echo json_encode(["status" => "success", "message" => "Product deleted successfully"]);
    } catch (Exception $e) {
        echo json_encode(["status" => "error", "message" => $e->getMessage()]);
    }
}
?>

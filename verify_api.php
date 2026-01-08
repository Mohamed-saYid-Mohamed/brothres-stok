<?php
/**
 * Verification Script for Brothers Stock API
 * Tests Read, Create, Update, and Delete operations
 */

function testApi($method, $data = null, $id = null) {
    $baseUrl = 'http://localhost/brothers_stock/api/products.php';
    $url = $id ? "$baseUrl?id=$id" : $baseUrl;
    
    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_CUSTOMREQUEST, $method);
    
    if ($data) {
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data));
        curl_setopt($ch, CURLOPT_HTTPHEADER, ['Content-Type: application/json']);
    }
    
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);
    
    return [
        'code' => $httpCode,
        'body' => json_decode($response, true)
    ];
}

echo "--- Brothers Stock API Verification ---\n\n";

// 1. Test Read (All)
echo "1. Testing READ (All products)...\n";
$res = testApi('GET');
if ($res['code'] == 200 && $res['body']['status'] == 'success') {
    echo "SUCCESS: " . count($res['body']['data']) . " products found.\n";
} else {
    echo "FAILED: " . print_r($res, true) . "\n";
}

// 2. Test Create
echo "\n2. Testing CREATE (New product)...\n";
$newProduct = [
    'name' => 'Verification Laptop',
    'description' => 'A laptop created during verification',
    'price' => 500.00,
    'image_url' => 'https://example.com/laptop.jpg',
    'category' => 'Electronics'
];
$res = testApi('POST', $newProduct);
$newId = null;
if ($res['code'] == 200 && isset($res['body']['status']) && $res['body']['status'] == 'success') {
    $newId = $res['body']['id'];
    echo "SUCCESS: Product created with ID $newId.\n";
} else {
    echo "FAILED: " . print_r($res, true) . "\n";
}

if ($newId) {
    // 3. Test Update
    echo "\n3. Testing UPDATE (Product $newId)...\n";
    $updatedProduct = $newProduct;
    $updatedProduct['id'] = $newId;
    $updatedProduct['name'] = 'Verification Laptop (Updated)';
    $res = testApi('PUT', $updatedProduct);
    if ($res['code'] == 200 && isset($res['body']['status']) && $res['body']['status'] == 'success') {
        echo "SUCCESS: Product updated.\n";
    } else {
        echo "FAILED: " . print_r($res, true) . "\n";
    }

    // 4. Test Read (Single)
    echo "\n4. Testing READ (Single product $newId)...\n";
    $res = testApi('GET', null, $newId);
    if ($res['code'] == 200 && isset($res['body']['status']) && $res['body']['status'] == 'success' && $res['body']['data']['name'] == 'Verification Laptop (Updated)') {
        echo "SUCCESS: Single product read correctly.\n";
    } else {
        echo "FAILED: " . print_r($res, true) . "\n";
    }

    // 5. Test Delete
    echo "\n5. Testing DELETE (Product $newId)...\n";
    $res = testApi('DELETE', null, $newId);
    if ($res['code'] == 200 && isset($res['body']['status']) && $res['body']['status'] == 'success') {
        echo "SUCCESS: Product deleted.\n";
    } else {
        echo "FAILED: " . print_r($res, true) . "\n";
    }
}

echo "\n--- Verification Completed ---\n";
?>

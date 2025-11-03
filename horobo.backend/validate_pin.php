<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

// Database configuration
$config = [
    'host' => 'localhost',
    'user' => 'root',
    'pass' => '',
    'db'   => 'hotel_management'
];

// Expected PIN (for demo - store this securely in production)
$valid_pin = "1234"; // Change this to your actual PIN

try {
    $conn = new mysqli($config['host'], $config['user'], $config['pass'], $config['db']);
    
    if ($conn->connect_error) {
        throw new Exception("Database connection failed");
    }

    // Get input data
    $input = json_decode(file_get_contents('php://input'), true) ?? $_POST;
    
    // Validate PIN first
    if (empty($input['pin']) || $input['pin'] !== $valid_pin) {
        throw new Exception("Invalid PIN");
    }

    // Then validate other fields
    $required = ['hotel_name', 'date', 'available_rooms'];
    foreach ($required as $field) {
        if (empty($input[$field])) {
            throw new Exception("Missing required field: $field");
        }
    }

    // Prepare statement
    $stmt = $conn->prepare("INSERT INTO room_availability 
                          (hotel_name, date, available_rooms) 
                          VALUES (?, ?, ?)
                          ON DUPLICATE KEY UPDATE 
                          available_rooms = VALUES(available_rooms)");
    
    $stmt->bind_param("ssi", 
        $input['hotel_name'],
        $input['date'],
        $input['available_rooms']
    );

    if ($stmt->execute()) {
        $response = [
            'status' => 'success',
            'message' => 'Room availability updated'
        ];
    } else {
        throw new Exception("Database error: " . $stmt->error);
    }

} catch (Exception $e) {
    $response = [
        'status' => 'error',
        'message' => $e->getMessage()
    ];
} finally {
    if (isset($stmt)) $stmt->close();
    if (isset($conn)) $conn->close();
    
    echo json_encode($response);
}
?>
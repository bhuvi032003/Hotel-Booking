<?php
header('Content-Type: application/json');

// Database connection
$host = "localhost";
$user = "root";
$password = "";
$database = "horobo";

// Create connection
$conn = new mysqli($host, $user, $password, $database);

// Check connection
if ($conn->connect_error) {
    echo json_encode(["status" => "error", "message" => "Database connection failed"]);
    exit;
}

// Get POST data
$hotel_name = isset($_POST['hotel_name']) ? trim($_POST['hotel_name']) : '';
$date = isset($_POST['date']) ? trim($_POST['date']) : '';
$available_rooms = isset($_POST['available_rooms']) ? intval($_POST['available_rooms']) : 0;

// Validate input
if (empty($hotel_name) || empty($date) || $available_rooms <= 0) {
    echo json_encode(["status" => "error", "message" => "All fields are required and must be valid"]);
    exit;
}

// Check if record exists
$checkQuery = "SELECT id FROM room_availability WHERE hotel_name = ? AND date = ?";
$stmt = $conn->prepare($checkQuery);
$stmt->bind_param("ss", $hotel_name, $date);
$stmt->execute();
$stmt->store_result();

if ($stmt->num_rows > 0) {
    // Update
    $updateQuery = "UPDATE room_availability SET available_rooms = ? WHERE hotel_name = ? AND date = ?";
    $updateStmt = $conn->prepare($updateQuery);
    $updateStmt->bind_param("iss", $available_rooms, $hotel_name, $date);
    
    if ($updateStmt->execute()) {
        echo json_encode(["status" => "success", "message" => "Room availability updated"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Failed to update record"]);
    }
} else {
    // Insert
    $insertQuery = "INSERT INTO room_availability (hotel_name, date, available_rooms) VALUES (?, ?, ?)";
    $insertStmt = $conn->prepare($insertQuery);
    $insertStmt->bind_param("ssi", $hotel_name, $date, $available_rooms);
    
    if ($insertStmt->execute()) {
        echo json_encode(["status" => "success", "message" => "Room availability inserted"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Failed to insert record"]);
    }
}

$conn->close();
?>

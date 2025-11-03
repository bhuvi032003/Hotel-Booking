<?php
header('Content-Type: application/json');

// Database connection
$host = "localhost";
$user = "root";
$password = ""; // Default for XAMPP
$database = "horobo"; // Your DB name

$conn = new mysqli($host, $user, $password, $database);

// Check connection
if ($conn->connect_error) {
    echo json_encode(["status" => "error", "message" => "Database connection failed"]);
    exit;
}

// Get POST data
$email = $_POST['email'] ?? '';
$hotelname = $_POST['hotelname'] ?? '';
$rooms = $_POST['rooms'] ?? 0;
$aadhar = $_POST['aadhar'] ?? '';
$address = $_POST['address'] ?? '';
$date = $_POST['date'] ?? '';
$price = $_POST['price'] ?? '';
$id = $_POST['id'] ?? '';
$guest = $_POST['guest'] ?? '';

// Validate required fields
if (empty($email) || empty($hotelname) || empty($aadhar) || empty($address) || empty($date) || empty($price) || empty($id) || empty($guest)) {
    echo json_encode(["status" => "error", "message" => "Missing required fields"]);
    exit;
}

// Insert query
$stmt = $conn->prepare("INSERT INTO hotelbooking (email, hotelname, rooms, aadhar, address, date, price, id, guest) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
$stmt->bind_param("ssissssss", $email, $hotelname, $rooms, $aadhar, $address, $date, $price, $id, $guest);

if ($stmt->execute()) {
    echo json_encode(["status" => "success", "message" => "Booking inserted successfully"]);
} else {
    echo json_encode(["status" => "error", "message" => "Insert failed: " . $stmt->error]);
}

$stmt->close();
$conn->close();
?>

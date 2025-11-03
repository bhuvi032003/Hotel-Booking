<?php
header('Content-Type: application/json');

// Database connection
$host = "localhost";
$user = "root";
$password = ""; // Default for XAMPP
$database = "horobo";

$conn = new mysqli($host, $user, $password, $database);

// Check connection
if ($conn->connect_error) {
    echo json_encode(["status" => "error", "message" => "Database connection failed"]);
    exit;
}

// Get email from POST or GET
$email = $_POST['email'] ?? $_GET['email'] ?? '';

if (empty($email)) {
    echo json_encode(["status" => "error", "message" => "Email is required"]);
    exit;
}

// Prepare query to fetch bookings by email
$stmt = $conn->prepare("SELECT * FROM hotelbooking WHERE email = ?");
$stmt->bind_param("s", $email);
$stmt->execute();

$result = $stmt->get_result();
$bookings = [];

while ($row = $result->fetch_assoc()) {
    $bookings[] = $row;
}

if (count($bookings) > 0) {
    echo json_encode(["status" => "success", "data" => $bookings]);
} else {
    echo json_encode(["status" => "success", "data" => [], "message" => "No bookings found"]);
}

$stmt->close();
$conn->close();
?>

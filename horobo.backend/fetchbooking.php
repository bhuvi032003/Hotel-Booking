<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST");
header("Access-Control-Allow-Headers: Content-Type");

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "horobo";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die(json_encode(["status" => "error", "message" => "Connection failed: " . $conn->connect_error]));
}

// Get email from request
$email = isset($_GET['email']) ? $conn->real_escape_string($_GET['email']) : '';

if (empty($email)) {
    echo json_encode(["status" => "error", "message" => "Email parameter is required"]);
    exit;
}

// Fetch bookings
$sql = "SELECT * FROM bookings WHERE email = '$email' ORDER BY created_at DESC";
$result = $conn->query($sql);

$bookings = [];
if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $bookings[] = $row;
    }
}

echo json_encode([
    "status" => "success",
    "data" => $bookings
]);

$conn->close();
?>
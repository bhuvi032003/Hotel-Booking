<?php
header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

$servername = "localhost";
$username = "root"; // Default XAMPP username
$password = "";     // Default XAMPP password
$dbname = "horobo";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die(json_encode(["status" => "error", "message" => "Connection failed: " . $conn->connect_error]));
}

// Get POST data
$data = json_decode(file_get_contents("php://input"), true);

// If not JSON, try form data
if (empty($data)) {
    $data = $_POST;
}

// Validate required fields
$required = ['email', 'hotelname', 'rooms', 'aadhar', 'address', 'date', 'price', 'guest'];
foreach ($required as $field) {
    if (empty($data[$field])) {
        echo json_encode(["status" => "error", "message" => "$field is required"]);
        exit;
    }
}

// Sanitize input
$id = uniqid();
$email = $conn->real_escape_string($data['email']);
$hotelname = $conn->real_escape_string($data['hotelname']);
$rooms = (int)$data['rooms'];
$aadhar = $conn->real_escape_string($data['aadhar']);
$address = $conn->real_escape_string($data['address']);
$date = $conn->real_escape_string($data['date']);
$price = (float)$data['price'];
$guest = (int)$data['guest'];

// Insert into database
$sql = "INSERT INTO bookings (id, email, hotelname, rooms, aadhar, address, date, price, guest)
        VALUES ('$id', '$email', '$hotelname', $rooms, '$aadhar', '$address', '$date', $price, $guest)";

if ($conn->query($sql) === TRUE) {
    echo json_encode([
        "status" => "success",
        "message" => "Booking confirmed!",
        "booking_id" => $id
    ]);
} else {
    echo json_encode([
        "status" => "error",
        "message" => "Error: " . $sql . "<br>" . $conn->error
    ]);
}

$conn->close();
?>
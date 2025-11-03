<?php
$host = "localhost";
$user = "root";
$password = ""; // XAMPP default
$database = "horobo"; // your actual DB name

$conn = new mysqli($host, $user, $password, $database);

if ($conn->connect_error) {
    die(json_encode([
        "status" => "error",
        "message" => "Connection failed: " . $conn->connect_error
    ]));
}
?>

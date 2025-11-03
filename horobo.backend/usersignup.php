<?php
header('Content-Type: application/json');

$host = "localhost";
$user = "root";
$password = ""; // For XAMPP
$database = "horobo";

$conn = new mysqli($host, $user, $password, $database);

if ($conn->connect_error) {
    echo json_encode([
        "status" => "error",
        "message" => "Connection failed"
    ]);
    exit();
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $name     = $_POST['name'];
    $email    = $_POST['email'];
    $password = $_POST['password']; // 🔓 Plain-text password (not secure)
    $number   = $_POST['number'];
    $role     = isset($_POST['role']) ? $_POST['role'] : 'user';

    // Check if email already exists
    $check = $conn->prepare("SELECT * FROM signup WHERE email = ?");
    $check->bind_param("s", $email);
    $check->execute();
    $result = $check->get_result();

    if ($result->num_rows > 0) {
        echo json_encode([
            "status" => "error",
            "message" => "Email already exists"
        ]);
        $check->close();
        $conn->close();
        exit();
    }
    $check->close();

    // Insert user without password hashing
    $stmt = $conn->prepare("INSERT INTO signup (name, email, password, number, role) VALUES (?, ?, ?, ?, ?)");
    $stmt->bind_param("sssss", $name, $email, $password, $number, $role);

    if ($stmt->execute()) {
        echo json_encode([
            "status" => "success",
            "message" => "Signup successful"
        ]);
    } else {
        echo json_encode([
            "status" => "error",
            "message" => "Signup failed: " . $stmt->error
        ]);
    }

    $stmt->close();
    $conn->close();
} else {
    echo json_encode([
        "status" => "error",
        "message" => "Invalid request"
    ]);
}
?>

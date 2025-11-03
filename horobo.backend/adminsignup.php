<?php
header('Content-Type: application/json');
include 'db.php'; // Reuse your database connection

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name       = $_POST['name'];
    $email      = $_POST['email'];
    $password   = $_POST['password']; // ✅ Store as plain text (NOT RECOMMENDED)
    $number     = $_POST['number'];
    $hotelname  = $_POST['hotelname'];
    $hotelpin   = $_POST['hotelpin'];

    // Check if email already exists
    $check = $conn->prepare("SELECT * FROM adminsignup WHERE email = ?");
    $check->bind_param("s", $email);
    $check->execute();
    $result = $check->get_result();

    if ($result->num_rows > 0) {
        echo json_encode(["status" => "error", "message" => "Email already exists"]);
        $check->close();
        $conn->close();
        exit();
    }
    $check->close();

    // ❌ Do not hash password — saving as plain text (insecure)
    $stmt = $conn->prepare("INSERT INTO adminsignup (name, email, password, number, hotelname, hotelpin) VALUES (?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("ssssss", $name, $email, $password, $number, $hotelname, $hotelpin);

    if ($stmt->execute()) {
        echo json_encode(["status" => "success", "message" => "Admin signup successful"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Signup failed: " . $stmt->error]);
    }

    $stmt->close();
    $conn->close();
} else {
    echo json_encode(["status" => "error", "message" => "Invalid request method"]);
}
?>

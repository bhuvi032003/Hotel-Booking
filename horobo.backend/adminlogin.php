<?php
header('Content-Type: application/json');
include 'db.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'] ?? '';
    $password = $_POST['password'] ?? '';

    // Validate inputs
    if (empty($email) || empty($password)) {
        echo json_encode(["status" => "error", "message" => "Missing email or password"]);
        exit();
    }

    $stmt = $conn->prepare("SELECT * FROM admin_signup WHERE email = ?");
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($row = $result->fetch_assoc()) {
        // NOTE: Plaintext password match (you asked for it)
        if ($password === $row['password']) {
            echo json_encode(["status" => "success", "message" => "Admin login successful"]);
        } else {
            echo json_encode(["status" => "error", "message" => "Invalid password"]);
        }
    } else {
        echo json_encode(["status" => "error", "message" => "Admin not found"]);
    }

    $stmt->close();
    $conn->close();
} else {
    echo json_encode(["status" => "error", "message" => "Only POST allowed"]);
}
?>

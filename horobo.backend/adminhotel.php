<?php
header('Content-Type: application/json');
$host = "localhost";
$user = "root";
$password = "";
$database = "horobo";

$conn = new mysqli($host, $user, $password, $database);
if ($conn->connect_error) {
    echo json_encode(["status" => "error", "message" => "Connection failed"]);
    exit;
}

$action = $_POST['action'] ?? $_GET['action'] ?? '';

function saveImage($field) {
    if (isset($_FILES[$field]) && $_FILES[$field]['error'] === 0) {
        $uploadDir = 'uploads/';
        if (!file_exists($uploadDir)) {
            mkdir($uploadDir, 0777, true);
        }
        $filename = basename($_FILES[$field]['name']);
        $target = $uploadDir . uniqid() . "_" . $filename;
        if (move_uploaded_file($_FILES[$field]['tmp_name'], $target)) {
            return $target;
        }
    }
    return '';
}

switch ($action) {
    case 'add':
        $name = $_POST['name'] ?? '';
        $address = $_POST['address'] ?? '';
        $price = $_POST['price'] ?? '';
        $rooms_available = $_POST['rooms_available'] ?? 0;
        $nearby_place1 = $_POST['nearby_place1'] ?? '';
        $nearby_place2 = $_POST['nearby_place2'] ?? '';

        // Save images
        $main_image = saveImage('main_image');
        $room_image1 = saveImage('room_image1');
        $room_image2 = saveImage('room_image2');
        $room_image3 = saveImage('room_image3');
        $nearby_image1 = saveImage('nearby_image1');
        $nearby_image2 = saveImage('nearby_image2');

        $stmt = $conn->prepare("INSERT INTO hotels (name, address, price, main_image, room_image1, room_image2, room_image3, nearby_place1, nearby_place2, nearby_image1, nearby_image2, rooms_available) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("sssssssssssi", $name, $address, $price, $main_image, $room_image1, $room_image2, $room_image3, $nearby_place1, $nearby_place2, $nearby_image1, $nearby_image2, $rooms_available);

        if ($stmt->execute()) {
            echo json_encode(["status" => "success", "message" => "Hotel added"]);
        } else {
            echo json_encode(["status" => "error", "message" => $stmt->error]);
        }
        $stmt->close();
        break;

    case 'get':
        $result = $conn->query("SELECT * FROM hotels ORDER BY added_on DESC");
        $hotels = [];
        while ($row = $result->fetch_assoc()) {
            $hotels[] = $row;
        }
        echo json_encode(["status" => "success", "data" => $hotels]);
        break;

    case 'update':
        $id = $_POST['id'] ?? '';
        $rooms_available = $_POST['rooms_available'] ?? '';

        if (empty($id) || !is_numeric($rooms_available)) {
            echo json_encode(["status" => "error", "message" => "Invalid input"]);
            break;
        }

        $stmt = $conn->prepare("UPDATE hotels SET rooms_available = ? WHERE id = ?");
        $stmt->bind_param("ii", $rooms_available, $id);

        if ($stmt->execute()) {
            echo json_encode(["status" => "success", "message" => "Room availability updated"]);
        } else {
            echo json_encode(["status" => "error", "message" => $stmt->error]);
        }
        $stmt->close();
        break;

    case 'delete':
        $id = $_POST['id'] ?? '';

        $stmt = $conn->prepare("DELETE FROM hotels WHERE id = ?");
        $stmt->bind_param("i", $id);

        if ($stmt->execute()) {
            echo json_encode(["status" => "success", "message" => "Hotel deleted"]);
        } else {
            echo json_encode(["status" => "error", "message" => $stmt->error]);
        }
        $stmt->close();
        break;

    default:
        echo json_encode(["status" => "error", "message" => "Invalid or missing action"]);
        break;
}

$conn->close();
?>

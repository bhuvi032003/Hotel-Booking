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

$sql = "SELECT id, name, address, price, main_image, room_image1, room_image2, room_image3, nearby_place1, nearby_place2, nearby_image1, nearby_image2, rooms_available FROM hotels ORDER BY added_on DESC";

$result = $conn->query($sql);

$hotels = [];

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $hotels[] = [
            "id" => $row["id"],
            "name" => $row["name"],
            "address" => $row["address"],
            "price" => $row["price"],
            "main_image" => $row["main_image"],
            "roomImages" => array_filter([$row["room_image1"], $row["room_image2"], $row["room_image3"]]),
            "nearbyPlacesImages" => array_filter([$row["nearby_image1"], $row["nearby_image2"]]),
            "nearbyPlaces" => array_filter([$row["nearby_place1"], $row["nearby_place2"]]),
            "rooms_available" => $row["rooms_available"]
        ];
    }

    echo json_encode(["status" => "success", "data" => $hotels]);
} else {
    echo json_encode(["status" => "success", "data" => []]);
}

$conn->close();
?>

<?php
session_start();
if ($_SESSION['role'] != 'user') {
    header("Location: login.php");
    exit();
}

// Koneksi ke database
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "kampeling";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Koneksi gagal: " . $conn->connect_error);
}

$user_id = $_POST['user_id'];
$amount = $_POST['amount'];

// Insert permintaan penarikan ke tabel withdraw_requests
$sql = "INSERT INTO withdraw_requests (user_id, amount) VALUES ('$user_id', '$amount')";

if ($conn->query($sql) === TRUE) {
    echo "Withdrawal request submitted successfully. <a href='dashboard_user.php'>Back to Dashboard</a>";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>

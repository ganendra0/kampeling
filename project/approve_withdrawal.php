<?php
session_start();
if ($_SESSION['role'] != 'admin') {
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

$request_id = $_POST['request_id'];
$action = $_POST['action'];

// Ambil data permintaan penarikan
$sql = "SELECT user_id, amount FROM withdraw_requests WHERE id = $request_id";
$result = $conn->query($sql);
$row = $result->fetch_assoc();
$user_id = $row['user_id'];
$amount = $row['amount'];

if ($action == 'approve') {
    // Update status permintaan menjadi approved dan kurangi saldo user
    $conn->begin_transaction();

    try {
        $sql_update_request = "UPDATE withdraw_requests SET status = 'approved', approve_date = NOW() WHERE id = $request_id";
        $conn->query($sql_update_request);

        $sql_update_saldo = "UPDATE user_saldo SET total_saldo = total_saldo - $amount WHERE user_id = $user_id";
        $conn->query($sql_update_saldo);

        // Insert ke tabel transactions
        $sql_transaction = "INSERT INTO transactions (user_id, type, amount) VALUES ('$user_id', 'withdrawal', '$amount')";
        $conn->query($sql_transaction);

        $conn->commit();
        echo "Withdrawal request approved successfully.";
    } catch (Exception $e) {
        $conn->rollback();
        echo "Failed to approve withdrawal request: " . $e->getMessage();
    }
} else if ($action == 'reject') {
    // Update status permintaan menjadi rejected
    $sql_update_request = "UPDATE withdraw_requests SET status = 'rejected' WHERE id = $request_id";
    if ($conn->query($sql_update_request) === TRUE) {
        echo "Withdrawal request rejected successfully.";
    } else {
        echo "Error: " . $sql_update_request . "<br>" . $conn->error;
    }
}

$conn->close();
header("Location: manage_withdrawals.php");
exit();
?>

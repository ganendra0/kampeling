<?php
ini_set('display_errors', 1);
error_reporting(E_ALL & ~E_NOTICE);

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

$user_id = $_POST['user_id'];
$sampah_ids = $_POST['sampah_id'];
$berat_kgs = $_POST['berat_kg'];

for ($i = 0; $i < count($sampah_ids); $i++) {
    $sampah_id = $conn->real_escape_string($sampah_ids[$i]);
    $berat_kg = $conn->real_escape_string($berat_kgs[$i]);
    
    // Ambil harga dari tabel sampah
    $sql_harga = "SELECT harga_nasabah FROM sampah WHERE id = $sampah_id";
    $result_harga = $conn->query($sql_harga);
    $row_harga = $result_harga->fetch_assoc();
    $harga_nasabah = $row_harga['harga_nasabah'];
    
    $total_harga = $berat_kg * $harga_nasabah;
    
    // Insert ke tabel user_sampah
    $sql = "INSERT INTO user_sampah (user_id, nama_barang, harga_nasabah, berat_kg, total, tanggal_setor) 
            VALUES ('$user_id', (SELECT nama_barang FROM sampah WHERE id = $sampah_id), '$harga_nasabah', '$berat_kg', '$total_harga', NOW())";

    if ($conn->query($sql) === TRUE) {
        // Update saldo user
        $update_saldo = "UPDATE user_saldo SET total_berat = total_berat + $berat_kg, total_saldo = total_saldo + $total_harga WHERE user_id = $user_id";
        if ($conn->query($update_saldo) === TRUE) {
            echo "Data berhasil disimpan. <a href='dashboard_admin.php'>Kembali ke Dashboard</a>";
        } else {
            echo "Error: " . $update_saldo . "<br>" . $conn->error;
        }
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
}

$conn->close();
header("Location: dashboard_admin.php");
exit();
?>

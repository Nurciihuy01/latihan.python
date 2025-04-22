import mysql.connector
from mysql.connector import errors

# Koneksi ke database
def koneksi():
    global dbku
    try:
        dbku = mysql.connector.connect(
            host="localhost",
            port="3306",
            user="root",
            password="",
            database="Klinik"
        )
    except errors.OperationalError as e:
        print(f"Error connecting to database: {e}")
        dbku = None

def reconnect():
    global dbku
    if dbku is None or not dbku.is_connected():
        koneksi()

#Inisialisasi sebelum digunakan
koneksi()

def login():
    print("===== Login =====")
    email = input("Email: ")
    password = input("Password: ")

    reconnect()

    conn = dbku  #Menggunakan koneksi yang sudah terbentuk
    if conn:
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM pengguna WHERE email = '"+email+"' AND password = '"+password+"'")
        user = cursor.fetchone()
        conn.close()

        if user:
            print("Berhasil Login")
            return user
        else:
            print("Email dan Password Anda salah")
            return None
    return None

#Menu Admin
def admin_menu():
    while True:
        print("\n===== Admin Menu =====")
        print("1. Pendaftaran")
        print("2. Input Pasien")
        print("3. Transaksi")
        print("4. Pengguna")
        print("5. Logout")
        menu = input("Pilih menu: ")

        if menu == "1":
            pendaftaran()
        elif menu == "2":
            input_pasien()
        elif menu == "3":
            input_transaksi()
        elif menu == "4":
            users()
        elif menu == "5":
            print("Anda berhasil Logout")
            break
        else:
            print("Menu yang Anda pilih tidak tersedia")

def menu_dokter():
    while True:
        print("\n===== Dokter Menu =====")
        print("1. Pendaftaran")
        print("2. Riwayat Pasien")
        print("3. Logout")
        menu = input("Pilih menu: ")

        if menu == "1":
            id_dokter = input("Masukkan ID Dokter anda: ")
            query = 'SELECT pasien.id_pasien, pasien.nama, pasien.tanggal_lahir, pasien.jenis_kelamin, pasien.alamat, pasien.nomor_telepon FROM pasien JOIN pendaftaran ON pasien.id_pasien = pendaftaran.id_pasien WHERE pendaftaran.id_dokter = %s'
            reconnect()
            cursor = dbku.cursor(dictionary=True)
            cursor.execute(query, (id_dokter,))
            pasien_list = cursor.fetchall()
            print("Daftar Pasien Anda:")
            for pasien in pasien_list:
                print(pasien)
        elif menu == "2":
            riwayat_pasien()
        elif menu == "3":
            print("Anda berhasil Logout")
            break
        else:
            print("Menu yang Anda pilih tidak tersedia")

#Pendaftaran Pasien
def pendaftaran():
    print("===== Pendaftaran Pasien =====")
    while True:
        id_pasien = input("Input ID Pasien: ")
        reconnect() 

        conn = dbku
        if conn:
            cursor = conn.cursor(dictionary=True)
            cursor.execute("SELECT * FROM pasien WHERE id_pasien = '"+id_pasien+"'")
            existing_patient = cursor.fetchone()

            if existing_patient:
                print("Pasien sudah terdaftar. Melanjutkan pendaftaran baru untuk pasien tersebut.")
                input_pendaftaran(existing_patient)
                break
            else:
                print("Pasien belum terdaftar. Silakan input data pasien terlebih dahulu.")
                input_pasien()

#input Pendaftaran Baru untuk pasien yang sudah ada
def input_pendaftaran(existing_patient):
    id_daftar = input("Input ID Pendaftaran: ")
    id_pasien = input("Input ID Pasien: ")
    id_dokter = input('Input ID Dokter: ')
    tanggal = input("Tanggal Pendaftaran (YYYY-MM-DD): ")
    antrian = input("Antrian ke: ")

    query = 'INSERT INTO pendaftaran (id_pendaftaran, id_pasien, id_dokter, tanggal_pendaftaran, antrian) VALUES (%s, %s, %s, %s, %s)'
    
    print(query) 
    konfirmasi = input("Apakah Anda ingin melanjutkan pendaftaran ini (Y/N)? ").upper()

    if konfirmasi == "Y":
        reconnect() 
        cursor = dbku.cursor()
        cursor.execute(query, (id_daftar, id_pasien, id_dokter, tanggal, antrian))
        dbku.commit()
        print("Berhasil melakukan pendaftaran.")
    else:
        print("Pendaftaran dibatalkan.")

def input_pasien():
    id_pasien = input("Input ID Pasien: ")
    reconnect() 

    conn = dbku

    if conn:
        cursor = conn.cursor(dictionary=True)
        cursor.execute("SELECT * FROM pasien WHERE id_pasien = '"+id_pasien+"'")
        existing_patient = cursor.fetchone()

        if existing_patient:
            print("ID Pasien sudah digunakan. Silakan masukkan ID yang lain.")
        else:
            # Input data pasien
            nama = input("Nama Pasien: ")
            tanggal_lahir = input("Tanggal Lahir (YYYY-MM-DD): ")
            jenis_kelamin = input("Jenis Kelamin (Laki-laki/Perempuan): ")
            alamat = input("Alamat: ")
            nomor_telepon = input("Nomor Telepon: ")

            cursor.execute(""" 
                INSERT INTO pasien (id_pasien, nama, tanggal_lahir, jenis_kelamin, alamat, nomor_telepon)
                VALUES (%s, %s, %s, %s, %s, %s)
            """, (id_pasien, nama, tanggal_lahir, jenis_kelamin, alamat, nomor_telepon))
            conn.commit()
            print(f"Pasien {nama} berhasil diinputkan!")

def input_transaksi():
    kode = input("Input ID Transaksi: ")
    id_pasien = input("Input ID Pasien: ")
    id_dokter = input("Input ID Dokter: ")
    tanggal = input("Tanggal Transaksi (YYYY-MM-DD): ")
    biaya_dokter = int(input("Masukkan Biaya Konsultasi: "))
    biaya_obat = int(input("Masukkan Biaya Obat: "))

    # hitung total biaya
    total_biaya = biaya_dokter + biaya_obat

    # input memasukkan transaksi
    query = '''
    INSERT INTO transaksi (id_transaksi, id_pasien, id_dokter, tanggal_transaksi, biaya_dokter, biaya_obat, total_biaya)
    VALUES (%s, %s, %s, %s, %s, %s, %s)
    '''
    print(f"Total Biaya: {total_biaya}")
    reconnect()
    cursor = dbku.cursor()
    cursor.execute(query, (kode, id_pasien, id_dokter, tanggal, biaya_dokter, biaya_obat, total_biaya))
    dbku.commit()
    print("Pembayaran Berhasil")

def users():
    print("=== Pilihan Menu User ===")
    print("1. View Data User")
    print("2. Input New User")
    print("3. Edit User")
    print("4. Delete User")

    pilih = input("Masukkan pilihan Anda: ")

    if pilih == "1":
        query = 'SELECT * FROM pengguna'
        reconnect()
        cursor = dbku.cursor(dictionary=True)
        cursor.execute(query)
        users = cursor.fetchall()
        for user in users:
            print(user)
    elif pilih == "2":
        id_user = input("Masukkan id_user: ")
        nama = input("Masukkan nama user: ")
        email = input("Masukkan email anda: ")
        password = input("Masukkan password: ")
        role = input("Input role anda (Dokter/Admin): ")
        query = 'INSERT INTO pengguna (id_user, nama, email, password, role) VALUES (%s, %s, %s, %s, %s)'
        reconnect()
        cursor = dbku.cursor()
        cursor.execute(query, (id_user, nama, email, password, role))
        dbku.commit()
        print("User berhasil ditambahkan.")
    elif pilih == "3":
        id_user = input("Masukkan id_user yang ingin diedit: ")
        nama = input("Masukkan nama user: ")
        email = input("Masukkan email anda: ")
        password = input("Masukkan password: ")
        role = input("Input role anda (Dokter/Admin): ")
        query = 'UPDATE pengguna SET nama = %s, email = %s, password = %s, role = %s WHERE id_user = %s'
        reconnect()
        cursor = dbku.cursor()
        cursor.execute(query, (nama, email, password, role, id_user))
        dbku.commit()
        print("User berhasil diperbarui.")
    elif pilih == "4":
        id_user = input("Masukkan id_user yang ingin dihapus: ")
        query = 'DELETE FROM pengguna WHERE id_user = %s'
        reconnect()
        cursor = dbku.cursor()
        cursor.execute(query, (id_user,))
        dbku.commit()
        print("User berhasil dihapus.")
    else:
        print("Silahkan pilih menu yang terdaftar")

def riwayat_pasien():
    print("=== Pilihan Menu Riwayat Pasien ===")
    print("1. View Data riwayat pasien")
    print("2. Input riwayat pasien")
    print("3. Edit riwayat pasien")
    print("4. Delete riwayat pasien")

    pilih = input("Masukkan pilihan Anda: ")

    if pilih == "1":
        query = 'SELECT * FROM riwayat_pasien'
        reconnect()
        cursor = dbku.cursor(dictionary=True)
        cursor.execute(query)
        riwayat = cursor.fetchall()
        for riwayat_pasien in riwayat:
            print(riwayat_pasien)
    elif pilih == "2":
        id_riwayat = input("Input id riwayat: ")
        id_pasien = input("Input id pasien: ")
        id_dokter = input("Input id dokter: ")
        diagnosis = input("Masukkan diagnosis: ")
        pengobatan = input("Masukkan pengobatan: ")
        query = 'INSERT INTO riwayat_pasien (id_riwayat, id_pasien, id_dokter, diagnosis, pengobatan) VALUES (%s, %s, %s, %s, %s)'
        reconnect()
        cursor = dbku.cursor()
        cursor.execute(query, (id_riwayat, id_pasien, id_dokter, diagnosis, pengobatan))
        dbku.commit()
        print("Riwayat Pasien Berhasil ditambahkan.")
    elif pilih == "3":
        id_riwayat = input("Input id riwayat: ")
        id_pasien = input("Input id pasien: ")
        id_dokter = input("Input id dokter: ")
        diagnosis = input("Masukkan diagnosis: ")
        pengobatan = input("Masukkan pengobatan: ")
        query = 'UPDATE riwayat_pasien SET diagnosis = %s, pengobatan = %s WHERE id_riwayat = %s'
        reconnect()
        cursor = dbku.cursor()
        cursor.execute(query, (diagnosis, pengobatan, id_riwayat))
        dbku.commit()
        print("Riwayat Pasien Berhasil diperbarui.")
    elif pilih == "4":
        id_riwayat = input("Masukkan id riwayat yang ingin dihapus: ")
        query = 'DELETE FROM riwayat_pasien WHERE id_riwayat = %s'
        reconnect()
        cursor = dbku.cursor()
        cursor.execute(query, (id_riwayat,))
        dbku.commit()
        print("Riwayat Pasien berhasil dihapus.")
    else:
        print("Silahkan pilih menu yang terdaftar")

#menjalankan sistem
def main():
    user = login()
    if user:
        if user['role'] == "Admin":
            admin_menu()
        elif user['role'] == 'Dokter':
            menu_dokter()

if __name__ == "__main__":
    main()

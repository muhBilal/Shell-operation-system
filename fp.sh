#!/bin/bash

echo -e "Kelompok 9
Abdi Pranawa Satura Ardana (22081010185)
Muhammad Bilal (22081010029)\n"

read -p "Program apa yang ingin anda jalankan?
1.Mengubah hak akses
2.Manajemen file
3.Menghitung luas dan keliling belah ketupat
4.Shutdown PC
5.Membuka firefox
6.Kalkulator
7.Mengecek bilangan ganjil atau genap
8.Program konverter suhu" option1

case $option1 in
    1)
        read -p "Masukkan path file: " file_path
        
        if [ -e "$file_path" ]; then
            echo "File $file_path ditemukan"
            echo "Hak Akses: $(ls -l "$file_path" | cut -d ' ' -f 1)"
            read -p "Masukkan hak akses baru : " new_permissions
            chmod "$new_permissions" "$file_path"
            echo "Hak Akses setelah perubahan: $(ls -l "$file_path" | cut -d ' ' -f 1)"
        else
            echo "File $file_path tidak ditemukan"
    fi ;;
    2)
        
        create_file() {
            read -p "Masukkan path file yang akan dibuat: " filepath
            touch "$filepath"
            echo "File di $filepath berhasil dibuat."
        }
        
        copy_file() {
            read -p "Masukkan path file yang akan disalin: " source_filepath
            read -p "Masukkan path file tujuan: " destination_filepath
            cp "$source_filepath" "$destination_filepath"
            echo "File di $source_filepath berhasil disalin ke $destination_filepath."
        }
        
        move_file() {
            read -p "Masukkan path file yang akan dipindahkan: " source_filepath
            read -p "Masukkan direktori tujuan: " destination_directory
            mv "$source_filepath" "$destination_directory"
            echo "File di $source_filepath berhasil dipindahkan ke $destination_directory."
        }
        
        delete_file() {
            read -p "Masukkan path file yang akan dihapus: " filepath
            rm "$filepath"
            echo "File di $filepath berhasil dihapus."
        }
        
        while true; do
            echo "1. Buat File"
            echo "2. Salin File"
            echo "3. Pindah File"
            echo "4. Hapus File"
            echo "5. Keluar"
            
            read -p "Pilihan Anda: " choice
            
            case $choice in
                1) create_file ;;
                2) copy_file ;;
                3) move_file ;;
                4) delete_file ;;
                5) echo "Terima kasih!"; exit ;;
                *) echo "Pilihan tidak valid." ;;
            esac
    done ;;
    3)
        read -p "Menghitung apa?
    1.Luas Belah ketupat
        2.Keliling Belah ketupat" option2
        case $option2 in
            1)
                echo "Menghitung belah ketupat"
                read -p "Masukkan diagonal 1: " d1
                read -p "Masukkan diagonal 2: " d2
                
                luas=$(echo "0.5 * $d1 * $d2" | bc)
            echo "Luas belah ketupat: $luas" ;;
            
            2)
                echo "Menghitung Keliling belah ketupat"
                read -p "Masukkan panjang sisi A: " sisi_a
                read -p "Masukkan panjang sisi B: " sisi_b
                read -p "Masukkan panjang sisi C: " sisi_c
                read -p "Masukkan panjang sisi D: " sisi_d
                
                keliling=$(echo "$sisi_a + $sisi_b + $sisi_c + $sisi_d" | bc)
            echo "Keliling belah ketupat: $keliling" ;;
            *)
                echo "Opsi tidak valid"
    esac ;;
    4)
        
        read -p "Masukkan jumlah menit sebelum shutdown: " minutes
        
        shutdown -h +$minutes
        
    echo "Komputer akan dimatikan dalam $minutes menit." ;;
    5)
        
        echo "Membuka Mozilla Firefox..."
    firefox ;;
    6)
        
        read -p "Masukkan angka pertama: " num1
        read -p "Masukkan operator (+, -, *, /): " operator
        read -p "Masukkan angka kedua: " num2
        
        result=0
        case $operator in
            +) result=$(echo "$num1 + $num2" | bc) ;;
            -) result=$(echo "$num1 - $num2" | bc) ;;
            \*) result=$(echo "$num1 * $num2" | bc) ;;
            /) result=$(echo "scale=2; $num1 / $num2" | bc) ;;
            *) echo "Operator tidak valid"; exit ;;
        esac
        
    echo "Hasil: $result" ;;
    7)
        
        check() {
            if [ $1 -eq 0 ]; then
                echo "$1 adalah bilangan genap."
                elif [ $(( $1 % 2 )) -eq 0 ]; then
                echo "$1 adalah bilangan genap."
            else
                echo "$1 adalah bilangan ganjil."
            fi
        }
        
        read -p "Masukkan sebuah bilangan: " number
        
    check $number ;;
    8)
        
        convert_temperature() {
            from_unit=$1
            to_unit=$2
            temperature=$3
            
            case $from_unit in
                "Celsius")
                    case $to_unit in
                        "Fahrenheit")
                            result=$(echo "scale=2; $temperature * 9/5 + 32" | bc)
                        ;;
                        "Kelvin")
                            result=$(echo "scale=2; $temperature + 273.15" | bc)
                        ;;
                        *)
                            echo "Unit konversi tidak valid."
                            exit 1
                        ;;
                    esac
                ;;
                "Fahrenheit")
                    case $to_unit in
                        "Celsius")
                            result=$(echo "scale=2; ($temperature - 32) * 5/9" | bc)
                        ;;
                        "Kelvin")
                            result=$(echo "scale=2; ($temperature + 459.67) * 5/9" | bc)
                        ;;
                        *)
                            echo "Unit konversi tidak valid."
                            exit 1
                        ;;
                    esac
                ;;
                "Kelvin")
                    case $to_unit in
                        "Celsius")
                            result=$(echo "scale=2; $temperature - 273.15" | bc)
                        ;;
                        "Fahrenheit")
                            result=$(echo "scale=2; $temperature * 9/5 - 459.67" | bc)
                        ;;
                        *)
                            echo "Unit konversi tidak valid."
                            exit 1
                        ;;
                    esac
                ;;
                *)
                    echo "Unit konversi tidak valid."
                    exit 1
                ;;
            esac
            
            echo "$temperature $from_unit = $result $to_unit"
        }
        
        read -p "Masukkan suhu: " temperature
        read -p "Dari unit (Celsius/Fahrenheit/Kelvin): " from_unit
        read -p "Ke unit (Celsius/Fahrenheit/Kelvin): " to_unit
        
    convert_temperature "$from_unit" "$to_unit" "$temperature" ;;
    *)
        echo "Opsi tidak valid"
esac

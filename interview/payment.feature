Feature: Payment Feature

    Scenario: Verify user able to paid from ATM with Voucher code
      Given a web browser is at the payment details
      Then the following address details are shown
        | Alamat             | Jl. Jalan Gg.Buntu no.17   |
        | Kurir              | JNE : Rp.12.000            |

      And the following details price are shown
        | Harga Barang        | Jl. Jalan Gg.Buntu no.17   |
        | Jasa Pengantar      | Rp12.000                   |
        | Total Barang        | Rp.112.000                 |

      When the user clicks on the "Pilih Metode Pembayaran" button
      Then the page for payment method is displayed


      When the user click on the "ATM" at payment method
      Then the following details price re shown
        | Harga Barang    | Rp100.000         |
        | Pengiriman      | Rp12.000          |
      And the details of the voucher code is displayed

      When the user entered "MERDEKA" at the voucher field
      Then results for "Voucher Detail price" are shown
      And the following voucher results are shown
        | Voucher       | Rp17.000       |
        | Total Bayar   | Rp95.000       |

      When the user clicks on the "Pilih Metode Pembayaran" button
      Then the following summary payment details are shown
        | No.Transaksi         | 170845             |
        | Nama Barangnya       |                    |
        | Jasa Pengiriman      | JNE                |

      And the following status payment details are shown
        | No.Tagihan           | BL4NK                |
        | Status Tagihan       | Menunggu Pembayaran  |
        | Metode Pembayaran    | Alfamart             |

      And the following details price are shown
        | Harga Barang         | Rp.100.000           |
        | Jasa Pengiriman      | Rp.12.000            |
        | Potongan Harga       | Rp.17.000            |
        | Total Pembayara      | Rp.95.000            |
      And The status waiting for payment is displayed

      When User have done paid
      Then The status payment change to paid
      When The Item has arrived
      Then the status change to done

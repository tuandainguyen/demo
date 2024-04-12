--Buổi 2 --THỰC HÀNH CÁC CÚ PHÁP SQL
--Đổi tên dùng AS
--Đổi tên MAHANG và TENHANG trong bảng MATHANG
SELECT  MAHANG AS 'MÃ HÀNG',TENHANG AS 'TÊN HÀNG'
    FROM MATHANG
--Đổi tên MANHANVIEN, HOTEN,LUONGCOBAN trong bảng NHANVIEN
SELECT MANHANVIEN AS 'MÃ NHÂN VIÊN',HO + ' ' + TEN AS 'HỌ TÊN',LUONGCOBAN AS'LƯƠNG CƠ BẢN'
    FROM NHANVIEN
-- Phép toán +,-,*,/ Hiển thị MaHang,TenHang,SoLuong,GiaHang,ThanhTien trong do ThanhTien = SoLuong * GiaHang
SELECT MAHANG,TENHANG,SOLUONG,GIAHANG,SOLUONG * GIAHANG AS 'THÀNH TIỀN'
    FROM MATHANG
  -- Hiển thị MaNhanVien,HoTen ,LuongCoBan,PhuCap,Luong trong đó
  --Luong = LuongCoBan + PhuCap
SELECT MANHANVIEN,HO + ' ' + TEN AS 'HỌ TÊN',LUONGCOBAN,
                                                         CASE 
														     WHEN PHUCAP IS NULL THEN 0
															 ELSE PHUCAP
															 END AS 'PHỤ CẤP',
															 CASE
															    WHEN PHUCAP IS NULL THEN LUONGCOBAN + 0
																ELSE LUONGCOBAN + PHUCAP
																END AS 'LƯƠNG'
     FROM NHANVIEN
--C2
	 SELECT MANHANVIEN, HO + ' ' + TEN as 'HoTen',LUONGCOBAN,PHUCAP , isNULL(LUONGCOBAN + PHUCAP,  LUONGCOBAN)
    FROM NHANVIEN

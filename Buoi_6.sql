﻿--Buổi 6
--20.Tổng số tiền mà khách hàng phải trả cho mỗi đơn đặt hàng là bao nhiêu?
SELECT KH.MAKHACHHANG,KH.TENGIAODICH,DDH.SOHOADON,SUM(CTDH.SOLUONG * CTDH.GIABAN - CTDH.SOLUONG * CTDH.GIABAN * CTDH.MUCGIAMGIA/100) AS TONG
   FROM KHACHHANG AS KH
   INNER JOIN DONDATHANG AS DDH
   ON KH.MAKHACHHANG = DDH.MAKHACHHANG
   INNER JOIN CHITIETDATHANG AS CTDH
   ON DDH.SOHOADON = CTDH.SOHOADON
GROUP BY KH.MAKHACHHANG,KH.TENGIAODICH,DDH.SOHOADON
--21.Trong năm 2017,những mặt hàng nào chỉ đặt mua đúng một lần
SELECT MH.MAHANG,MH.TENHANG,DDH.NGAYDATHANG,COUNT(CTDH.MAHANG) AS SOLANMUA
    FROM MATHANG AS MH
	INNER JOIN CHITIETDATHANG AS CTDH
	ON MH.MAHANG = CTDH.MAHANG
	INNER JOIN DONDATHANG AS DDH
	ON CTDH.SOHOADON = DDH.SOHOADON
WHERE YEAR(DDH.NGAYDATHANG) = 2017
GROUP BY  MH.MAHANG,MH.TENHANG,DDH.NGAYDATHANG
HAVING COUNT(CTDH.MAHANG) = 1 
--22.Hãy cho biết tổng số tiền lời thu mà công ty thu được từ mỗi mặt hàng trong năm 2017
--Tiền lời: (GIABAN * SOLUONG - SOLUONG*GIABAN*MUCGIAMGIA/100) - GIAHANG*SOLUONG
SELECT MH.MACONGTY,MH.MAHANG,MH.TENHANG,SUM((GIABAN * CTDH.SOLUONG - CTDH.SOLUONG*GIABAN*MUCGIAMGIA/100) - MH.GIAHANG*MH.SOLUONG) AS TIEN_LOI
   FROM MATHANG as MH
   INNER JOIN CHITIETDATHANG AS CTDH
   ON MH.MAHANG = CTDH.MAHANG
   INNER JOIN DONDATHANG AS DDH
   ON CTDH.SOHOADON = DDH.SOHOADON
WHERE YEAR(NGAYDATHANG) = 2017
GROUP BY  MH.MACONGTY,MH.MAHANG,MH.TENHANG




--Mỗi nhân viên của công ty đã lập bao nhiêu đơn đặt hàng
--(nếu nhân nhân viên chưa hề lập đơn đặt hàng cho là 0)
SELECT NV.MANHANVIEN,HO + ' ' + TEN AS HOTEN,COUNT(DDH.SOHOADON) AS LAPBAONHIEUDON
   FROM NHANVIEN AS NV
   LEFT JOIN DONDATHANG AS DDH
   ON NV.MANHANVIEN = DDH.MANHANVIEN
GROUP BY NV.MANHANVIEN,HO,TEN

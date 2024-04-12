--Sử dụng câu lệnh SELECT để viết các yêu cầu truy vấn dữ liệu sau đây:
--5. 1 Cho biết danh sách các đối tác cung cấp hàng cho công ty.
select *
from NHACUNGCAP
--5. 2 Mã hàng, tên hàng và số lượng của các mặt hàng hiện có trong công ty.
select MAHANG,TENHANG, SOLUONG 
from MATHANG
--5. 3 Họ tên và địa chỉ và năm bắt đầu làm việc của các nhân viên trong công ty.
select HO + ' ' + TEN as HOTEN, DIACHI, YEAR(NGAYLAMVIEC) as NAMVAOLAM
from NHANVIEN
--5. 4 Địa chỉ và điện thoại của nhà cung cấp có tên giao dịch A là gì?
select DIACHI, DIENTHOAI, TENGIAODICH
from NHACUNGCAP
where TENGIAODICH = 'A'
--5. 5 Cho biết mã và tên của các mặt hàng có giá lớn hơn 1000 và số lượng
--hiện có ít hơn 50.
select MAHANG, TENHANG, GIAHANG, SOLUONG
from MATHANG
where GIAHANG > 1000 and SOLUONG < 50
--5. 6 Cho biết mỗi mặt hàng trong công ty do ai cung cấp.
select MAHANG, TENHANG, ncc.MACONGTY, TENCONGTY
from MATHANG mh inner join NHACUNGCAP ncc
on mh.MACONGTY = ncc.MACONGTY
--5. 7 Công ty B đã cung cấp những mặt hàng nào?
select ncc.MACONGTY, TENCONGTY, MAHANG, TENHANG 
from MATHANG mh inner join NHACUNGCAP ncc
on mh.MACONGTY = ncc.MACONGTY
where TENCONGTY = N'Công ty B'
--5. 8 Loại hàng thực phẩm do những công ty nào cung cấp và địa chỉ của các công ty
--đó là gì?
select LOAIHANG.MALOAIHANG, TENLOAIHANG, NHACUNGCAP.MACONGTY, TENCONGTY,DIACHI
from LOAIHANG join MATHANG on LOAIHANG.MALOAIHANG = MATHANG.MALOAIHANG
join NHACUNGCAP on MATHANG.MACONGTY = NHACUNGCAP.MACONGTY
where TENLOAIHANG = N'Thực phẩm'
--5. 9 Những khách hàng nào (tên giao dịch) đã đặt mua mặt hàng Sữa hộp XYZ của
--công ty?
select kh.MAKHACHHANG, TENCONGTY, mh.MAHANG, TENHANG
from KHACHHANG kh JOIN DONDATHANG ddh on kh.MAKHACHHANG = ddh.MAKHACHHANG
Join CHITIETDATHANG ctdh on ddh.SOHOADON = ctdh.SOHOADON
JOIN MATHANG mh on ctdh.MAHANG = mh.MAHANG
where TENHANG = N'sữa hộp'
--5. 10 Đơn đặt hàng số 1 do ai đặt và do nhân viên nào lập, thời gian và địa điểm giao
--hàng là ở đâu?
select SOHOADON, kh.MAKHACHHANG, TENGIAODICH, nv.MANHANVIEN, 
HO + ' ' + TEN as HOTEN, NGAYGIAOHANG, NOIGIAOHANG
from KHACHHANG kh JOIN DONDATHANG ddh on 
kh.MAKHACHHANG = ddh.MAKHACHHANG JOIN NHANVIEN nv
on ddh.MANHANVIEN = nv.MANHANVIEN
where ddh.SOHOADON = 1
--5. 11 Hãy cho biết số tiền lương mà công ty phải trả cho mỗi nhân viên là bao nhiêu
--(lương = lương cơ bản + phụ cấp).
select MANHANVIEN,HO + ' ' + TEN AS HOTEN,ISNULL(LUONGCOBAN + 0, LUONGCOBAN + PHUCAP) AS LUONCOBAN
from NHANVIEN
--5. 12 Trong đơn đặt hàng số 3 đặt mua những mặt hàng nào và số tiền mà khách hàng
--phải trả cho mỗi mặt hàng là bao nh iêu (số tiền phải trả được tính theo công thức
--SOLUONG×GIABAN - SOLUONG×GIABAN×MUCGIAMGIA/100)

--5. 13 Hãy cho biết có những khách hàng nào lại chính là đối tác cung cấp hàng của
--công ty (tức là có cùng tên giao dịch).

--5. 14 Trong công ty có những nhân viên nào có cùng ngày sinh?

--5. 15 Những đơn đặt hàng nào yêu cầu giao hàng ngay tại công ty đặt hàng và những
--đơn đó là của công ty nào?

--5. 16 Cho biết tên công ty, tên giao dịch, địa chỉ và điện thoại của các khách hàng và
--các nhà cung cấp hàng cho công ty.

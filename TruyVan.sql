-- Người thực hiện: NGUYỄN ĐÔNG HƯỚNG   Mã SV: 18110299
-- Em cam đoạn tất cả các câu dưới đây đều do em viết code và đều đã chạy ra kết quả
-- 
--                    
-- Bài 1 QLNV
use QuanLyNhanVien
GO
Select NgSinh, Dchi
From NhanVien
Where HoNV = 'Nguyen' and Tenlot = 'Bao' and TenNV = 'Hung';
-- Câu b. Tìm tên và địa chỉ của các nhân viên làm việc cho phòng “Nghiên cứu”
Select HoNV, Tenlot, TenNV, Dchi
From NhanVien, PhongBan
Where NhanVien.Phong = PhongBan.MaPB and TenPB = 'Nghien cuu';
-- câu c. Với mỗi dự án được triển khai ở Gò Vấp, cho biết mã dự án, mã phòng quản lý và họ tên, ngày sinh trưởng phòng của phòng đó 
select MaDA,MaPB,TrPhong,HoNV,Tenlot,tenNV, NgSinh from DUAN
inner join PhongBan 
on Phong = MaPB
inner join NhanVien
on TrPhong = Manv
where DUAN.DiaDiem = 'Go Vap'
-- câu d. Với mỗi nhân viên, cho biết họ tên nhân viên và họ tên của người quản lý nhân viên đó
select a.Manv,a.HoNV,a.Tenlot,a.tenNV,a.MaNQL,b.HoNV as HoNQL,b.Tenlot as TenlotNQL, b.tenNV as TenNQL
from NhanVien a,NhanVien b
where a.MaNQL = b.Manv
-- câu e.Cho biết mã nhân viên, họ và tên của các nhân viên của phòng “Nghiên cứu” có mức lương từ 30000 đến 50000
select MaNV,HoNV,Tenlot,TenNV
from PhongBan,NhanVien
where
MaPB = Phong and  TenPB = 'Nghien cuu' and Luong >= 30000 and Luong<= 50000
-- câu f.Cho biết mã nhân viên, họ tên nhân viên và mã dự án, tên dự án của các dự án màhọ tham gia 
select NhanVien.Manv,HoNV,tenNV,DUAN.MaDA,TenDA
from NhanVien
left join PhanCong
on NhanVien.Manv = PhanCong.MaNV
left join DUAN
on  PhanCong.MaDA = DUAN.MaDA
-- câu g. Cho biết mã nhân viên, họ tên của những người không có người quản lý
select Manv,HoNV,Tenlot,tenNV
from NhanVien
where MaNQL is NULL
-- câu h. Cho biết họ tên của các trưởng phòng có thân nhân
select distinct HoNV,Tenlot,tenNV
from PhongBan,ThanNhan,NhanVien
where PhongBan.TrPhong = ThanNhan.MaNV and PhongBan.TrPhong = NhanVien.Manv
-- câu i. Tính tổng lương nhân viên, lương cao nhất, lương thấp nhất và mức lương trung bình 
select SUM(Luong) as TongLuong,AVG(Luong) as LuongTB, MAX( Luong) as LuongCaoNhat,MIN(Luong) as LuongThapNhat
from NhanVien
-- câu j. Cho biết tổng số nhân viên và mức lương trung bình của phòng “Nghiên cứu”
select TenPB, COUNT(Manv)as SoNV, AVG(Luong) as LuongTB
from PhongBan,NhanVien
where PhongBan.TenPB = 'Nghien cuu'and NhanVien.Phong = PhongBan.MaPB
group by TenPB
-- câu k. Với mỗi phòng, cho biết mã phòng, số lượng nhân viên và mức lương trung bình 
select TenPB, COUNT(Manv)as SoNV, AVG(Luong) as LuongTB
from PhongBan,NhanVien
where NhanVien.Phong = PhongBan.MaPB
group by TenPB
-- câu l. Với mỗi dự án, cho biết mã dự án, tên dự án và tổng số nhân viên tham gia 
select DUAN.MaDA,TenDA,COUNT(PhanCong.MaNV)as SoNVthamgia
from DUAN,PhanCong,NhanVien
where DUAN.MaDA = PhanCong.MaDA and PhanCong.MaNV = NhanVien.Manv
group by DUAN.MaDA,TenDA
-- câu m. Với mỗi dự án có nhiều hơn 2 nhân viên tham gia, cho biết mã dự án, tên dự án và số lượng nhân viên tham gia
select DUAN.MaDA,TenDA,COUNT(PhanCong.MaNV)as SoNVthamgia
from DUAN,PhanCong,NhanVien
where DUAN.MaDA = PhanCong.MaDA and PhanCong.MaNV = NhanVien.Manv 
group by DUAN.MaDA,TenDA
Having COUNT(PhanCong.MaNV)>=2
-- câu n. Với mỗi dự án, cho biết mã số dự án, tên dự án và số lượng nhân viên phòng số 5 tham gia
select DUAN.MaDA,DUAN.TenDA,COUNT(PhanCong.MaNV) as SoNVPhong5 
from DUAN,PhanCong,NhanVien
where NhanVien.Phong = 5 and NhanVien.Manv = PhanCong.MaNV and DUAN.MaDA = PhanCong.MaDA
group by DUAN.MaDA,DUAN.TenDA
-- câu o. Với mỗi phòng có nhiều hơn 2 nhân viên, cho biết mã phòng và số lượng nhân viên có lương lớn hơn 25000
select a.Phong,COUNT(a.Manv) as SoNV,COUNT(b.Manv) SoNVLuongLonHon25k
from NhanVien a
left join NhanVien b
on a.Manv = b. Manv and b.Luong>= 25000
group by a.Phong
Having COUNT(a.Manv) >=2
-- câu p. Với mỗi phòng có mức lương trung bình lớn hơn 30000, cho biết mã phòng, tên phòng, số lượng nhân viên của phòng đó 
select MaPB,TenPB,COUNT(Manv) as SoNV, AVG(Luong) as LuongTB
from PhongBan,NhanVien
where PhongBan.MaPB = NhanVien.Phong
group by MaPB,TenPB
having AVG(Luong)>=30000
-- câu q. Với mỗi phòng có mức lương trung bình lớn hơn 30000, cho biết mã phòng, tên phòng, số lượng nhân viên nam của phòng đó 
select PhongBan.MaPB,PhongBan.TenPB,COUNT(b.Manv) as SoNVNam
from PhongBan,NhanVien a
left join NhanVien b
on a.Manv = b.Manv and b.Phai = 'Nam'
where PhongBan.MaPB = a.Phong
group by MaPB,TenPB
having AVG(a.Luong)>=30000
------------------
------------------
------------------
--note: vì em nhập dữ liệu theo cách của em nên em xin thay dữ liệu bằng dữ liệu của bản thân ạ
--BAI2:Quản lí thư viện
use QuanLyThuVien
go
-- câu a. Cho biết Địa chỉ và số điện thoại của Nhà xuất bản “Addison Wesley” ( thay bằng " Kim Đồng ")
select NXB.DiaChi,NXB.SoDT
from NXB
where NXB.TenNXB = 'Kim Dong'
-- câu b. Cho biết mã sách và Tựa sách của những cuốn sách được xuất bản bởi nhà xuất bản “Addison Wesley” ( thay bằng " Kim Đồng ")
select DauSach.MaSach, DauSach.Tua
from DauSach,NXB
where NXB.TenNXB = 'Kim Dong'
-- câu c. Cho biết mã sách và Tựa sách của những cuốn sách có tác giả là “Hemingway” ( thay bằng Ngô Xuân Tiến)
select DauSach.MaSach,DauSach.Tua
from DauSach,TacGia
where TacGia.TenTacGia = 'Ngo Xuan Tien'
-- câu d. Với mỗi đầu sách, cho biết tựa và số lượng cuốn sách mà thư viện đang sở hữu
select DauSach.Tua, COUNT(DauSach.MaSach) as SLSach
from DauSach
group by
DauSach.Tua
-- câu e. Với mỗi độc giả, hãy cho biết Tên, địa chỉ và số lượng cuốn sách mà người đó đã mượn 
select TenDG,DiaChi,COUNT(MaCuon) as SLSachMuon
from DocGia,Muon
where DocGia.MaDG = Muon.MaDG
group by
TenDG,DiaChi
-- câu f. Cho biết mã cuốn, tựa sách và vị trí của những cuốn sách được xuất bản bởi nhà xuất bản “Addison Wesley”( thay bằng Kim Đồng)
select MaCuon,Tua,ViTri
from NXB,CuonSach,DauSach
where NXB.MaNXB = DauSach.MaNXB and DauSach.MaSach = CuonSach.MaSach and TenNXB = 'Kim Dong'
-- câu g. Với mỗi đầu sách, hãy cho biết Tên nhà xuất bản và số lượng tác giả 
select TenNXB, COUNT( DauSach.MaSach) as sốluongTG
from DauSach,NXB,TacGia
where DauSach.MaNXB = NXB.MaNXB and TacGia.MaSach = DauSach.MaSach
group by TenNXB
-- câu h. Hãy cho biết Tên, địa chỉ, số điện thoại của những độc giả đã mượn từ 5 cuốn sách trở lên
select TenDG,SoDT,DiaChi,COUNT(MaCuon) as SL
from DocGia,Muon
where DocGia.MaDG = Muon.MaDG
group by
TenDG,SoDT,DiaChi
having COUNT(MaCuon)>=5
-- câu i. Cho biết mã NXB, tên NXB và số lượng đầu sách của NXB đó trong CSDL
select NXB.MaNXB,TenNXB,COUNT(MaSach) as SL
from NXB,DauSach
where NXB.MaNXB = DauSach.MaNXB 
group by NXB.MaNXB,TenNXB
-- câu j. Cho biết mã NXB, tên NXB và địa chỉ của những NXB có từ 100 đầu sách trở lên 
select NXB.MaNXB,TenNXB,DiaChi,COUNT(MaSach) as SL
from NXB,DauSach
where NXB.MaNXB = DauSach.MaNXB 
group by NXB.MaNXB,TenNXB,DiaChi
having COUNT(MaSach)>=100
-- câu k. Cho biết mã NXB, tên NXB, và số lượng tác giả đã hợp tác với NXB đó 
select NXB.MaNXB,TenNXB,COUNT(TacGia.TenTacGia) as SL
from NXB,DauSach,TacGia
where NXB.MaNXB = DauSach.MaNXB and DauSach.MaSach = TacGia.MaSach
group by NXB.MaNXB,TenNXB
-- câu l. Tựa và số lượng tác giả của những cuốn sách có tác giả là “Hemingway” mà độc giả “Nguyễn Văn A” đã từng mượn (thay tác giả = Ngo Xuan Tien,đọc giả = Nguyễn Thanh tuấn)
select Tua, COUNT( TacGia.TenTacGia) as SL
from DocGia,Muon,CuonSach,DauSach,TacGia
where DocGia.MaDG = Muon.MaDG and Muon.MaCuon = CuonSach.MaCuon and CuonSach.MaSach = DauSach.MaSach and DauSach.MaSach = TacGia.MaSach and TacGia.TenTacGia= 'Ngo Xuan Tien' and DocGia.TenDG = 'Nguyen Thanh Tuan'
Group by Tua
-------------
-------------
-------------
-------------
-------------
----BAI3-----
use BT3
go
-- câu a. Tìm tên những nhân viên ở cơ quan có mã số là 50
select TEN
from NV
where NV.MSCOQUAN = 50	
-- câu b. Tìm mã số tất cả các cơ quan từ quan hệ NV
select distinct MSCOQUAN from NV
-- câu c. Tìm tên các nhân viên ở cơ quan có mã số là 15,20,25
Select NV.TEN
from NV
where NV.MSCOQUAN = 15 and NV.MSCOQUAN = 20 and NV.MSCOQUAN = 25
-- câu d. Tìm tên những người làm việc ở Đồ Sơn
Select NV.TEN
from NV,COQUAN
where NV.MSCOQUAN = COQUAN.MSCOQUAN and COQUAN.DIACHI = 'Do Son'
------------
------------
------------
------------
------------
--BAIF4-----
use QuanLySuaXe
go
--Câu 1. Cho biết danh sách các người thợ hiện không tham gia vào một hợp đồng sửa chữa nào
select TenTho
from THO
left join CHITIET_HD
on THO.MaTho = CHITIET_HD.MaTho
where SoHD is null
--Câu 2. Cho biết danh sách những hợp đồng đã thanh lý nhưng chưa được thanh toán tiền đầy đủ.
select CHITIET_HD.SoHD,CHITIET_HD.TriGiaCV,SUM(SoTienThu) as SoTienDaThu
from PHIEUTHU,CHITIET_HD
where PHIEUTHU.SoHD = CHITIET_HD.SoHD 
group by
CHITIET_HD.SoHD,CHITIET_HD.TriGiaCV
having SUM(SoTienThu) < TriGiaCV
--Câu 3. Cho biết danh sách những hợp đồng cần phải hoàn tất trước ngày 31/12/2002
select *
from HOPDONG
where NgayGiaoDK < '2002/12/31'
--Câu 4. Cho biết người thợ nào thực hiện công việc nhiều nhất.
select *
from
(select MaTho,COUNT(MaCV) as SLCV
from CHITIET_HD 
group by MaTho) as tem1,
(select MAX(tem1.SLCV) as SLCV
from
(select MaTho,COUNT(MaCV) as SLCV
from CHITIET_HD 
group by MaTho) as tem1) as tem2
where tem1.SLCV = tem2.SLCV
--Câu 5. Cho biết người thợ nào có tổng trị giá công việc được giao cao nhất.
select te3.MaTho
from(select MAX(temp1.TC)as LN from 
(
select MaTho,SUM(KhoanTho) as TC from CHITIET_HD
group by MaTho ) as temp1) as te2,
(
select MaTho,SUM(KhoanTho) as TC from CHITIET_HD
group by MaTho ) as te3
where te2.LN = te3.TC

--------------------
--------------------
--------------------
--------------------
-------Câu 5--------
use QuanLyLopHoc
go
--a. Danh sách các giáo viên dạy các môn học có số tiết từ 45 trở lên
select GV.TENGV 
from GV,MHOC
where GV.MAMH = MHOC.MAMH and MHOC.SOTIET >=45
--b. Danh sách giáo viên được phân công gác thi trong học kỳ 1
select GV.TENGV
from PC_COI_THI,GV
where PC_COI_THI.MAGV = GV.MAGV and PC_COI_THI.HKY = 1
--c. Danh sách giáo viên không được phân công gác thi trong học kỳ 1
select GV.TENGV
from PC_COI_THI,GV
where PC_COI_THI.MAGV = GV.MAGV and PC_COI_THI.HKY != 1
--d. Cho biết lịch thi môn văn (TENMH = ‘VĂN HỌC’)
select HKY,NGAY,GIO,PHG,TGTHI 
from MHOC,BUOITHI
where MHOC.MAMH = BUOITHI.MAMH and TENMH ='VAN HOC'
--e. Cho biết các buổi gác thi của các giáo viên chủ nhiệm môn văn (TENMH = ‘VĂN HỌC’).
select BUOITHI.HKY,BUOITHI.NGAY,BUOITHI.GIO,BUOITHI.GIO,BUOITHI.PHG,BUOITHI.TGTHI 
from PC_COI_THI,GV,BUOITHI,MHOC
where PC_COI_THI.MAGV = GV.MAGV and GV.MAMH = BUOITHI.MAMH and MHOC.MAMH = BUOITHI.MAMH and MHOC.TENMH = 'VAN HOC'




















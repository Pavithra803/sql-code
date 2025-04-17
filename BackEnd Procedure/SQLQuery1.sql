create table Mst_Asset1(
Asset_id int primary key identity(1,1),
Asset_type varchar(50) null,
Asset_sl_no varchar(50) null,
Asset_ip varchar(20) null,
Asset_make varchar(50) null, 
Asset_model varchar(50) null,
Asset_specification varchar(50) null,
Asset_date_of_installation date null, 
Asset_po_no int null, 
Asset_po_date date null, 
Asset_invoice_no int null, 
Asset_invoice_date date null,
Asset_os varchar(50) null,
Asset_mso_version varchar(50) null,
Asset_warranty_start_date date null,
Asset_warranty_end_date date null,
Asset_Host_name varchar(50) null,
Emp_id int null,
Username varchar(50) null,
Userid int null,
Dept_name varchar(50) null,
Designation varchar(50) null,
Asset_status varchar(20) null,
Scarp_date date null,
Asset_remarks varchar(100) null,
Created_by int null,
Created_on date null,
Modified_by int null,
Modified_on date null,
Modification_status bit null,
Product_id int null,
Active_status bit null,
constraint fk_Mst_Asset1_Mst_User foreign key(Username)
references Mst_User(Username),

constraint fk_Mst_Asset1_Mst_Department foreign key(Dept_name)
references Mst_Department(DEpt_name)
);


EXEC sp_rename 'Trn_Call_Log.modified_on', 'Modified_on', 'COLUMN';

create table Trn_Ticket_Action_History(
Ticket_no int primary key identity(1,1),
Ticket_id int,
Modified_on datetime,
Action_description varchar(500),

constraint fk_Trn_Ticket_Action_History_Trn_Call_Log foreign key(Ticket_id)
references Trn_Call_Log(Ticket_id),
);

EXEC sp_helptext 'GetTickets';
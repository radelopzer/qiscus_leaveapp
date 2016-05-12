# qiscus_leaveapp



kalau mau ngejoin 2 table yang memiliki nama kolom yang sama.
maka cara join adalah dengan menginisialisasi semua kolom yang akan dipakai oleh view nya di controller
seperti contoh saya memiliki 2 tabel dengan nama user dan message yang masing2 memiliki nama colom "id"
jadi saya harus menjelaskan di controller agar pemanggilan id tidak bentrok karna join sperti contoh d bawah:


@messages = Message.select("messages.id, messages.approval_status, messages.leave_start_date, messages.leave_end_date, messages.amount_taken, users.id as u_id,
    				users.username").joins(:user)

custom routes untuk di gunakan di html.erb kita memparsing dengan cara 


	    <%= form_for namaclass, :url => {:action => "namaaction", :id => namamodel, :controller => "namacontroller"} do |f| %>
	    





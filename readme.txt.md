# product_seek
 follow the following steps



1.Pull the code form git hub
2. Make vs code ready for android/iOS support and xampp server ready and create a database (flutter and dark packages are required)
3.Download node.js from the below link   
Node. js is a platform built on Chrome's JavaScript runtime for easily building fast and scalable network applications.
https://nodejs.org/en/

4.Rename the database name product_seek from the database you just created 
5.Go to vs code and open the folder from file option located


6.Right Click on product_seek_backend and click open in integrated terminal

7.Install composer (composer install is the command)
8.Install npm
9.Php artisan key: generate
10.Php artisan passport:install
11.Php artisan migrate
12.Check you ip address and change accordingly in networks_endpoints.dart file since my ip is 192.168.1.103 (very important step)
Now open new terminal
12.Type the command to call the backend directory
Cd product_seek_backend

Now run the host
Command is
Php artisan serve – host=ip(since my ip is 192.168.1.103, yours will be different so check before)
Now you are ready to uses the app as a customer through emulator for that click on main.dart file and run the emulator


To run the server mode or to run the app from admin side
Go to your chrome browser or when your xamp server is opening and call the port by
Your ip that you used in php artisan serve:8000
In my case its like this
http://192.168.1.103:8000


credentials for admin logging in xampp server

userid- admin@admin.com
password-123456789



email used to forget password setup is bhishang@gmail.com




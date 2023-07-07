from prettytable import PrettyTable
import mysql.connector


# Functions
def checkPass(passwrd):

    condition=False

    numallocated=False
    alphallocated=False
    symballocated=False

    pass_popup=''
    
    for i in passwrd:
        if(numallocated==False and i.isnumeric()==True):
            numallocated=True
        if(alphallocated==False and i.isalpha()==True):
            alphallocated=True
        if(symballocated==False and i.isalnum()==False and i!=" "):
            symballocated=True

    if (len(passwrd)>=8):
        if (numallocated==False):
            pass_popup = pass_popup + '\n' + ("YOUR PASSWORD SHOULD INCLUDE A NUMBER")
        if (alphallocated==False):
            pass_popup = pass_popup + '\n' + ("YOUR PASSWORD SHOULD INCLUDE AN ALPHABET")
        if (symballocated==False):
            pass_popup = pass_popup + '\n' + ("YOUR PASSWORD SHOULD INCLUDE A SYMBOL")
        if (numallocated==True and alphallocated==True and symballocated==True):
            condition=True
    else:
        print("\nYOUR PASSWORD SHOULD HAVE ATLEAST 8 CHARACTERS\n-------------------------------------------------------------------------------")

    if (len(passwrd)>=8 and condition==False):
        print('\n'+pass_popup+'\n-------------------------------------------------------------------------------')

    return condition


#creating database
mydb=mysql.connector.connect(host="localhost",user="root",passwd="hello")
mycursor=mydb.cursor()
mycursor.execute("CREATE DATABASE IF NOT EXISTS Delhi_Store")
mycursor.execute("USE Delhi_Store")



mycursor.execute ("SELECT Admin_Code FROM Store")
admin_code=mycursor.fetchall()[0][0]



print(''' _____________________________________________________________________________
|                                                                             |
|                                                                             |
|                            THE DELHI'S CREAMERY                             |
|                                                                             |
|_____________________________________________________________________________|



Please Confirm you are not a ROBOT''')

condition=True

while not condition:
    import random
    n_=random.randint(10000000,99999999)
    print('''
                                 __________
                                |          |
                                |''',n_,'''|
                                |__________|
''')
    confirm=input('''                                  ''')

    if(confirm==str(n_)):
        
        print("VERIFIED SUCCESSFULLY")
        condition=True
    else:
        print('\n                              PLEASE TRY AGAIN')
    



#creating required tables
mycursor.execute('''CREATE TABLE IF NOT EXISTS Supplier (
                    Supplier_Name varchar(50) NOT NULL DEFAULT "The Delhi's Creamery HO",
                    Permission_Level int1 NOT NULL DEFAULT 0,
                    PRIMARY KEY (Supplier_Name)
                ) engine = InnoDB;''')
mycursor.execute('''CREATE TABLE IF NOT EXISTS Store (
                    Store_ID int NOT NULL AUTO_INCREMENT,
                    Store_Admin varchar(50) NOT NULL DEFAULT 'Admin Operator',
                    Store_Location varchar(50) NOT NULL DEFAULT 'Delhi',
                    State_Catered varchar(50) NOT NULL DEFAULT 'Haryana',
                    Permission_Level int1 NOT NULL DEFAULT 1,
                    Supplier_Name varchar(50) NOT NULL,
                    Admin_Code varchar(50) NOT NULL,
                    PRIMARY KEY (Store_ID),
                    FOREIGN KEY (Supplier_Name) references Supplier(Supplier_Name) on DELETE CASCADE on UPDATE CASCADE
                ) engine = InnoDB;''')
mycursor.execute('''CREATE TABLE IF NOT EXISTS Product_Category (
                    Category_ID int NOT NULL AUTO_INCREMENT,
                    Category_Name varchar(50) NOT NULL,
                    PRIMARY KEY (Category_ID)
                ) engine = InnoDB;''')
mycursor.execute('''CREATE TABLE IF NOT EXISTS Product(
                    Product_ID int NOT NULL,
                    Product_Name varchar(50) NOT NULL,
                    Price int NOT NULL DEFAULT 0,
                    Stock int NOT NULL DEFAULT 0,
                    Category_ID int NOT NULL,
                    Product_Details varchar(100) NOT NULL DEFAULT '-',
                    PRIMARY KEY (Product_ID),
                    FOREIGN KEY (Category_ID) references Product_Category(Category_ID) on DELETE CASCADE on UPDATE CASCADE
                ) engine = InnoDB;''')
mycursor.execute('''CREATE TABLE IF NOT EXISTS Customer (
                    Customer_ID int NOT NULL AUTO_INCREMENT,
                    Customer_Name varchar(50) NOT NULL,
                    Contact_Number varchar(50) NOT NULL,
                    Street varchar(30) NOT NULL DEFAULT '-',
                    City varchar(20) NOT NULL DEFAULT '-',
                    State varchar(20) NOT NULL DEFAULT '-',
                    Pincode int NOT NULL,
                    Permission_Level int1 NOT NULL DEFAULT 2,
                    User_Password varchar(10) NOT NULL DEFAULT '0000',
                    PRIMARY KEY (Customer_ID)
                ) engine = InnoDB;''')
mycursor.execute('''CREATE TABLE IF NOT EXISTS Cart (
                    Customer_ID int NOT NULL,
                    Product_ID int NOT NULL,
                    Quantity int NOT NULL DEFAULT 0,
                    Delivery_Charges int NOT NULL DEFAULT 0,
                    Total_Price int NOT NULL DEFAULT 0,
                    FOREIGN KEY (Product_ID) references Product(Product_ID) on DELETE CASCADE on UPDATE CASCADE,
                    FOREIGN KEY (Customer_ID) references Customer(Customer_ID) on DELETE CASCADE on UPDATE CASCADE
                ) engine = InnoDB;''')
mycursor.execute('''CREATE TABLE IF NOT EXISTS `Payment`(
                    Payment_ID int NOT NULL AUTO_INCREMENT,
                    Customer_ID int NOT NULL,
                    Payment_Mode varchar(50) NOT NULL,
                    Total_Amount int NOT NULL DEFAULT 0,
                    PRIMARY KEY (Payment_ID),
                    FOREIGN KEY (Customer_ID) references Customer(Customer_ID) on DELETE CASCADE on UPDATE CASCADE
                ) engine = InnoDB;''')
mycursor.execute('''CREATE TABLE IF NOT EXISTS Delivery(
                    Delivery_ID int NOT NULL AUTO_INCREMENT,
                    Customer_ID int NOT NULL,
                    Person_Name varchar(20) NOT NULL,
                    Contact_Number varchar(50) NOT NULL,
                    `Status` varchar(20) NOT NULL,
                    PRIMARY KEY (Delivery_ID),
                    FOREIGN KEY (Customer_ID) references Customer(Customer_ID) on DELETE CASCADE on UPDATE CASCADE
                ) engine = InnoDB;''')
mycursor.execute('''CREATE TABLE IF NOT EXISTS Delivery_Log(
                    Delivery_ID int NOT NULL AUTO_INCREMENT,
                    Customer_ID int NOT NULL,
                    Person_Name varchar(20) NOT NULL,
                    Contact_Number varchar(50) NOT NULL,
                    `Status` varchar(20) NOT NULL,
                    PRIMARY KEY (Delivery_ID),
                    FOREIGN KEY (Customer_ID) references Customer(Customer_ID) on DELETE CASCADE on UPDATE CASCADE
                ) engine = InnoDB;''')
mycursor.execute('''CREATE TABLE IF NOT EXISTS `Order`(
                    Order_ID int NOT NULL AUTO_INCREMENT,
                    Customer_ID int NOT NULL,
                    Payment_ID int NOT NULL,
                    Delivery_ID int NOT NULL,
                    PRIMARY KEY (Order_ID),
                    FOREIGN KEY (Payment_ID) references Payment(Payment_ID) on DELETE CASCADE on UPDATE CASCADE,
                    FOREIGN KEY (Customer_ID) references Customer(Customer_ID) on DELETE CASCADE on UPDATE CASCADE,
                    FOREIGN KEY (Delivery_ID) references Delivery_Log(Delivery_ID) on DELETE CASCADE on UPDATE CASCADE
                ) engine = InnoDB;''')
mydb.commit()



# MAIN

print('''

===============================================================================


WELCOME TO DELHI'S CREAMERY''')


while True :
        
    d=input('''
press ENTER to continue
''')
            
    print('''

===============================================================================


REGISTER                ------->    Press (1)

LOGIN                   ------->    Press (2)

ENTER AS ADMIN          ------->    Press (3)

EXIT                    ------->    Press (4)
    ''')

    ch=input("ENTER ")


# REGISTER

    if(ch=='1'):

        print('''
-------------------------------------------------------------------------------

ALL INFORMATION PROMPTED ARE MANDATORY TO BE FILLED
press ENTER to continue

-------------------------------------------------------------------------------''')
        a=input("")

        mycursor.execute(f"SELECT Customer_ID FROM Customer")
        lst=mycursor.fetchall()

        id = lst[-1][0]+1
        print("Your USER NUMBER for your application is",id,"\nplease remember this User Number and press Enter to continue\n\n-------------------------------------------------------------------------------")
        a=input("")
        
        condition=False   
        while (condition==False):
            passwrd=str(input("Create a Password for your account (should be atleast 8 characters, include alphabet,number,symbol)\n"))
            condition = checkPass(passwrd)
                

        print("\nPLEASE REMEMBER YOUR USER NUMBER AND PASSWORD\npress ENTER to continue and fill all the details given below\n\n-------------------------------------------------------------------------------")
        a=input("")
        
        name=str(input("\nEnter Your Full Name "))
        while not name:
            name=str(input("\nEnter Your Full Name "))

        mobno=str(input("\nEnter Mobile No.(10 Digits) "))
        error = True
        while error:
            if(mobno.isnumeric()==True and len(mobno)==10):
                error=False
            if error:
                mobno=str(input("\nEnter VALID Mobile No.(10 Digits) "))
        
        street=str(input("\nEnter Your Street "))
        while not street:
            street=str(input("\nEnter Your Street "))

        city=str(input("\nEnter Your City Name "))
        while not city:
            city=str(input("\nEnter Your City Name "))
        
        state=str(input("\nEnter Your State Name "))
        while not state:
            state=str(input("\nEnter Your State Name "))
        
        pincode=str(input("\nEnter Your pincode "))
        while not pincode or not pincode.isnumeric():
            pincode=str(input("\nEnter Your pincode "))

        f = True       
        while f:
            secques_no=str(input('''
===============================================================================


Choose any of the following as a security question

Favourite Sport    ------->    Press (1)
Favourite Song     ------->    Press (2) 
Favourite Movie    ------->    Press (3)
Favourite Car      ------->    Press (4)

CHOOSE ANY OF THE ABOVE SECURITY QUESTION '''))
#------------------------------------------------------------------------------
            if(secques_no=='1'):
                secques=str(input("\n-------------------------------------------------------------------------------\n\nEnter your Favourite Sport\n"))
                secques_=("Enter your Favourite Sport")
                f=False
#------------------------------------------------------------------------------                            
            elif(secques_no=='2'):
                secques=str(input("\n-------------------------------------------------------------------------------\n\nEnter your Favourite Song\n"))
                secques_=("Enter your Favourite Song")
                f=False
#-------------------------------------------------------------------------------
            elif(secques_no=='3'):    
                secques=str(input("\n-------------------------------------------------------------------------------\n\nEnter your Favourite Movie\n"))
                secques_=("Enter your Favourite Movie")
                f=False
#-------------------------------------------------------------------------------
            elif(secques_no=='4'):                        
                secques=str(input("\n-------------------------------------------------------------------------------\n\nEnter your Favourite Car\n"))
                secques_=("Enter your Favourite Car")
                f=False
#------------------------------------------------------------------------------
# Transaction No. 1 -> When a customer is register, its cart is also created
        mycursor.execute("START TRANSACTION;") 
        mycursor.execute(f'INSERT INTO Customer VALUES ({id},"{name}","{mobno}","{street}","{city}","{state}","{pincode}",2,"{passwrd}")')
        mycursor.execute(f'INSERT INTO Cart VALUES ({id},-1,0,0,0,0)')
        mycursor.execute("COMMIT;")
        mydb.commit()
        print("\n===============================================================================\n\n\n                  ACCOUNT HAS BEEN REGISTERED SUCCUESSFULLY\n")


# LOGIN

    elif(ch=='2'):

        id=str(input('''
-------------------------------------------------------------------------------

Enter your ID
'''))
        
        if not id.isnumeric():
            print('''
-------------------------------------------------------------------------------

INVALID ID
''')
            continue

        id=int(id)

        
        mycursor.execute(f"SELECT * FROM Customer WHERE Customer_ID={id}")
        data=mycursor.fetchall()

        if not data:
            print('''
-------------------------------------------------------------------------------

INVALID ID
''')
            continue
            
        
        passwd=str(input('''

Enter Password
'''))
        
        mycursor.execute(f"SELECT User_Password FROM Customer WHERE Customer_ID={id}")
        correct_pass = mycursor.fetchall()[0][0]
        
        if passwd!=correct_pass:
            
            print('''
-------------------------------------------------------------------------------

INCORRECT PASSWORD
''')
            continue


        

        d=input('''

===============================================================================


YOU HAVE SUCCESSFULLY LOGGED IN
press ENTER to continue
''')
            

        while True:
            
            print('''

===============================================================================


VIEW PRODUCTS           ------->    Press (1)

VIEW CART               ------->    Press (2)

ORDER CART              ------->    Press (3)

VIEW ACCOUNT            ------->    Press (4)

UPDATE ACCOUNT DETAILS  ------->    Press (5)

UPDATE PASSWORD         ------->    Press (6)

BACK                    ------->    Press (7)

EXIT                    ------->    Press (8)
''')
            ch=input("ENTER ")


# DISPLAYING THE PRODUCTS

            if(ch=='1'):
                    
                mycursor.execute("SELECT * FROM Product_Category")
                inf=mycursor.fetchall()[1:]
                
                x = PrettyTable()

                x.field_names = ["ID", "Category Name"]
                x.add_rows(inf)

                print('\n\n',x)

                cat_id=str(input("\nEnter the Category you want to explore "))
                if not cat_id.isnumeric():
                    print('''
===============================================================================


Enter Valid Category ID''')
                          
                    continue

                cat_id = int(cat_id)

                mycursor.execute(f"SELECT * FROM Product WHERE Category_ID={cat_id}")
                inf=mycursor.fetchall()

                dat = [list(i[:4])+list(i[5]) for i in inf]
                ids = [str(i[0]) for i in inf]
                q = [int(i[3]) for i in inf]

                x = PrettyTable()

                x.field_names = ["ID", "Product Name", "Price", "Stock", "Details"]
                x.add_rows(dat)

                print('\n\n',x)

                order=str(input("\nAdd to Cart (id quantity)\npress ENTER to go back\n"))
                ordered=False

                while order!='':

                    lst=order.split(' ')
                    if len(lst)!=2:
                        print('''
===============================================================================


Invalid Order''')
                        break

                    pid,quantity=lst[0],lst[1]

                    if pid not in ids:
                        if ordered:
                            print('''
===============================================================================


Invalid Product ID
Rest items are added to cart''')
                        else:
                            print('''
===============================================================================


Invalid Product ID''')
                        break

                    if not quantity.isnumeric():
                        if ordered:
                            print('''
===============================================================================


Invalid Quantity
Rest items are added to cart''')
                        else:
                            print('''
===============================================================================


Invalid Quantity''')
                        break

                    pid=int(pid)
                    quantity=int(quantity)
                    if quantity>q[int(ids.index(str(pid)))]:
                        if ordered:
                            print(f'''
===============================================================================


{q[pid]} items of {inf[pid][1]} are out of stock
Rest items are added to cart''')
                        else:
                            print('''
===============================================================================


Out of stock''')
                        break


                    del_charge=0

                    mycursor.execute(f'INSERT INTO Cart VALUES ({id},{pid},{quantity},{del_charge},{quantity*inf[int(ids.index(str(pid)))][2]},{quantity*inf[int(ids.index(str(pid)))][2]+del_charge})')
                    mydb.commit()

                    order=str(input(""))
                    ordered=True


# DISPLAYING THE CART

            elif(ch=='2'):
                    
                mycursor.execute(f"SELECT Product_ID, Quantity, Delivery_Charges, Item_Total, Grand_Total FROM Cart WHERE Customer_ID={id} AND Product_ID!=-1")
                data=mycursor.fetchall()

                p_name=[]
                p_price=[]
                for i in data:
                    mycursor.execute(f"SELECT Product_Name, Price FROM Product WHERE Product_ID={i[0]} AND Product_ID!=-1")
                    inf=mycursor.fetchall()[0]
                    p_name.append(inf[0])
                    p_price.append(inf[1])

                lst=[]
                ids=[]
                for i in range(len(data)):
                    if data[i][0] in ids:
                        lst[ids.index(data[i][0])][2]+=data[i][1]
                    else:
                        l=[]
                        l.append(data[i][0])
                        l.append(p_name[i])
                        l+=list(data[i][1:-3])
                        l.append(data[i][-2])
                        lst.append(l)
                        ids.append(data[i][0])


                x = PrettyTable()

                x.field_names = ["ID", "Product Name", "Quantity", "Total"]
                x.add_rows(lst)

                print('\n\n',x)
                del_charges = 0
                total=0
                for i in range(len(data)):
                    del_charges=max(del_charges,data[i][2])
                    total+=data[i][3]
                total+=del_charges
                print("Delivery Charges: ",del_charges)
                print("Grand Total: ", total)

# ORDER YOUR CART

            elif(ch=='3'):

                mycursor.execute(f"SELECT Product_ID, Quantity, Delivery_Charges, Item_Total, Grand_Total FROM Cart WHERE Customer_ID={id} AND Product_ID!=-1")
                orders = mycursor.fetchall()
                del_charges=0
                total_item_price=0
                for order in orders:
                    del_charges=max(del_charges,order[2])
                    total_item_price+=order[3]
                total_amount=total_item_price+del_charges   

# Transaction 2 -> Freezing product stocks and adding the amount to be payed in payment tracker

                mycursor.execute("START TRANSACTION;") 
                mycursor.execute(f"SELECT Product_ID, Quantity, Delivery_Charges, Item_Total, Grand_Total FROM Cart WHERE Customer_ID={id} AND Product_ID!=-1")
                orders = mycursor.fetchall()
                for row in orders:
                    prod_id = int(row[0])
                    q_rm = int(row[1])
                    mycursor.execute(f"UPDATE product SET stock = stock-{q_rm} WHERE product_ID = {prod_id};")
                    mycursor.execute(f"DELETE FROM Cart WHERE Customer_ID={id} AND Product_ID={prod_id};")
    
                mycursor.execute(f"INSERT INTO Pay_Tracker VALUES ({id},{total_amount})")
                mycursor.execute("COMMIT;")
                mycursor.execute("ROLLBACK;")
                mydb.commit()
                d=input("\n\nPRESS ENTER TO CONTINUE TO PAYMENT PAGE\n\n")


# WRITE ALL CODE FOR PAYMENT -> IF FAIL THEN PAYTRACKER SE DELETE WITHOUT ORDER ID

                print('''\n---------------------------------------------------------
                           --------------------PAYMENT PAGE ------------------------
                           ---------------------------------------------------------\n ''' )

# Transactions 3 and 4
                mycursor.execute("START TRANSACTION;") 
                mycursor.execute(f"SELECT Customer_ID, Total FROM Pay_tracker WHERE Customer_ID={id} AND Total!=0")
                paydata = mycursor.fetchall()
                temp_list = paydata[0]            
                print(f"Final Amount to be payed: {int(temp_list[1])}")
                print("Press 0: To exit and go back to homepage")
                print("Press 1: To place order and complete payment")
                
                inp = input("Enter: ")
                if(inp==0):
                    mycursor.execute(f"DELETE FROM Pay_tracker WHERE Customer_ID={id};")
                    mycursor.execute("COMMIT;") #3
                    print("Order Cancelled")
                    mydb.commit()
                    break

                else:
                    paymode = input("Type in the payment mode: ")
                    mycursor.execute(f"INSERT INTO Payment (Customer_ID,Payment_Mode,Total_Amount) VALUES ({id},'{paymode}',{int(temp_list[1])});")
                    print("\nThe PAYMENT IS COMPLETED\n")
                    mycursor.execute("SELECT * FROM Payment ORDER BY Payment_ID DESC LIMIT 1;")
                    pay_id = mycursor.fetchall()[0][0]

                    mycursor.execute(f"INSERT INTO Delivery_Log (Customer_ID,Person_Name,Contact_Number,Status) VALUES ({id},'Hanahh Del','965445965','Delivery by 7AM');")
                    mycursor.execute("SELECT * FROM Delivery_Log ORDER BY Delivery_ID DESC LIMIT 1;")
                    del_id = mycursor.fetchall()[0][0]

                    mycursor.execute(f"INSERT INTO `ORDER` (Customer_ID, Payment_ID, Delivery_ID) VALUES ({id},{pay_id},{del_id});")
                    mycursor.execute("SELECT * FROM `ORDER` ORDER BY Order_ID DESC LIMIT 1;")
                    ord_id = mycursor.fetchall()[0][0]

                    print(f"The generated Delivery_ID is {del_id}")
                    print(f"The generated Order_ID is {ord_id} ")
                    print("Your ORDER is successfully Placed")
                    mycursor.execute("COMMIT;") #4
                    mycursor.execute("ROLLBACK;")
                    mydb.commit()
                    d=input("\n\nPRESS ENTER TO CONTINUE\n\n")

# DISPLAYING THE DETAILS OF YOUR APPLICATION

            elif(ch=='4'):
                    
                mycursor.execute(f"SELECT * FROM Customer WHERE Customer_ID={id}")
                inf=mycursor.fetchall()

                inf = [i[:-2] for i in inf]
                
                x = PrettyTable()

                x.field_names = ["Customer ID", "Customer Name", "Contact Number", "Street", "City", "State", "Pincode"]
                x.add_rows(inf)

                print('\n\n',x)               


# EDITING DETAILS OF YOUR ACCOUNT

            elif(ch=='5'):


                print('''
-------------------------------------------------------------------------------

Name             ------->   Press (1)

Contact Number   ------->   Press (2)

Street           ------->   Press (3)

City             ------->   Press (4)

State            ------->   Press (5)

Pincode          ------->   Press (6)

''')
                        
                ch_=str(input("-------------------------------------------------------------------------------\n\nEnter the detail you want to edit\n"))

                while ch_ not in ['1','2','3','4','5','6'] :
                    ch_=str(input("-------------------------------------------------------------------------------\n\nPlease enter the correct detail you want to edit\n"))

#===========================================================================================================================================================================================
                    
                
                if(ch_=='1'):
                    name=str(input("\n-------------------------------------------------------------------------------\nEnter Name\n"))
                    while not name:
                        name=str(input('''
===============================================================================


Enter Valid Name'''))
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------                    
                            
                    mycursor.execute(f'UPDATE Customer SET Customer_Name="{name}" where Customer_ID={id}')
                    mydb.commit()
                    print('''===============================================================================


ACCOUNT HAS BEEN EDITED SUCCESSFULLY''')


#===========================================================================================================================================================================================
                            
                            
                elif(ch_=='2'):
                    mobno=str(input("\n-------------------------------------------------------------------------------\nEnter Contact Number\n"))
                    while not mobno:
                        mobno=str(input('''
===============================================================================


Enter Valid Contact Number'''))
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------                    
                            
                    mycursor.execute(f'UPDATE Customer SET Contact_Number="{mobno}" where Customer_ID={id}')
                    mydb.commit()
                    print('''===============================================================================


ACCOUNT HAS BEEN EDITED SUCCESSFULLY''')



#===========================================================================================================================================================================================
                            
                            
                elif(ch_=='3'):
                    street=str(input("\n-------------------------------------------------------------------------------\nEnter Street\n"))
                    while not street:
                        street=str(input('''
===============================================================================


Enter Valid Street'''))
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                            
                    mycursor.execute(f'UPDATE Customer SET Street="{street}" where Customer_ID={id}')
                    mydb.commit()
                    print('''===============================================================================


ACCOUNT HAS BEEN EDITED SUCCESSFULLY''')


#===========================================================================================================================================================================================

                            
                elif(ch_=='4'):
                    city=str(input("\n-------------------------------------------------------------------------------\nEnter City\n"))
                    while not city:
                        city=str(input('''
===============================================================================


Enter Valid City'''))
        #-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                            
                    mycursor.execute(f'UPDATE Customer SET City="{city}" where Customer_ID={id}')
                    mydb.commit()
                    print('''===============================================================================


ACCOUNT HAS BEEN EDITED SUCCESSFULLY''')



        #===========================================================================================================================================================================================

                            
                elif(ch_=='5'):
                    state=str(input("\n-------------------------------------------------------------------------------\nEnter State\n"))
                    while not state:
                        state=str(input('''
===============================================================================


Enter Valid State'''))
        #-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                            
                    mycursor.execute(f'UPDATE Customer SET State="{state}" where Customer_ID={id}')
                    mydb.commit()
                    print('''===============================================================================


ACCOUNT HAS BEEN EDITED SUCCESSFULLY''')



#===========================================================================================================================================================================================

                            
                elif(ch_=='6'):
                    pincode=str(input("\n-------------------------------------------------------------------------------\nEnter Pincode\n"))
                    while not pincode or not pincode.isnumeric():
                        pincode=str(input('''
===============================================================================


Enter Valid Pincode'''))
        #-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                            
                    mycursor.execute(f'UPDATE Customer SET Pincode="{pincode}" where Customer_ID={id}')
                    mydb.commit()
                    print('''===============================================================================


ACCOUNT HAS BEEN EDITED SUCCESSFULLY''')


# UPDATING YOUR PASSWORD

            elif(ch=='6'):

                mycursor.execute(f"SELECT User_Password FROM Customer WHERE Customer_ID={id}")
                correct_pass = mycursor.fetchall()[0][0]

                oldpass=str(input('''
-------------------------------------------------------------------------------

Enter Old Password
'''))
                if oldpass!=correct_pass:
                    print('''
-------------------------------------------------------------------------------

Incorrect Password
''')
                    continue


                newpass=str(input('''
-------------------------------------------------------------------------------

Enter New Password
'''))

                condition=False   
                while (condition==False):
                    passwrd=str(input("Create a Password for your account (should be atleast 8 characters, include alphabet,number,symbol)\n"))
                    condition = checkPass(passwrd)


                mycursor.execute(f'UPDATE Customer SET User_Password="{passwrd}" WHERE Customer_ID={id}')
                mydb.commit()

                print('''
===============================================================================


PASSWORD HAS BEEN UPDATED SUCCESSFULLY''')
                              

# BACK

            elif (ch=='7'):
                break


#EXIT
                
            elif(ch=='8'):
                print('''
===============================================================================

                        ________________________
                        |                        | 
                        |       THANK YOU        |
                        |________________________|
''')
                raise SystemExit


#OTHER CASE

            else:
                print("\n===============================================================================\n\n\nPLEASE ENTER A VALID OPTION\ntry again, press ENTER")
    

# ADMIN

    elif(ch=='3'):

        ADMIN=False

        admin=str(input('''

===============================================================================


Continue if you are ADMIN
Else press Enter to continue
 _____________________________                 
|                             |
|*****ADMINISTRATIVE CODE*****|             ENTER ADMIN CODE
|_____________________________|             ^^^^^^^^^^^^^^^^
                                            '''))
                
        if (admin==str(admin_code)):
            ADMIN=True

            print('''
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx


*******************************
*ADMINISTRATIVE ACCESS GRANTED*
*******************************
''')

        else:
            print('''

===============================================================================


INCORRECT ADMIN CODE''')

        while ADMIN:
        
            print('''

VIEW ALL APPLICATIONS  ------->    Press (1)

ADD NEW PRODUCT        ------->    Press (2)

REMOVE PRODUCT         ------->    Press (3)

CHECK PRODUCT STOCK    ------->    Press (4)

ADD STOCK              ------->    Press (5)

BACK                   ------->    Press (6)

EXIT                   ------->    Press (7)
''')
    
            q=input("ENTER ")


            if (q=='1'):

                mycursor.execute ("SELECT * FROM Customer")
                p=mycursor.fetchall()

                p = [i[:-2] for i in p]

                x = PrettyTable()
                x.field_names = ["Customer ID", "Customer Name", "Contact Number", "Street", "City", "State", "Pincode"]
                x.add_rows(p)

                print('\n\n',x)
                
                d=input("\n\nPRESS ENTER TO CONTINUE\n\n")
#===========================================================================================

            if(q=='2'):
                product_name = input("Enter Product Name: ")
                price = int(input("Enter Price: "))
                stock = int(input("Enter Stock: "))
                category_id = int(input("Enter Category ID: "))
                str1 = "INSERT INTO Product (Product_Name,Price,Stock,Category_ID,Product_Details) VALUES"
                str2 = f"('{product_name}',{price},{stock},{category_id},'-');"
                mycursor.execute(str1+str2)
                mydb.commit()
                print("\n Product Added Successfully")
                d=input("\n\nPRESS ENTER TO CONTINUE\n\n")

#===========================================================================================

            if(q=='3'):
                product_id = int(input("Enter Product Name: "))
                mycursor.execute(f"DELETE FROM Product WHERE Product_ID='{product_id}';")
                mydb.commit()
                print("\n Product Deleted Successfully")
                d=input("\n\nPRESS ENTER TO CONTINUE\n\n")

#===========================================================================================

            if(q=='4'):
                print("This query prints the stock of all the products in least stock to max")
                mycursor.execute("select product_id, product_name, stock from product order by stock asc")
                columns = [i[0] for i in mycursor.description]
                table = PrettyTable(columns)
                for row in mycursor:
                    table.add_row(row)
                print(table)
                d=input("\n\nPRESS ENTER TO CONTINUE\n\n")

#===========================================================================================

            if(q=='5'):
                prod_id = int(input("Enter Product ID: "))
                q_add = int(input("Enter Quantity To Be Added: "))
                mycursor.execute(f"UPDATE product SET stock = stock+{q_add} WHERE product_ID = {prod_id};")
                mydb.commit()
                print("\n Product Stocks Updated Successfully")
                d=input("\n\nPRESS ENTER TO CONTINUE\n\n")

#===========================================================================================
        
            elif (q=='6'):
                
                ADMIN=False
                switch=True


#===========================================================================================

            elif (q=='7') :

                print('''
===============================================================================

                         ________________________
                        |                        | 
                        |       THANK YOU        |
                        |________________________|


''')
                raise SystemExit

#===========================================================================================

            else:
                print('''

===============================================================================


PLEASE ENTER A VALID OPTION''')


# EXIT

    elif(ch=='4'):

        print('''
===============================================================================

                         ________________________
                        |                        | 
                        |       THANK YOU        |
                        |________________________|


''')
        raise SystemExit


# OTHER CASE

    else:
        print('''
===============================================================================


PLEASE ENTER A VALID OPTION
try again, press ENTER''')
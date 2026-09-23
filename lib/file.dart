import 'dart:io';
enum RoomStatus {available, booked, cleaning, maintainance}
class RoomNotFoundException {
  String message;
  RoomNotFoundException(this.message);
}
class GuestNotFoundException {
  String message;
  GuestNotFoundException(this.message);
}
class InvalidInputException {
  String message;
  InvalidInputException(this.message);
}
abstract class Hotels{
  RoomStatus? roomstatus;
  int id = 0;
  String name = "";
  void display();
}
class Guest extends Hotels{
String phonenumber;
String email;
Guest(this.phonenumber, this.email, String newname, int newid, RoomStatus newstatus)
{
if ( newid <= 0 ){
  throw InvalidInputException("Guest-Id must be greater then 0 ");
}
name = newname;
id = newid;
roomstatus = newstatus;
}
@override
void display(){
  print("Guest ID : $id | Name : $name | Phone : $phonenumber | Email : $email");
}
}
class Room{
  int roomnumber;
  String roomtype;
  double pricepernight;
  RoomStatus status;

  Room(this.roomnumber, this.roomtype, this.pricepernight, this.status){
    if (pricepernight <= 0){
      throw InvalidInputException("Price Per Night Must be Greater Then 0 ");
    }
    if (roomnumber <= 0){
      throw InvalidInputException("RoomNumber Must Be Greater then 0 ");
    }
  }
  void display(){
    print("Room # $roomnumber | Type : $roomtype | Price : \$$pricepernight | Status : ${status.name}");
  }
}
class Booking{
  Guest? guest;
  Room room;
  int numberofdays;
  Booking(this.guest, this.room, this.numberofdays);
    double calculatetotal(){
      return room.pricepernight*numberofdays;
    }
    void display(){
       print("Booking -> Guest : ${guest?.name} (ID : ${guest?.id}) | Room : ${room.roomnumber} | Days : $numberofdays | Total : ${calculatetotal()}");
    }
}
class Hotel
{
  List<Guest> guests = [];
  List<Room> rooms = [];
  List<Booking> bookings = [];
  void addRoom(int roomnumber, String type, double price)
  {
    Room roo = Room(roomnumber,type,price,RoomStatus.available);
    rooms.add(roo);
    print("Room Successfully Added ");
  }
  void addGuest(String number, String email, String name, int id)
  {
    Guest gu =Guest(number, email, name, id, RoomStatus.available);
    guests.add(gu);
    print("Guest $name Successfully added ");
  }
  void createbooking(int guestid, int roomnumber, int days)
  {
    Guest? foundGuest;
    for(Guest g in guests)
    {
      if(g.id == guestid)
      {
        foundGuest = g;
        break;
      }
      if (foundGuest == null)
      {
        throw GuestNotFoundException("no guest found with id $guestid");
      }
    }
    Room? foundroom;
    for(Room r in rooms)
    {
      if(r.roomnumber == roomnumber)
      {
        foundroom = r;
        break;
      }
    }
    if (foundroom == null)
    {
     throw RoomNotFoundException("No room number with $roomnumber ");
    }
    Booking booking = Booking(foundGuest, foundroom, days);
    bookings.add(booking);
    foundroom.status = RoomStatus.booked;
    print("Booking created Successfully ");
  }
  void displayavailablerooms()
  {
   bool count = false;
   for(Room r in rooms)
   {
    if(r.status == RoomStatus.available)
    {
      r.display();
      count = true;
    }
   }
   if(!count) print("No available rooms. ");
  }
  void displayAllBookings()
  {
    print("======= ALL ACTIVE BOOKINGS ===========");
    if(bookings.isEmpty)
    {
      print("no bookings found.");
      return;
    }
    for(Booking b in bookings)
    {
      b.display();
    }
  }
  void serchRoom(int roomnum)
  {
    for(Room r in rooms)
    {
      if(r.roomnumber == roomnum)
      {
        print("Room details");
        r.display();
        return;
      }
    }
    throw RoomNotFoundException("Room number not found ");
  }
  void serchGuest(int guestid)
  {
   for (Guest g in guests)
   {
     if(g.id == guestid)
     {
      print("Guest details");
      g.display();
      return;
     }
   }
   throw GuestNotFoundException("Guest not found");
  }
}

void main() {
  Hotel hotel = Hotel();
  bool isRunning = true;

  print("==========================================");
  print("   WELCOME TO HOTEL MANAGEMENT SYSTEM     ");
  print("==========================================");

  while (isRunning) {
    print("\n--- MAIN MENU ---");
    print("1. Add Room");
    print("2. Add Guest");
    print("3. Create Booking");
    print("4. View Available Rooms");
    print("5. View All Bookings");
    print("6. Search Room by Number");
    print("7. Search Guest by ID");
    print("8. Exit");
    stdout.write("Enter your choice (1-8): ");

    String? choice = stdin.readLineSync();

    print(""); // Blank line for spacing

    try {
      switch (choice) {
        case '1':
          stdout.write("Enter Room Number: ");
          int roomNum = int.parse(stdin.readLineSync()!);
          
          stdout.write("Enter Room Type (Deluxe/Single/Suite): ");
          String type = stdin.readLineSync()!;
          
          stdout.write("Enter Price per Night: ");
          double price = double.parse(stdin.readLineSync()!);

          hotel.addRoom(roomNum, type, price);
          break;

        case '2':
          stdout.write("Enter Guest ID: ");
          int id = int.parse(stdin.readLineSync()!);
          
          stdout.write("Enter Guest Name: ");
          String name = stdin.readLineSync()!;
          
          stdout.write("Enter Phone Number: ");
          String phone = stdin.readLineSync()!;
          
          stdout.write("Enter Email: ");
          String email = stdin.readLineSync()!;

          hotel.addGuest(phone, email, name, id);
          break;

        case '3':
          stdout.write("Enter Guest ID: ");
          int guestId = int.parse(stdin.readLineSync()!);

          stdout.write("Enter Room Number: ");
          int roomNum = int.parse(stdin.readLineSync()!);

          stdout.write("Enter Number of Days: ");
          int days = int.parse(stdin.readLineSync()!);

          hotel.createbooking(guestId, roomNum, days);
          break;

        case '4':
          hotel.displayavailablerooms();
          break;

        case '5':
          hotel.displayAllBookings();
          break;

        case '6':
          stdout.write("Enter Room Number to Search: ");
          int roomNum = int.parse(stdin.readLineSync()!);
          hotel.serchRoom(roomNum);
          break;

        case '7':
          stdout.write("Enter Guest ID to Search: ");
          int guestId = int.parse(stdin.readLineSync()!);
          hotel.serchGuest(guestId);
          break;

        case '8':
          print("Thank you for using the Hotel System. Goodbye!");
          isRunning = false;
          break;

        default:
          print("⚠️ Invalid menu choice! Please select 1-8.");
      }
    } on FormatException {
      print("❌ Input Error: Please enter valid numbers for IDs, prices, and days.");
    } on RoomNotFoundException catch (e) {
      print("❌ Error: ${e.message}");
    } on GuestNotFoundException catch (e) {
      print("❌ Error: ${e.message}");
    } on InvalidInputException catch (e) {
      print("❌ Validation Error: ${e.message}");
    } catch (e) {
      print("❌ An unexpected error occurred: $e");
    }
  }
}
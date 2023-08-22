class BookLoanResponse {
  BookLoan bookLoan;

  BookLoanResponse(this.bookLoan);
}

class BookLoan {
  String bookName;
  String date;
  String status;

  BookLoan(this.bookName, this.date, this.status); 
}

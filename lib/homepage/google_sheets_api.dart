import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  // create credentials
  static const _credentials = r'''

{
  "type": "service_account",
  "project_id": "miniprojectflutter-366606",
  "private_key_id": "72e74a61c72410f84d36c8aa59eb163f05080b3b",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDTdWGH5C7zFuRr\noC/GP9gMe+NRreRdI4EfYZtIIQ4mXB+kBCbtMVJtVFj+tPX5Aky+CWk6BNiX0taA\nC7BEWQScs3eYQ2BavaHLeXrdjQM0o1Of011VDY9Yg3wydF8lHOMjnD6m6cDLpxHP\nnD2lElr1LIkGoIYeb+aaWlVc8Snmf+IhyNCG2oA9SDnwpgxGCRADOSOEAdn2wBoI\ni6wp+9vWj0mR/rc+62wfS3tsc9swktuaAnzp3RFzepiMCGKGGSmQK9FLoIYBcTXV\nDK2vBP4fn454GpLj13cXdjdCBh3LaXTV6Twn4iKAdWfEJkG8QdiC0bz+CumwmEYH\nT9V+aKiRAgMBAAECggEAM39UM8yJ9JCgK2fVCrJ0ssGfID65rUcexJ44O241bHkm\nCYMrWbuXx+FxVQKMHssFFojjNAqHFx51N7ThBhwpx+HbH91Uw3SISS36EqerXq/i\nBzvp8HM/dD59SipWG4s38+2ywmKOHeq/pzB1QNTCCxCABHmmgBYfcnrKbDqdSjFs\nKuTQqV8sjdHu9KeXmNZhd3sCNIeP3glHoWBVfiGQRqvfTzwjPfVgMEsf5jyd8kg4\nSf1Owc3H7NXO9chwYIA8HeijfOex2SMIJlDeXNDoyYz0gVYbynHBhBTvUcT8NmgU\nKvtLyT6IHJ2ZP7ckyUKjbTnQFsBAiDeOmiRXXse+uwKBgQD55sbL6hLaDutFsJoH\nNqi70LIStQyLl42IiXpT2WH2ZGAqnOD7IMR8y++70mB0qLkRBanP2bvaRL/YwvOl\nROakPT904M857CJit1x74RYC1Cte4qPH7++rOA2eLwuUKTyNmaDomqA2m+3w5Mb+\n1rj4zrq/7oY4tRfH2jVytrefWwKBgQDYnnAIYPRu0g4v7p8ExcFAVaWNz/sAeVb3\nsK3F9D6HN7eka9eT+BikJ0CjcESv8ABPLOvoVebBbQwve9gNB1EQ+ngE+gg+qzdG\nIV56W0lANaLYG3Lw9S4K3OAHxrKNXUv0aTne0q4H2OvPbBCu7ML/k4qnLPINg+7t\nrBj1SKXngwKBgQDkAKyMS8pbbZU3BkPiJPqaMXTnIIyLqACX/GbBrep1NWuQNYYH\nWgQroJ3gDbe3eGExqKsgWpXMNUGccXJ+7XhJjSAicSJgxJMy4fzdgaXletL/RWUM\n/Fr9Kq0yD9ZOnbkDsJFg6AMZD/dt/C2bQSmOyH8Wsnd/sao6y1pMiWzLVQKBgQDM\nDILwAZR/B7OBhz+X2Uhu976ZVT7VdXdsnqsyex6jdOKyKTvLELr1dlw3GLw7FtLT\nwjb+hlx1++ismfYsX6YHXkjMN1Ko5dONZkV+8JqRt3SMKV8eh3Y1mVYXPR5Yd3fi\n5XQz5zU0AywuGVelzzToVu0XCQmBnbPlgmWIOES/TQKBgDlBaJJAUFbv33jp6egR\nzKc8iAreMOT6efisEBajwe5ZFoEEGJ0XSEvfRroO+8NgH01HSLTfE6wk6LiXQp4S\ndgrvmyD/iddqxZIHnPJlNzVuaQZO46dhpT27x/on5+qEf0FYlFRRnzhAa9UizYHt\nQdhPQpp4jp67EmRC9Izil6iL\n-----END PRIVATE KEY-----\n",
  "client_email": "miniproject@miniprojectflutter-366606.iam.gserviceaccount.com",
  "client_id": "112532081236029389053",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/miniproject%40miniprojectflutter-366606.iam.gserviceaccount.com"
}

''';


  // set up & connect to the spreadsheet
  static final _spreadsheetId = '1hMYhWMryRXtfcA5StR0Pbx5mRFNutJDQl7dNHdtC7Ro';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _worksheet;

  // some variables to keep track of..
  static int numberOfTransactions = 0;
  static List<List<dynamic>> currentTransactions = [];
  static bool loading = true;

  // initialise the spreadsheet!
  Future init() async {
    final ss = await _gsheets.spreadsheet(_spreadsheetId);
    _worksheet = ss.worksheetByTitle('page1');
    countRows();
  }

  // count the number of notes
  static Future countRows() async {
    while ((await _worksheet!.values
            .value(column: 1, row: numberOfTransactions + 1)) !=
        '') {
      numberOfTransactions++;
    }
    // now we know how many notes to load, now let's load them!
    loadTransactions();
  }

  // load existing notes from the spreadsheet
  static Future loadTransactions() async {
    if (_worksheet == null) return;

    for (int i = 1; i < numberOfTransactions; i++) {
      final String transactionName =
          await _worksheet!.values.value(column: 1, row: i + 1);
      final String transactionAmount =
          await _worksheet!.values.value(column: 2, row: i + 1);
      final String transactionType =
          await _worksheet!.values.value(column: 3, row: i + 1);

      if (currentTransactions.length < numberOfTransactions) {
        currentTransactions.add([
          transactionName,
          transactionAmount,
          transactionType,
        ]);
      }
    }
    // this will stop the circular loading indicator
    loading = false;
  }

  // insert a new transaction
  static Future insert(String name, String amount, bool _isIncome) async {
    if (_worksheet == null) return;
    numberOfTransactions++;
    currentTransactions.add([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
    await _worksheet!.values.appendRow([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
  }

  // CALCULATE THE TOTAL INCOME!
  static double calculateIncome() {
    double totalIncome = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'income') {
        totalIncome += double.parse(currentTransactions[i][1]);
      }
    }
    return totalIncome;
  }

  // CALCULATE THE TOTAL EXPENSE!
  static double calculateExpense() {
    double totalExpense = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'expense') {
        totalExpense += double.parse(currentTransactions[i][1]);
      }
    }
    return totalExpense;
  }
}

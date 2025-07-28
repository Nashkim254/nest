import 'package:nest/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';

import '../../../models/ticket.dart';

class TicketsViewModel extends BaseViewModel {
   List<Ticket> getSampleTickets() {
    return [
      Ticket(
        id: '1',
        eventName: 'Neon Night Rave',
        eventDate: 'Fri, Oct 27',
        eventTime: '9:00 PM',
        ticketType: 'General Admission',
        imageUrl: scan,
        qrCode: 'QR_CODE_1',
        isSavedToWallet: false,
      ),
      Ticket(
        id: '2',
        eventName: 'City Lights Gala',
        eventDate: 'Sat, Nov 11',
        eventTime: '7:30 PM',
        ticketType: 'VIP Access',
        imageUrl: scan,
        isSavedToWallet: true,
        specialOffer: '20 x 20',
      ),
      Ticket(
        id: '3',
        eventName: 'Groove Fest 2023',
        eventDate: 'Sun, Dec 3',
        eventTime: '2:00 PM',
        ticketType: 'General Admission',
        imageUrl: scan,
        isSavedToWallet: false,
      ),
      // Add some past events for testing
      Ticket(
        id: '4',
        eventName: 'Summer Music Festival',
        eventDate: 'Sat, Aug 15',
        eventTime: '6:00 PM',
        ticketType: 'VIP Access',
        imageUrl: scan,
        isSavedToWallet: true,
      ),
    ];
  }
}

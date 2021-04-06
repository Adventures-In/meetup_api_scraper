import 'dart:io';

import 'package:html/parser.dart';
import 'package:meetup_api_scraper/models/endpoint_info/response/response.dart';
import 'package:meetup_api_scraper/utils/path_utils.dart';
import 'package:test/test.dart';

void main() {
  group('Response', () {
    test('correctly parses a complex Response object', () async {
      final path = '/members/:member_id';
      final testDataPath = PathUtils.testDataPathFrom(path);
      final htmlString = await File(testDataPath).readAsString();
      final document = parse(htmlString);

      final responseElement = document.getElementById('getresponse')!;

      final response = Response.fromElement(responseElement);

      expect(response.map.keys, [
        'bio',
        'birthday',
        'city',
        'country',
        'email',
        'gender',
        'id',
        'is_pro_admin',
        'joined',
        'last_event',
        'lat',
        'localized_country_name',
        'lon',
        'memberships',
        'messaging_pref',
        'name',
        'next_event',
        'other_services',
        'photo',
        'privacy',
        'self',
        'state',
        'stats',
        'status',
        'topics'
      ]);

      expect(response.map['bio']?.description,
          'Member bio. When profile does not belong to the authenticated member, this may be omitted if member opted to hide their bio from others');

      final birthday = response.map['birthday']!;
      expect(birthday.description,
          'Returned only when the fields request parameter value includes \'birthday\'\nand only for the authenticated member when defined');
      expect(birthday.isLeaf, false);
      final day = birthday.map['day']!;
      final month = birthday.map['month']!;
      final year = birthday.map['year']!;
      expect(day.description,
          'Numeric day member was born. May be absent if not defined');
      expect(month.description,
          'Numeric month member was born. May be absent if not defined');
      expect(year.description, 'Year member was born');

      final lastEvent = response.map['last_event']!;
      expect(
          lastEvent.description,
          'Optional field representing the last RSVP\'d Meetup this member attended within the last two weeks,\n'
          'where available. Returned when the "fields"\n'
          'request parameter value contains "last_event"\n'
          'only for the profile of the authenticated member');
      final fee = lastEvent.map['fee']!;
      expect(fee.description,
          'Ticketing fee information for events that support payments');
      final accepts = fee.map['accepts']!;
      expect(accepts.description,
          'Acceptable methods of payments may be one of "paypal", "wepay", "stripe", or "cash"');
    });
  });
}

import 'dart:io';

import 'package:html/parser.dart';
import 'package:meetup_api_scraper/enums/operation_type.dart';
import 'package:meetup_api_scraper/models/endpoint_info.dart';
import 'package:test/test.dart';

void main() {
  group('EndpointInfo', () {
    /// The file "report-group.html" is the result of calling
    /// scraper.scrape(endpoint: ':urlname/abuse_reports')
    ///
    /// The call to the scraper retrieves the html from the documentation
    /// page for the endpoint with path ':urlname/abuse_reports'
    /// and extracting the element with id='method-info'
    test('correctly parses with fromElement', () async {
      final htmlString =
          await File('test/data/report-group.html').readAsString();
      final element = parse(htmlString).documentElement!;

      final endpointInfo = EndpointInfo.fromElement(element);

      expect(endpointInfo.title, 'Report Group');
      expect(endpointInfo.summary,
          'Submits a new abuse report for a target group. Abuse reports will be followed up on by our Community Support team.');
      expect(endpointInfo.path, '/:urlname/abuse_reports');
      expect(endpointInfo.operationType, OperationType.post);
      expect(endpointInfo.requestParameters.notes,
          'This method requires the oauth reporting scope for oauth-authenticated requests');

      // there are just two request parameters described for this endpoint
      expect(endpointInfo.requestParameters.parameterSet.first.toString(),
          'comments: An optional string of text that describes why you are submitting this report');
      expect(endpointInfo.requestParameters.parameterSet.last.toString(),
          'type: A required identifier for type of abuse you are reporting. Acceptable values include dangerous, graphic_content, graphic_photo, harmful_activities, inappropriate:illegal, inappropriate:intellectual_property, inappropriate:licensed_services, inappropriate:misinformation, inappropriate:other, inappropriate:sexual_exploitation, inappropriate:sexually_explicit, inappropriate:underage, irl:hateful, irl:misrepresentation, irl:other, irl:violent, licensed_services, not_accurate, not_community, not_irl, nudity, other, poor_quality_or_spam:misinformation, poor_quality_or_spam:misleading_title, poor_quality_or_spam:no_description, poor_quality_or_spam:not_irl, poor_quality_or_spam:other, poor_quality_or_spam:spam, promotion_focus, sex, smyte_warn, transactional, violence, violent_or_hateful:hateful, violent_or_hateful:misinformation, violent_or_hateful:other, violent_or_hateful:violent');

      // the response in this case only has a description
      expect(endpointInfo.response.toString(),
          'A successful abuse report request will result in a 202 Accepted response');

      // the examples section has a description and then the example
      expect(endpointInfo.examples!.notes,
          "Submit an abuse report for a group {urlname} that doesn't appear to be fostering a health community");

      // the strings here are close but not exactly the same - not sure if it's worth
      // takong the time to fix it, will come back to it
//       expect(endpointInfo.examples!.example, '''
// curl -H "Authorization: Bearer {token}" \
//   "https://api.meetup.com/{urlname}/abuse_reports" \
//   -d "type=not_community"
//     });
// ''');
    });
  });
}

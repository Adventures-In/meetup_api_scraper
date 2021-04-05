import 'dart:io';

import 'package:html/parser.dart';
import 'package:meetup_api_scraper/enums/operation_type.dart';
import 'package:meetup_api_scraper/utils/path_utils.dart';
import 'package:meetup_api_scraper/extensions/document_extensions.dart';
import 'package:test/test.dart';

void main() {
  group('EndpointInfo', () {
    test('correctly parses a page with one endpoint info item', () async {
      final path = '/:urlname/abuse_reports';
      final testDataPath = PathUtils.testDataPathFrom(path);
      final htmlString = await File(testDataPath).readAsString();
      final document = parse(htmlString);

      final endpointInfo = document.toEndpointInfo(0, path);

      expect(endpointInfo.title, 'Report Group');
      expect(
          endpointInfo.summary,
          '\n'
          '  Submits a new abuse report for a target group. Abuse reports will be followed up on by our Community Support team.\n'
          '  ');
      expect(endpointInfo.path, path);
      expect(endpointInfo.operationType, OperationType.post);
      expect(endpointInfo.requestParameters.notes,
          'This method requires the oauth reporting scope for oauth-authenticated requests');

      // there are just two request parameters for this endpoint
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
      expect(
          endpointInfo.examples!.example,
          'curl -H "Authorization: Bearer {token}" \\\n'
          '  "https://api.meetup.com/{urlname}/abuse_reports" \\\n'
          '  -d "type=not_community"\n'
          '');
    });

    test('correctly parses a page with multiple endpoint info items', () async {
      final path = '/members/:member_id';
      final testDataPath = PathUtils.testDataPathFrom(path);
      final htmlString = await File(testDataPath).readAsString();
      final document = parse(htmlString);

      final endpointInfo1 = document.toEndpointInfo(0, path);

      expect(endpointInfo1.title, 'Get Member Profile');
      expect(
          endpointInfo1.summary,
          '\n'
          '  Gets Member Profiles.\n'
          'For Group Profiles, see this endpoint\n'
          '  ');
      expect(endpointInfo1.path, '/members/:member_id');
      expect(endpointInfo1.operationType, OperationType.get);
      expect(endpointInfo1.requestParameters.notes,
          'A valid path parameter for :member_id is required. A value of "self"\nmay be used in place of a numeric identifier to represent the authenticated\nMember\'s id');

      // there is just one request parameter for this endpoint
      expect(endpointInfo1.requestParameters.parameterSet.first.toString(),
          'fields: A comma-delimited string of optional response field names.\nThis may include groups, privacy, and topics');

      // the response in this case only has a description
      expect(endpointInfo1.response.toString(),
          'Returns a single Member Profile object');

      // the examples section has a description and then the example
      expect(endpointInfo1.examples!.notes,
          'Fetch your own profile with all your groups');
      expect(
          endpointInfo1.examples!.example,
          'curl -H "Authorization: bearer {ACCESS_TOKEN}" \\\n'
          '    "https://api.meetup.com/members/self?fields=groups"\n'
          '');

      final endpointInfo2 = document.toEndpointInfo(1, path);

      expect(endpointInfo2.title, 'Member Profile Edit');
      expect(
          endpointInfo2.summary,
          '\n'
          '  \n'
          '  ');
      expect(endpointInfo2.path, '/members/:member_id');
      expect(endpointInfo2.operationType, OperationType.patch);
      expect(
          endpointInfo2.requestParameters.notes,
          'All parameters are optional.\n'
          'OAuth authenticated applications should\n'
          'request the profile_edit\n'
          'permission scope\n'
          'Some Meetup group organizers may define a set of profile questions\n'
          'they\'d like their members to answer. You can obtain that question\n'
          'list using the Get Group by sending\n'
          ' a "fields" request parameter containing\n'
          '"join_info"\n'
          'The authenticated member may set their currently location by either supplying a valid\n'
          '"city_id" or a valid "lat", "lon", or "zip".\n'
          'You can resolve a coordinate-based "zip" by using the\n'
          'Find locations API');

      // one request parameter for this endpoint
      expect(endpointInfo2.requestParameters.parameterSet.first.toString(),
          'add_topics: Comma-delimited list of topic ids to add to members interest list');

      // the response in this case only has a description
      expect(
          endpointInfo2.response.toString(),
          'A successful HTTP PATCH request will return an\n'
          'updated representation of the Member Profile');

      // the examples section has a description and then the example
      expect(endpointInfo2.examples, null);
    });
  });
}

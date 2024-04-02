import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:wizarding_world/0_data/datasources/house_remote_data_source.dart';
import 'package:wizarding_world/0_data/models/house_model.dart';
import 'package:wizarding_world/1_domain/entities/house_entities/head_entity.dart';
import 'package:wizarding_world/1_domain/entities/house_entities/trait_entity.dart';

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  const housesResponseBody = '''
  [
  {
    "id": "0367baf3-1cb6-4baf-bede-48e17e1cd005",
    "name": "Gryffindor",
    "houseColours": "Scarlet and gold",
    "founder": "Godric Gryffindor",
    "animal": "Lion",
    "element": "Fire",
    "ghost": "Nearly-Headless Nick",
    "commonRoom": "Gryffindor Tower",
    "heads": [
      {
        "id": "530da97d-5a83-4ea6-bc15-790edf5b5efc",
        "firstName": "Minerva",
        "lastName": "McGonagall"
      },
      {
        "id": "9915c5f8-9177-4f63-bba8-d04387a404f9",
        "firstName": "Godric",
        "lastName": "Gryffindor"
      }
    ],
    "traits": [
      {
        "id": "1773bce8-7a22-4d57-b8e1-7e1cbe26fa2b",
        "name": "Courage"
      },
      {
        "id": "21f22e43-efd9-4a43-87f5-eab5fb1666ea",
        "name": "Chivalary"
      }
    ]
  }
]
  ''';
  group('HouseRemoteDataSource', () {
    group('should return HouseModel', () {
      test('when client response is 200 and data is valid', () async {
        final mockClient = MockClient((request) {
          return Future.value(Response(housesResponseBody, 200));
        });

        final adviceRemoteDatasourceUnderTest =
            HouseRemoteDataSourceImpl(client: mockClient);

        final result = await adviceRemoteDatasourceUnderTest.getHouses();

        expect(
            result.first,
            HouseModel(
                id: '0367baf3-1cb6-4baf-bede-48e17e1cd005',
                name: 'Gryffindor',
                houseColours: "Scarlet and gold",
                founder: 'Godric Gryffindor',
                animal: 'Lion',
                element: 'Fire',
                ghost: 'Nearly-Headless Nick',
                commonRoom: 'Gryffindor Tower',
                heads: [
                  HeadEntity(
                      id: '530da97d-5a83-4ea6-bc15-790edf5b5efc',
                      firstName: 'Minerva',
                      lastName: 'McGonagall'),
                  HeadEntity(
                      id: '9915c5f8-9177-4f63-bba8-d04387a404f9',
                      firstName: 'Godric',
                      lastName: 'Gryffindor')
                ],
                traits: [
                  TraitEntity(
                      id: '1773bce8-7a22-4d57-b8e1-7e1cbe26fa2b',
                      name: 'Courage'),
                  TraitEntity(
                      id: '21f22e43-efd9-4a43-87f5-eab5fb1666ea',
                      name: 'Chivalary')
                ]));
      });
    });
  });
}

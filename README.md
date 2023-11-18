# Auctus-Mobile-App

Auctus(NU, The Garage) is currently on hiatus;

Implementation of AI-based car diagnosis tool mobile app endpoint. Swift, SwiftUI, and GQL(Apollo) on the mobile endpoint. Python and Flask on the web endpoint.

```python
class DiagnosisType(ObjectType):
    diagnosis = String()
    part = String()
    expl = String()
    estimate = String()

class DiagQuery(ObjectType):
    diagnose_car = Field(
        DiagnosisType,
        car_info=List(NonNull(String))
    )

    def resolve_diagnose_car(self, info, car_info):
        
        ai_analysis = analyze_issue_with_context(*car_info)

        n = ai_analysis.find('Auctus Diagnosis:')
        n1 = ai_analysis.find('Part Recommendation:')
        n2 = ai_analysis.find('Explanation:')
        n3 = ai_analysis.find('Auctus Estimate:')

        if n == -1 or n1 == -1 or n2 == -1 or n3 == -1:
            raise GraphQLError("The analysis text is not in the expected format.")
        
        diagnosis = ai_analysis[n:n1].replace('Auctus Diagnosis:', '').strip()
        part = ai_analysis[n1:n2].replace('Part Recommendation:', '').strip()
        expl = ai_analysis[n2:n3].replace('Explanation:', '').strip()
        estimate = ai_analysis[n3:].replace('Auctus Estimate:', '').strip()
        return DiagnosisType(diagnosis=diagnosis, part = part, expl = expl, estimate=estimate)

import 'package:healthy_me/src/model/diseases_model.dart';
import 'package:healthy_me/src/model/drugs_model.dart';
List<Diseases> diseases = [
  Diseases(
    name: 'Headache',
    conditions: [5, 10],
    intro:
    'Most headaches go away on their own and are not a sign of something more serious.',
    diagnose: [
      'Do: drink plenty of water, get plenty of rest if you have a cold or the flu, try to relax – stress can make headaches worse, take paracetamol or ibuprofen',
      'Do not: do not drink alcohol, do not skip meals (even if you might not feel like eating anything), do not sleep more than you usually would – it can make the headache worse, do not strain your eyes for a long time – for example, by looking at a screen',
      'See a General Practitioners if: your headache keeps coming back, painkillers do not help and your headache gets worse, you have a bad throbbing pain at the front or side of your head – it could be a migraine or, more rarely, a cluster headache, you feel sick, vomit and find light or noise painful',
      'Get an urgent General Practitioner appointment or call 102 if: You or your child has a severe headache and: jaw pain when eating, blurred or, double vision, a sore scalp, other symptoms, such as numbness or weakness in the arms or legs. Also get an urgent GP appointment or call 102 if your child is under 12 and has any 1 of the following: a headache that wakes them at night, a headache when they wake up in the morning, a headache that gets progressively worse, a headache triggered or made worse by coughing, sneezing or bending down, a headache with vomiting, a headache with a squint (where the eyes point in different directions) or an inability to look upward',
      'Call 102 or go to the hospital immediately if you or your child: has a head injury – for example, from a fall or accident, has a headache that came on suddenly and is extremely painful, You or your child has an extremely painful headache and: sudden problems speaking or remembering things, loss of vision, feel drowsy or confused, has a very high temperature and symptoms of meningitis, the white part of the eye is red, Also call 102or go to Hospital if your child is under 12 and has any 1 of the following: a headache with vision problems or difficulty speaking, swallowing, balancing or walking, a headache with drowsiness or a persistent lack of energy, a headache that starts within 5 days of a head injury',
    ],
    drugs: [
      DrugsModel(
        img: 'assets/images/paracetamol.png',
        title: 'Paracetamol',
        text:
        'Paracetamol is a common painkiller used to treat aches and pain. It can also be used to reduce a high temperature.',
      ),
      DrugsModel(
        img: 'assets/images/ibuprofen.png',
        title: 'Ibuprofen',
        text:
        'Find out how ibuprofen treats pain and swelling (inflammation), and how to take it.',
      ),
    ],
    recommendation: 'We will suggest you to consume the following drugs to ease pain or make an appointment with General Practitioners',
  ),
  Diseases(
    name: 'Flu',
    conditions: [3, 2, 1, 4, 5, 6, 16, 7],
    intro:
    'Flu will often get better on its own, but it can make some people seriously ill. It\'s important to get the flu vaccine if you\'re advised to.',
    diagnose: [
      'To help you get better more quickly: rest and sleep, keep warm, take paracetamol or ibuprofen to lower your temperature and treat aches and pains, drink plenty of water to avoid dehydration (your pee should be light yellow or clear)',
      'A pharmacist can help with flu: A pharmacist can give treatment advice and recommend flu remedies. Be careful not to use flu remedies if you\'re taking paracetamol and ibuprofen tablets as it\'s easy to take more than the recommended dose.',
      'Get advice from 102 now if: you\'re worried about your baby\'s or child\'s symptoms, you\'re 65 or over, you\'re pregnant, you have a long-term medical condition – for example, diabetes or a heart, lung, kidney or neurological disease, you have a weakened immune system – for example, because of chemotherapy or HIV, your symptoms do not improve after 7 days',
      'GPs do not recommend antibiotics for flu because they will not relieve your symptoms or speed up your recovery.',
      'Call 102or go to the hospital if you: develop sudden chest pain, have difficulty breathing, start coughing up blood',
    ],
    drugs: [
      DrugsModel(
        img: 'assets/images/paracetamol.png',
        title: 'Paracetamol',
        text:
        'Paracetamol is a common painkiller used to treat aches and pain. It can also be used to reduce a high temperature.',
      ),
      DrugsModel(
        img: 'assets/images/ibuprofen.png',
        title: 'Ibuprofen',
        text:
        'Find out how ibuprofen treats pain and swelling (inflammation), and how to take it.',
      ),
    ],
    recommendation: 'Go and take the Blood Test, the probability of having a flu is high but we cannot tell exactly based on your condition, so it would be better if you get a proper diagnose after taking a Blood Test',
  ),
  Diseases(
    name: 'Stomach ache',
    conditions: [12, 19, 20, 21, 16, 13, 23, 14, 15, 8, 9],
    intro:
    'Most stomach aches are not anything serious and will go away after a few days.',
    diagnose: [
      'See a General Practitioner if: the pain gets much worse quickly, the pain or bloating will not go away or keeps coming back, you have stomach pain and problems with swallowing food, you\'re losing weight without trying to, you suddenly pee more often or less often, peeing is suddenly painful, you bleed from your bottom or vagina, or have abnormal, discharge from your vagina, your diarrhoea does not go away after a few days',
      'Call 102 or go to the hospital if: your stomach ache came on very suddenly or is severe, it hurts when you touch your stomach, you\'re vomiting blood or your vomit looks like ground coffee, your poo is bloody or black and sticky and extremely smelly, you cannot pee, you cannot poo or fart, you cannot breathe, you have chest pain, you\'re diabetic and vomiting, someone has collapsed',
    ],
    drugs: [
      DrugsModel(
        img: 'assets/images/antacid.png',
        title: 'Antacids',
        text:
        'An antacid is a substance which neutralizes stomach acidity and is used to relieve heartburn, indigestion or an upset stomach.',
      ),
      DrugsModel(
        img: 'assets/images/prilosec.png',
        title: 'Prilosec',
        text:
        'Proton pump inhibitors (PPIs) are medicines that work by reducing the amount of stomach acid made by glands in the lining of your stomach.',
      ),
    ],
    recommendation: 'Do not self-diagnose – see a GP if you\'re worried. You can ask a pharmacist about: what might be causing your stomach ache, treatments that might help, medicines for constipation and indigestion',
  ),
  Diseases(
    name: 'Earache',
    conditions: [22, 17],
    intro:
    'Earache and ear pain is common, particularly in young children. It can be painful, but is not usually a sign of anything serious.',
    diagnose: [
      'Do: use painkillers, such as paracetamol or ibuprofen (children under 16 should not take aspirin), place a warm or cold flannel on the ear',
      'Do not: do not put anything inside your ear, such as cotton buds, do not try to remove earwax, do not let water get inside your ear',
      'See a General Practitioner if you or your child: have earache for more than 3 days, keep getting earache',
      'Get an urgent GP appointment if: You or your child have earache and: become generally unwell, a very high temperature or feel hot and shivery, swelling around the ear, fluid coming from the ear, hearing loss or a change in hearing, something stuck in the ear, your child is under 2 and has earache in both ears, Call 103 for advice if you cannot get an urgent appointment.',
    ],
    drugs: [
      DrugsModel(
        img: 'assets/images/natrullo.png',
        title: 'Natrullo',
        text:
        'Ear drops can be used to treat or prevent ear infections or to help remove earwax.',
      ),
    ],
    recommendation: 'A pharmacist might be able to tell you: what you can do to treat earache, yourself if you can buy anything to help (for example, eardrops), if you need to see a GP.',
  ),
  Diseases(
    name: 'Trapped wind',
    conditions: [12, 15],
    intro:
    'Farting, also known as flatulence or wind, is normal. There are things you can do if you fart a lot or it\'s smelly. Sometimes it can be a sign of a health condition.',
    diagnose: [
      'Do: eat smaller meals, more often drink or chew food slowly exercise regularly to improve how your body digests food drink peppermint tea.',
      'Do not: do not chew gum, smoke, or suck pen tops or hard sweets to avoid swallowing air do not wear loose-fitting dentures do not eat too many foods that are difficult to digest and make you fart',
      'See a General Practitioner if: self help and pharmacy treatments have not worked and farting is affecting your life you have a stomach ache or bloating that will not go away or comes back you keep getting constipation or diarrhoea you have lost weight without trying there\'s blood in your poo',
    ],
    drugs: [
      DrugsModel(
        img: 'assets/images/antacid.png',
        title: 'Antacids',
        text:
        'Charcoal can absorb gas in the bowel, thus helping with the symptoms of excessive flatulence.',
      ),
      DrugsModel(
        img: 'assets/images/bragg.png',
        title: 'Bragg\'s Medicinal Charcoal',
        text:
        'Charcoal can absorb gas in the bowel, thus helping with the symptoms of excessive flatulence.',
      ),
    ],
    recommendation: 'Speak to a pharmacist about excessive or smelly farts.',
  ),
  Diseases(
    name: 'Indigestion',
    conditions: [19, 20],
    intro:
    'Most people have indigestion at some point. Usually, it\'s not a sign of anything more serious and you can treat it yourself.',
    diagnose: [
      'Do: cut down on tea, coffee, cola or alcohol prop your head and shoulders up in bed – this can stop stomach acid coming up while you sleep lose weight if you\'re overweight',
      'eat 3 to 4 hours before going to bed have rich, spicy or fatty foods take ibuprofen or aspirin – this can make indigestion worse smoke',
    ],
    drugs: [
      DrugsModel(
        img: 'assets/images/antacid.png',
        title: 'Antacids',
        text:
        'An antacid is a substance which neutralizes stomach acidity and is used to relieve heartburn, indigestion or an upset stomach.',
      ),
      DrugsModel(
        img: 'assets/images/prilosec.png',
        title: 'Prilosec',
        text:
        'Proton pump inhibitors (PPIs) are medicines that work by reducing the amount of stomach acid made by glands in the lining of your stomach.',
      ),
    ],
    recommendation: 'A pharmacist can recommend medicines to ease the burning feeling or pain that can come with indigestion.',
  ),
  Diseases(
    name: 'Constipation',
    conditions: [13, 12],
    intro:
    'Constipation is common and it affects people of all ages. You can usually treat it at home with simple changes to your diet and lifestyle.',
    diagnose: [
      'drink plenty of fluids and avoid alcohol increase the fibre in your diet add some wheat bran, oats or linseed to your diet',
      'Keep to a regular time and place and give yourself plenty of time to use the toilet. Do not delay if you feel the urge to poo. To make it easier to poo, try resting your feet on a low stool while going to the toilet. If possible, raise your knees above your hips.',
      'A daily walk or run can help you poo more regularly.',
      'are not improving with treatment are regularly constipated and it lasts a long time are bloated and it lasts a long time have blood in your poo have unexpectedly lost weight feel very tired all the time are taking medicine that’s causing constipation – such as opioid painkiller. Speak to the GP before you stop taking any prescribed medicine.',
    ],
    drugs: [
      DrugsModel(
        img: 'assets/images/fybogel.png',
        title: 'Fybogel (ispaghula husk)',
        text:
        'Bulk-forming laxatives work by increasing the "bulk" or weight of poo, which in turn stimulates your bowel.',
      ),
      DrugsModel(
        img: 'assets/images/lactulose.png',
        title: 'Lactulose',
        text:
        'Lactulose is a laxative taken to treat constipation (difficulty pooing).',
      ),
      DrugsModel(
        img: 'assets/images/bisacodyl.png',
        title: 'Bisacodyl',
        text:
        'Bisacodyl is a laxative. This type of medicine can help you empty your bowels if you have constipation (difficulty pooing).',
      ),
    ],
    recommendation: 'Make changes to your diet: drink plenty of fluids and avoid alcohol, increase the fibre in your diet, add some wheat bran, oats or linseed to your diet.',
  ),
  Diseases(
    name: 'Diarrhoea or Food poisoning',
    conditions: [23, 19, 14],
    intro:
    'Food poisoning is rarely serious and usually gets better within a week. You can normally treat yourself or your child at home. They\'re often caused by a stomach bug and should stop in a few days.',
    diagnose: [
      'You can usually treat yourself or your child at home. The symptoms usually pass within a week. The most important thing is to have lots of fluids, such as water or squash, to avoid dehydration.',
      'Stay at home and get plenty of rest drink lots of fluids, such as water or squash – take small sips if you feel sick carry on breast or bottle feeding your baby – if they\'re being sick, try giving small feeds more often than usual give babies on formula or solid foods small sips of water between feeds eat when you feel able to – you do not need to eat or avoid any specific foods take paracetamol if you\'re in discomfort – check the leaflet before giving it to your child',
      'Do not: do not have fruit juice or fizzy drinks – they can make diarrhoea worse do not make baby formula weaker – use it at its usual strength do not give children under 12 medicine to stop diarrhoea do not give aspirin to children under 16',
    ],
    drugs: [
      DrugsModel(
        img: 'assets/images/loperamide.png',
        title: 'Loperamide',
        text:
        'Loperamide is a medicine to treat diarrhoea (runny poo). It can help with short-term diarrhoea or irritable bowel syndrome (IBS).',
      ),
      DrugsModel(
        img: 'assets/images/prilosec.png',
        title: 'Prilosec',
        text:
        'Proton pump inhibitors (PPIs) are medicines that work by reducing the amount of stomach acid made by glands in the lining of your stomach.',
      ),
    ],
  ),
];

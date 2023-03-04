
class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent({required this.image, required this.title, required this.discription});
}


List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Why choose \nHappSales?',
      image: 'assets/Icons/Android/2_StoryBoard screen_1/drawable-hdpi/img_story_board_1.png',
      discription: "HappSales is  as traditional CRM software can take more time to deploy. It is Easy-to-use as you can spend more time putting it to use and less time figuring it out. Its Effective as can be customized to meet any business needs."
  ),

  UnbordingContent(
      title: 'Collaborate with teams',
      image: 'assets/Icons/Android/3_StoryBoard screen_2/drawable-hdpi/img_story_board_2.png',
      discription: "Make sales tracking with Real-time reports. Secure your revenue by tracking transactions. Get detailed activity reports on your team's transactions and operations."
  ),
  UnbordingContent(
      title: 'Hi Im Ami, how can I help you?',
      image: 'assets/Icons/Android/4_StoryBoard screen_3/drawable-hdpi/img_story_board_3.png',
      discription: "HappSales offers an industry-first CRM app with personal-assistant that is uniquely designed to improve velocity across Sales, Service & Accounts Receivable (AR)."

  ),
];
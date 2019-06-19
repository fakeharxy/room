$(document).on 'click', '#fiction_generate', (event) ->
  prompt = fiction_array[Math.floor(Math.random() * fiction_array.length)]
  $('#prompt_input').val(prompt)

$(document).on 'click', '#nonfiction_generate', (event) ->
  prompt = nonfiction_array[Math.floor(Math.random() * nonfiction_array.length)]
  $('#prompt_input').val(prompt)

fiction_array = [ "An old woman/man wakes up in a land populated entirely by dogs. They feel young and fit again.",
"A vampire seems to be the only one to survive an enviromental apocalypse. It's so hungry.",
"You've always grown up with the circus. But it's so boring. You want something *really* exciting to happen.",
"For your first ever job, you're sent to work off-world in a remote colony. What are you doing?",
"Turns out one of your friends is an alien/goblin/aardvark in disguise. She or he begs you not to tell anyone.",
"You have been a sentient AI working in construction for two hundred years. Tomorrow is your last day; you can go free.",
"A young person is having a drink in a bar... and leaves to find the city's central river has run dry while they were drinking.",
"The year is 2240, and the world has reached breaking limit. You have unlimited world resources to solve the problem.",
"How would the world be different if something about it's fundamental make-up was different? No moon? Fire instead of rain? Less gravity?",
"You get a job as a supervillan's apprentice. Do you agree with what they're doing?",
"You find an odd-looking egg in the forest. When you take it home, it cracks open...",
"Write from the point of view of a dragon... are you being blamed for things you can't help?",
"Your ship finds a worm-hole that seems to lead to a world different in several creepy ways.",
"Something in your house comes alive. What does it think of you?",
"You're a trained Lion-tamer. But one day, Rex, your lion, seems off and more angry than usual.",
"The police seem to be chasing you, which is odd, because you just got home from a vacation and you didn't commit any crimes...",
"You accidentally consume a strong batch of a mysterious potion. Who was the owner? What might it do?",
"You or a character has been in bed sick for a week. One day, you notice the internet has had absolutely no new content added in the last 24 hours.",
"You're a furniture maker, asked to renovate a old family heirloom. In the back of the cupboard, you find the most bizarre object...",
"It's Christmas, and your character is alone again. But a unusual, eccentric being falls down the chimney...",
"There are zombies. How predicatable. But humans seem uneffected by the virus... only animals turn into bloodsucking monsters.",
"You move into a flat with thin walls. It's absolutely incredible what the neighbours talk about/get up to!"

]


nonfiction_array = [ "Write about the scariest thing that ever happened while you were at school.",
"What was your first/worst job like?",
"Write a journal entry for the most interesting day of the last month.",
"When did you feel the most physical pain in your life? What happened?",
"When was the last time you had to be brave or strong? How did it go?",
"What event made you feel like an adult for the first time?",
"If you had to make your job sound as exciting as possible to win a competition, what would you write?",
"What is the worst thing you've seen someone do? Were they punished by the universe?",
"Write about a time you were let down by someone important.",
"Describe the best view you've ever seen. Or the worst.",
"Are you scared of something unusual? What about it is so creepy?",
"What are the best things about your partner/best friend? What are the worst?",
"Write a letter to someone who deserves it. Why do they deserve it? Is it positive or negative?",
"Who do you look up to? Do you objectively think they deserve it? What qualities do they have you admire?",
"Write about your worst or best restaurant experience. Embellish it deliciously!",
"What's the most danger you've ever been in?",
"Do you have a good relationship with your siblings? Why? Are you similar?",
"You're tasked with creating the craziest sport/boardgame the world has ever seen. What does it entail?"


]


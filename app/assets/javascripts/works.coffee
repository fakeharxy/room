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
"You get a job as a supervillan's apprentice. Do you agree with what they're doing?"


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
"Describe the best view you've ever seen."

]


Tales of Yore - Project README

Overview
"Tales of Yore" is an interactive storytelling app inspired by classic choose-your-own-adventure novels and my extensive experience with RPG video games like "Fable" and "Baldur's Gate," as well as tabletop RPGs like "Dungeons and Dragons." The goal was to blend traditional storytelling with modern interactive elements enabled by Swift programming and the MVC pattern.

Project Progress
While I did not advance as far as I had hoped, particularly with the AI-driven visual aspects like the character portrait generator or visual diary, I found the process engaging and educational. Although not implemented, you can see where I was going with the AI portrait generator in the NetworkManager module. The app currently allows users to choose from three character classes and distribute fifteen points across three attributes. Decision nodes in the story require certain attributes to be above specific thresholds to succeed. For example, the door-opening sequence requires a level 6 in any ability, whether it's breaking down the door, picking the lock, or casting the "Alohomora" spell.

I invested significant effort into ensuring a functional game flow despite numerous challenges with the story engine structure. Although the current state is pretty “meh” IMO, I believe the effort invested is evident and the foundational code fairly robust.

This project helped deepen my understanding of Swift, and I encountered and overcame numerous annoying bugs, particularly with the storyEngine and getting the nodes to behave themselves. Managing the story engine's complex interactions and maintaining state coherence across different game scenarios were particularly challenging.

I plan to continue developing this app. I'm particularly interested in integrating features such as:
- AI-generated character portraits and diary visualizations.
- An alignment system influencing story outcomes.
- Multiple endings based on player decisions and attributes.
- An achievement system to reward exploration and consistency.
- dynamic interactions with NPCs using generative AI techniques, aiming for more coherent and contextually appropriate responses than my previous attempts.

The save game functionality is operational, and most buttons and interactions work as intended, although you may encounter some intermittent bugs. Currently, the adventure progresses smoothly until entering the keep, where further development is required.

Despite not implementing all envisioned features, creating a minimum viable product proved both feasible and enlightening. I think the project scope remains flexible enough for significant expansion down the road. I am keen on continuing to work on this and would appreciate any feedback. I look forward to potentially sharing a more developed version in the future if you are open to it.




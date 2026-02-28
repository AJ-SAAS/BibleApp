import SwiftUI

// MARK: - Content Models

struct Situation: Identifiable {
    let id = UUID()
    let when: String
    let reflection: String
    let verse: String
    let reference: String
}

struct TopicContent {
    let category: String
    let situations: [Situation]
}

// MARK: - Content Data

struct ContentData {
    static let all: [String: TopicContent] = [

        "Anger": TopicContent(category: "Anger", situations: [
            Situation(
                when: "When you've lost your patience with your children",
                reflection: "You are not a bad mother because you lost your temper. You are a human mother learning to reflect God's patience in a world that tests it daily. His mercies are new every morning — and so is your chance to begin again.",
                verse: "Be ye angry, and sin not: let not the sun go down upon your wrath.",
                reference: "Ephesians 4:26"
            ),
            Situation(
                when: "When anger is simmering beneath the surface",
                reflection: "Unspoken anger finds a way out — often at the wrong moment and at the wrong people. Bring it to God before it spills. He can hold what you cannot.",
                verse: "A soft answer turneth away wrath: but grievous words stir up anger.",
                reference: "Proverbs 15:1"
            ),
            Situation(
                when: "When you feel angry at God",
                reflection: "God is not afraid of your anger. He has heard it before — from David, from Job, from Elijah. Bring it honestly. He is big enough to hold it and gentle enough to answer.",
                verse: "The LORD is merciful and gracious, slow to anger, and plenteous in mercy.",
                reference: "Psalm 103:8"
            ),
            Situation(
                when: "When you need to model self-control for your children",
                reflection: "Your children are watching how you handle the hard moments more than the easy ones. Every time you pause and breathe, you are teaching them something no lesson plan could.",
                verse: "He that is slow to anger is better than the mighty; and he that ruleth his spirit than he that taketh a city.",
                reference: "Proverbs 16:32"
            )
        ]),

        "Assurance": TopicContent(category: "Assurance", situations: [
            Situation(
                when: "When you doubt your salvation",
                reflection: "Your salvation does not rest on the steadiness of your feelings — it rests on the faithfulness of God. He who began a good work in you will carry it through to completion.",
                verse: "These things have I written unto you that believe on the name of the Son of God; that ye may know that ye have eternal life.",
                reference: "1 John 5:13"
            ),
            Situation(
                when: "When you feel too broken to be loved by God",
                reflection: "God did not come for the put-together. He came for the broken, the weary, the ones who feel too far gone. You are not too much for Him. You are exactly who He came for.",
                verse: "For God so loved the world, that he gave his only begotten Son, that whosoever believeth in him should not perish, but have everlasting life.",
                reference: "John 3:16"
            ),
            Situation(
                when: "When your child asks if they are truly saved",
                reflection: "The fact that they are asking shows the Spirit is working. Walk with them gently. God draws children close — and He does not let go of what He holds.",
                verse: "Suffer little children to come unto me, and forbid them not: for of such is the kingdom of God.",
                reference: "Luke 18:16"
            ),
            Situation(
                when: "When you need reassurance that nothing can separate you from God",
                reflection: "Not your worst day. Not your deepest failure. Not your longest silence. Nothing in all creation has the power to pull you from the grip of God's love.",
                verse: "For I am persuaded, that neither death, nor life, nor angels, nor principalities, nor powers, nor things present, nor things to come, shall be able to separate us from the love of God.",
                reference: "Romans 8:38-39"
            )
        ]),

        "Babies": TopicContent(category: "Babies", situations: [
            Situation(
                when: "When a new baby has turned your world upside down",
                reflection: "The exhaustion is real. The love is real. The overwhelm is real. And so is God's presence in every 3am feeding, every tear-soaked shirt, every moment you wonder if you're doing it right.",
                verse: "She shall be saved in childbearing, if they continue in faith and charity and holiness with sobriety.",
                reference: "1 Timothy 2:15"
            ),
            Situation(
                when: "When you're struggling with an unplanned pregnancy",
                reflection: "God does not make mistakes. This little life arrived in His timing, held in His hands, known before the foundations of the world. You are not alone in this — He will provide what you cannot see yet.",
                verse: "Children are an heritage of the LORD: and the fruit of the womb is his reward.",
                reference: "Psalm 127:3"
            ),
            Situation(
                when: "When you're overwhelmed by the weight of keeping a baby alive",
                reflection: "You do not have to be perfect — you just have to be present. God entrusted this child to you knowing exactly who you are. He will fill the gaps.",
                verse: "I can do all things through Christ which strengtheneth me.",
                reference: "Philippians 4:13"
            ),
            Situation(
                when: "When you want to treasure these fleeting moments",
                reflection: "The days are long but the years are short — you have heard it and found it achingly true. Let yourself be fully here. These ordinary moments are the sacred ones.",
                verse: "Lo, children are an heritage of the LORD: and the fruit of the womb is his reward.",
                reference: "Psalm 127:3"
            )
        ]),

        "Burnout": TopicContent(category: "Burnout", situations: [
            Situation(
                when: "When you have absolutely nothing left to give",
                reflection: "You cannot pour from an empty vessel — and God never asked you to. He is not standing over you with a clipboard. He is standing beside you with an invitation to rest.",
                verse: "Come unto me, all ye that labour and are heavy laden, and I will give you rest.",
                reference: "Matthew 11:28"
            ),
            Situation(
                when: "When motherhood has lost its joy",
                reflection: "Burnout does not mean you love your family less. It means you have been giving without receiving. Let God replenish what the world has taken. Joy is not gone — it is waiting to be renewed.",
                verse: "They that wait upon the LORD shall renew their strength; they shall mount up with wings as eagles.",
                reference: "Isaiah 40:31"
            ),
            Situation(
                when: "When you feel like you're failing at everything",
                reflection: "The enemy wants you to measure yourself against an impossible standard. God measures you by His grace — and in Him, you are already enough. You are not behind. You are held.",
                verse: "And he said unto me, My grace is sufficient for thee: for my strength is made perfect in weakness.",
                reference: "2 Corinthians 12:9"
            ),
            Situation(
                when: "When you need permission to stop and breathe",
                reflection: "God rested on the seventh day — not because He was tired, but to show us that rest is holy. You are allowed to stop. Stillness is not laziness. It is trust.",
                verse: "Be still, and know that I am God.",
                reference: "Psalm 46:10"
            )
        ]),

        "Children": TopicContent(category: "Children", situations: [
            Situation(
                when: "When you're worried about your child's future",
                reflection: "You can see today — God can see forever. The future you cannot imagine, He has already prepared. Trust the One who loves your child even more than you do.",
                verse: "For I know the thoughts that I think toward you, saith the LORD, thoughts of peace, and not of evil, to give you an expected end.",
                reference: "Jeremiah 29:11"
            ),
            Situation(
                when: "When your child is making choices that break your heart",
                reflection: "You planted seeds that are still growing — even when you cannot see them. Keep praying. Keep loving. God is working in the unseen places of your child's heart.",
                verse: "Train up a child in the way he should go: and when he is old, he will not depart from it.",
                reference: "Proverbs 22:6"
            ),
            Situation(
                when: "When you need wisdom in how to raise your children",
                reflection: "You do not need to have all the answers — you need to know the One who does. Ask boldly. God gives wisdom generously to every mother who asks.",
                verse: "If any of you lack wisdom, let him ask of God, that giveth to all men liberally, and upbraideth not; and it shall be given him.",
                reference: "James 1:5"
            ),
            Situation(
                when: "When you want to point your children toward God",
                reflection: "The greatest gift you will ever give your children is not a good education or a safe home — it is a mother whose life points to Jesus. Keep going. It matters more than you know.",
                verse: "And these words, which I command thee this day, shall be in thine heart: And thou shalt teach them diligently unto thy children.",
                reference: "Deuteronomy 6:6-7"
            )
        ]),

        "Courage": TopicContent(category: "Courage", situations: [
            Situation(
                when: "When fear is paralyzing you",
                reflection: "Fear is loud. But God is louder. He does not ask you to feel brave — He asks you to take one step while He holds your hand. Courage is not the absence of fear. It is moving forward anyway.",
                verse: "For God hath not given us the spirit of fear; but of power, and of love, and of a sound mind.",
                reference: "2 Timothy 1:7"
            ),
            Situation(
                when: "When you need to have a hard conversation",
                reflection: "The conversations we avoid are often the ones that matter most. God will give you the words. Ask Him before you speak — and trust that love delivered honestly is still love.",
                verse: "Be strong and of a good courage; be not afraid, neither be thou dismayed: for the LORD thy God is with thee whithersoever thou goest.",
                reference: "Joshua 1:9"
            ),
            Situation(
                when: "When the road ahead feels too hard",
                reflection: "You do not have to see the whole road — you just need light for the next step. God has never once left you to walk it alone, and He is not starting today.",
                verse: "The LORD is my light and my salvation; whom shall I fear? the LORD is the strength of my life; of whom shall I be afraid?",
                reference: "Psalm 27:1"
            ),
            Situation(
                when: "When you need courage to trust God's plan",
                reflection: "Trusting God's plan when you cannot see it is one of the bravest things a mother can do. It is not naive — it is faith. And faith is never wasted.",
                verse: "Trust in the LORD with all thine heart; and lean not unto thine own understanding.",
                reference: "Proverbs 3:5"
            )
        ]),

        "Depression": TopicContent(category: "Depression", situations: [
            Situation(
                when: "When you can barely get out of bed",
                reflection: "God meets you where you are — not where you think you should be. He is present in the bed, in the dark, in the quiet. You do not have to perform for Him. Just breathe. He is here.",
                verse: "The LORD is nigh unto them that are of a broken heart; and saveth such as be of a contrite spirit.",
                reference: "Psalm 34:18"
            ),
            Situation(
                when: "When the darkness feels like it will never lift",
                reflection: "Morning always follows night. It has never once failed to come. Hold on — the light is not gone, it is simply on its way. And God is with you in every hour of the waiting.",
                verse: "Weeping may endure for a night, but joy cometh in the morning.",
                reference: "Psalm 30:5"
            ),
            Situation(
                when: "When you feel completely numb",
                reflection: "Numbness is not the absence of God — it is sometimes the body's way of surviving what the heart cannot yet carry. He sees you even when you cannot feel Him. He has not moved.",
                verse: "He healeth the broken in heart, and bindeth up their wounds.",
                reference: "Psalm 147:3"
            ),
            Situation(
                when: "When you need hope that things can get better",
                reflection: "You are not stuck forever. What feels permanent today is not. God is a God of redemption — He takes what is broken and makes it new. Your story is not over.",
                verse: "For I will restore health unto thee, and I will heal thee of thy wounds, saith the LORD.",
                reference: "Jeremiah 30:17"
            )
        ]),

        "Encouragement": TopicContent(category: "Encouragement", situations: [
            Situation(
                when: "When no one notices the work you do",
                reflection: "The laundry folded at midnight, the lunches made before dawn, the tears wiped and the prayers prayed — God sees every single one. Not one act of love you have given goes unnoticed by Him.",
                verse: "And whatsoever ye do, do it heartily, as to the Lord, and not unto men.",
                reference: "Colossians 3:23"
            ),
            Situation(
                when: "When you need someone to tell you you're doing a good job",
                reflection: "You are doing a good job. Not a perfect job — a good one. And good, offered with love, is exactly what your family needs. God sees your effort and He is pleased.",
                verse: "Well done, thou good and faithful servant.",
                reference: "Matthew 25:21"
            ),
            Situation(
                when: "When you feel like giving up",
                reflection: "Do not despise the day of small things. The seeds you are planting in your children's lives will bear fruit you cannot yet see. Keep going. It is worth it.",
                verse: "And let us not be weary in well doing: for in due season we shall reap, if we faint not.",
                reference: "Galatians 6:9"
            ),
            Situation(
                when: "When you need to be reminded of your purpose",
                reflection: "Motherhood is not a lesser calling — it is one of the most profound ways to reflect God's love to the world. What you do inside your home echoes into eternity.",
                verse: "She is clothed with strength and dignity; and she shall rejoice in time to come.",
                reference: "Proverbs 31:25"
            )
        ]),

        "Faith": TopicContent(category: "Faith", situations: [
            Situation(
                when: "When your faith feels thin and fragile",
                reflection: "Faith the size of a mustard seed is enough. God does not require you to feel mountains of confidence — He just asks you to keep your eyes on Him, even through the blur of tears.",
                verse: "If ye have faith as a grain of mustard seed, ye shall say unto this mountain, Remove hence to yonder place; and it shall remove.",
                reference: "Matthew 17:20"
            ),
            Situation(
                when: "When you're struggling to believe God is good",
                reflection: "Doubt is not the opposite of faith — it is part of the journey. Bring your questions to God. He is not threatened by them. He is waiting to meet you in them.",
                verse: "And we know that all things work together for good to them that love God, to them who are the called according to his purpose.",
                reference: "Romans 8:28"
            ),
            Situation(
                when: "When your faith is being tested",
                reflection: "Fire refines gold — and trials refine faith. What you are walking through is not punishment. It is the very process that makes faith unshakeable. You will come through this stronger.",
                verse: "That the trial of your faith, being much more precious than of gold that perisheth, though it be tried with fire, might be found unto praise and honour and glory.",
                reference: "1 Peter 1:7"
            ),
            Situation(
                when: "When you want to pass your faith on to your children",
                reflection: "Faith caught is as powerful as faith taught. When your children see you pray, trust, and return to God after failure — they are learning what no Sunday school class alone can teach.",
                verse: "Now faith is the substance of things hoped for, the evidence of things not seen.",
                reference: "Hebrews 11:1"
            )
        ]),

        "Family": TopicContent(category: "Family", situations: [
            Situation(
                when: "When your family feels fractured and broken",
                reflection: "God is a God of restoration. He specialises in what seems beyond repair. Bring your family to Him — broken pieces and all. He can make something beautiful from what feels like rubble.",
                verse: "As for me and my house, we will serve the LORD.",
                reference: "Joshua 24:15"
            ),
            Situation(
                when: "When there is conflict in your home",
                reflection: "Peace in the home is worth pursuing at great cost. Not the false peace of avoiding hard things — but the real peace that comes from choosing love over being right.",
                verse: "Blessed are the peacemakers: for they shall be called the children of God.",
                reference: "Matthew 5:9"
            ),
            Situation(
                when: "When you want to build a legacy of faith",
                reflection: "The most important thing you will ever build is not a career or a house — it is a home where God is known and loved. That legacy outlives everything else.",
                verse: "But as for me and my house, we will serve the LORD.",
                reference: "Joshua 24:15"
            ),
            Situation(
                when: "When you feel like you're failing your family",
                reflection: "Grace covers the gaps. Your children do not need a perfect mother — they need a real one who shows them what it looks like to love God imperfectly and keep going anyway.",
                verse: "Love suffereth long, and is kind; charity envieth not; charity vaunteth not itself, is not puffed up.",
                reference: "1 Corinthians 13:4"
            )
        ]),

        "Fear": TopicContent(category: "Fear", situations: [
            Situation(
                when: "When you're afraid for your children's safety",
                reflection: "Your children are held in hands far stronger than yours. You can do everything right and still not control every outcome — but God can. Give them back to Him daily.",
                verse: "The angel of the LORD encampeth round about them that fear him, and delivereth them.",
                reference: "Psalm 34:7"
            ),
            Situation(
                when: "When anxiety grips you in the night",
                reflection: "The fears that grow large in the dark look different in the light of God's presence. He is with you in the 3am spiral. Call on Him — He does not sleep.",
                verse: "I will both lay me down in peace, and sleep: for thou, LORD, only makest me dwell in safety.",
                reference: "Psalm 4:8"
            ),
            Situation(
                when: "When you're afraid of the future",
                reflection: "The future is not unknown to God — it is already held in His hands. He does not send you into tomorrow alone. He goes before you, preparing the way.",
                verse: "Fear thou not; for I am with thee: be not dismayed; for I am thy God: I will strengthen thee.",
                reference: "Isaiah 41:10"
            ),
            Situation(
                when: "When fear is stealing your peace",
                reflection: "Fear and faith cannot occupy the same space for long. Every time you choose to trust God over your fear, faith grows. Start small. Start today.",
                verse: "There is no fear in love; but perfect love casteth out fear.",
                reference: "1 John 4:18"
            )
        ]),

        "Forgiveness": TopicContent(category: "Forgiveness", situations: [
            Situation(
                when: "When you can't forgive yourself for past mistakes",
                reflection: "The cross was not a partial payment — it was complete. What God has forgiven, do not keep bringing back to the courtroom. You are not condemned. You are free.",
                verse: "There is therefore now no condemnation to them which are in Christ Jesus.",
                reference: "Romans 8:1"
            ),
            Situation(
                when: "When someone has deeply hurt you",
                reflection: "Forgiveness is not saying what they did was acceptable. It is releasing the debt so that bitterness does not take root in your heart. You forgive for your freedom, not their absolution.",
                verse: "And be ye kind one to another, tenderhearted, forgiving one another, even as God for Christ's sake hath forgiven you.",
                reference: "Ephesians 4:32"
            ),
            Situation(
                when: "When you need to model forgiveness for your children",
                reflection: "When your children watch you forgive — especially when it is hard — they are learning one of the most powerful lessons of their lives. You are showing them the gospel in action.",
                verse: "Forbearing one another, and forgiving one another, if any man have a quarrel against any: even as Christ forgave you, so also do ye.",
                reference: "Colossians 3:13"
            ),
            Situation(
                when: "When you've hurt someone and need to make it right",
                reflection: "Humility is not weakness — it is courage. Going back to repair what was broken takes more strength than pride ever will. God honours the mother who is willing to say I'm sorry.",
                verse: "Confess your faults one to another, and pray one for another, that ye may be healed.",
                reference: "James 5:16"
            )
        ]),

        "Future": TopicContent(category: "Future", situations: [
            Situation(
                when: "When tomorrow feels terrifying",
                reflection: "You do not have to carry tomorrow today. God gives grace for today — and tomorrow's grace will arrive with tomorrow. His mercies are new every single morning.",
                verse: "Take therefore no thought for the morrow: for the morrow shall take thought for the things of itself.",
                reference: "Matthew 6:34"
            ),
            Situation(
                when: "When your plans have fallen apart",
                reflection: "A broken plan is not a broken life. God is not surprised by what surprised you. He is already in your detour, weaving it into something you could not have planned yourself.",
                verse: "A man's heart deviseth his way: but the LORD directeth his steps.",
                reference: "Proverbs 16:9"
            ),
            Situation(
                when: "When you're worried about what the world holds for your children",
                reflection: "Your children were not born into the wrong generation. God placed them here — in this time, in this world — on purpose. He has equipped them for exactly where they will go.",
                verse: "For I know the thoughts that I think toward you, saith the LORD, thoughts of peace, and not of evil, to give you an expected end.",
                reference: "Jeremiah 29:11"
            ),
            Situation(
                when: "When you need hope that the best is still ahead",
                reflection: "God is not done with your story. The pages still unwritten hold more than you can imagine. Hold onto hope — it is not wishful thinking, it is confident expectation in a faithful God.",
                verse: "For I know the plans I have for you, declares the LORD, plans to prosper you and not to harm you, plans to give you hope and a future.",
                reference: "Jeremiah 29:11"
            )
        ]),

        "Grief": TopicContent(category: "Grief", situations: [
            Situation(
                when: "When loss has hollowed you out",
                reflection: "Grief is the price of love — and it is worth it. God does not ask you to rush through it. He sits with you in it. He is acquainted with grief. He understands yours.",
                verse: "The LORD is nigh unto them that are of a broken heart; and saveth such as be of a contrite spirit.",
                reference: "Psalm 34:18"
            ),
            Situation(
                when: "When you're grieving and trying to be strong for your children",
                reflection: "You do not have to pretend in front of your children. Letting them see your grief — and your faith in the middle of it — teaches them more about God than a hundred sermons.",
                verse: "Blessed are they that mourn: for they shall be comforted.",
                reference: "Matthew 5:4"
            ),
            Situation(
                when: "When you wonder if the pain will ever ease",
                reflection: "Grief changes shape over time. It does not disappear — but it softens. God promises to bind up the brokenhearted. He is actively healing what is broken inside you.",
                verse: "He healeth the broken in heart, and bindeth up their wounds.",
                reference: "Psalm 147:3"
            ),
            Situation(
                when: "When you need to know your loved one is with God",
                reflection: "Death is not the end of the story for those who belong to God. What feels like goodbye here is only see you soon in eternity. Hold onto that hope.",
                verse: "For God so loved the world, that he gave his only begotten Son, that whosoever believeth in him should not perish, but have everlasting life.",
                reference: "John 3:16"
            )
        ]),

        "Hope": TopicContent(category: "Hope", situations: [
            Situation(
                when: "When hope feels impossible",
                reflection: "Hope is not a feeling — it is a choice anchored in what God has promised. His Word does not return void. His promises do not expire. Hope in Him is never misplaced.",
                verse: "For with God nothing shall be impossible.",
                reference: "Luke 1:37"
            ),
            Situation(
                when: "When your prayers feel unanswered",
                reflection: "Unanswered does not mean unheard. God is not ignoring you — He is working in ways you cannot yet see. His timing is not your timing, and His answer is always better than your plan.",
                verse: "Wait on the LORD: be of good courage, and he shall strengthen thine heart: wait, I say, on the LORD.",
                reference: "Psalm 27:14"
            ),
            Situation(
                when: "When you need an anchor in the storm",
                reflection: "Hope in God is not wishful thinking — it is an anchor that holds when everything around you is shifting. You will not drift away. You are held fast.",
                verse: "Which hope we have as an anchor of the soul, both sure and stedfast.",
                reference: "Hebrews 6:19"
            ),
            Situation(
                when: "When you want to pass hope on to your children",
                reflection: "A hopeful mother is one of the greatest gifts a child can receive. When they see you trust God in the dark, they learn that the dark is never the final word.",
                verse: "Be of good courage, and he shall strengthen your heart, all ye that hope in the LORD.",
                reference: "Psalm 31:24"
            )
        ]),

        "Infertility": TopicContent(category: "Infertility", situations: [
            Situation(
                when: "When the wait feels unbearable",
                reflection: "Every month that passes without the answer you are longing for is a month God is still with you. He has not forgotten your name or your prayer. He sees your empty arms and He cares.",
                verse: "They that wait upon the LORD shall renew their strength.",
                reference: "Isaiah 40:31"
            ),
            Situation(
                when: "When you feel like God isn't listening to your prayers for a child",
                reflection: "Hannah wept before God and He heard her. Elizabeth waited decades and God remembered her. You are in a long line of women whose prayers God has not forgotten. He hears you.",
                verse: "And she was in bitterness of soul, and prayed unto the LORD, and wept sore.",
                reference: "1 Samuel 1:10"
            ),
            Situation(
                when: "When you're struggling with why others get pregnant easily",
                reflection: "Comparison in this season is a thief. Your journey is not a punishment — it is a path, and God is on it with you. What He has for you is being prepared even now.",
                verse: "For my thoughts are not your thoughts, neither are your ways my ways, saith the LORD.",
                reference: "Isaiah 55:8"
            ),
            Situation(
                when: "When you need to surrender your desire to God",
                reflection: "Surrender is not giving up hope — it is placing your deepest longing in the safest hands possible. God can do more with your open hands than your clenched ones.",
                verse: "Delight thyself also in the LORD; and he shall give thee the desires of thine heart.",
                reference: "Psalm 37:4"
            )
        ]),

        "Joy": TopicContent(category: "Joy", situations: [
            Situation(
                when: "When you've lost your joy somewhere along the way",
                reflection: "Joy is not dependent on circumstances — it is rooted in the unchanging character of God. When the feeling fades, the foundation remains. Return to Him and find joy waiting.",
                verse: "Thou wilt shew me the path of life: in thy presence is fulness of joy.",
                reference: "Psalm 16:11"
            ),
            Situation(
                when: "When you want to be more present with your children",
                reflection: "The laundry will wait. The emails can wait. This moment — this giggle, this small hand in yours — will not come again. Be here. This is the joy you will look back on.",
                verse: "This is the day which the LORD hath made; we will rejoice and be glad in it.",
                reference: "Psalm 118:24"
            ),
            Situation(
                when: "When you're grateful and want to celebrate God's goodness",
                reflection: "Gratitude and joy are sisters. When you stop to name what God has done, joy rises. Count the gifts — the small ones most of all. They are everywhere.",
                verse: "Rejoice in the Lord alway: and again I say, Rejoice.",
                reference: "Philippians 4:4"
            ),
            Situation(
                when: "When you need joy that doesn't depend on your circumstances",
                reflection: "The world offers happiness when things go right. God offers joy that holds even when they don't. It is deeper, steadier, and available to you right now — in this very moment.",
                verse: "The joy of the LORD is your strength.",
                reference: "Nehemiah 8:10"
            )
        ]),

        "Miscarriage": TopicContent(category: "Miscarriage", situations: [
            Situation(
                when: "When your arms ache for the baby you lost",
                reflection: "Your grief is not a sign of weak faith — it is a sign of deep love. God does not look away from your pain. He sits with you in it, holding what your hands could not.",
                verse: "The LORD is nigh unto them that are of a broken heart; and saveth such as be of a contrite spirit.",
                reference: "Psalm 34:18"
            ),
            Situation(
                when: "When you wonder if God was listening to your prayers",
                reflection: "His silence is not absence. He was there in the waiting, in the hoping, in the loss. Trust that He holds what your hands could not. Your baby is known to Him.",
                verse: "For I know the thoughts that I think toward you, saith the LORD, thoughts of peace, and not of evil.",
                reference: "Jeremiah 29:11"
            ),
            Situation(
                when: "When guilt tells you it was your fault",
                reflection: "There is no condemnation for you here. You did not fail. You loved — and loving always carries the risk of loss. You are not being punished. You are deeply, completely loved.",
                verse: "There is therefore now no condemnation to them which are in Christ Jesus.",
                reference: "Romans 8:1"
            ),
            Situation(
                when: "When you need hope that joy will return",
                reflection: "Weeping may endure for a night — but morning is still coming for you, precious mom. The God who holds your tears also holds your future. Joy is not gone forever.",
                verse: "Weeping may endure for a night, but joy cometh in the morning.",
                reference: "Psalm 30:5"
            )
        ]),

        "Motherhood": TopicContent(category: "Motherhood", situations: [
            Situation(
                when: "When you wonder if what you do matters",
                reflection: "The world measures importance by visibility. God measures it by faithfulness. What you do in the hidden places of your home — the prayers, the presence, the patience — echoes into eternity.",
                verse: "And whatsoever ye do, do it heartily, as to the Lord, and not unto men.",
                reference: "Colossians 3:23"
            ),
            Situation(
                when: "When motherhood feels like too much",
                reflection: "You were not designed to do this alone — and you are not. God called you to this and He equips every calling. The strength you need for today will be there when today arrives.",
                verse: "I can do all things through Christ which strengtheneth me.",
                reference: "Philippians 4:13"
            ),
            Situation(
                when: "When you need to remember why you do this",
                reflection: "You are not just raising children. You are shaping souls that will outlast everything else you will ever build. There is no more important work on earth than the one happening in your home.",
                verse: "Her children arise up, and call her blessed; her husband also, and he praiseth her.",
                reference: "Proverbs 31:28"
            ),
            Situation(
                when: "When you need to be reminded you are not alone",
                reflection: "Every mom who has ever felt exactly as you feel right now — overwhelmed, unseen, uncertain — is part of a long line of women who have been sustained by the same faithful God. You are held.",
                verse: "The LORD thy God in the midst of thee is mighty; he will save, he will rejoice over thee with joy.",
                reference: "Zephaniah 3:17"
            )
        ]),

        "Overwhelmed": TopicContent(category: "Overwhelmed", situations: [
            Situation(
                when: "When everything is too much at once",
                reflection: "You do not have to solve everything today. You just have to do the next right thing. God does not ask you to carry the whole week — just this moment. Hand the rest to Him.",
                verse: "Cast thy burden upon the LORD, and he shall sustain thee.",
                reference: "Psalm 55:22"
            ),
            Situation(
                when: "When the to-do list never ends",
                reflection: "Not everything on that list is yours to carry. Some of it belongs to God. Some of it can wait. Some of it doesn't matter as much as sitting with your child for five minutes. Choose wisely.",
                verse: "Come unto me, all ye that labour and are heavy laden, and I will give you rest.",
                reference: "Matthew 11:28"
            ),
            Situation(
                when: "When you can't see a way through",
                reflection: "You don't need to see the whole path — just the next step. God will illuminate what you need when you need it. He has never let you walk into darkness without a light.",
                verse: "Thy word is a lamp unto my feet, and a light unto my path.",
                reference: "Psalm 119:105"
            ),
            Situation(
                when: "When you need peace in the middle of chaos",
                reflection: "Peace is not the absence of noise — it is the presence of God in the middle of it. Ask Him into the chaos. He specialises in speaking calm into storms.",
                verse: "And the peace of God, which passeth all understanding, shall keep your hearts and minds through Christ Jesus.",
                reference: "Philippians 4:7"
            )
        ]),

        "Peace": TopicContent(category: "Peace", situations: [
            Situation(
                when: "When your heart is restless and unsettled",
                reflection: "The restlessness you feel is an invitation. Your heart was made for more than this world can offer — and only God can fill the space that keeps emptying. Come to Him and find what you're looking for.",
                verse: "Thou wilt keep him in perfect peace, whose mind is stayed on thee: because he trusteth in thee.",
                reference: "Isaiah 26:3"
            ),
            Situation(
                when: "When you need peace about a decision you've made",
                reflection: "If you sought God and made the best decision you could with what you knew — rest in that. He redeems imperfect decisions made with sincere hearts. You are not beyond His grace.",
                verse: "And the peace of God, which passeth all understanding, shall keep your hearts and minds through Christ Jesus.",
                reference: "Philippians 4:7"
            ),
            Situation(
                when: "When there is conflict all around you",
                reflection: "You cannot control the chaos around you — but you can guard the peace within you. Ask God for the kind of peace that doesn't make sense to the world. It is real and it is available.",
                verse: "Peace I leave with you, my peace I give unto you: not as the world giveth, give I unto you.",
                reference: "John 14:27"
            ),
            Situation(
                when: "When you want your home to be a place of peace",
                reflection: "A peaceful home is built one moment at a time. Every time you choose gentleness over reaction, prayer over panic, you are laying another brick. It starts with you — and God will help you.",
                verse: "And let the peace of God rule in your hearts, to the which also ye are called in one body; and be ye thankful.",
                reference: "Colossians 3:15"
            )
        ]),

        "Prayer": TopicContent(category: "Prayer", situations: [
            Situation(
                when: "When you don't know what to say to God",
                reflection: "You don't need perfect words. You need an honest heart. God hears the groans, the silences, the half-formed thoughts. Bring whatever you have — He will meet you there.",
                verse: "Likewise the Spirit also helpeth our infirmities: for we know not what we should pray for as we ought: but the Spirit itself maketh intercession for us.",
                reference: "Romans 8:26"
            ),
            Situation(
                when: "When prayer feels like talking to the ceiling",
                reflection: "Feeling unheard and being unheard are not the same thing. God's faithfulness is not measured by your emotions. He is listening even when the connection feels static. Keep praying.",
                verse: "The effectual fervent prayer of a righteous man availeth much.",
                reference: "James 5:16"
            ),
            Situation(
                when: "When you want to pray more consistently",
                reflection: "Prayer is not a spiritual performance — it is a conversation with your Father. Start small. Start honest. Even a minute of genuine connection is worth more than an hour of religious routine.",
                verse: "Pray without ceasing.",
                reference: "1 Thessalonians 5:17"
            ),
            Situation(
                when: "When you're praying for your children",
                reflection: "The most powerful thing you will ever do for your children is pray for them. Your prayers outlast your presence. They follow your children into rooms you will never enter.",
                verse: "Ask, and it shall be given you; seek, and ye shall find; knock, and it shall be opened unto you.",
                reference: "Matthew 7:7"
            )
        ]),

        "Protection": TopicContent(category: "Protection", situations: [
            Situation(
                when: "When you're afraid for your child's physical safety",
                reflection: "You cannot be everywhere — but God can. He watches over your children when you cannot see them, in the places your eyes cannot reach. Trust the One who never sleeps.",
                verse: "He shall give his angels charge over thee, to keep thee in all thy ways.",
                reference: "Psalm 91:11"
            ),
            Situation(
                when: "When you're worried about the world your children are growing up in",
                reflection: "God placed your children in this generation on purpose. He has not sent them into the world unequipped. What looks dangerous to you is not outside of His sovereign care.",
                verse: "No weapon that is formed against thee shall prosper.",
                reference: "Isaiah 54:17"
            ),
            Situation(
                when: "When you need to release your children into God's hands",
                reflection: "Your hands are good — but His are better. Every morning you can do the bravest thing a mother does: open your hands and give your children back to the One who loves them most.",
                verse: "The eternal God is thy refuge, and underneath are the everlasting arms.",
                reference: "Deuteronomy 33:27"
            ),
            Situation(
                when: "When you want to pray a hedge of protection over your family",
                reflection: "Prayer is your most powerful act of protection. You cannot follow your children everywhere — but your prayers can. Lift them up daily and trust God to guard what you cannot.",
                verse: "The LORD shall preserve thy going out and thy coming in from this time forth, and even for evermore.",
                reference: "Psalm 121:8"
            )
        ]),

        "Rest": TopicContent(category: "Rest", situations: [
            Situation(
                when: "When you feel guilty for resting",
                reflection: "Rest is not a reward for getting everything done — it will never come then. Rest is a gift God built into creation. Receiving it is an act of trust. You are allowed to stop.",
                verse: "Come ye yourselves apart into a desert place, and rest a while.",
                reference: "Mark 6:31"
            ),
            Situation(
                when: "When your body is exhausted but your mind won't stop",
                reflection: "Bring the spinning thoughts to God. He is not overwhelmed by them — not by a single one. Hand them over one by one and let Him hold what your mind cannot release.",
                verse: "He maketh me to lie down in green pastures: he leadeth me beside the still waters.",
                reference: "Psalm 23:2"
            ),
            Situation(
                when: "When you need to protect your margins",
                reflection: "Saying no to the right things is not selfish — it is stewardship. You cannot give your best to your family if you give everything away before you get home. Guard your rest.",
                verse: "Be still, and know that I am God.",
                reference: "Psalm 46:10"
            ),
            Situation(
                when: "When you need soul rest, not just physical rest",
                reflection: "Sleep can restore your body but only God can restore your soul. The rest He offers goes deeper than a good night's sleep. It is peace for the places that physical rest cannot reach.",
                verse: "Come unto me, all ye that labour and are heavy laden, and I will give you rest.",
                reference: "Matthew 11:28"
            )
        ]),

        "Sleepless Nights": TopicContent(category: "Sleepless Nights", situations: [
            Situation(
                when: "When you're up for the third time tonight",
                reflection: "God is awake with you. Right now, in the dark, in the quiet of this feeding or this nightmare or this worry — He is here. You are not alone in the 3am hours.",
                verse: "He that keepeth thee will not slumber.",
                reference: "Psalm 121:3"
            ),
            Situation(
                when: "When exhaustion makes everything feel impossible",
                reflection: "Sleep deprivation is a real and heavy burden. God sees what it costs you. He does not minimise your exhaustion — He meets you in it and promises strength for what today requires.",
                verse: "He giveth power to the faint; and to them that have no might he increaseth strength.",
                reference: "Isaiah 40:29"
            ),
            Situation(
                when: "When anxious thoughts keep you awake",
                reflection: "The worries that feel enormous at 3am belong in God's hands, not yours. He is working on what you are worrying about. You can rest — He is already on it.",
                verse: "When thou liest down, thou shalt not be afraid: yea, thou shalt lie down, and thy sleep shall be sweet.",
                reference: "Proverbs 3:24"
            ),
            Situation(
                when: "When you need to find God in the night season",
                reflection: "Some of the most sacred encounters with God happen in the night. When the world is quiet and you have nothing left — He has your full attention. Let Him speak.",
                verse: "I will bless the LORD, who hath given me counsel: my reins also instruct me in the night seasons.",
                reference: "Psalm 16:7"
            )
        ]),

        "Waiting": TopicContent(category: "Waiting", situations: [
            Situation(
                when: "When God's timing feels unbearably slow",
                reflection: "God is never late — but He is rarely early by our standards. The waiting is not wasted. Something is being built in you during this season that could not be built any other way.",
                verse: "Wait on the LORD: be of good courage, and he shall strengthen thine heart.",
                reference: "Psalm 27:14"
            ),
            Situation(
                when: "When you're waiting for a prayer to be answered",
                reflection: "Unanswered is not the same as unheard. God has heard every word you have prayed. His answer is coming — in His time, in His way, which is always better than yours.",
                verse: "But they that wait upon the LORD shall renew their strength.",
                reference: "Isaiah 40:31"
            ),
            Situation(
                when: "When the waiting feels purposeless",
                reflection: "There is no purposeless season in God's economy. He wastes nothing — not your pain, not your patience, not your tears. What feels like a delay is often preparation.",
                verse: "For the vision is yet for an appointed time, but at the end it shall speak, and not lie: though it tarry, wait for it.",
                reference: "Habakkuk 2:3"
            ),
            Situation(
                when: "When you need patience you don't have",
                reflection: "Patience is a fruit — it grows under pressure. You do not manufacture it yourself. Ask God to grow it in you through this season. He will. It just takes time — and that is the point.",
                verse: "But let patience have her perfect work, that ye may be perfect and entire, wanting nothing.",
                reference: "James 1:4"
            )
        ]),

        "Weariness": TopicContent(category: "Weariness", situations: [
            Situation(
                when: "When the bone-deep tired of motherhood has set in",
                reflection: "This is the kind of tired that sleep doesn't fix. God knows. He sees the invisible labour — the emotional weight, the mental load, the relentless giving. He honours what the world does not see.",
                verse: "And let us not be weary in well doing: for in due season we shall reap, if we faint not.",
                reference: "Galatians 6:9"
            ),
            Situation(
                when: "When you're too tired to even pray",
                reflection: "A sigh offered toward heaven is a prayer. God does not require eloquence from the exhausted. He hears the heart behind the silence. You don't need words — just turn toward Him.",
                verse: "Likewise the Spirit also helpeth our infirmities: for we know not what we should pray for as we ought.",
                reference: "Romans 8:26"
            ),
            Situation(
                when: "When you need strength for one more day",
                reflection: "You don't need strength for the whole year — just today. And today's strength is available. Ask for it. God gives generously to the mother who has come to the end of herself.",
                verse: "He giveth power to the faint; and to them that have no might he increaseth strength.",
                reference: "Isaiah 40:29"
            ),
            Situation(
                when: "When you wonder if it will always feel this hard",
                reflection: "Seasons change. This exhausting, beautiful, overwhelming season of your life will not last forever. What God is building in you through it will. Hold on. Morning is coming.",
                verse: "For his anger endureth but a moment; in his favour is life: weeping may endure for a night, but joy cometh in the morning.",
                reference: "Psalm 30:5"
            )
        ]),

        "Wisdom": TopicContent(category: "Wisdom", situations: [
            Situation(
                when: "When you don't know what to do next",
                reflection: "You are not expected to have all the answers — you are expected to know the One who does. Ask boldly. God delights in giving wisdom to mothers who ask.",
                verse: "If any of you lack wisdom, let him ask of God, that giveth to all men liberally, and upbraideth not; and it shall be given him.",
                reference: "James 1:5"
            ),
            Situation(
                when: "When you need discernment about your child",
                reflection: "No one knows your child like you do — except God, who knows them completely. Ask for His eyes to see what you cannot, and His wisdom to know how to respond.",
                verse: "Trust in the LORD with all thine heart; and lean not unto thine own understanding.",
                reference: "Proverbs 3:5"
            ),
            Situation(
                when: "When you've made a decision and need peace about it",
                reflection: "God redeems imperfect decisions made with sincere hearts. You sought Him and you chose. Now walk forward in faith. He is able to work through what is done.",
                verse: "A man's heart deviseth his way: but the LORD directeth his steps.",
                reference: "Proverbs 16:9"
            ),
            Situation(
                when: "When you want to grow in wisdom as a mother",
                reflection: "Wisdom grows quietly — in the Word, in prayer, in the counsel of trusted people, in the lessons pain teaches. You are growing even when you cannot feel it.",
                verse: "The fear of the LORD is the beginning of wisdom: and the knowledge of the holy is understanding.",
                reference: "Proverbs 9:10"
            )
        ]),

        "Worry": TopicContent(category: "Worry", situations: [
            Situation(
                when: "When worry won't let you go",
                reflection: "Worry is a conversation with yourself about a future only God can see. Redirect it. Every time a worry rises, let it become a prayer. You'll find yourself talking to God all day long.",
                verse: "Be careful for nothing; but in every thing by prayer and supplication with thanksgiving let your requests be made known unto God.",
                reference: "Philippians 4:6"
            ),
            Situation(
                when: "When you're spiralling over your children",
                reflection: "The same God who holds the universe holds your children. You can do everything right and still not control every outcome — and that is where trust begins. Give them to Him daily.",
                verse: "Cast all your anxiety on him because he cares for you.",
                reference: "1 Peter 5:7"
            ),
            Situation(
                when: "When what-ifs are keeping you up at night",
                reflection: "What-ifs live in a future that may never come. God gives grace for today — not for the imagined tomorrows your mind creates at 2am. Stay here. He is here.",
                verse: "Therefore take no thought for tomorrow: for tomorrow shall take thought for the things of itself.",
                reference: "Matthew 6:34"
            ),
            Situation(
                when: "When you need to replace worry with trust",
                reflection: "Trust is a muscle — it grows with use. Every time you choose to give a worry to God instead of carrying it yourself, trust gets stronger. Start with one. Just one.",
                verse: "Thou wilt keep him in perfect peace, whose mind is stayed on thee: because he trusteth in thee.",
                reference: "Isaiah 26:3"
            )
        ])
    ]
}

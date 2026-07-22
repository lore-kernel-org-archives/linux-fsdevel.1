Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A20F2D47F4
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 05:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784697576; cv=pass; b=a7pIqcWHY3FHPUiz9azOiOtiRQpuA8dBw+zpWTvEkm41N5eP3+80rS/4gbxIZ2U/4QdhBXurQ4aVn8IjlPDp5dF4i2xfuVh0VGO2juoemJpG3m2kAGxd9QacHf3Rg/0HpVgeRl5VZ9wx3LdB3xOtD4ZSXxAzIgffcwnR/K/qg6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784697576; c=relaxed/simple;
	bh=WcWRLAptzPgrLqPYiOKE8ufHxkI27abaURWOrkE7Yj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMDkVkW7G4SLIVwMygQNPHwKGW27VGul3zW9MfJdDqJZ6J5ui1K4egDdqHWEhCy9w4FRkbIgSOY2w4RaYyhdLRwHVqY87a1JuN8KPL4B0nEWTdItstkYmBMLjbfpLyiWkvJN2AwS4UqLevGQhu8Q7rqBfAAXs/9ueY3tgFhKA6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=helpoIyX; arc=pass smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="helpoIyX"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4896ae35be9so4948785b6e.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 22:19:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784697573; cv=none;
        d=google.com; s=arc-20260327;
        b=YMzh4ahERH3wAdLcUaLb4HViwmivqFVOfed8FBoCP6EQuKTJ48tT4QiOUXTDZB75L7
         VJyAgWScrnt4yfcsVT3v4kx+LkpYGCKoqBg4UeT2oa9F7UOR013jIBdL6WncdBgA0T2G
         qkS5krnjybnkXlHvecr3UQiF9/7fTL/vhW4QuhjI9RmM6FwpcY6EENaYMGvWslxWaj7M
         PA3ykCkmi4xUc4Qp+Zh+0Pps6hZE/3WZvzuz85YWCaw41DXUl1om8REah7l7Yl/67LUC
         AVqIU5Gh+TEgG85Z69jcaaiCZtBzBuEpbx/9HV34LGjBcFFIxjdMV8t+0nc1a1i5Vlur
         Eb8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A/Dqsl8H6IiKR42CBO5Hlc/3Xlc4zR+YmCj2cJHqBPc=;
        fh=Me7TS1moWW+T9ittf/QDtB1IjbxWPgrz3Q0sn4OWJEg=;
        b=Z7SF4osc52E9ulOghr4wUVasxw1uLK8Uhw0EZmdR19BxaJV/7RT/JWP68dnJyy5l++
         3eJcG0prAPOh47yIXp2wpDt59ZsPCPGcB21edQKBzfXSf56rUNOaRt1FYqpXmpS63LZs
         1hTMijpJedGf/tXHgr9dAF9EXlfA6maEI6PU6eDO2NuPnCd+wdWKGqK4Haqx32tt2u2O
         FLk1PIZOhx3MrvflhJg8h80/agAiSH/3vq77OXRZrKHL2rWLn/+bFsWzjdaBKKRaZOTI
         +df8JNRGKgBO/N3VybKSP5vm3tkn5JIj+bwtX2dAjRa+NjjLU3bap8jCUn+yuNwqHRIu
         eQqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784697573; x=1785302373; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A/Dqsl8H6IiKR42CBO5Hlc/3Xlc4zR+YmCj2cJHqBPc=;
        b=helpoIyX3TxOJvnh3ORh8HU0MWVzjbvskZb8eJOuWObpxOMZZ/Fej559whjGQiagLa
         LDVO2+YJ1QoOgJSJXjGwLoDBKUgfEBS0U1XAeM1aN0mAKWuNmSirmVCzASeV1tr3ELF6
         u/O82uCz/csFWXIy7BedhmrSZMPi+enT8tiBLuScUt9s18QqEyF2b7fRUW018gQgcm41
         dmkOvsVIbWRfK/kbEE+rw4Ja7H/mttIlJq1GKvDXVEOuZUaPj3uT3gK7pOEUE3fPja7C
         XfYPTdhBzoVkys7scS8A81OomEUIXOlafeC+XJP2qd+Im8SkPOqMLoAq04J3mHxBd7xD
         Lf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784697573; x=1785302373;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A/Dqsl8H6IiKR42CBO5Hlc/3Xlc4zR+YmCj2cJHqBPc=;
        b=jCEPGoSFQfyK/lvWUsJsllNdox6S1gyY4hRtsa4sClqhQL7S5EkWCCBbwkpCTF90Wc
         kSKv0JuYEWr9h7lUxlmdV1tR3aG/VYJyxZhKGJG9+vICYgXFWKRcdbhv9E/NdiwVNuzi
         cbLuSiDuTHNJ6raQxZERx88YQW2JLcR8vvxSywixDAHLK5anuyf+geL+csmYh91d7/m3
         Gvhzq48+QWoUhBmKS0H8ldl1F09MewJqGVh1z1n+5MFGAx2Z1TARujiY/RUh/HfGz5kf
         Jf0PmNvP/DgoIxZvOBs5hRDolwok6igLyVHJZKYqK+bSZ3wuNE4cDU6DF0xLGWHX/IUp
         bBdg==
X-Forwarded-Encrypted: i=1; AHgh+Rp3QUMmCjtmKTLXGw09uVuA+5pnNZCURyDusFl/iHfMIqHl6VBSLzWIJH4yybJbXPOkoZ0A3TsjXdhCCCBw@vger.kernel.org
X-Gm-Message-State: AOJu0YzyOTSa6dbsfzvbRegC1mhTCW0dD0WP9QcKFouDqJ2uS9A+5+Wx
	UTt7mW5lKOJGXNZpTDJYMQUUBJH45iRuGK3qME6yJoaIHBbtEu+YEqEoW6Q1RV2yuBIhZz6B8O5
	SRqWwCpm9q6sjXWphRfTUEevjPsKGdMLS/3uz
X-Gm-Gg: AR+sD11lV46N7nNHCM58mPiy4JTWVeH/HEbmDgCCyAs/J1GjUAx1Oydb0OAeWacrYaV
	VYoD63eO1Uwg4xuHfXAKc3j70na6kzolDDGucxxCtNTFlqK4jYxe2pg2lTTL92rS9Duv6E84ig/
	qVXxmpqoStmri5jQjq7TL9fJgR2UrJMcCEFl19Ft1brJtIQIQRXSVQUPAMhroTjS7j4yoO+pKW0
	YaKJM3GBAJ4xCjalzO3FcliO61sV34Bst+qdcHxnzeBk46uAHTTkQecUf0kFxoKQlPhg5I6aZBA
	YXE5
X-Received: by 2002:a05:6808:1387:b0:496:3a1:e44f with SMTP id
 5614622812f47-4a4d03443e2mr13023144b6e.6.1784697573231; Tue, 21 Jul 2026
 22:19:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+9F0A23jrHtcGc7gx=9hSCNmjwuDWYpzf-3+UR8ELCTt1bFCQ@mail.gmail.com>
 <CA+9F0A3uywPD8vk=O3Fg7LUgY9kYLtrNNLCcf-62k4RGrgQ5iw@mail.gmail.com>
In-Reply-To: <CA+9F0A3uywPD8vk=O3Fg7LUgY9kYLtrNNLCcf-62k4RGrgQ5iw@mail.gmail.com>
From: Farid Zakaria <farid.m.zakaria@gmail.com>
Date: Tue, 21 Jul 2026 22:19:21 -0700
X-Gm-Features: AUfX_mwSFVGUdsJ0Zv4hsTi507JmejWZd65i64gzIJZLoiyLc1PbY3VSOmHouKk
Message-ID: <CACCo2j=J0EQ7shObawP2Ra6LzJfPiG-wj2tgBVA+i+H=m6BWJQ@mail.gmail.com>
Subject: Re: Questions and concerns about BPF-selected interpreter
To: Cole Faust <colefaust@google.com>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Alessandro Di Federico <ale@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Third time's the charm. I don't see the email on the mailing list so
I'm not sure if it was delivered.
(Sending it again. Sorry for the duplicates if it made it's way
through; I'm having an off day with email I guess)

On Tue, Jul 21, 2026 at 5:26=E2=80=AFPM Cole Faust <colefaust@google.com> w=
rote:
>
> Correcting Farid's email.
>
> On Tue, Jul 21, 2026 at 5:24=E2=80=AFPM Cole Faust <colefaust@google.com>=
 wrote:
> >
> > Hi Christian, Farid,
> >
> > My name is Cole, I work on the android build system. We have similar
> > goals for creating hermetic and relocatable builds in our build system
> > (a custom, android-specific one). I was very excited when I saw Farid
> > working on $ORIGIN support, but then somewhat disappointed when I saw
> > the new BPF-based solution.
> >
> > Our usecase is mostly to decouple the glibc version used in the
> > android build from the host machine. We've had several instances where
> > our CI machines are running old glibc versions that cause problems,
> > and they're not trivial to update. Ideally you should be able to
> > download the android source and build it on a modern linux kernel,
> > regardless of the userspace.
> >
> > To register a binfmt_misc handler, you need either root + modifying
> > global state on the host, or to make a user+mount namespace. But if we
> > use a mount namespace, couldn't we just mount the interpreter we want
> > to use at a fixed path? I thought one of the main goals of this
> > features was to avoid the use of namespaces because they don't always
> > nest well; Farid called this out as a problem with buck2's sandboxing.
> > In android, we don't yet have any nested sandboxing but there have
> > been conversations about increasing security of the build using
> > something like gvisor to isolate the build from the kernel, in wake of
> > the recent AI-discovered local privilege escalations, after which
> > these complicated kernel features are likely to stop working. And
> > requiring root is definitely out of the question.
> >
> > I also wanted to ask about the security of this bpf solution. I
> > understand there are some security concerns about $ORIGIN. Why is this
> > new binfmt_misc + bpf solution better? An attacker will still have
> > more opportunity to place a malicious loader relative to the
> > executable. With the binfmt_misc solution, you will be able to only
> > have it active for certain things, like a build, but that's only if
> > you use the user+mount namespace to scope it. From what I understand,
> > Farid plans on registering the handler globally and persistently on
> > NixOS systems that want relocatable builds, does that not make those
> > systems susceptible to these concerns? (correct me if that's not your
> > plan, Farid)
> >
> > I can't really think of a better solution than the originally-proposed
> > $ORIGIN support for build systems to use. I don't care about setuid or
> > complicated filesystems like memfd, so I would hope it would be
> > straightforward to just error out if AT_SECURE is set or if any issue
> > arises like not being able to determine the directory of the
> > executable. IMO it's fine if it only works in simple, known-safe
> > cases.
> >
> > Thanks to both of you for working on this, please let me know what you =
think.
> >  - Cole

Hey Cole,

Thanks for the response. Funny timing since Alessandro, who've I added
to the email, also reached out privately and I referred him to the
mailing list [1]. You also might want to cross-post this there as it's
the original thread containing the use-cases and rationale if you can
speak publicly on the matter for Android.

Is the Android build system Blaze (I'm a Xoogler)? I think although
the namespacing can be funky, even with the BPF solution we could
leverage this at my current company (Meta) with buck2 to alleviate
problems with building against a single monolithic glibc that I am
excited about.

Very cool to here that you have the same issue as well; seems like
there is a more well-understood need to have the interpreter support
$ORIGIN than many think -- or at least that's the assesment from those
on the mailing list. [2]

I think the BPF solution Christian recommended and ultimately put
forward is technically very cool; the idea to programmatically hook
into binfmt_misc sounded cool although more than what's necessary for
the $ORIGIN support. It's kind of neat that's a superset of every
binfmt_misc solution out there now.

I'm pragmatic and appreciated Christian working with me towards a
solution. My idea was to hopefully get a more understood rationale for
the need for $ORIGIN by deploying it with the BPF, albeit in a limited
capacity due to the root privilege, to make a stronger case in the
future for something builtin.

[1] https://lore.kernel.org/all/20260722011217.45e79a08@spawn/
[2] https://lore.kernel.org/all/20260626172832.366deaac@pumpkin/

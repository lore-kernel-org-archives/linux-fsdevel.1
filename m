Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AA8470E8F
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 19:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784749185; cv=pass; b=F935nNDyiFYWc7azQZPIo/QUetbDPn7etiyyp+xL1I3cRjKg3Jv3XnaW6CtlP8b7ZmhC9s2OFMZCQzCcDOFoSz3LUFKpyNtrnbpAJqsj8Ehp9Vv+VCFAuP5FMHWXMf5wUqFHhYyzcSmFI/iSIcTBS3PubD/R+mqY8606OCuScPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784749185; c=relaxed/simple;
	bh=OHZkMhmOArYpBr1frnSI6PZjgaND1BXkj6Z8fUy24uY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gA0dsapJ+HmY+2OuhCqYP7TJB7KrENramFW2CLaPfNQDamlLFxxjYZlZIhVNJL7trd7/BS2Mf5F/1xotFkCUWMRH9aLY9XfhkrMHaivYfrkyVVnF88bNPktUdXD1VN3hCAC4Fcz8Oz5WzmOBXpk8qlIPnxbx5WJ6EqbN4kNKy4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NhlHVhbn; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NhlHVhbn"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c10e86e52so33211cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 12:39:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784749183; cv=none;
        d=google.com; s=arc-20260327;
        b=mXbfRm1pd7ZurxQ9nRL/uJD+l7S6787cbzwiBatyCKWicnbDp+NSqt44NedF1d6ph3
         hs7LbUZ7+Ep5Lyn/5E7HnqptQsCLuzHxvVuQb+RIqWl4SzSlWGRCAT/Te4W1KOo4nn5E
         qlBHN5CJpE/1TTgYw4ysLcSrbF7S2yE+3unZIRnzj5TSl41LlaOrmg6/map/K3XYtgVz
         0XfJB5tfB/JfKuMKir3Rc+MiFzgOIwvvIg2JqmRy7jY5IX5H42ibpaDuAyIhiGpld59f
         XpT12BdVgD3yrQASuHpNm2EzEC4YCIifhM2rcQ0dS22JnOGEQAFq6t/JfGwaSNb/J2eY
         echQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5qXbkgwSKDSabZuddI1CRIIDK1igNagvJjAJX2DjxXA=;
        fh=EQvtMep6j0M68ENN8XGA6fl/17O1G35JqVkOCBYoCeY=;
        b=W2GYVUwWDFPQq4o/Ie6CxTyN0HecTPWFuq+JGtX+ki2d5+mY/SawE+uC50vsSdbGJX
         cLJ4ciDVisre8FHZeaD1YpWHwms2LiDCBoYrI0BfPI56Evazq0tmLaLo8rDMx1/2r2o7
         x5H0lcNkUbATcHi3lHmpi1O3LghH0l54ysww+WFzWv/XEhaSqc/dGI3sDJE0BF9VJwtc
         hVtFRw8mq094ZxJN31ASEMvOp5gWUynQSbeBUGpqdcttiL7DewpAhmdty1DymB8OoI/D
         W6frTk36JMoXLon4jRJAKB/exovxC3pY8SlEFGofMWdDj5x6lF1LVg41CmhvUpQsMkXV
         7H0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784749183; x=1785353983; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5qXbkgwSKDSabZuddI1CRIIDK1igNagvJjAJX2DjxXA=;
        b=NhlHVhbnkcrwP5quRZYAo+1ApQXVnyq50YuYGYuxpqkEJI0kgxhCBdhdNqfH8MYjQw
         Vo8vhgPAK2ca45zRlEailgg9qGbZ1vAqQ+dvX7JqCDMrtU5UoOU6en2EPBlbC8B6tfLY
         q+d+nAQHHXMUDb/hPCX8nrqEf/KQzXXpG3JDLnM2akFsZjgtGuEE6Pihvx6Nbh+d3LZQ
         4da2K485sfoPzD3aTbhClvWSQ470K7USB1KczvO7wXxo8as3MWxcx011257XCiblYt9v
         YObHZHlOPXCRkG+QB73w3Gvn9BhkUmYkXlRt4VbPwEdb07o2gfQTFJv7x3vpt3bl6xFt
         AbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784749183; x=1785353983;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5qXbkgwSKDSabZuddI1CRIIDK1igNagvJjAJX2DjxXA=;
        b=d5Wv6nHL7CwwCH6GaJx66tE0cTyMZOoofM71DGdG3wAYZb6IzZpiINijjchgmUE0O2
         fP9I0pkjFJHjOryW7owyhsEjCWkxHnDuwK/iXZSRS6mnzyPbo/0gGyKuFz/8EGQRCmHe
         nfXH83cyr5XslnEHXXI9dUlNzxLdN0cN9/5Css1VvLvgFpSoxp6eW8mLNN56inlHLRes
         zbbCh2Ln1SglTJYLN/HaSFD0a+Uxh5tLRtBuit5857lHSLV/SA1+mawq4nBcrREpp7iN
         oOTeLfvYhieUFDL4hxC9vNsbJztGB8hSGi3dnq9Ijt/RarDH7+xm6ZPbQ/DI9djrtwzJ
         al2g==
X-Forwarded-Encrypted: i=1; AHgh+RqkssekJ2fc0NBX4s1R+Fe4imonUc2p2k31EvVzh+QiJRgIQkJSnfz8MDwD0TpnQyzayAiVqT9xLu5DpgKQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy7rPvlxRSqL4x5Slk1wSGBGEXgt+Xo4Waw0ZvJxSDaJjJbPRJ
	MOUT9A1d0csMkdBt1rk9CEnzuUAWlapiPeUt9neRdQ4mzxnkhtv86N6pDlcGoGeALnkoKsXta5v
	ssNDf/WCFyWNhMtUchIzxZA51viQJaL+qd8dWGKMNwW4aKBl4pR1CnRlS
X-Gm-Gg: AR+sD12kS1j5RLSRB22P/aE0PiGX/H6oHAhO6AyrK7n8DwvhqpcR4djF8tz6/rd7G2+
	8Ku7hN1DqZZk2/7LnOUYCxZ0oddOv8A/7aCnUIQ3Dvur8cQk5YTTE7HVDHUYegR8s0WlYq+l8Ru
	jFOZtb4VNPQm0Dz4b1HguUg2gyZNtBaitk54v36Fij+C20RSKuxgRn6xXTLgi0Fym80dh5FVziz
	ia4gVrpJkfHB3ZdISNJyqGQmg2fowh8kgxwwGsfjUAfOYt3Nmp+DasKHufc
X-Received: by 2002:a05:622a:a98b:10b0:528:3186:5799 with SMTP id
 d75a77b69052e-5283bac81a0mr1783231cf.10.1784749182226; Wed, 22 Jul 2026
 12:39:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+9F0A23jrHtcGc7gx=9hSCNmjwuDWYpzf-3+UR8ELCTt1bFCQ@mail.gmail.com>
 <CA+9F0A3uywPD8vk=O3Fg7LUgY9kYLtrNNLCcf-62k4RGrgQ5iw@mail.gmail.com> <CACCo2j=J0EQ7shObawP2Ra6LzJfPiG-wj2tgBVA+i+H=m6BWJQ@mail.gmail.com>
In-Reply-To: <CACCo2j=J0EQ7shObawP2Ra6LzJfPiG-wj2tgBVA+i+H=m6BWJQ@mail.gmail.com>
From: Cole Faust <colefaust@google.com>
Date: Wed, 22 Jul 2026 12:39:25 -0700
X-Gm-Features: AUfX_myVmpUNE7jKD5_Sguny5iQeXldWW1yhJMi41yT9lz-_votkWWRviCaWwCs
Message-ID: <CA+9F0A2-QAoGKRx28fvfO0kBuVgBCo3x2D7LN-MekTn6-kY8Ag@mail.gmail.com>
Subject: Re: Questions and concerns about BPF-selected interpreter
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Alessandro Di Federico <ale@rev.ng>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Farid,

No, the android build system is a custom one called soong. There was
an effort to migrate from soong to bazel (which is when I joined the
team), but it was cancelled in 2023.

Yes, I think $ORIGIN is very widely applicable for basically any build
system. And redistributable linux binaries in general, since the
kernel is the only stable part of linux, making apps that only depend
on the kernel would be very useful for linux app development.

The binfmt_misc thing is technically cool but seems to have limited
use due to its reliance on root or mount namespaces. It seems more
designed for system administrators than for app developers. Still,
it's a step in the right direction.

-Cole


On Tue, Jul 21, 2026 at 10:19=E2=80=AFPM Farid Zakaria
<farid.m.zakaria@gmail.com> wrote:
>
> Third time's the charm. I don't see the email on the mailing list so
> I'm not sure if it was delivered.
> (Sending it again. Sorry for the duplicates if it made it's way
> through; I'm having an off day with email I guess)
>
> On Tue, Jul 21, 2026 at 5:26=E2=80=AFPM Cole Faust <colefaust@google.com>=
 wrote:
> >
> > Correcting Farid's email.
> >
> > On Tue, Jul 21, 2026 at 5:24=E2=80=AFPM Cole Faust <colefaust@google.co=
m> wrote:
> > >
> > > Hi Christian, Farid,
> > >
> > > My name is Cole, I work on the android build system. We have similar
> > > goals for creating hermetic and relocatable builds in our build syste=
m
> > > (a custom, android-specific one). I was very excited when I saw Farid
> > > working on $ORIGIN support, but then somewhat disappointed when I saw
> > > the new BPF-based solution.
> > >
> > > Our usecase is mostly to decouple the glibc version used in the
> > > android build from the host machine. We've had several instances wher=
e
> > > our CI machines are running old glibc versions that cause problems,
> > > and they're not trivial to update. Ideally you should be able to
> > > download the android source and build it on a modern linux kernel,
> > > regardless of the userspace.
> > >
> > > To register a binfmt_misc handler, you need either root + modifying
> > > global state on the host, or to make a user+mount namespace. But if w=
e
> > > use a mount namespace, couldn't we just mount the interpreter we want
> > > to use at a fixed path? I thought one of the main goals of this
> > > features was to avoid the use of namespaces because they don't always
> > > nest well; Farid called this out as a problem with buck2's sandboxing=
.
> > > In android, we don't yet have any nested sandboxing but there have
> > > been conversations about increasing security of the build using
> > > something like gvisor to isolate the build from the kernel, in wake o=
f
> > > the recent AI-discovered local privilege escalations, after which
> > > these complicated kernel features are likely to stop working. And
> > > requiring root is definitely out of the question.
> > >
> > > I also wanted to ask about the security of this bpf solution. I
> > > understand there are some security concerns about $ORIGIN. Why is thi=
s
> > > new binfmt_misc + bpf solution better? An attacker will still have
> > > more opportunity to place a malicious loader relative to the
> > > executable. With the binfmt_misc solution, you will be able to only
> > > have it active for certain things, like a build, but that's only if
> > > you use the user+mount namespace to scope it. From what I understand,
> > > Farid plans on registering the handler globally and persistently on
> > > NixOS systems that want relocatable builds, does that not make those
> > > systems susceptible to these concerns? (correct me if that's not your
> > > plan, Farid)
> > >
> > > I can't really think of a better solution than the originally-propose=
d
> > > $ORIGIN support for build systems to use. I don't care about setuid o=
r
> > > complicated filesystems like memfd, so I would hope it would be
> > > straightforward to just error out if AT_SECURE is set or if any issue
> > > arises like not being able to determine the directory of the
> > > executable. IMO it's fine if it only works in simple, known-safe
> > > cases.
> > >
> > > Thanks to both of you for working on this, please let me know what yo=
u think.
> > >  - Cole
>
> Hey Cole,
>
> Thanks for the response. Funny timing since Alessandro, who've I added
> to the email, also reached out privately and I referred him to the
> mailing list [1]. You also might want to cross-post this there as it's
> the original thread containing the use-cases and rationale if you can
> speak publicly on the matter for Android.
>
> Is the Android build system Blaze (I'm a Xoogler)? I think although
> the namespacing can be funky, even with the BPF solution we could
> leverage this at my current company (Meta) with buck2 to alleviate
> problems with building against a single monolithic glibc that I am
> excited about.
>
> Very cool to here that you have the same issue as well; seems like
> there is a more well-understood need to have the interpreter support
> $ORIGIN than many think -- or at least that's the assesment from those
> on the mailing list. [2]
>
> I think the BPF solution Christian recommended and ultimately put
> forward is technically very cool; the idea to programmatically hook
> into binfmt_misc sounded cool although more than what's necessary for
> the $ORIGIN support. It's kind of neat that's a superset of every
> binfmt_misc solution out there now.
>
> I'm pragmatic and appreciated Christian working with me towards a
> solution. My idea was to hopefully get a more understood rationale for
> the need for $ORIGIN by deploying it with the BPF, albeit in a limited
> capacity due to the root privilege, to make a stronger case in the
> future for something builtin.
>
> [1] https://lore.kernel.org/all/20260722011217.45e79a08@spawn/
> [2] https://lore.kernel.org/all/20260626172832.366deaac@pumpkin/

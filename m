Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0473A383E
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 14:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776434958; cv=none; b=iocMloNNAjFDK8LykcjX8ffs6tXDEaMQv4HSOBRDci62WYYKlL801ATfx3lzmSqCUym/9/TNMnFKnFhPjvXLoHuGlYMBnYdVjtT0K1WqpRL7Gpi9d7jFDiKYYdvFd4khpIt3AB/gmQTVei01Rc8Z4AdKIIZJc8NFWIFSKXKEFho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776434958; c=relaxed/simple;
	bh=hDINANr2lOJehHhWpqIs2vMJtnPVOcOP7GCyF4OaGKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iojJQgvG+LWo0Vo0n2bI2FxfA3M2BcOpolmWZF9MAaCTbFaMEq32OiK1kKERe3qzOoVzx/RdfDhVKgSHIV8iJcCaPQJDSsSBob/YJAimoENU4ETUQlFiwk8XnypOQ3FsmEoqXDRwsriliR9oKBvMkhMOnzosiRI2wgcPPW4gYg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYAGvC4j; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYAGvC4j"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79ee5037d44so10516967b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 07:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776434956; x=1777039756; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RYPsDqc9ytAePTJ20Ne3zqUb8fDAuukERSfY3WHaxOA=;
        b=EYAGvC4j2gc320KPtDy7GR4LSTuEqbYEccwn4F+MWD96oNGpeHEkZ6lCUw/W98cl1X
         6HhoBqs2HxaU44ksYDWZST0OD4S8irBCn352sZ7H8T6yr8liRImsm5/6LXumUVAlwstZ
         Wj24xX9CpYIS7ZREB3sgOMPOOxAS+YnOBOaFpPDURj4KzlHuVVABaScbVdEY6L1uj+US
         qzmCLT15jRJL1a7yYidAtBmpqDG6mDfaO+/13J8jtzIvy7dNbi3+m5e0Yc9YMvEbGNVj
         i3TvuzuBbIQzuuMl12+5qSKpztNRBw02tgURv/u9TL7YcSQZmDOzLEJ+aMb0BMXmlAQT
         C9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776434956; x=1777039756;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RYPsDqc9ytAePTJ20Ne3zqUb8fDAuukERSfY3WHaxOA=;
        b=gSAUJsq5/nYiiNipEKKi3gOwqyxNWd3AeYDUQscg8pViDQHef9e7rL/xtBXuFiSPfv
         CW467BfnhAgPmMCRnDZhYsfho+nGFCIaAqAaae6SQHLX5t1992wot28UmwGvR58zd22H
         +5dQvKIVb/vFRQoLcwjWMZ/R5KX0WwAnP3mLuIQs6CSMnngV2SdpP3Nceug02xKMe/CW
         GC45r8gP8gPD7inWo6iV9nbGXQOWnInsQBD6yTvmZlYad48Ob/jB8piphyw9nLv+Uo6o
         S51AmmJkI2h8ouWSQAZxt0fjDjyFShkX/ShZgDTHAt7yaZYcUuQzZPZV+55hONua607c
         Sa5g==
X-Forwarded-Encrypted: i=1; AFNElJ/OBJMhBmEDLsLi/I0m17c9XlecCArgq1pUSQZHYG4DtiH1ctH87FqQOCAJlm+S4NfSP8KDyv3UDF6pSC/p@vger.kernel.org
X-Gm-Message-State: AOJu0YzxzeYNtXD2/t8hg+jt1oGaI0CfAx2NB9+fuDAQPd8fifoV/kfA
	S/tp6PTmLeK3ftxc00Ws7c5l6RpgM5fYB96Cv3dLEP3SfUJHiQbbaLuX
X-Gm-Gg: AeBDiesAlEfhZCikbXb6uoOpIaXu64/J/rhUuxe7SJMJXkw92nqcbgYAEdEj271LkYe
	EYiJw8mPxZzUZyV1qZ9AbhOgsaSAYs8/nWqhMbdUv3Beoz5xA5GRKm1Vbqi/1O+NOOsHBHzTPac
	U0h2PSBBDKLbiFgsxAzCVrHFk/R9KcfI+3pXF7VziQhG9WwVp/1Zsz2/IqkjO+okc1eMHKys7N9
	t1f8HkYrDpcuItJajr5VIBC0gRtY6wRSroPhzgDuWxBEdzoFB+tN8JIsvkOKn2T168rhFFBpQnC
	246x/FoFxDFL8Vhld80ZGpHu6IVPFsKlEwtFCPexzcJA8ZCbKG6rFKGZv1zkwMep9wZ55q0FFgU
	WdsyIt2fs8SVhQ3yZHLEfrkaRJ/fxPXO26vC1tbhQnA9ybO4/vvtB1M814tSCBrJ2vE8ySNOQka
	31Gi9J8bdhY/nWg0GJUok43KitHIeilEfe9xHUALiUuJWlm6X9PfFkRtRsYvzdbl56bcX0
X-Received: by 2002:a05:690c:f05:b0:7ba:a726:58ad with SMTP id 00721157ae682-7baa7266dc8mr830267b3.26.1776434956044;
        Fri, 17 Apr 2026 07:09:16 -0700 (PDT)
Received: from suesslenovo ([129.222.87.6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee99bb32sm6550297b3.30.2026.04.17.07.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 07:09:15 -0700 (PDT)
Date: Fri, 17 Apr 2026 10:09:13 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Song Liu <song@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	kpsingh@kernel.org, paul@paul-moore.com, mic@digikod.net,
	viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org,
	gnoack@google.com, jack@suse.cz, jmorris@namei.org,
	serge@hallyn.com, yonghong.song@linux.dev, martin.lau@linux.dev,
	m@maowtm.org, eddyz87@gmail.com, john.fastabend@gmail.com,
	sdf@fomichev.me, skhan@linuxfoundation.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 08/20] bpf: Add Landlock ruleset map type
Message-ID: <aeI_CXj6F-nI_DCL@suesslenovo>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
 <20260407200157.3874806-9-utilityemal77@gmail.com>
 <CAPhsuW7zzXXd6-d86B-rpGr-wfSzmEoCYNKhTMP_pXnybtA27A@mail.gmail.com>
 <aeFaQXkKNHFeE-oC@suesslenovo>
 <CAPhsuW648HdcCbXWMHaJ4uirPWq2WX3Ggx3AGMU6CGzhNYUREg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW648HdcCbXWMHaJ4uirPWq2WX3Ggx3AGMU6CGzhNYUREg@mail.gmail.com>

On Thu, Apr 16, 2026 at 04:47:40PM -0700, Song Liu wrote:
> On Thu, Apr 16, 2026 at 2:53 PM Justin Suess <utilityemal77@gmail.com> wrote:
> [...]
> > I don't think we can pass the FD number via a map, since the FD is
> > process specific. And it needs to be done in a way where we can lookup
> > the specific ruleset the FD points to safely.
> >
> > So we'd need some other way to load the ruleset from a file descriptor,
> > either through a new userspace side BPF call or similar mechanism.
> >
> > Is there some other common pattern for FDs --> kptr I can follow?
> 
> I didn't find an exact example like this. There must be a way to achieve
> this. In the worst case, we can add a kfunc for this.
>

I think new kfunc is a doable approach. I could make a kfunc taking a struct
*task_struct and an FD that looks up a landlock ruleset within a given
task that returns a trusted kptr.

Something like:

struct bpf_landlock_ruleset* bpf_landlock_get_ruleset_from_fd(struct
task_struct* task, int fd)

And tagging it with KF_ACQUIRE + KF_RET_NULL.

Then keep the existing kfunc for putting the ruleset and enforcing it on
a struct linux_binprm.

The BPF program would need to get a reference to a task struct
of the program creating the rulesets with bpf_task_from_pid for
instance. Then they could use the task_struct with another plain integer
map to store FD numbers and then use the rulesets or store them in a map
of __kptr objects for later usage.

Would this be more acceptable?
> > Basically the pattern I need is userspace must create the file
> > descriptor, BPF converts that FD into a refcounted kernel object, and
> > even if userspace closes the FD BPF needs to hold a reference on the
> > underlying ruleset structure.
> >
> > (In this patch this was accomplished through the map_ops)
> >
> > Let me know what you think Song. I do understand the benefit of having a
> > __kptr instead, the refcounting is all there, and it would allow storing
> > rulesets in multiple map types. (and one less map type to maintain).
> 
> A new type of map for each FD referenced kernel type is non-starter.
> It is impossible to add UAPI for a specific use case.
>
You've convinced me. I could see a lot of problems if everyone wanting
to add their specialized maps, it would be difficult to maintain.

It's probably best to keep the specialized map types to core kernel
interfaces only that are unlikely to change.

> Thanks,
> Song
> 
> > Mickaël, do you have any thoughts on this? I have v2 basically ready,
> > although it uses the BPF_MAP_TYPE_LANDLOCK_RULESET it changes a lot on
> > the Landlock side.

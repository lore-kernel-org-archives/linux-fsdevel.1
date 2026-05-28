Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E3F2D94AB
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779990778; cv=pass; b=AxogGWe5EtkPJC2RKXCyEnWqjqLB1arMbyX3MoTtSBY7YnfcG1XdNlJLqikn82xy40wR/6MqwMc3hkVRx4jAi+zggHC5gPcfVPPNASZuCSfD9w36wa4ZwUB8XAGbSftGVMDFWOwMsR1QWbanrw0xCtVSD9D/xDCkE0wNRawlRIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779990778; c=relaxed/simple;
	bh=XbgGr1DpJBD+dLwd/tCfxcgTz4CXLxEN948SQO9+BFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eAMWOKdCDAv08tgxioMVZ5mbJOxQ6a3zIGzLhF/KhRQBWHdPzoWqdYmnkYIMe7jB7h4SctIiYzYfgqNGmoLcq/f8U5Zmu0iG3CHYMrJgfv/7ntMAntqfgDfxTCM9FxTgjtwoHgb0b5dCtnd+7MsqowFQf4LWhjKRZRccYKpr0ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NOP4IgGB; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOP4IgGB"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-68ae265815aso1867705a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 10:52:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779990775; cv=none;
        d=google.com; s=arc-20240605;
        b=dzfAgfbLGxx7ivOVT5QoIJoOSvw6Jx7/n8Lb5NxwBuGzMSgHzdue+CfcssRqUJwyxG
         oSjw4a4aNIyATyPozF4TO1B1k+pksI5dZaE7Ko87VJeb1gjFuh4Q52SZGe/fmnYEKXVO
         /6L02F6jaElAncfp7HZPksaOL0nUmJXGgi62S2XgDu5JM7qDZ3lKFECsLMhzKR4XSmAV
         wW/fKkBkgnP20zRjCwL7iZfY4J48Hx13id3d5X/iK+Fs2Hc72tOjp3aXPaqvl5uRbZJQ
         K8AKJhfUlxM//frHqmrUoIcp2/eGZnkhwgwkvSi400p0iMxkXYviMpBrwEjExheivJxF
         Imvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g0aHJDWEh8MAC+JnPqZMh4NdnKpqE7oTWoNo6RnV35k=;
        fh=+pTBIy/Mqnzfj49wKtUbgkk8MYOcNmGXZg8kSitrFq4=;
        b=j5jvr6iwDrxCPfiMMPhBfHr4kIrJ2A5TghQSzb9lbg+xe1YIrJ2ZqFwHPOOBxLkLCp
         MM4rBxrpyTGWYlR/lekGyIh1FQpvKRWbVS1RLYuy+Zz5Ksv34yyuJ322EI7XumNPkey/
         zmYYRo6UsLfrpYp3QlObHHCWSYfy6izKh4L6w4JdiUAEyJlUV9ym36y8bSsVfP0XR91R
         K8uohiJr6wh0V9iukhhYT6rQOdFV/gAQGlaHcNLBp92aVA8L+3MeogqDWe8ZUgGQMavj
         IwnfGsspyPwLGS3mAH7i7vTkJ6w2UWwaOMumVY+vmb0oEYFpIYyetYXDTglmQnHdEfTX
         OdYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779990775; x=1780595575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0aHJDWEh8MAC+JnPqZMh4NdnKpqE7oTWoNo6RnV35k=;
        b=NOP4IgGB8HkFf+gYSuCtZgnUd990S1kRwSVI5nPqwwmRw7MRFsbzb7mXurhhIe55UK
         dC2y/cATh7wnpdJdRi6TBBDTyXSkXK9g35pQ7l2c5wd3bMeN/WIPLHX0onJLebk7GGI7
         8GPXScoy36z9F1NW4RhaJdWXFQEupAaPGOSbhyMPRu4wrJFctIZhqhG0a6WlnsHPm+kA
         DFnv/1hetk8BIpExbtlDWOn+K5xeIX2sOw4y4CBzgGSQU/TYLKnn6BVo4Nznq050ByVO
         O1euzykuKH4cMpTCxRpz3PcT1H4oBxaV1bG0Tq6gQHSiE/TXAQSybem2Jwto64+CrK0g
         BL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779990775; x=1780595575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g0aHJDWEh8MAC+JnPqZMh4NdnKpqE7oTWoNo6RnV35k=;
        b=ZQf7PTYvaG7oIEHuDa4h/aT8Or8NeXfYDJEq7h1CGunOs9U3nWL5xsX8L2bfFhkbNF
         DndmUAb+eb4ckRKEPCgN8PfoKgWsUtuZKx0XZ6hkU2ZSW08SnebMNbJv81CEZ3Wk4Z2P
         Aefe5joSnjsmIRO9dikjfOvNPk2jl1eAse6IHljg9bZkcR2KQ1ZvTm8KbYY50xRW772V
         sHkgN7dX+NR+VLkIN5NmtDv0XQUw8kaGPRBV88ITCwPTmJWY7LImggo8WcKBxU8TuLbU
         Dw98V2Jwk7CtUoNAffe+WmDg7819qe/vfdpm/7e6R+oOpsXgZUe7iOzRF3QNyLEo4ZoW
         OkCQ==
X-Forwarded-Encrypted: i=1; AFNElJ+22L99z/sj9jlmwpI3Jdeiu9TiJHDsHpR48OXWl/ged6Fe+qTKYc/kcTcTIIBgytSxVia2tkZjTk6s2hf1@vger.kernel.org
X-Gm-Message-State: AOJu0YxrBxbsargf2VlcurAv4GUFdz+9SWHhSYIjyHjKLA4ZiiXoYb3a
	9tnfuSSQQLbzxoMAFNqWse4OBYxMIpGbUbw8HTgtt9XU1n0w6lxwX/wYkQYj3jlOs9U9XG9z010
	XCYoD7ykTV+Y0NilIz7nEFdIB3rt9Q71PM26KUMg=
X-Gm-Gg: Acq92OEPZfn2SWyaKxhNrLkBOTsSSVsLYfH782+7KDbYWIriP7OZTxTePg/+f6uE0yB
	4UqiTGHfIxtJnoDZNooJfOGZ81LXBa9qIH9WB6LCkAcri154nmxwZBg/fMpZCTW4ZzkP9mCvPQY
	Cwa8dLrSbFrNJ5oAVMSVHsKcIoXrOVpeKyiqS6raUE96T80JIEkA7fNdBvk9jsLckJgKiUGSgJZ
	DNDlj+c9Z+Y/3ryuIlK6x9A/tVQM9lrH8meACCIQbJe4hheeD9yefeWgtyY4qCgbrW+oN/oPzjw
	pPRV1XOzPj+55LxmT1AsrLcS3bPGgEcw/rYomVeR4B6L7JGuEbl7
X-Received: by 2002:a05:6402:42cc:b0:683:75ec:c17c with SMTP id
 4fb4d7f45d1cf-6889c4464afmr16787030a12.10.1779990775000; Thu, 28 May 2026
 10:52:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424170503.2096847-1-amir73il@gmail.com> <20260424170503.2096847-8-amir73il@gmail.com>
 <ulal5iiolonkeccun5lyzkuf73odidgbkmabzupbwtawwjhhlz@tneaqqtlody6>
 <CAOQ4uxjO+Q_Z0OF4XquO7o4GVF2b3akRDrLYadtUNpZzi8nEsQ@mail.gmail.com> <cz26vtfw5xq3hi7lv6guec75untdqrtqx5violro7ymefxduqy@ajieh3qai7xr>
In-Reply-To: <cz26vtfw5xq3hi7lv6guec75untdqrtqx5violro7ymefxduqy@ajieh3qai7xr>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 28 May 2026 19:52:43 +0200
X-Gm-Features: AVHnY4KZrbZU7Bseb3jhjOT3YJ0ZDv_4qm04w0NGvjdB8EY5kC_XOhnvkry-VaM
Message-ID: <CAOQ4uxi93n7beP20Lt865hGotZA-=2Kvuc=rMA+H+gwbQaWOAg@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] fanotify: gate fs events checks in
 fanotify_mark() by group type
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 1:05=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 25-05-26 14:52:46, Amir Goldstein wrote:
> > On Mon, May 25, 2026 at 1:28=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Fri 24-04-26 19:05:00, Amir Goldstein wrote:
> > > > fanotify_mark() has plenty of checks on the event mask.
> > > > The event mask bits that correspond to filesystem watchers are only
> > > > meaningful in the context of filesystem group type.
> > > >
> > > > Hence, before checking if event is a specific event (e.g. FAN_FS_ER=
ROR)
> > > > need to check that the group type as well (e.g. filesystem).
> > > >
> > > > Add helpers fanotify_test_{fs,ns}_watcher_event() and use them inst=
ead
> > > > of checking the event mask directly.
> > > >
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > >
> > > I was looking into this and thinking about it for some time and I hav=
e one
> > > brainstorming suggestion:
> > >
> > > > +static inline bool fanotify_test_fs_watcher_event(struct fsnotify_=
group *group,
> > > > +                                               u32 mask, u32 test_=
mask)
> > > > +{
> > > > +     return fsnotify_is_fs_watcher(group) && (mask & test_mask);
> > > > +}
> > > > +
> > > > +static inline bool fanotify_test_ns_watcher_event(struct fsnotify_=
group *group,
> > > > +                                               u32 mask, u32 test_=
mask)
> > > > +{
> > > > +     return fsnotify_is_ns_watcher(group) && (mask & test_mask);
> > > > +}
> > >
> > > These helpers look a bit cumbersome (having to manually select the ri=
ght
> > > one, there's no safety if you accidentally pick the wrong helper, you=
 need
> > > to pass the group as well, ...). So I was thinking about the followin=
g: In
> > > fanotify uAPI the mask is actually 64-bit. What if we carve out some =
bits
> > > from the upper word (8?) and store the group type there? Either we ca=
n do
> > > this type-encoding only internaly once we receive the mask from users=
pace
> > > or we could even have the encoding in uAPI constants as well - which =
would
> > > provide additional uAPI constant type safety (we'd have to special-ca=
se
> > > FAN_MNT_ATTACH & FAN_MNT_DETACH in that case but that should be doabl=
e,
> > > since they are not widely used yet we could maybe even eventually dep=
recate
> > > the old values).
> > >
> > > Anyway, once we have the type encoded in the 64-bit mask we can easil=
y
> > > compare, mask, combine, ... these with some helper functions without =
having
> > > to check the group all the time and having to select different helper
> > > function based on event type. We are not very consistent with passing
> > > 64-bit mask everywhere since the fsnotify core has only 32-bit mask a=
nd so
> > > far we use only the lower 32-bits in fanotify as well so that would n=
eed to
> > > be fixed.  Also once we store the mask into the mark, it would be squ=
ashed
> > > down to 32 bits but I think that's fine.
> > >
> > > What do you think about it? Do you find this worth it? What's your op=
inion
> > > on having the type encoded already in uAPI constants?
> >
> > My opinion is that I had already started playing with that, see:
> >
> > https://github.com/amir73il/linux/commits/fanotify_event_type-wip
>
> Cool :)
>
> > --- a/include/linux/fsnotify_backend.h
> > +++ b/include/linux/fsnotify_backend.h
> > @@ -78,8 +78,10 @@
> >
> >  /* 64bit kernel internal event hint flags */
> >  #define FS_EVENT_IS_PERM       BIT_ULL(33)     /* Wait for user respon=
se */
> > +#define FS_EVENT_ON_NS         BIT_ULL(34)     /* For namespace watche=
rs */
> >
> >  #define FS_PERM_EVENT(mask)    (FS_EVENT_IS_PERM | (mask))
> > +#define FS_NS_EVENT(mask)      (FS_EVENT_ON_NS | (mask))
>
> I'd prefer we have couple bits reserved like:
>
> #define FSNOTIFY_EVENT_TYPE_BITS 8
> #define FSNOTIFY_EVENT_TYPE_MASK (~0ULL << (64 - FSNOTIFY_EVENT_TYPE_BITS=
))
>
> And then allocate different types (FILESYSTEM =3D=3D 0, NAMESPACE =3D=3D =
1, ...)
> from this in an enum fashion. This is much more efficient on bit space th=
an
> just event flags.

Wow, 256 types. What a rich future ;)

Note that I also considered flags (FS_EVENT_IS_PERM) as part of the
event definition - those would control things that are common to all types.

>
> > @@ -136,7 +138,7 @@
> >  #define ALL_FSNOTIFY_FLAGS  (FS_ISDIR | FS_EVENT_ON_CHILD | FS_DN_MULT=
ISHOT)
> >
> >  /* Kernel internal 64bit flags */
> > -#define ALL_FSNOTIFY_KERN_FLAGS  (FS_EVENT_IS_PERM)
> > +#define ALL_FSNOTIFY_KERN_FLAGS  (FS_EVENT_IS_PERM | FS_EVENT_ON_NS)
> >
> >  #define ALL_FSNOTIFY_BITS   (ALL_FSNOTIFY_KERN_FLAGS | \
> >                              ALL_FSNOTIFY_EVENTS | \
> >
> > ---
> >
> > TBH, I don't remember whether I was discouraged for some reason
> > or if I had started to question the value of this
> > or if I thought it was better to send the simpler version first.
> >
> > Anyway, I am fond of this approach so I will give it a try.
>
> Thanks!
>
> > I went back and forth about exporting this explicitly in uAPI and
> > require that all fanotify_mark() calls on namespace objects
> > (add,remove,flush) always carry the explicit FS_EVENT_ON_NS
> > flag and/or in the outgoing mask.
> >
> > or that they are defined as:
> > #define FAN_NS_CREATE (__FAN_NS_CREATE | FS_EVENT_ON_NS)
> >
> > Also if we do that, we need to think of the least ugly way to handle
> > FAN_MNT_ATTACH & FAN_MNT_DETACH.
>
> These are good questions. After thinking about this I think the most
> convenient would be if:
>
> * Type was already included in the defined event constants
> * Type was included in the reported outgoing events
>
> That way you can combine events constants like EVENT1 | EVENT2 | EVENT3 a=
nd
> get a valid input for fanotify_mark() or a valid mask. For checking you'd
> have to do received_mask & ~FSNOTIFY_EVENT_TYPE_MASK & (EVENT1 | EVENT2) =
to
> check whether any of these events was received which is bearable, mask =
=3D=3D
> EVENT1 would keep working.

When you write "you'd have to do..." meaning all the applications need to b=
e
educated about this and we need to expose FAN_EVENT_TYPE_MASK
in uAPI.

I guess we should provide

#define FAN_EVENT_MATCH(event_meta, event_set)

The risk of a programmer doing if (event->mask & EVENT1) exists,
but not much more we can do about it.

>
> I've checked and FAN_MNT_ATTACH / FAN_MNT_DETACH already got used in a
> couple of places (stress-ng, util-linux, ...) so the only realistic optio=
n
> I see at this point is to define FAN_MNTNS_ATTACH, FAN_MNTNS_DETACH with
> proper type info included and automatically morph FAN_MNT_ATTACH and
> FAN_MNT_DETACH into FAN_MNTNS_ATTACH and FAN_MNTNS_DETACH, respectively i=
n
> fanotify_mark(). When morphing we'd have to set some group flag to disabl=
e
> reporting of type in outgoing events as well and make sure FAN_MNT_ATTACH
> and FAN_MNT_DETACH cannot be mixed with any other properly typed events i=
n
> one group.

Seems manageable.

>
> I also considered an option to explicitly define a group flag that
> userspace can set to enable verification of types in fanotify_mark() and
> reporting them in outgoing event mask. This would be an option as well bu=
t
> so far it seemed somewhat more confusing than what I suggested above (whe=
re
> I expect people to transition to properly typed events faster because
> otherwise their functionality will be restricted).
>
> Of course there's still the question whether we want to expose types in t=
he
> uAPI at all but I'm slowly leaning towards yes to make it harder to use t=
he
> API wrongly.

I see no value in opt-in for verification of types in fanotify_mark().
opt-in or -out for the outgoing mask - maybe, especially since we need this
internal flag anyway for FAN_MNT_*, but I am also leaning against it.

Anyway, with no end users to nag me and summer vacation getting close
it may take me some time to post v3, so if you think of any new ideas
there is still time to bring them up.

Thanks,
Amir.

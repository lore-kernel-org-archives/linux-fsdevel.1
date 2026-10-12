Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4664483B9
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 09:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791796815; cv=pass; b=T1tVHZtEzvUbdDC5WbPSlCwg0rSeHZv2CsZKOSPyePWj/5e7p9kkUl7IZJtgM3psSrucXANoBytDqnbgfW9u1jx8dFS/65UhaPoDn8Bm6SsOtGG9ksBhnW0c0ID62eSORIDa2ybrlf39UsdPlyx59dx3gJUqxlCtCMXdziVjMMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791796815; c=relaxed/simple;
	bh=rZYWKO97THLwlm7b2mKQ1zQaKFQpv4oQ/zqxgHBBBew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emkzsDR3YtUChjV3MjPqpY09V7bSB/7YH1ToeLmSlV/T/pQi2sRNKxaMhIVswclkCfk9tp5Annu+S+baoKOHboKks/lmToktrF/r284leVAtvLUK0ttI9YiSasJAhp9LzV2DOz83zcWBmSXvH1pSsJHN6mUJR56BmWb4Qxy/Zlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrOmqb21; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrOmqb21"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c2e8e738ae0so261908966b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 02:20:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791796811; cv=none;
        d=google.com; s=arc-20260327;
        b=dOPlFj3tLMO1tl5T9U13/woZiB+qfykHDTUqut2qdvG6nGuoj6R17GWpQJpnGd9Txa
         hXgFgf2ZVEWdtPHbZ9Uyl4Jz5gsFUjY6/vrzvpVdjtuUeJrUGdI5ItGB6RtU+o9Bv8B4
         1qVqbGhkgSl3ru8Bd5PrI4DwjJuwHogmZxoA3rBdhEVGbXQ4t+oCBtn+cfhiA4gphsnX
         h+HauWvSHDHafE2FEh5nhy4wOcrfgUmRJJT82iF4u32covyxD6afBkctUZEIg4Q+PO0H
         w+p+ppITBV7iqkLqrPYL2403+xcqTcMN3Ppa7DK5t4Lw6DjXEXcx5a8lAfsG8zSSLe4O
         JywQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aifZSW8ey3FHVcSBApv2HUaNCWq6JON3I12TVQmAsTo=;
        fh=DUTOZy2erlYIAUP2J2Ll6A4f7ZniasKFM/6DdGEB1p4=;
        b=PKTGNIWnDUwrWyH69yaMtNpyyOyOBF+TGijqczkVSQm+vL6syjc0hQrpibWFEzEwt4
         E9nA4Wn+MMBXLCvOZQVouW0kFUVuzVgWIGxcPvMD/XtqwWiAfzDjZfkfhM3nn3nLNA6S
         lJqPNxwN35HjnNqxV7SzNawSN54N9sP/DO75lv+M65Rto2kcCp4R4XE2sRukeS0Y8+tB
         kuNC/8PjmJkZeJsZLm5OY2RvvcK1h+DOWETVszX19UpiOeUM2TeJtP62BI7jp3DhNpiW
         dULCvmunO3wR3iNW1YM5P0aW9tEdKBfDIo8K6r9t6vRfL+Ls2qStuva67jkEZaj1Ezct
         AzQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791796811; x=1792401611; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aifZSW8ey3FHVcSBApv2HUaNCWq6JON3I12TVQmAsTo=;
        b=JrOmqb21NiWt/8fJEvImzolYK71JApAexnM9foGJ5e5w0Y3Z0webwtNYP2Ag3JdJry
         5xHq/XI/j4Rr0ubwsb8Fb4ZS5RQxDAcFVrbbH4i0ZHs9LJfAJCMRd0BiVWAdFz7YYss7
         TYfqYI1hsJCtU5IgPhbwJH2+zpf27rzrX6OEoVIEnUaw7ZV+5oySU3twnExd4ZRYg5Yw
         OmITA16eveg7AhrckEi46aspphQen9zuZ/vOPdGRGJkRyUi4YPjwmSXLGRHg8Ke//3kD
         U+6BaTFaLAXVpbLqpk1JVbe8f5U80Bgzw/HUsjGvEEJSP0XO8vzTztFkIeinCHKg0xE4
         TvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791796811; x=1792401611;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aifZSW8ey3FHVcSBApv2HUaNCWq6JON3I12TVQmAsTo=;
        b=P5XI+Ggm4Ccl9Xoh+3M/EpAVCYa172QrGzbMxe7tfFr09dmbW/0mYHsPQW+RtoK0qS
         ia22NEZyZSk96LpyjEesECoDCSPW8WWAvCpkVsOgQOX7zecb6+orSJy/cJZeZ1KSvtQB
         z89mqSdE5afIPpLzAW9rWKGOOLKNGSosTkggaJ/z/Q/KeJlVwunGYDeJFDGxFBT+nzX6
         wm7DeVbwDoylReDLZ2c8tGigpXDhKVb599ud/PmFtLd4fHsMop1+5fcXhQAqCq7LGPgF
         H3LM0lYvhBH6pmsJTUH3xDa6vnI0RjmsuuWYUN9Zb38lz1iDOQ/AEV7M6EJLDWXwwBx3
         0FGw==
X-Forwarded-Encrypted: i=1; AKwUvBwv8EASSfa011sEyyG3IBgmx4UjzktB9e42R9hhJmPemkwDwXzCGbzFYcpn/DqVbi48SGtnHkkEoE6rMUa8@vger.kernel.org
X-Gm-Message-State: AFq9FYJFKiaTrjWxxOk1MC6epSVv/lqdB09PEid4TqRjxYMW3LSvFQR5
	HcvJTmP2/t0sd+eYih33nC9JB7DVF3qrqIcYlvTlY2Q/vTeT7VNnaD16fHGMWkyXs6y/7WV9+9J
	tp4XDsCtFKF0TTcdItkp9/Awq8kvFqQbLLHv3f+M=
X-Gm-Gg: AYBFou0l29lR8b/cWO2c02/INfwiArU/IvGKyXrOJfuNCLO6ism0nHOVYBdIu3YQaWh
	zxqtRdABbwWP+TeLVCU5KYnUD6635/bgOy0oGdKdZCaEfP3eitiqarBGhe2mi9BRw9cQ9bcBJvV
	5oNXoZbe8/5vWQD8l8uvXaA9sEAQIq8dqcMPuk6G+PqKUCfb+ve9+EOtN7/4Qj3IX8God+snvs8
	fiHSNK16JPOZ49hK8V0thzCYZ7furrKs3D4akiNp91yQdCs5ti4FBbdBMlYIuVusp5CT+X0LA9H
	nPUX7y0upZ4IZRKF83ks4ol7t+3BhxGpY5qmM9XkcueBzpUaQcxnZIyO
X-Received: by 2002:a17:907:d89:b0:c2e:42e:4da0 with SMTP id
 a640c23a62f3a-c31a9d0df2bmr973104966b.19.1791796810497; Mon, 12 Oct 2026
 02:20:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424170503.2096847-1-amir73il@gmail.com> <20260424170503.2096847-8-amir73il@gmail.com>
 <ulal5iiolonkeccun5lyzkuf73odidgbkmabzupbwtawwjhhlz@tneaqqtlody6>
 <CAOQ4uxjO+Q_Z0OF4XquO7o4GVF2b3akRDrLYadtUNpZzi8nEsQ@mail.gmail.com>
 <cz26vtfw5xq3hi7lv6guec75untdqrtqx5violro7ymefxduqy@ajieh3qai7xr>
 <CAOQ4uxi93n7beP20Lt865hGotZA-=2Kvuc=rMA+H+gwbQaWOAg@mail.gmail.com> <u4wnn46chae6helb5yuqw2eqjxux6plmyffxilisxnuiuyhyyh@mq7rahg3g5fq>
In-Reply-To: <u4wnn46chae6helb5yuqw2eqjxux6plmyffxilisxnuiuyhyyh@mq7rahg3g5fq>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 12 Oct 2026 11:19:59 +0200
X-Gm-Features: AclHuK8M3ZzBzyuPKTYnheU1y5q1_cr4wAxpzHdHFHVMqTrOTmX_46qMnSuVEmM
Message-ID: <CAOQ4uxi4x+K7LNS07Z9raB6u5toYUXap22UFNDnz-yw9mRC7QA@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] fanotify: gate fs events checks in
 fanotify_mark() by group type
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 12:06=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 28-05-26 19:52:43, Amir Goldstein wrote:
> > On Thu, May 28, 2026 at 1:05=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > > On Mon 25-05-26 14:52:46, Amir Goldstein wrote:
> > > > On Mon, May 25, 2026 at 1:28=E2=80=AFPM Jan Kara <jack@suse.cz> wro=
te:
> > > > > On Fri 24-04-26 19:05:00, Amir Goldstein wrote:
> > > > > > fanotify_mark() has plenty of checks on the event mask.
> > > > > > The event mask bits that correspond to filesystem watchers are =
only
> > > > > > meaningful in the context of filesystem group type.
> > > > > >
> > > > > > Hence, before checking if event is a specific event (e.g. FAN_F=
S_ERROR)
> > > > > > need to check that the group type as well (e.g. filesystem).
> > > > > >
> > > > > > Add helpers fanotify_test_{fs,ns}_watcher_event() and use them =
instead
> > > > > > of checking the event mask directly.
> > > > > >
> > > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > >
> > > > > I was looking into this and thinking about it for some time and I=
 have one
> > > > > brainstorming suggestion:
> > > > >
> > > > > > +static inline bool fanotify_test_fs_watcher_event(struct fsnot=
ify_group *group,
> > > > > > +                                               u32 mask, u32 t=
est_mask)
> > > > > > +{
> > > > > > +     return fsnotify_is_fs_watcher(group) && (mask & test_mask=
);
> > > > > > +}
> > > > > > +
> > > > > > +static inline bool fanotify_test_ns_watcher_event(struct fsnot=
ify_group *group,
> > > > > > +                                               u32 mask, u32 t=
est_mask)
> > > > > > +{
> > > > > > +     return fsnotify_is_ns_watcher(group) && (mask & test_mask=
);
> > > > > > +}
> > > > >
> > > > > These helpers look a bit cumbersome (having to manually select th=
e right
> > > > > one, there's no safety if you accidentally pick the wrong helper,=
 you need
> > > > > to pass the group as well, ...). So I was thinking about the foll=
owing: In
> > > > > fanotify uAPI the mask is actually 64-bit. What if we carve out s=
ome bits
> > > > > from the upper word (8?) and store the group type there? Either w=
e can do
> > > > > this type-encoding only internaly once we receive the mask from u=
serspace
> > > > > or we could even have the encoding in uAPI constants as well - wh=
ich would
> > > > > provide additional uAPI constant type safety (we'd have to specia=
l-case
> > > > > FAN_MNT_ATTACH & FAN_MNT_DETACH in that case but that should be d=
oable,
> > > > > since they are not widely used yet we could maybe even eventually=
 deprecate
> > > > > the old values).
> > > > >
> > > > > Anyway, once we have the type encoded in the 64-bit mask we can e=
asily
> > > > > compare, mask, combine, ... these with some helper functions with=
out having
> > > > > to check the group all the time and having to select different he=
lper
> > > > > function based on event type. We are not very consistent with pas=
sing
> > > > > 64-bit mask everywhere since the fsnotify core has only 32-bit ma=
sk and so
> > > > > far we use only the lower 32-bits in fanotify as well so that wou=
ld need to
> > > > > be fixed.  Also once we store the mask into the mark, it would be=
 squashed
> > > > > down to 32 bits but I think that's fine.
> > > > >
> > > > > What do you think about it? Do you find this worth it? What's you=
r opinion
> > > > > on having the type encoded already in uAPI constants?
> > > >
> > > > My opinion is that I had already started playing with that, see:
> > > >
> > > > https://github.com/amir73il/linux/commits/fanotify_event_type-wip
> > >
> > > Cool :)
> > >
> > > > --- a/include/linux/fsnotify_backend.h
> > > > +++ b/include/linux/fsnotify_backend.h
> > > > @@ -78,8 +78,10 @@
> > > >
> > > >  /* 64bit kernel internal event hint flags */
> > > >  #define FS_EVENT_IS_PERM       BIT_ULL(33)     /* Wait for user re=
sponse */
> > > > +#define FS_EVENT_ON_NS         BIT_ULL(34)     /* For namespace wa=
tchers */
> > > >
> > > >  #define FS_PERM_EVENT(mask)    (FS_EVENT_IS_PERM | (mask))
> > > > +#define FS_NS_EVENT(mask)      (FS_EVENT_ON_NS | (mask))
> > >
> > > I'd prefer we have couple bits reserved like:
> > >
> > > #define FSNOTIFY_EVENT_TYPE_BITS 8
> > > #define FSNOTIFY_EVENT_TYPE_MASK (~0ULL << (64 - FSNOTIFY_EVENT_TYPE_=
BITS))
> > >
> > > And then allocate different types (FILESYSTEM =3D=3D 0, NAMESPACE =3D=
=3D 1, ...)
> > > from this in an enum fashion. This is much more efficient on bit spac=
e than
> > > just event flags.
> >
> > Wow, 256 types. What a rich future ;)
>
> :) It may be a bit too much but OTOH in those 64 bits I think we can spar=
e
> 8 bits...
>

I went with bits 32..39 so that event macros can be written explicitly as:

/*
 * Bits 32..39 of the 64-bit event mask encodes the watcher type.
 * Filesystem events have type 0, so legacy event constants are
 * filesystem events.
 */
#define FAN_EVENT_TYPE_SHIFT    32
#define FAN_EVENT_TYPE_MASK     (0xffULL << FAN_EVENT_TYPE_SHIFT)
#define FAN_EVENT_TYPE(mask)    \
        (((mask) & FAN_EVENT_TYPE_MASK) >> FAN_EVENT_TYPE_SHIFT)
...
/* Backward compat mount events - cannot be mixed with other events */
#define FAN_MNT_ATTACH          0x0001000000UL  /* Mount was attached */
#define FAN_MNT_DETACH          0x0002000000UL  /* Mount was detached */
/* "Strong typed" mount events - may be mixed with other namespace events *=
/
#define FAN_NS_MNT_ATTACH       0x0101000000UL  /* Mount was attached */
#define FAN_NS_MNT_DETACH       0x0102000000UL  /* Mount was detached */
...
/* Internal fsnotify_mnt() events */
#define FSN_MNT_ATTACH          0x01000000      /* Mount was attached */
#define FSN_MNT_DETACH          0x02000000      /* Mount was detached */
#define FSN_MNT_MOVE            (FSN_MNT_ATTACH | FSN_MNT_DETACH)
...
#define ASSERT_FS_EVENT(fan_mask, fsn_mask) \
        BUILD_BUG_ON((u32)(fan_mask) !=3D (fsn_mask) || \
                     FAN_EVENT_TYPE(fan_mask) !=3D FSNOTIFY_GROUP_TYPE_FILE=
SYSTEM)
#define ASSERT_NAMESPACE_EVENT(fan_mask, fsn_mask) \
        BUILD_BUG_ON((u32)(fan_mask) !=3D (fsn_mask) || \
                     FAN_EVENT_TYPE(fan_mask) !=3D FSNOTIFY_GROUP_TYPE_NAME=
SPACE)
...
        ASSERT_FS_EVENT(FAN_RENAME, FS_RENAME);
        ASSERT_FS_EVENT(FAN_PRE_ACCESS, FS_PRE_ACCESS);
        /* Assert backward compat mount events */
        ASSERT_FS_EVENT(FAN_MNT_ATTACH, FSN_MNT_ATTACH);
        ASSERT_FS_EVENT(FAN_MNT_DETACH, FSN_MNT_DETACH);
        /* Assert "strong typed" events for namespace watcher */
        ASSERT_NAMESPACE_EVENT(FAN_NS_MNT_ATTACH, FSN_MNT_ATTACH);
        ASSERT_NAMESPACE_EVENT(FAN_NS_MNT_DETACH, FSN_MNT_DETACH);
---


> > Note that I also considered flags (FS_EVENT_IS_PERM) as part of the
> > event definition - those would control things that are common to all ty=
pes.
>
> Hum, but FS_EVENT_IS_PERM is kernel internal flag and I really want it to
> stay that way. If needed we can move it out of the mask completely...
>

I left these out for now.

> > > > @@ -136,7 +138,7 @@
> > > >  #define ALL_FSNOTIFY_FLAGS  (FS_ISDIR | FS_EVENT_ON_CHILD | FS_DN_=
MULTISHOT)
> > > >
> > > >  /* Kernel internal 64bit flags */
> > > > -#define ALL_FSNOTIFY_KERN_FLAGS  (FS_EVENT_IS_PERM)
> > > > +#define ALL_FSNOTIFY_KERN_FLAGS  (FS_EVENT_IS_PERM | FS_EVENT_ON_N=
S)
> > > >
> > > >  #define ALL_FSNOTIFY_BITS   (ALL_FSNOTIFY_KERN_FLAGS | \
> > > >                              ALL_FSNOTIFY_EVENTS | \
> > > >
> > > > ---
> > > >
> > > > TBH, I don't remember whether I was discouraged for some reason
> > > > or if I had started to question the value of this
> > > > or if I thought it was better to send the simpler version first.
> > > >
> > > > Anyway, I am fond of this approach so I will give it a try.
> > >
> > > Thanks!
> > >
> > > > I went back and forth about exporting this explicitly in uAPI and
> > > > require that all fanotify_mark() calls on namespace objects
> > > > (add,remove,flush) always carry the explicit FS_EVENT_ON_NS
> > > > flag and/or in the outgoing mask.
> > > >
> > > > or that they are defined as:
> > > > #define FAN_NS_CREATE (__FAN_NS_CREATE | FS_EVENT_ON_NS)
> > > >
> > > > Also if we do that, we need to think of the least ugly way to handl=
e
> > > > FAN_MNT_ATTACH & FAN_MNT_DETACH.
> > >
> > > These are good questions. After thinking about this I think the most
> > > convenient would be if:
> > >
> > > * Type was already included in the defined event constants
> > > * Type was included in the reported outgoing events
> > >
> > > That way you can combine events constants like EVENT1 | EVENT2 | EVEN=
T3 and
> > > get a valid input for fanotify_mark() or a valid mask. For checking y=
ou'd
> > > have to do received_mask & ~FSNOTIFY_EVENT_TYPE_MASK & (EVENT1 | EVEN=
T2) to
> > > check whether any of these events was received which is bearable, mas=
k =3D=3D
> > > EVENT1 would keep working.
> >
> > When you write "you'd have to do..." meaning all the applications need =
to be
> > educated about this and we need to expose FAN_EVENT_TYPE_MASK
> > in uAPI.
>
> Yes, all apps wanting to use other than the standard filesystem events wi=
th
> type =3D=3D 0 will need to be using this new way of checking.
>
> > I guess we should provide
> >
> > #define FAN_EVENT_MATCH(event_meta, event_set)
>
> Yes, we could do that I guess.

Created two macros:

    fanotify: introduce FAN_EVENT_MATCH() macro

    With "strong typed" events a correctly written program needs to
    use the new macros FAN_EVENT_MATCH() FAN_EVENT_MASK_MATCH() to match
    the reported event mask in the scope of the watcher type.
---
/* Match event mask to any event in @event_set of the same watcher type */
#define FAN_EVENT_MASK_MATCH(mask, event_set)                   \
        (FAN_EVENT_TYPE(mask) =3D=3D FAN_EVENT_TYPE(event_set) &&   \
         ((mask) & (event_set) & ~FAN_EVENT_TYPE_MASK))

/* Was one of the events in @event_set reported in the event? */
#define FAN_EVENT_MATCH(meta, event_set)                        \
        FAN_EVENT_MASK_MATCH((meta)->mask, event_set)
---

>
> > The risk of a programmer doing if (event->mask & EVENT1) exists,
> > but not much more we can do about it.
>
> Yep + documentation in the manpage obviously.
>
> > > I've checked and FAN_MNT_ATTACH / FAN_MNT_DETACH already got used in =
a
> > > couple of places (stress-ng, util-linux, ...) so the only realistic o=
ption
> > > I see at this point is to define FAN_MNTNS_ATTACH, FAN_MNTNS_DETACH w=
ith
> > > proper type info included and automatically morph FAN_MNT_ATTACH and
> > > FAN_MNT_DETACH into FAN_MNTNS_ATTACH and FAN_MNTNS_DETACH, respective=
ly in
> > > fanotify_mark(). When morphing we'd have to set some group flag to di=
sable
> > > reporting of type in outgoing events as well and make sure FAN_MNT_AT=
TACH
> > > and FAN_MNT_DETACH cannot be mixed with any other properly typed even=
ts in
> > > one group.
> >
> > Seems manageable.

I examined some options here and uapi seemed problematic.
For starters, FAN_MNTNS_ATTACH sounds like an mntns object is being attache=
d
and it does not conform to the language in other event macos.

What I settled on at the moment is the following semantics:

    fanotify: define new FAN_NS_MNT_* constants

    The FAN_MNT_* event constants belong to the namespace watcher group typ=
e,
    but the type bits do not match.

    We preserve these legacy FAN_MNT_* constants - they can never be mixed
    with any other event in the mask in upstream kernel anyway, so there is
    no real risk of confusion for applications that only watch mount events=
.

    We define a new set of FAN_NS_MNT_* constants, which are defined with t=
he
    namespace watcher group type.  These could be allowed together with
    other namespace events in future kernels, so they are intended to be
    used by new applications that are going to watch namespace trees and
    mount trees with the same fanotify group.
---
/* Backward compat mount events - cannot be mixed with other events */
#define FAN_MNT_ATTACH          0x0001000000UL  /* Mount was attached */
#define FAN_MNT_DETACH          0x0002000000UL  /* Mount was detached */
/* "Strong typed" mount events - may be mixed with other namespace events *=
/
#define FAN_NS_MNT_ATTACH       0x0101000000UL  /* Mount was attached */
#define FAN_NS_MNT_DETACH       0x0102000000UL  /* Mount was detached */
---

    fanotify: introduce FAN_REPORT_MNTID

    This fanotify_init() flag is similar to FAN_REPORT_MNT, but instead of
    enabling the legacy FAN_MNT_* events, it enabled the new FAN_NS_MNT_*
    events which also report the watcher type bits in event->mask.

    FAN_REPORT_MNT and FAN_REPORT_MNTID are mutually exclusive and therefor=
e
    the group accepts either the legacy FAN_MNT_* events or the new
    FAN_NS_MNT_* events in fanotify_mark().

    Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
#define FAN_REPORT_MNT          0x00004000      /* Report FAN_MNT_ events *=
/
#define FAN_REPORT_MNTID        0x00008000      /* Report FAN_NS_MNT_ event=
s */
---

opting-in to this mode at init time greatly simplifies the semantics
compared to guessing what user meant later on and this is quite easy
to document in man page, as per the short commit message above.


> >
> > > I also considered an option to explicitly define a group flag that
> > > userspace can set to enable verification of types in fanotify_mark() =
and
> > > reporting them in outgoing event mask. This would be an option as wel=
l but
> > > so far it seemed somewhat more confusing than what I suggested above =
(where
> > > I expect people to transition to properly typed events faster because
> > > otherwise their functionality will be restricted).
> > >
> > > Of course there's still the question whether we want to expose types =
in the
> > > uAPI at all but I'm slowly leaning towards yes to make it harder to u=
se the
> > > API wrongly.
> >
> > I see no value in opt-in for verification of types in fanotify_mark().
> > opt-in or -out for the outgoing mask - maybe, especially since we need =
this
> > internal flag anyway for FAN_MNT_*, but I am also leaning against it.
>
> OK, good.
>

I was swayed the other way ;)

I now have opt-in for both input verification and outgoing mask:

#define FANOTIFY_MNT_MODES      (FAN_REPORT_MNT | FAN_REPORT_MNTID)

/* fanotify_init() flags that report watcher type in event mask */
#define FANOTIFY_REPORT_TYPE    (FAN_REPORT_MNTID)
...
static bool fanotify_is_valid_mask(struct fsnotify_group *group, int mark_t=
ype,
                                  struct fanotify_mask fan_mask)
{
        u64 valid_mask =3D 0;
...
        /* Only allow high bits in mask when reporting them in event->mask =
*/
        if (!FAN_GROUP_FLAG(group, FANOTIFY_REPORT_TYPE) && fan_mask.type)
                return false;

        switch (group->type) {
        case FSNOTIFY_GROUP_TYPE_FILESYSTEM:
                valid_mask =3D FANOTIFY_EVENTS_ON_FILESYSTEM |
                             FANOTIFY_EVENT_FLAGS;
                if (!IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS))
                        valid_mask &=3D ~FANOTIFY_PERM_EVENTS;
                break;
        case FSNOTIFY_GROUP_TYPE_NAMESPACE:
                /* Only report mount events on mntns mark */
                if (mark_type =3D=3D FAN_MARK_MNTNS &&
                    FAN_GROUP_FLAG(group, FANOTIFY_MNT_MODES))
                        valid_mask =3D FANOTIFY_MOUNT_EVENTS;
                /* Classify the legacy mount events as namespace events */
                if (fan_mask.mask & (FAN_MNT_ATTACH | FAN_MNT_DETACH) &&
                    FAN_GROUP_FLAG(group, FAN_REPORT_MNT))
                        fan_mask.type =3D FSNOTIFY_GROUP_TYPE_NAMESPACE;
                break;
        }

        if (fan_mask.type !=3D group->type)
                return false;

        return !(fan_mask.mask & ~valid_mask);
}

Later on this opt-in is going to grow to:

#define FANOTIFY_REPORT_TYPE    (FAN_REPORT_MNTID | FAN_REPORT_NSID)

> > Anyway, with no end users to nag me and summer vacation getting close
> > it may take me some time to post v3, so if you think of any new ideas
> > there is still time to bring them up.
>
> Sure :) Thanks for working on this!

I pushed the tested poc to github [1] so you can take a look when you have =
time.
I will post the patches for proper review, but first I wanted to know
if you are fine
with the semantics I came up with.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/fsnotify_group_type

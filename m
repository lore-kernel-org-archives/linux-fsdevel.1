Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B679939A4B3
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779382854; cv=pass; b=DRltW23NsOvJ3dTmTdO40mhacWgYZAYPfWONpg4/5EsfuCi1Opqbu/dfeFzNjnRsgQKpMYTCiFRUYTz7y7yCcwDYpMsaNm8scRNh53gp53q1jsq7aazRY4URXsMO+7MLCZqWFM63YmY67U5W66xc2dcmHo+2KvG3aBvwnBGnPXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779382854; c=relaxed/simple;
	bh=Iu3yFPNixriSvUIqk3q2dqtiEDRl2s3EBJEG4eWYlEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c2APuYWRhZw/0ZhrNoga370gD6/xBXQH8Gxa9OO42cjjcCxx1UsAzXEpFAlQPsoy8W9n5Wxjdn1YLbrYZ3nqwRPUoj/X6JTJ/najsOkQBq3+rorFyh3bvYsykcUAY/I1egUtX5zYHERpg0161TE5NZLPZ91ttKblFxxvizSGN0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sHwoKZQ5; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHwoKZQ5"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67cd93d8affso8088952a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 10:00:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779382851; cv=none;
        d=google.com; s=arc-20240605;
        b=DxTwyehtVL2NEJ18lj/hWMo7YVv6algxT6a4zGuPgif2+3Emajv+3dG2ndukZqR3Xw
         t9W6DmI5rpvRmc1qIRA/9/MvKEAeqe3lNeByHTAVAfwMJxhHxlOncPmTuQrzgVhQbrHX
         gQS1/9x80CYHVufhv20OCs4sHKONuDTX1jBwaqqrFP844DgRv4/BM70VyY//z//kzp9r
         lfTOZH/RRJPOi/qfQ7LjvCwucnKyqo2iG0nBNXIxvKZl+QJfl/zUJxLs88W4xi6IMfiJ
         YFcmoiPRO3xqOocIA5X+ojoJAJR3y88keOcVZ1wN0aprnwva4A7A5sf4DOEvULeyw3+d
         X/nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=O9p2v4HcZft4Nepv9J5aJp2pL8EvgHdOC418lkbfD3k=;
        fh=osEgEOniqNd2XO+iOTRsyu9+6Q+uIbtMf+9kjnzPNAA=;
        b=OV88w66yvFOg81gBiP9ll97NoCzUEoeb9Aj5HkoyrYLjxmeI/KERAH4pMAnYMBg+C6
         RU/iZxejqbrLIys0Q4bucVrUJXWvBvlJxYPPv57FsDx0Ephd+atThNcKfoZa4y8Zqu/8
         EqDPkEyaYf3+aNDssP8iQZTH29XD5TU07HwMK5kHW8myfjPe776ktN6UimY6XxWjgh0E
         eEy4SL3D1flNk7dcFVpnqKNlteObr57p1usPEgRPVK2zNm94ZpKUmQ6xBbzmnXB1v9a0
         W0N3xnF+Ack9HMPh+y3FS3amggP/2yiD8YtUUZMJM8AbWQbzaaClqJY6b82YHZBJRtik
         CVYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779382851; x=1779987651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O9p2v4HcZft4Nepv9J5aJp2pL8EvgHdOC418lkbfD3k=;
        b=sHwoKZQ5Fsgl3KVqMc6vN8PYtpy+jEvHZczQGPZ1CyV/cwP00TCSO4B8czk1Lqz+2N
         U8bQtrSCUagZIcKjWtNbOxgpYhcbM2FmEPszebvNV+5E64NS4q75gjiSUWMvZG18zr7J
         HsmI8meplqVZovB+W2J1whj+wYB91/foTm6mdIKtXv/Sm2km4QydIdlygnOiEk1sj1AS
         iLR7s3gvaCdZRMFKT7Dhd2ag3YoU0E6ARsdWq9xjccFGfSJWrszSxVNGvCL81Ee/rAhR
         d+mXQbl2eI69aqFVHgei6RTusA/LPhg1ZTrf+9V9IJNoazdSaGhcxLKs02hed0UV5PrV
         gUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779382851; x=1779987651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O9p2v4HcZft4Nepv9J5aJp2pL8EvgHdOC418lkbfD3k=;
        b=Pd0mT78NENwA+2rm32Z4us+7q6a2xvL0z+ZUamyEfMu7pcA3Rcq/nS/dv1yoDLVyM2
         S5L59z2qqGPMiARGZUYgUc4BJ3ZLYH2aypo5clZsCfYp0yOFmQEWvHBj4YG9Kdgfuh10
         icTL/2+3HHUY9ZCO9MP8sQzwG71J1Rxql9dpjWKK1301fdcO7DXgYWXGOPjxifu4Xk7H
         aR3DAcd8p5xTt4WPwif11AnEN+UfP+MEKNDbK06Ld7x4cl0AHBbFBeyZsK5PPkAagt/c
         RLNSWtya6WjNulZH5JiIHe0agVkjKb92C7nKXXTZgbVNR1HR8eapq5CjGCXEpdOXZw77
         46+Q==
X-Forwarded-Encrypted: i=1; AFNElJ8BKQwmJ//RGU5IBQEg98UMInEiGN1qTrHO3WwYHEyylziojOiZhFf2RqO9T2LUQF3lgcA5N3hf24OlN+M1@vger.kernel.org
X-Gm-Message-State: AOJu0YwG1g5GIVnufz+dXFaeoY41+fwHAzbb3rkyw3gApbKGvPfLvg47
	gWGDtKPY3OvJIr01YF4iUS+h0s83MA/dK9YWc11Ot+6toW4uRulX/lwSePKbbSTctPKB0Lbx0pu
	5Qcx/xGLPsJVGvz21gl/ikpKHg5Bfw9ihMAUvXVY=
X-Gm-Gg: Acq92OFK4tWJbQuLwWu+LRSmMK10zCHHMT7cDmjqwHIUgUagP7J/Ce3aLrm7dURkT+t
	8x774gkqygKtrYza4qKoINGioAkRhv/UztSbhO8UGyj7wrVHTe99jVzJtnpKKlpF6YM4W/4SWEw
	c13vM15UaatqWrdc/6Fak8a6LHpRL8OOT4KDU6EHLpMpt3BATgYta5znpFL09OWCgFinCYDKgOK
	I+9oeiro11ZCZZOp5Jcm6zn/royWlzBCITYVIBwZitiBxQiGD7d+/79FTv1aNyEvt1rdcJRE6F3
	aHqIfKn0QFjqugvGtDeFiX3A8Y9VvSiMlPXhQfq73A==
X-Received: by 2002:a05:6402:448e:b0:683:1cc8:84b0 with SMTP id
 4fb4d7f45d1cf-68835ef3519mr2031657a12.1.1779382850712; Thu, 21 May 2026
 10:00:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424170503.2096847-1-amir73il@gmail.com> <20260424170503.2096847-4-amir73il@gmail.com>
 <pnpqweynr6u4jtc67orwdqcelj4yo4c4ydeiw2td7777dzxl7j@xmo22qzv3yp4>
In-Reply-To: <pnpqweynr6u4jtc67orwdqcelj4yo4c4ydeiw2td7777dzxl7j@xmo22qzv3yp4>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 21 May 2026 19:00:38 +0200
X-Gm-Features: AVHnY4K4BtdqLPku22jgA6-vHz1EBnNktovW1-Q4oVtH3_NLTPHbDgjX5Tdw9RI
Message-ID: <CAOQ4uxjcPa=DWwmnU3AK+qA_CGd+HP0h5rfA5FhrpdBTqxprxg@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] fsnotify: separate the events bitmask macros by
 group type
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 6:15=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 24-04-26 19:04:56, Amir Goldstein wrote:
> > Fork the macros ALL_FSNOTIFY_EVENTS and FANOTIFY_EVENTS to
> > *_EVENTS_ON_{FS,NS} and use them to determine the valid mask for
> > fanotify_mark() and the outgoing mask by the group type.
> >
> > Use the fanotify_is_valid_mask() helepr to simplifies the check for
> > reporting mount events IFF group was initialized with FAN_REPORT_MNT
> > and IFF watching an mntns object.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotif=
y.c
> > index e768c25262e27..494bba49634e1 100644
> > --- a/fs/notify/fanotify/fanotify.c
> > +++ b/fs/notify/fanotify/fanotify.c
> > @@ -303,7 +303,7 @@ static u32 fanotify_group_event_mask(struct fsnotif=
y_group *group,
> >                                    struct inode *dir)
> >  {
> >       __u32 marks_mask =3D 0, marks_ignore_mask =3D 0;
> > -     __u32 test_mask, user_mask =3D FANOTIFY_OUTGOING_EVENTS |
> > +     __u32 test_mask, user_mask =3D FANOTIFY_OUTGOING_FS_EVENTS |
> >                                    FANOTIFY_EVENT_FLAGS;
> >       const struct path *path =3D fsnotify_data_path(data, data_type);
> >       unsigned int fid_mode =3D FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS=
);
> > @@ -315,6 +315,7 @@ static u32 fanotify_group_event_mask(struct fsnotif=
y_group *group,
> >                __func__, iter_info->report_mask, event_mask, data, data=
_type);
> >
> >       if (fsnotify_is_ns_watcher(group)) {
> > +             user_mask =3D FANOTIFY_OUTGOING_NS_EVENTS;
>
> I'd use the helper function you define in fanotify_user.c for this so tha=
t
> we have the logic in one place.

ok

>
> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fa=
notify_user.c
> > index 95e7c24c70249..7afb017d40f50 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -830,6 +830,19 @@ static int copy_info_records_to_user(struct fanoti=
fy_event *event,
> >       return total_bytes;
> >  }
> >
> > +static __u64 fanotify_event_mask(struct fsnotify_group *group,
> > +                              struct fanotify_event *event)
>
> I'd call this fanotify_group_outgoing_events(). Your name is too similar =
to
> fanotify_group_event_mask() - it's unclear what's what from the name. Als=
o
> I'd let it just take the mask as an argument instead of event.

ok

>
> > +{
> > +     switch (group->type) {
> > +     case FSNOTIFY_GROUP_TYPE_FS:
> > +             return event->mask & FANOTIFY_OUTGOING_FS_EVENTS;
> > +     case FSNOTIFY_GROUP_TYPE_NS:
> > +             return event->mask & FANOTIFY_OUTGOING_NS_EVENTS;
>
> Here I'd also go for FILESYSTEM / NAMESPACE in constant names to increase
> distinction.

ok

>
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  static ssize_t copy_event_to_user(struct fsnotify_group *group,
> >                                 struct fanotify_event *event,
> >                                 char __user *buf, size_t count)
> > @@ -848,7 +861,7 @@ static ssize_t copy_event_to_user(struct fsnotify_g=
roup *group,
> >       metadata.metadata_len =3D FAN_EVENT_METADATA_LEN;
> >       metadata.vers =3D FANOTIFY_METADATA_VERSION;
> >       metadata.reserved =3D 0;
> > -     metadata.mask =3D event->mask & FANOTIFY_OUTGOING_EVENTS;
> > +     metadata.mask =3D fanotify_event_mask(group, event);
> >       metadata.pid =3D pid_vnr(event->pid);
> >       /*
> >        * For an unprivileged listener, event->pid can be used to identi=
fy the
> > @@ -1881,6 +1894,35 @@ static int fanotify_events_supported(struct fsno=
tify_group *group,
> >       return 0;
> >  }
> >
> > +static bool fanotify_is_valid_mask(struct fsnotify_group *group, int m=
ark_type,
> > +                                __u64 mask)
> > +{
> > +     u32 valid_mask =3D 0;
> > +
> > +     /*
> > +      * Event bits for different group type may be overloaded but even=
t
> > +      * flags are common to all group types.
> > +      */
> > +     BUILD_BUG_ON(FANOTIFY_EVENTS_ON_FS & FANOTIFY_EVENT_FLAGS);
> > +     BUILD_BUG_ON(FANOTIFY_EVENTS_ON_NS & FANOTIFY_EVENT_FLAGS);
>
> I'm a bit curious what's your rationale for this? It isn't like EVENT_FLA=
GS
> can be sensibly used with namespace notifications, they are kind of fs
> specific as well...
>

The rationale is written in the cover letter.
I should have mentioned it here:

"To simplify the implementation, the event flags (ON_CHILD, ISDIR)
live in a shared space that cannot be overloaded by neither group types.
This is not because ISDIR makes sense for ns watcher, just to reduce the
number of gates in common code. ON_CHILD flag might be usable for ns
watchers, not sure."

My rationale was not having to take care of gating or making sure that they
are already gated with is_filesystem_watcher() in all the places in common
fsnotify code that test those flags:

fsnotify_ignore_mask(), fsnotify_mask_applicable(),
fsnotify_iter_select_report_types(), send_to_group()

Just a lot of pain and hard to maintain subtle code saving for giving up tw=
o
bits - one of those bits may be usable to namespaces, which sounded like a
good enough deal to me.

The reason that FAN_EVENT_ON_CHILD could be applicable to
namepsace watchers is that namespaces are a tree so userns mark
could be watching events on children namespaces and pidns mark
could also be required to watch children pid namespaces or children
processes (Christian has some ideas there).

> > +
> > +     switch (group->type) {
> > +     case FSNOTIFY_GROUP_TYPE_FS:
> > +             valid_mask =3D FANOTIFY_EVENTS_ON_FS | FANOTIFY_EVENT_FLA=
GS;
> > +             if (!IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS))
> > +                     valid_mask &=3D ~FANOTIFY_PERM_EVENTS;
> > +             break;
> > +     case FSNOTIFY_GROUP_TYPE_NS:
> > +             /* Only report mount events on mntns mark */
> > +             if (mark_type =3D=3D FAN_MARK_MNTNS &&
> > +                 FAN_GROUP_FLAG(group, FAN_REPORT_MNT))
> > +                     valid_mask =3D FANOTIFY_MOUNT_EVENTS;
> > +             break;
> > +     }
>
> Shouldn't this also check that the mark type matches the group type? The
> condition you replace with this call did that...

Hmm not sure.
See this check:
        if (group->type !=3D group_type ||
            !fanotify_is_valid_mask(group, mark_type, mask))
                return -EINVAL;

group_type is determined earlier in the switch (mark_type) block.

Because every mark type maps to one single group type,
this makes more sense, but maybe a better choice of variable name
for group_type is in order. mark_group_type?

>
> > +
> > +     return !(mask & ~valid_mask);
> > +}
> > +
> >  static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64=
 mask,
> >                           int dfd, const char  __user *pathname)
> >  {
> > @@ -1890,7 +1932,6 @@ static int do_fanotify_mark(int fanotify_fd, unsi=
gned int flags, __u64 mask,
> >       struct fan_fsid __fsid, *fsid =3D NULL;
> >       struct user_namespace *user_ns =3D NULL;
> >       struct mnt_namespace *mntns;
> > -     u32 valid_mask =3D FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
> >       unsigned int mark_type =3D flags & FANOTIFY_MARK_TYPE_BITS;
> >       unsigned int mark_cmd =3D flags & FANOTIFY_MARK_CMD_BITS;
> >       unsigned int ignore =3D flags & FANOTIFY_MARK_IGNORE_BITS;
> > @@ -1945,13 +1986,6 @@ static int do_fanotify_mark(int fanotify_fd, uns=
igned int flags, __u64 mask,
> >               return -EINVAL;
> >       }
> >
> > -     if (IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS))
> > -             valid_mask |=3D FANOTIFY_PERM_EVENTS;
> > -
> > -     if (mask & ~valid_mask)
> > -             return -EINVAL;
> > -
> > -
> >       /* We don't allow FAN_MARK_IGNORE & FAN_MARK_IGNORED_MASK togethe=
r */
> >       if (ignore =3D=3D (FAN_MARK_IGNORE | FAN_MARK_IGNORED_MASK))
> >               return -EINVAL;
> > @@ -1974,22 +2008,10 @@ static int do_fanotify_mark(int fanotify_fd, un=
signed int flags, __u64 mask,
> >               return -EINVAL;
> >       group =3D fd_file(f)->private_data;
> >
> > -     if (group->type !=3D group_type)
> > +     if (group->type !=3D group_type ||
> > +         !fanotify_is_valid_mask(group, mark_type, mask))
> >               return -EINVAL;
> >
> > -     /* Only report mount events on mnt namespace */
> > -     if (FAN_GROUP_FLAG(group, FAN_REPORT_MNT)) {
> > -             if (mask & ~FANOTIFY_MOUNT_EVENTS)
> > -                     return -EINVAL;
> > -             if (mark_type !=3D FAN_MARK_MNTNS)
> > -                     return -EINVAL;
> > -     } else {
> > -             if (mask & FANOTIFY_MOUNT_EVENTS)
> > -                     return -EINVAL;
> > -             if (mark_type =3D=3D FAN_MARK_MNTNS)
> > -                     return -EINVAL;
> > -     }
> > -
> >       /*
> >        * A user is allowed to setup sb/mount/mntns marks only if it is
> >        * capable in the user ns where the group was created.
> > diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> > index b646a861a84c6..429ce614233ce 100644
> > --- a/fs/notify/fsnotify.c
> > +++ b/fs/notify/fsnotify.c
> > @@ -149,7 +149,7 @@ static inline __u32 fsnotify_object_watched(struct =
inode *inode, __u32 mnt_mask,
> >       __u32 marks_mask =3D READ_ONCE(inode->i_fsnotify_mask) | mnt_mask=
 |
> >                          READ_ONCE(inode->i_sb->s_fsnotify_mask);
> >
> > -     return mask & marks_mask & ALL_FSNOTIFY_EVENTS;
> > +     return mask & marks_mask & FSNOTIFY_EVENTS_ON_FS;
> >  }
>
> With this change it becomes kind of obvious that fsnotify_object_watched(=
)
> is a misnomer after mntns events were added. And it is ok only because th=
e
> callers of this are really specific to fs events. Can you please fix the
> name - perhaps to fsnotify_fs_object_watched()?

Sure, are you sure that you don't want it to be
fsnotify_filesystem_object_watched() ;)

Thanks,
Amir.

Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143A13624A5
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 19:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303975; cv=pass; b=Qxy6FSPO8S0JXDEcNHZDLkHknR1XfOIsucqxiOTlMmLCLIgQ65+TikT+mHcQdr2kxkcniimna0pApjsjnWMDltworBHmsBTkgkoGo5MN96n/MPfOwQWnBhthfivc/s9gNymkbBQ64k1M/dKYATmpGOx+9WLmwFlh/dq92N8DzTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303975; c=relaxed/simple;
	bh=ul+ilZ3hlKSgrvcYYYxvTtg3IcB8WgPYsiwV0vwMxdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vl4QpFu163Y9yzHUV3Lpu+107DdNvlOO1MS5rEDn7EwTDC2OAdJhM+1+Ey42tcUH/1Y+/BOi6fBoGNML8l9FItecHUcCE1BfekQE+rvq+0wIt4GU1WXxYWA3rYyBnF3ji+Yk+UiA/WvataEovb2+wrT9qRIfB3A/oaDspmtnx/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Thf6vfJC; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Thf6vfJC"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-67cac5ece75so10760115a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2026 12:06:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779303972; cv=none;
        d=google.com; s=arc-20240605;
        b=cH2aHCQO5k2LxiZZkkHUWkiDRVy8Sqvmlggu0ZSHInez1vnp2Ts5JoM/epoJb2jvB1
         cX+V1pAsBn9pQqqYOmLEwLaOjVhLchtzdcZk48qS2kbC9kq7R6z79C+9YNr6H0G2g5Fl
         DrdVuKw8E19OGnnNhKfsl5snqndIfUE1LAGz8Jv/Ia1cwMK+yyrZLdWWx9FS46NMEjVZ
         9+vqnbv8MyKCR7BhrC4m0GDQiUoBWD1N7tJnJTguOMXgcgtTpoT7lrV2i4/m8SN9wBdq
         rc9h9JVvpGvYY4hSME0xe7xWYfcAM/TjisyJe4kd38m19rDVPsR8uZzpUF+kU1nPQpFS
         PvUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZJA3dKgmHgQeX32rOVTxzhpBb7cYcEEOL7Jo4IqrYts=;
        fh=ITQQEzOd7jfibi1NRggJ9ZIKvDz/YWMBo/qKuAuUoJ0=;
        b=ZFEOM0rmmRzLbfgZ+e0V1mr9mfj0b1SZAGchrA5yG4ExHZWFunub9MvBRc5Id/FA3S
         EyeRX/HLigdckPLvvmHN5EKkI+Z3+ad9dDLmjtCfKimIQPcMds4QDT7xx0rTZEclFGpy
         TZ1+GhSoSFPhxxYjqbTYUuN5ndqk8q4qYE667F1MEIRZWbYO0XOSHmY0jFZPoFob3G0S
         xCu/wQWTegvs5fULOSpKsmQYV2NZoofHFVj92NjgcixTDiyzzUml+EN9weiwY1Xj0/8W
         2thwoSIAE54Wr1mV1tvToAMLR1OTAxWrjYE351tnSvF/qCh0sh5qMN4fjlu+KYoGQWgL
         fqyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779303972; x=1779908772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJA3dKgmHgQeX32rOVTxzhpBb7cYcEEOL7Jo4IqrYts=;
        b=Thf6vfJCWLwQZ/xxIkOKD/8EeRp3DqQz/I9wBDR67tAxuyFYbr7VP9bIAbslqGrD78
         iTMzO1EIw9hSImdq8Sqm7cMhIcWN9zkftoOr8GGqmheqomM6HMEt2t8M1Dmzsz1f0Ar8
         AEF+WFxb++s853kwlVtp7vvijOhFFDH2VlKGkXQrKdj9XZ15BBopbuUc0uiVwSRSeyat
         APUQItvy/ylmiS+ogsU2gpAnrkbHbcnny7pDpmoqzNO0v8TYGzIWJLKcXJT1cAIE03DX
         3knwuse3GkQSon4ZmW5t+MpOWh2wzsEsUzp2h+8lRm+c9U5Ww6V1cWLcdz1nfcEmQyxc
         SlYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779303972; x=1779908772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZJA3dKgmHgQeX32rOVTxzhpBb7cYcEEOL7Jo4IqrYts=;
        b=WMcCaRmpXtO7KPKtZzc/HUHulghhG+aai2PbnOYWmrLopZaIaMeR3eGAABY4k5CNYT
         QGmgb4UFVWWW4/bBYb/ISVcXfMief0MonD2SWI3gjb5NHXc5QBDX5259RW8AqUC7dQQd
         CnWJ5h2YPStk0+jk/rFPEhIaH+UxwzzbU9YCmSssgZvjTlFys1SOzraYZF6E7VzTJX2P
         qI3Z/kiEipFHOd0na0N0SsGxePoeizRdgBukV8OdJzQ8bm1++ugkf/yLmc6VxOAPgrlb
         Cn5q6aGELd6RMZlkDTB3BMSni5r1w6LyYP6z2Uf+14UwiLdgmuyojnUWTHLejPXTdMM1
         t1jg==
X-Forwarded-Encrypted: i=1; AFNElJ8GKif+8E27tKOG3hBmz/Ka2nkvpv8QNaUTgBdRnSfdfLzGDvBGKQ99b8QchfxCq1wTBbynpboG7cl6wH/2@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9DAR5wtWZGrduNbH0IxLB11ELoBKQC/XQXrX6J1rwmklrM0AP
	xbfx6llH9oqk3sqJdSxK5XxITMYwnL/JPznee7z/gifa6tQG//9+Z7nID0D6FYMxgxa79LDEHTF
	Dj1n6d2Rk2tV4RzbtX1OdcA3z+PpRBM8=
X-Gm-Gg: Acq92OHoE4tlvxWMR2QIrCSmupmgbkcX9wbXr2ShH/IhasqtTPs2PtbyqqAlEwO+4U2
	PoMppiv7Is46G9ZeNcFp9CDWo3dX4ErwGcCXxbDM4xjPRmEb0gWjNllB2zdx5e0jFgI+oQXvF6n
	UFhAXDTZXywI4PXj85Kpwhxx7Y0edBfHdwmkoz4jp3aOHy3fGoUvzocZ25eavCxe5QyQ9KP0K9n
	ETreStp008MEzaHgH/PwEdyAe93VNriiLc8kPTD7addws0zpx0T8EQ2fpNMafIDc+Tpri7W72m6
	IzKnzBjvzZynyrDj0ZlWJ9LcvmaV8C4Bt2uI2my3cg==
X-Received: by 2002:aa7:d492:0:b0:683:c39d:4d9e with SMTP id
 4fb4d7f45d1cf-683c39d4eb1mr9098633a12.13.1779303972286; Wed, 20 May 2026
 12:06:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424170503.2096847-1-amir73il@gmail.com> <20260424170503.2096847-3-amir73il@gmail.com>
 <b5xolvjlm3xnx3dzdbvyc7nqgaejjatnrrwint6gleirdy6czi@vtj2m2qpayj6>
In-Reply-To: <b5xolvjlm3xnx3dzdbvyc7nqgaejjatnrrwint6gleirdy6czi@vtj2m2qpayj6>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 20 May 2026 21:06:00 +0200
X-Gm-Features: AVHnY4JW9ujX3b0rDJDIj6rtvEuA-TurV88bHQCu7Lo58ccm7jKrInsvVPF6IZY
Message-ID: <CAOQ4uxjCrhOLuwW-UAcCDejrTkGrhmLwc4+rJE097w2pXOvf6g@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] fsnotify: introduce fsnotify group types
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 5:55=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 24-04-26 19:04:55, Amir Goldstein wrote:
> > Currently an fanotify group can subscribe to events FAN_MNT_ATTACH/DETA=
CH
> > only on mark type FAN_MARK_MNTNS and IFF the group was initialized with
> > FAN_REPORT_MNT.
> >
> > Hence, mount events can not be mixed on the same group with filesystem
> > events and mntns marks cannot be mixed with filesystem type marks.
> >
> > Define a new property for an fsnotify group called fsnotify_group_type
> > which describes the category of events and mark types and use a distinc=
t
> > category FSNOTIFY_GROUP_TYPE_NS for the mount event groups.
> >
> > Create helpers fsnotify_is_{fs,ns}_watcher() and the macro
> > FANOTIFY_NS_INIT_FLAGS and use them to generalize some code that was
> > checking the FAN_REPORT_MNT flag.
> >
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> ...
>
> > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotif=
y.c
> > index 38290b9c07f7b..e768c25262e27 100644
> > --- a/fs/notify/fanotify/fanotify.c
> > +++ b/fs/notify/fanotify/fanotify.c
> > @@ -314,9 +314,11 @@ static u32 fanotify_group_event_mask(struct fsnoti=
fy_group *group,
> >       pr_debug("%s: report_mask=3D%x mask=3D%x data=3D%p data_type=3D%d=
\n",
> >                __func__, iter_info->report_mask, event_mask, data, data=
_type);
> >
> > -     if (FAN_GROUP_FLAG(group, FAN_REPORT_MNT)) {
> > +     if (fsnotify_is_ns_watcher(group)) {
> >               if (data_type !=3D FSNOTIFY_EVENT_MNT)
> >                       return 0;
> > +     } else if (WARN_ON_ONCE(!fsnotify_is_fs_watcher(group))) {
> > +             return 0;
>
> ns_watcher and fs_watcher names are really very similar. I was staring at
> that for a while trying to understand what you're doing here before I
> noticed that single letter difference. I'm struggling to find better name=
s.
> Maybe fsnotify_namespace_watcher() and fsnotify_filesystem_watcher() and
> correspondingly FSNOTIFY_GROUP_TYPE_FILESYSTEM / NAMESPACE?

Yes, I agree. This is less confusing.

>
> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fa=
notify_user.c
> > index 49531a4fe71de..95e7c24c70249 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -1586,8 +1586,11 @@ static struct hlist_head *fanotify_alloc_merge_h=
ash(void)
> >  DEFINE_CLASS(fsnotify_group,
> >            struct fsnotify_group *,
> >            if (!IS_ERR_OR_NULL(_T)) fsnotify_destroy_group(_T),
> > -          fsnotify_alloc_group(ops, flags),
> > -          const struct fsnotify_ops *ops, int flags)
> > +          __fsnotify_alloc_group(ops, type,
> > +                                 FSNOTIFY_GROUP_FLAG_USER,
> > +                                 GFP_KERNEL_ACCOUNT),
> > +          const struct fsnotify_ops *ops,
> > +          enum fsnotify_group_type type)
>
> I don't like this much. It's a bit of a catch that
> FSNOTIFY_GROUP_FLAG_USER is now always set (although I see that that's wh=
at
> the only user is doing). I'd keep this as is.
>

Sorry, you mean keep it as a constant flag? or pass the flag as an argument=
 of
CLASS fsnotify_group?
We can also make it DEFINE_CLASS(fsnotify_user_group,
and then the constant flag will not look as awkward?

> > @@ -2005,14 +2022,15 @@ static int do_fanotify_mark(int fanotify_fd, un=
signed int flags, __u64 mask,
> >               return -EINVAL;
> >
> >       /*
> > -      * Events that do not carry enough information to report
> > +      * Filesystem events that do not carry enough information to repo=
rt
> >        * event->fd require a group that supports reporting fid.  Those
> >        * events are not supported on a mount mark, because they do not
> >        * carry enough information (i.e. path) to be filtered by mount
> >        * point.
> >        */
> >       fid_mode =3D FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
> > -     if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_MOUNT_EVENTS|FANOTIFY_EV=
ENT_FLAGS) &&
> > +     if (fsnotify_is_fs_watcher(group) &&
> > +         mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_EVENT_FLAGS) &&
> >           (!fid_mode || mark_type =3D=3D FAN_MARK_MOUNT))
> >               return -EINVAL;
>
> I guess it would look more obvious here to switch on mark_type and valida=
te
> that the set event bits match the mark_type (and fid_mode).
>

I will try that.

> > -static struct fsnotify_group *__fsnotify_alloc_group(
> > -                             const struct fsnotify_ops *ops,
> > -                             int flags, gfp_t gfp)
> > +struct fsnotify_group *__fsnotify_alloc_group(const struct fsnotify_op=
s *ops,
> > +                                           enum fsnotify_group_type ty=
pe,
> > +                                           int flags, gfp_t gfp)
> >  {
>
> Can't we just derive the group type from flags in this function? I don't
> see a huge reason to duplicate that info in flags argument.

I am not sure I am following.
These are FSNOTIFY_GROUP_FLAG_* flags not the fanotify_init() flags.
Did you mean to add a temporary flag FSNOTIFY_GROUP_FLAG_NAMESPACE
just in order to save the extra type argument?

I did not want to encode fanotify logic in fsnotify generic
code if that is what you meant.

Thanks,
Amir.

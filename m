Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF982DA75C
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776954509; cv=pass; b=ZNYwbu0d57NAlvMC5ndeOYoAa3bYQWq4N8kChgRM3jm4FLZRTfl6OaB8dJ4XNvmEkfijLZQjo7QdQRLZAEw2+ICon/3iMhFjywk0951UWey3dQoWdjDhWbTwOLcofqWXUGXdGvpvwq5mPeFF/RgWUex4CkPMj5CFLyxaiUcYXOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776954509; c=relaxed/simple;
	bh=t9zTS/h6965iid2oKWqVR3n+lPMpGBa+2PO82Wkk6+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tjRE9IoKJUYynGr0lGUIQmgjQG1/XLzEnXz13vSz045YQbx1rfwL0av/DswzYtU0s+CH/egNvYEHilM7AtEF3e6bsG0pWMwHXzbc/p/RVjWCtjNUAYBUHivOdHyCFZLUtfP700x2qJV7SCUEdt7OhsdZTD+Rtdd8pv1b1G2GqMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAqlGReb; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAqlGReb"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8d7f22d405so1149963866b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2026 07:28:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776954506; cv=none;
        d=google.com; s=arc-20240605;
        b=LdQRqBiHVxYbrUC16HfiSfIpbyifumj9eBnAX/9Kr6x/gi22Rf20gw27gcBBuQNX6C
         bziZVsIyLG+v1Ro3n72Ah5amC4dMk3DjLy1fluTMhKj5J5IxfCYybVVmtDBvhvP55MB0
         Bgdzmaz8h6l4x5paBqy+8KZmdUrT+K635kiYouW7STKHoFPR/nKcrvTHah+kbeUSn/aZ
         GysfBG1nfiumYQtWVK3dyzSdCgs6W1Ws95ho4vWtmBUi1a2BT4RqaCv8J6oiPuUl5QmW
         4AJFIExRucjE4qKM04l/lH/9xCjnjaOmBduGgb17XC9i0Dnl8JAJSSLHPwhjxg92EDhY
         793w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UvV8I/r+MwMn6SZvHsaj4pMpjgtZOZ0sD2j9OtfR7hI=;
        fh=Pdydlp7tE4a9GaYMjNMbQ9eW2mUFiy+pNrq9pIljWYw=;
        b=Ed/IJ5Lghn4PxiQPLfICCGDxioHgEqm2WofYG1riI3aqq7SWc47S435jLgtAsl5yhJ
         9tZP0s1SGEo4VTPb597YGXz4JAFZFUWMzt9YnLf3pViEE8F9x2OUP6E/Hdzu24tBe459
         W085yFdKw0/Ox9ZBL3DPJcjx8R8PsW5R8PaDHjmssShZP+Ycxnu8fLO35oB60FEE77rv
         xrJQ9Z7zombHx/w4sAIARW5gvE1HjkhaRmlnTEY8XfHq64VYdDrep0XmNKNHRWkcK7lm
         0jeI5DLvcmbzm4+h3X1FiYb5L4OWz5GLtLenaHdDnN9V5q6y2fEoJi5HANyDGbOIrFRN
         811g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776954506; x=1777559306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvV8I/r+MwMn6SZvHsaj4pMpjgtZOZ0sD2j9OtfR7hI=;
        b=bAqlGRebPi38qcxZLQLPBgL7dkiMavuHBnY2688FE4VgJZa2SRlBd9ypPyCgYI7vnw
         n4F1b4oWMEYMLXMf/Imee+ffXij+x7Ppd/O80+7OM0cechKMIZJMiChQbVkHHRSsi12Z
         n3udabkU5YGJxjNHoHXFs9h4s8jMM2aMZKXBqtBirmw3U8aQK8M4tzY/Zzns0uIzTugm
         V6aspSgBWDf1XCmTN3d/uHF94rKCZnFJfGSKbe/CQeg0u9WBnvP/zsPtVLThv8whw2sx
         Kvyo+pT2A6waY3qUuibNqIDqu9YFmOMgVHnfkWmA347jqsTPVw+tJrrG3AvQBVqr/83z
         hoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776954506; x=1777559306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UvV8I/r+MwMn6SZvHsaj4pMpjgtZOZ0sD2j9OtfR7hI=;
        b=g3ZBAQEmi3EFgy2OU1hYQu4WEh3GGJyLJrJ66BptEFh8tfsXXWZo7JlG53h7EzJlra
         mebgepvTZDUCtbnvYrOWXjRtrGAzPFiHiUtbasvxiLBjS3kOV+Bbd6QflXrVJbVMGC5N
         QxhhnDLRAHVmUofnMt16oD+coAzmhqloQiPdutg5U9fNwdCj8GKjVGCrpdk2fKuh+pVn
         Vfaairb728Uvn0AMxVij2hTQtEQ+BkvokoOHn4udERuwIyZtGSrJqWNRWakGPusNZx5f
         +mxOfb4mC46yBIusx+t9GKm35ufJnI7eCwnFMDuXssTUzMouw0TmYwjKAHH2Y5VEuPbj
         FcXw==
X-Forwarded-Encrypted: i=1; AFNElJ/1F/LDcLSXuTnd3kj18a4unAAc0DmAIb5dCwLWq9D790hPkeJCNVj8Fl+Q80bhY6ILCZGWeOaYyQqsmLey@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+8ki4m8BCuwHcCsd6PjBCm/c83EqwqlN+0FFLZg+BGM+SZAyv
	wZW3V4oK3JWjh0Br9zvDZ6ZORWuF1VKq6/79DmLTjIO3FQrVsU1ErOEE/AOfRJKudnHyBon3tII
	anPR6iOhUBzafbcOvi3/Y7IvRWWu8Vq8=
X-Gm-Gg: AeBDiet4exS75lTfKLuqhU9lkb11yvFvI3bC7aulSGrJuVEk3VzWKKDAGYr8aRdbAX/
	yr3Kk+bB23CQ+QMVAcAbinqf2UU8vr44xHr/8AfW/elyE3QvK8PnZsMAjkxalhD/RtFJzWltPq6
	5wEbTB2bEeLtzJJfL3b5ruu3JEiXanksF9EDtO0q8Ih4uBMSLrVZdeVNe9qVV655HpkSuCS+IRK
	Jaf6zcnRNqE/IuBS/4zLhVzWRlxRwXwrkmTffZ2PKwdct0Sa1p2kJkuFX3uoR5Kb1Ne881QlKp2
	42Wp2Nrq1DbXXXhaUQVKpOdZcKxaKPw0gsZwNmwmqx/PWqoJcQ==
X-Received: by 2002:a17:906:c112:b0:ba8:b416:6ebc with SMTP id
 a640c23a62f3a-ba8b4167828mr822838666b.49.1776954505977; Thu, 23 Apr 2026
 07:28:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422181711.1340269-1-mjguzik@gmail.com> <AF9A814D-BABE-45FA-A6C4-2AAAD9CE2F21@dilger.ca>
In-Reply-To: <AF9A814D-BABE-45FA-A6C4-2AAAD9CE2F21@dilger.ca>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 23 Apr 2026 16:28:12 +0200
X-Gm-Features: AQROBzBNkghJCjChnEVSNRLehjqQ1ss-QKlyx18sasTsbvj3SGi4BMtZKJk5Gpk
Message-ID: <CAGudoHFZHc+B+Oi9dce=uQ1L7UpTQJwi_M63aR01OC4=0Y6uMw@mail.gmail.com>
Subject: Re: [PATCH v2] cache the string generated by reading /proc/filesystems
To: Andreas Dilger <adilger@dilger.ca>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 12:07=E2=80=AFAM Andreas Dilger <adilger@dilger.ca>=
 wrote:
>
> On Apr 22, 2026, at 12:17, Mateusz Guzik <mjguzik@gmail.com> wrote:
> > +     new =3D kmalloc(offsetof(struct file_systems_string, string) + ne=
wlen + 1,
> > +                   GFP_KERNEL);
> > +     if (!new)
> > +             return -ENOMEM;
>
> This is introducing an error case where there was none before, in a
> critical system file.  It would also be possible to fall back to
> seq_printf() instead of sprinft() if no buffer is available.
>

Fair, should be easy to do.

> > +     /*
> > +      * Populate the string.
> > +      *
> > +      * We know we have just enough space because we calculated the ri=
ght
> > +      * size the previous time we had the lock and confirmed the list =
has
> > +      * not changed after reacquiring it.
> > +      */
>
> It doesn't seem prudent to use raw sprintf() in a loop and justify this i=
n
> a comment, when the actual string generation is not performance critical.
> This could use scnprintf() and be "safer" even if it "should just work" (=
tm).
>

I don't get how that's supposed help anything. I still have to call
the routine in a loop, except this time I have to keep recalculating
remaining size by hand on top of it.

What this really wants is a string library which handles easy things
like this one, FreeBSD has something like this in
https://man.freebsd.org/cgi/man.cgi?sbuf(9) , but I certainly can't be
bothered to work on an equivalent or porting it over.

If one is to "overflow-proof this" with total disregard for
performance, a series of strlcats would do it.

> > +      usedlen =3D 0;
> >       tmp =3D file_systems;
> >       while (tmp) {
> > -             seq_printf(m, "%s\t%s\n",
> > +             usedlen +=3D sprintf(&new->string[usedlen], "%s\t%s\n",
> >                       (tmp->fs_flags & FS_REQUIRES_DEV) ? "" : "nodev",
> >                       tmp->name);
> >               tmp =3D tmp->next;
> >       }
> > -     read_unlock(&file_systems_lock);
> > +     BUG_ON(new->len !=3D strlen(new->string));
>
> Adding a BUG_ON() here seems gratuitous, when there are lots of other
> options to handle this case, especially if sprintf() didn't just corrupt
> memory for some reason.  It could allocate a larger buffer and retry,
> or in the worst case return an error instead of crashing the system.
>

Well nobody is supposed to get the splat, except maybe someone messing
with how the string is generated, so I don't really see your point --
it's purely a bug-catching measure.

However, it can still just print a warn and fallback to the current
pointer chasing.

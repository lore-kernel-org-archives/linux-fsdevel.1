Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAAC3403EC
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 07:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780039333; cv=pass; b=dD9a6mWtMh1Z/RFrDv2GNJP7VdrUV/+mkhhysH7XXWp+V+HuYVe1MTV41MX6zCE9Qe0QMizowXH3IMci4fwcP9tWvKflUCWZc+m7d2BC2LzWRnB8NSMWKC6wxlNwtmRZq1nkpqelM33ByrQe/ACzDTv9shuy+70h+E2ysdDQUS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780039333; c=relaxed/simple;
	bh=1ooRt5yESY5s/bnlhaojeFLGVxsIJO396Ozrp3aYZeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ny9YVzuFNUr9NWzx8aCQ7o8Gnf0DDu2RlfAbm8z9A0sUTGnltk3s5RdwK7kMCUtnyXyZgN8wpEYhqHulOQDLPp04QOgdWujm1JlV/t+ZcZq9uvO3pRLEkQGxD32ykHR/XGGVjvLtgF71SIFfBi+mkDZ+nh0rKsOZsCSOSCwvVlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lg8BCzfB; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lg8BCzfB"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-68c1653ea0cso401015a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 00:22:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780039330; cv=none;
        d=google.com; s=arc-20240605;
        b=E9JGNJ2FTL03mRzYD+SVVPN31zzRdl4u5S528oeK/a55oK7LRrskl4UkAlVjdUAyTE
         86zPcZKLMD5yqwhOEigMB2oDbnLu2p48OZBFPx4Gu4Nw32hxqiOTjoMfKftZlavTd9LK
         PUvDFsKxOVnbqhfISja/HyJ+GVLCWS1OKiE0tSX22Nmml0hJG2uovzvb5GLToi+d8SW3
         HWpTndvCV1YGKbxOz2Bqtl2srNBicderiJXacjpi6u5mzwchHdXkpe5MFDbI6/Llaibl
         jFvhUf2hB8z6GN8p3Z1mlV8ktVTl2h0cDxnLgqUTJhbzQmbh3vDFUwzhQZ+5wMJO4K2o
         H/yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4lnbwy4CxDtxFD+AVA6tQQtkMgBecPZSKbVqZVQYCF0=;
        fh=e28kqJgH84/kFZihe/tyo0omY6d1XHHjcVWQSNW0wM0=;
        b=cA8obMMyso/LM59BWKAHoK8V3uRMp1oJ27HI8EmQIkvwP01suWIoDFoskDOfJ1twEt
         yO/6rLf/P4c79w23vrNYFAF1qnPdlfT898BtZn0L6WCialYGQvE47svs6Q1ZN0+nfRmQ
         mfKfLcbJXD7rxvtlfI5jDqk+s4EFk2EGHqyWu3mUfp/h2eTsC7BFBQtPpm44lb7/iPjy
         WQ4R3Qg9CHRzDNn9hTpfTxyfqy0jspHEBXEU/CP47vnBXGUnmGB7/8nPEAcepKZ5FuXu
         6lmXYTYNOXG7Df855xDHBfxlksh+zmwUULBKu2I6xz0F1jUfHZl8tlSUfs5QokxUy8C+
         FpoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780039330; x=1780644130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4lnbwy4CxDtxFD+AVA6tQQtkMgBecPZSKbVqZVQYCF0=;
        b=lg8BCzfBuEwMJBtmS8eRTU9SGLRbxQ8Man9b6g+3rrHh8e+iwvY3x/EDrILafIffGh
         W3MOWDFRZazqyDTHwHm4i4Na+lBSeEp/mgo4eQxZtgS6MJ3o3nJJ9CeVrTYKQVJ+A7Y5
         586G5L9lQwbFbzbGAxpBIh/Vf16TaUn6eDFGG4M5/XGy6dsy59t+FnWYNtc6VTIWLy/j
         Dzdy46mXhaw3Dc+6/1xmcEJSzMjbHqKIaSar7wD9gxlNYqLdkbYpgoeIbC2xOj24wMi0
         bluWFTxApoRmxrOLGFHgvG/W4GLKk+K/buRZ9gEjrOyQRGqhqHeWJBsgPhp7GX08Imre
         8r/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780039330; x=1780644130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4lnbwy4CxDtxFD+AVA6tQQtkMgBecPZSKbVqZVQYCF0=;
        b=DKI+0QHeXcFR/tR01t3UzfldtX1ObOCePVW3xuhteqGyW1XDWZV2icgaC+GLQFNRxH
         Cg9smGcDdf6zX0WTe59BaNr2BUmyvdJqQESGKKxP0qzWKsAFoAJ02fOITp0aXxcCIRI8
         +cNaJSYVIoVd+aZDb5uiVAFwdLFRGGL/hEOI/+M0s+zrdPy9XQBQ4JWl50iAlOuGe8cT
         tSqoEI75SRdfFaEg1z89B2wYSa8u4wOmR7XpqdJOXXEYTaEqRvQ/4Wm0Ew0FrteE0Xku
         6njCjhcu1O81wdm+GnkiC7q+QuhqGIqp48pA8a8RSzHOJzpUIK90IOk1WUhmKqT1rKw/
         JpVw==
X-Forwarded-Encrypted: i=1; AFNElJ/qyar2D+r1gx7iFtPpcqOZT4hHVRptnSDeNYMYglzLLp7QIhTa2FgdR9aTz8DFSzPlLSzJjZY+kzXhqQ0O@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2y+2D1m3e7S2QSXw0ooi+HyI6ZFteLwRIPR+2H24kVXOqXAJV
	UleSCZ2gwQl2ibsVnQ4lpYOZcf/LRoNpIaUNgR0BDcImC1lqzT31YgSiZ9TF2GuJ/m0+FPGefO6
	we+BmA74Azar5EFu6fQ0rjMPF+7HNBnA=
X-Gm-Gg: Acq92OESOdl46rX13KBIXd2NtMJhlFodBkqU0z6N5+U3d3wqrWZ7DC8lrAJJfOj9vdg
	eo1YiE+cnvETII8yaT0i7yD0xmLouwtDGb7a6LzwPmTJqeOR6QsjUYJp4jJSZE4Y4anfQVJtfLl
	8xwR+wLSPpFMzF4JMMvRJy4p/ZmYZvXSsGzqww2XtV37k1e8CQhqfH+nSHCyLVJtkecGck0mxF1
	fg9mRs/OkZrkg9g4+bkYWvuYksKuiwct+9rq5P5QpexxycgyufV7wiIti75P1JG4xQ+i1GXmYN5
	f2n6N9W1/XQ12EriExkKuATohSXUSo9ZBZDrs75AQKd1Bz8s3pow
X-Received: by 2002:a05:6402:42cf:b0:68b:48c3:3f6 with SMTP id
 4fb4d7f45d1cf-68c1290f54amr807447a12.18.1780039329724; Fri, 29 May 2026
 00:22:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528-schmuckvoll-heilen-garen-be77b4208671@brauner> <20260529020035.17477-1-anonymemeow@gmail.com>
In-Reply-To: <20260529020035.17477-1-anonymemeow@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 29 May 2026 09:21:55 +0200
X-Gm-Features: AVHnY4Ksbi5I1TCbfb3tf8aoUJqIzFYWO5PCb26aZRZTKhYadGrMWiju4bgl7bs
Message-ID: <CAOQ4uxiGr7i=_H4XttS3kWKni1nT75BjnVNZM-0j2JnAHLY7cA@mail.gmail.com>
Subject: Re: [PATCH v2] fanotify: report thread pidfds for FAN_REPORT_TID
To: AnonymeMeow <anonymemeow@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, repnop@google.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 4:01=E2=80=AFAM AnonymeMeow <anonymemeow@gmail.com>=
 wrote:
>
> The FAN_REPORT_PIDFD and FAN_REPORT_TID flags used to be mutually
> exclusive because by the time the pidfd support was introduced to
> fanotify, pidfds could only be created for thread group leaders. Now
> that the pidfd API supports thread-specific pidfds via PIDFD_THREAD,
> this restriction can be lifted.
>
> Also drop the pid_has_task() check to allow pidfds to be reported for
> reaped tasks as well.

I am not objecting to this change, but as a rule of thumb, almost
every time that
a commit message says "Also" it means that it should have been a separate
commit.

This is not an exception to the rule and even worse -
This change PIDFD_STALE is an independent change of behavior
(as observed by breakage of fanotify21) that could (maybe unlikely)
surprise real users.

We have few options:
1. Make it opt-in with yet another fanotify_init flag
2. Enable it implicitly together (and in the same patch) with FAN_REPORT_TI=
D
3. Enable it without opt-in (as you did) but as separate patch
    that will be reverted if someone complains on "real world"
    (i.e. not test) breakage

IMO, the path of least resistance is option 2.
If users want to get the pidfd of tgid I suppose there should be no
problem to get it from the pidfd of the thread. Right?
So what FAN_REPORT_TID really means is give me a richer pidfd
with more information about the actor than without FAN_REPORT_TID.

I'd like to get Jan's input on those UAPI choices.

>
> Link: https://lore.kernel.org/lkml/20260528-schmuckvoll-heilen-garen-be77=
b4208671@brauner/
> Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
> ---
>
> On 2026-05-28 13:51 +0200, Christian Brauner wrote:
> > For quite a while the kernel refused to hand out pidfds for reaped
> > processes even if the struct pid was pinned like in this case.
> >
> > But that makes various APIs - including this one - way less powerful
> > than they can be. Nowadays the socket layer already hands out pidfds fo=
r
> > reaped processes. It also stashed the struct pid. Let's do the same
> > here.
> >
> > Drop the pid_has_task() change and then:
> >
> > pidfd =3D pidfd_prepare(event->pid, pidfd_flags | PIDFD_STALE, &pidfd_f=
ile);
> >
> > which instructs pidfs to and out a pidfd even if the task has already
> > been reaped. Reaped pidfds can still be queried for various types of
> > information that is kept around even if the task is long gone.
>
> Thanks for the review. I've updated this in v2 as you suggested.
>
> Also, the LTP fanotify21 test currently explicitly expects ESRCH or
> FAN_NOPIDFD for exited processes. I will update that test case accordingl=
y.

This sentence highlights the problematic aspect of this change.
How would you update the test expectation?
The test must be able to run on upstream as well as stable kernels.
Would you test for support in FAN_REPORT_TID
and according to the result determine the expected behavior of the
test cases (variants) without FAN_REPORT_TID?
Very ugly IMO.

OTH, if you take the suggestion that PIDFD_STALE is implied only
for FAN_REPORT_TID, you can change the expectation for the
"terminated child" test case only for TST_VARIANT_PIDFD_THREAD.

Thanks,
Amir.

>
> With Best Regards,
> AnonymeMeow
>
> ---
>  fs/notify/fanotify/fanotify_user.c | 33 +++++++-----------------------
>  1 file changed, 7 insertions(+), 26 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index ae904451dfc0..b604e3da58ad 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -19,6 +19,7 @@
>  #include <linux/memcontrol.h>
>  #include <linux/statfs.h>
>  #include <linux/exportfs.h>
> +#include <linux/pidfd.h>
>
>  #include <asm/ioctls.h>
>
> @@ -903,25 +904,13 @@ static ssize_t copy_event_to_user(struct fsnotify_g=
roup *group,
>                 metadata.fd =3D fd >=3D 0 ? fd : FAN_NOFD;
>
>         if (pidfd_mode) {
> -               /*
> -                * Complain if the FAN_REPORT_PIDFD and FAN_REPORT_TID mu=
tual
> -                * exclusion is ever lifted. At the time of incoporating =
pidfd
> -                * support within fanotify, the pidfd API only supported =
the
> -                * creation of pidfds for thread-group leaders.
> -                */
> -               WARN_ON_ONCE(FAN_GROUP_FLAG(group, FAN_REPORT_TID));
> +               unsigned int pidfd_flags =3D PIDFD_STALE;
>
> -               /*
> -                * The PIDTYPE_TGID check for an event->pid is performed
> -                * preemptively in an attempt to catch out cases where th=
e event
> -                * listener reads events after the event generating proce=
ss has
> -                * already terminated.  Depending on flag FAN_REPORT_FD_E=
RROR,
> -                * report either -ESRCH or FAN_NOPIDFD to the event liste=
ner in
> -                * those cases with all other pidfd creation errors repor=
ted as
> -                * the error code itself or as FAN_EPIDFD.
> -                */
> -               if (metadata.pid && pid_has_task(event->pid, PIDTYPE_TGID=
))
> -                       pidfd =3D pidfd_prepare(event->pid, 0, &pidfd_fil=
e);
> +               if (FAN_GROUP_FLAG(group, FAN_REPORT_TID))
> +                       pidfd_flags |=3D PIDFD_THREAD;
> +
> +               if (metadata.pid)
> +                       pidfd =3D pidfd_prepare(event->pid, pidfd_flags, =
&pidfd_file);
>
>                 if (!FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR) && pidfd =
< 0)
>                         pidfd =3D pidfd =3D=3D -ESRCH ? FAN_NOPIDFD : FAN=
_EPIDFD;
> @@ -1628,14 +1617,6 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags=
, unsigned int, event_f_flags)
>  #endif
>                 return -EINVAL;
>
> -       /*
> -        * A pidfd can only be returned for a thread-group leader; thus
> -        * FAN_REPORT_PIDFD and FAN_REPORT_TID need to remain mutually
> -        * exclusive.
> -        */
> -       if ((flags & FAN_REPORT_PIDFD) && (flags & FAN_REPORT_TID))
> -               return -EINVAL;
> -
>         /* Don't allow mixing mnt events with inode events for now */
>         if (flags & FAN_REPORT_MNT) {
>                 if (class !=3D FAN_CLASS_NOTIF)
> --
> 2.54.0
>

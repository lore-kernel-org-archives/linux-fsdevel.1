Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F593D8135
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 10:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780050745; cv=pass; b=ZMWR7sqey2ETsEA3P2Ordz4WPfFYC88ksL+OYsiXVDDD/f7tQE76ZVF72l2rm4x0D7ViUrvD4T/t0DooA4Vj8vpuQ0agHQOqNhhaHxRpL1bDpWZ3rcOdHpAkCnejltQ6fndes8V564WomsAwEd9D+14uQ6/mBOK2zDjwyZGshyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780050745; c=relaxed/simple;
	bh=0Z8G8Fc03t0xe4iIts5vzMlUzLhqURpN5rsJJExa7wk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EsSGpn2GA+Tv2SKvdRMdmdZhNoHs245cUwoppAPaVUsduapyzVQsNaCYjyucnBWY1H1c6fwFR1USKm6CIED3nlMFO128ngeiXM4+UlF6Vc8+q2wCXPleqZ4Yv7AXYEHMqGqqpIcSRPSPflgnXZbdxsyr+dsmKOaWCd7BHecqIDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxxy3zNN; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxxy3zNN"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-68c19f1f3ceso730398a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 03:32:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780050738; cv=none;
        d=google.com; s=arc-20240605;
        b=JwIQXkJAgZOQQD1sKmetiquk5VCjMpBXlgwrDODIsySDRHbQXB/ZaBa/8seg+Yn8/3
         2E58rnr/ka3rNRudyECRzin/Ip9vY+yJbEFelh63gqYboWyVFHkXqOtTzClDMTAb+Y4d
         eJDXiO94y7FJvLvo8y9zC8VVHfd5wHal15ncltu0KJAkiMfsMrU8iYZo3GKuVkZoRzxp
         unLcs0WqWgPVH0T+8PMB9VVsM/R3lHOM5Dry9/Ag7tFy6EkCVVDA0HCdY80/4xBnBVNr
         Xe2UshEE9TDG4gWpSBGms36UsFT19T1+UCXDd80GcnlAvQYOALH6xJPywpbyM+6RejOl
         nKsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KlNYEgnUJFjtyAdqaqrXO6t79cGa+JdphkQwWnHLbDA=;
        fh=CRERso476dIVVRohgv/yMPNfmJZtDarWL0bTV93W5tk=;
        b=PROtSNMer/Avq9SsBX3GLmazNuseCWR7mmPBhdcj4T4bH52Or+lzVBpvX6gvRAEFhR
         D809BrWKQbIMkFMR49hVApHEbmUPskvoma+FKzZWujfqXa8QOsYFGPw+kI92DxDzpPXA
         TVIMdjdO1j6fZ7/92umXW2fyYgy7vQ/AifDH+2rYzWfl+B1fwBREDpbQkBuJaRWHoElZ
         +ewFF2Vet9fTbVHApp0AojcBT4jciHyQkME3lNq3qNH9hVy2mMU4A/RktPNJnEM6+0m9
         yRBSp0T4SjhQ9hlk3DbqtBPQGyHo28lmo03FDzbCDg2TcE4H2xERmFCHHDuCpLWxUam9
         AqTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780050738; x=1780655538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlNYEgnUJFjtyAdqaqrXO6t79cGa+JdphkQwWnHLbDA=;
        b=hxxy3zNNEAwbtCc/GsCZLFn6X5seMbBrg3V3cAzpg0qxvAxmLPvTDZUdTAYgF1rMcv
         d3tyXGneANo/eXlomUQynfiQENwWCcKd2qXMAohP4DrZLn9F6qbMw+gfv6krafgzbMRr
         7W/VG64r4Kpc0cPXUv/a4nHKLO+jcKzJ9Jc1xxYM6pbqEPjBqlqvJC8ZheenbFwdumYT
         Ap/CZu0QNnYfh1HS3i4cLOzO1rqWqy0cUkxFKAk2PkOu+nMrwTXmrL/9PpCWfjmZN9k7
         Fj61mg93xLaW38XDWKwZ0OFQ8hKUjzQSMnee5zlUO8o1/9bUPvnbE7casNoSLcvxcsfa
         eHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780050738; x=1780655538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KlNYEgnUJFjtyAdqaqrXO6t79cGa+JdphkQwWnHLbDA=;
        b=c7I6VM/sXTRJA03m73/gZMW6h2MFFrLoQB9VITgwv2GXUBAcdDNghJ50C3JcbgeHw0
         AYXcPAALz9b3svpc3Pvt5YK9F7Ym+hGLxv7Vu/2metc6oAbK7uAQRNg53BlizhcIogro
         c8cgt1vXO2A2s3x1RjgFAJ5Wiiunp1HnorHB1VdVIwvDvWpzAuEglz8xxY6ooFboEDHa
         s2y5x1ipbg5MwD53q2OrSuvPbwFyi0SJkPTcSCus6QjSZG51S5tRYxHauxlDJi4a2zs9
         7ICpOEp4MKIUlJoKyj+BtY16BdDljmEp4QvB4EJ8TuaPKHbV8ElOP91hNKTXABQYJdC8
         A+Uw==
X-Forwarded-Encrypted: i=1; AFNElJ+RnIJ6Ih9ZVS7ZCygFARLYW11ao4uGwz01d9ZxOK50WC0myj0jwBOWp96I1T+FWFaY6yu/Ahg49L+4GHJL@vger.kernel.org
X-Gm-Message-State: AOJu0YxQbFHPlqrQnUsIlcOUAbp+NOISAmC5hCBEzabB8rvMNY7ZC5TT
	LwFEandMYcJF835gGls8qYfOay0JMGbRtWEbtmTK7BsuwcAOA8VlJmclzXRvmCNvo746Pxm61a+
	ciVMlAiOix2/H1pLgryHrg7BvJaAWfZc=
X-Gm-Gg: Acq92OFY0CQeF1vmbYnJ3KGcs2eZsIqxi4MIXMmgRD83z9qtHR/FKBeLGJiU/34ljIV
	L3DIxcUlloXa+p198EKf7alJJ7bc2UVh0qrrtt3Won6iHrLu00ddOeiU5f8qFRRm4NqfPTT+H/v
	+nXQGm/v2H9isvKjxBOIxSeZUiWFgAs+nV4KwBAELR6Ux2uGApy28C+BToisGYABlOOM9R43hIO
	bthibURxRa4KtapiureZMZwXG76uygSpNCT4BKZuGbIdLwKYK0lqXGpWgZkf/oRi5PBzlj03wan
	co6Cp4WN5fi1HxK48WSN4cYNoQaSSggf7A8nQ+AGbZJdBNECf0WB
X-Received: by 2002:a05:6402:40c7:b0:68b:ce88:9d3f with SMTP id
 4fb4d7f45d1cf-68c11657878mr1129718a12.22.1780050737378; Fri, 29 May 2026
 03:32:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528-schmuckvoll-heilen-garen-be77b4208671@brauner>
 <20260529020035.17477-1-anonymemeow@gmail.com> <CAOQ4uxiGr7i=_H4XttS3kWKni1nT75BjnVNZM-0j2JnAHLY7cA@mail.gmail.com>
 <20260529-erdig-eckig-querulant-439a4ba4317d@brauner>
In-Reply-To: <20260529-erdig-eckig-querulant-439a4ba4317d@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 29 May 2026 12:32:06 +0200
X-Gm-Features: AVHnY4L1WhirJUgq1nbYINA2dO20vufByH80KeKyRkuT7c1H8CIBAS36F70anQg
Message-ID: <CAOQ4uxi_5QArLFcgcWKjyWmomrHje_rvVQm=6Cf7NEh7JBcVKw@mail.gmail.com>
Subject: Re: [PATCH v2] fanotify: report thread pidfds for FAN_REPORT_TID
To: Christian Brauner <brauner@kernel.org>
Cc: AnonymeMeow <anonymemeow@gmail.com>, jack@suse.cz, repnop@google.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 9:40=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Fri, May 29, 2026 at 09:21:55AM +0200, Amir Goldstein wrote:
> > On Fri, May 29, 2026 at 4:01=E2=80=AFAM AnonymeMeow <anonymemeow@gmail.=
com> wrote:
> > >
> > > The FAN_REPORT_PIDFD and FAN_REPORT_TID flags used to be mutually
> > > exclusive because by the time the pidfd support was introduced to
> > > fanotify, pidfds could only be created for thread group leaders. Now
> > > that the pidfd API supports thread-specific pidfds via PIDFD_THREAD,
> > > this restriction can be lifted.
> > >
> > > Also drop the pid_has_task() check to allow pidfds to be reported for
> > > reaped tasks as well.
> >
> > I am not objecting to this change, but as a rule of thumb, almost
> > every time that
> > a commit message says "Also" it means that it should have been a separa=
te
> > commit.
> >
> > This is not an exception to the rule and even worse -
> > This change PIDFD_STALE is an independent change of behavior
> > (as observed by breakage of fanotify21) that could (maybe unlikely)
> > surprise real users.
>
> I don't think so. It's the same as when we enabled PIDFD_STALE for
> AF_UNIX sockets: it strictly expanded the usability of the interface as
> you could now reliably get a pidfd for all events and get stronger
> guarantees.
>
> > We have few options:
> > 1. Make it opt-in with yet another fanotify_init flag
> > 2. Enable it implicitly together (and in the same patch) with FAN_REPOR=
T_TID
> > 3. Enable it without opt-in (as you did) but as separate patch
> >     that will be reverted if someone complains on "real world"
> >     (i.e. not test) breakage
> >
> > IMO, the path of least resistance is option 2.
> > If users want to get the pidfd of tgid I suppose there should be no
> > problem to get it from the pidfd of the thread. Right?
> > So what FAN_REPORT_TID really means is give me a richer pidfd
> > with more information about the actor than without FAN_REPORT_TID.
> >
> > I'd like to get Jan's input on those UAPI choices.
> >
> > >
> > > Link: https://lore.kernel.org/lkml/20260528-schmuckvoll-heilen-garen-=
be77b4208671@brauner/
> > > Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
> > > ---
> > >
> > > On 2026-05-28 13:51 +0200, Christian Brauner wrote:
> > > > For quite a while the kernel refused to hand out pidfds for reaped
> > > > processes even if the struct pid was pinned like in this case.
> > > >
> > > > But that makes various APIs - including this one - way less powerfu=
l
> > > > than they can be. Nowadays the socket layer already hands out pidfd=
s for
> > > > reaped processes. It also stashed the struct pid. Let's do the same
> > > > here.
> > > >
> > > > Drop the pid_has_task() change and then:
> > > >
> > > > pidfd =3D pidfd_prepare(event->pid, pidfd_flags | PIDFD_STALE, &pid=
fd_file);
> > > >
> > > > which instructs pidfs to and out a pidfd even if the task has alrea=
dy
> > > > been reaped. Reaped pidfds can still be queried for various types o=
f
> > > > information that is kept around even if the task is long gone.
> > >
> > > Thanks for the review. I've updated this in v2 as you suggested.
> > >
> > > Also, the LTP fanotify21 test currently explicitly expects ESRCH or
> > > FAN_NOPIDFD for exited processes. I will update that test case accord=
ingly.
> >
> > This sentence highlights the problematic aspect of this change.
> > How would you update the test expectation?
> > The test must be able to run on upstream as well as stable kernels.
> > Would you test for support in FAN_REPORT_TID
> > and according to the result determine the expected behavior of the
> > test cases (variants) without FAN_REPORT_TID?
> > Very ugly IMO.
> >
> > OTH, if you take the suggestion that PIDFD_STALE is implied only
> > for FAN_REPORT_TID, you can change the expectation for the
> > "terminated child" test case only for TST_VARIANT_PIDFD_THREAD.
>
> I think this is just not worth it. It brings users no value if they get
> slightly different semantics for effectively the same API. I don't see
> what the problem is with just enabling it and fixing the LTP tests.
> We've done that so many times before when APIs get extended.

Of course, fixing LTP tests is no problem.
I'm just not sure what the expectation should be for test that
runs on different stable kernels and I assume this change cannot
be backported all the way to all versions with FAN_REPORT_PIDFD
support. If the test can be made to support both its fine.

>
> Worst-case someone comes back and tells us that they were relying on
> that specific behavior then you just revert. So I would propose to add a
> separate patch on top of PIDFD_THREAD that enables PIDFD_STALE
> unconditionally. If this leads to non-test regressions revert the patch.

I can live with that, but the legacy flag behavior change  needs to be in
a patch of its own clearly stating this change.

Thanks,
Amir.

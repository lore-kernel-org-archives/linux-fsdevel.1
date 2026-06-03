Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AA237188B
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 12:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780488160; cv=pass; b=fetXAk9hHIDzJUI32q9BK1HgtXkfNST0P9QabOYgmrXe6upeGMU5urnxcHAL7L93pAb5AcMkFtuOiVVFv7BaHiSE2/64x/FUUT59DJzrOXUaSh1v5xd2fhaUkfFV6Spr4Qq+ebX9Pi49q8F6wY3GeBBjmYcvsrsoBQYOrD1NgKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780488160; c=relaxed/simple;
	bh=owyXeRKGW+c5fp41gUIIcTObCbc3vEQMYLzPXAcYr0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9EzoowPipt70atz1NXbpUfU5UatEyM7igEwHduTNFORvXMGtZgjJMQGk77JaILFnITnHfAmupByVViLKL2JvqGKd3bpKgP+AxBAmx5axdXwxaGQftPndFplVixsYHaBnat1u/StPDuUq3lCMok0eC+SAlM5R2pIxKOQVZur1jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLI4LWzx; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLI4LWzx"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-68ad1e513d3so10426409a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 05:02:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780488157; cv=none;
        d=google.com; s=arc-20240605;
        b=cqX4IZKLRa+MIN6gG5IQTm2/8oRUjjOTYdemje52v4E1mL57n0D/BewPWoqvhIA+3Z
         sQmqcfZeUGmJ2vyT706JznXMKD/stMTYbRLMf6LWGztc/9P6jlrC48aiHnCsF7MHOFgx
         sDCKQS1ReuMpHrBkUSW2x2keF26ZfKMkvZbnShq3hKxT7Y496hj/Ltryv1xsu0bun6tq
         D5GgcCiEhJ61e9y5T15nGgDP/yEYLH2HgXDfdr/XS+77E06cVDvZdvfA4V18fdDBK8av
         wOr/6hLUA1gqslpTHHJIf49X7OqgY+zUmVIjV6hcpEKXClF9WPESkm62Cz/CcuBqm0tY
         7OnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=owyXeRKGW+c5fp41gUIIcTObCbc3vEQMYLzPXAcYr0Q=;
        fh=E+6WtmlVi96LsZ13k0BQ7mF5vR0ptHl5imShHUBT1Ao=;
        b=LzItpHM9u64/dQ/moegI3Eyc/ng59RCiaU97SYaMiVr7I/iuM3yZJ3Uj8/WQtSt8z9
         CgtX00BdDuvonknmAe/kN8y7rslkATncFbLoOqz2X25ojaY5ASFHL0g4/wl5oFOPZ7c5
         4dnh2OMrv9U7ifDusoxj8rpgp2XO8cNeisRsrEg3tVbuj/wlv14Bsoy2QHxXO7G+qUkl
         qG+djQbPG6gnBVbgmlUMzg6Zjf3kgtDaJ9g3kk9RNKQ+3XhoLuf8Zz30G4VPYsiPk96x
         H0x/katNfTbbE7xgn5pDiOYS0w3KUugyAC9PzNcPpx6+3FJvo5D0WW7o9HOtGfCRzQYK
         /3CA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780488157; x=1781092957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owyXeRKGW+c5fp41gUIIcTObCbc3vEQMYLzPXAcYr0Q=;
        b=XLI4LWzxdFpyZoEeEin9akP3rQXDEz0cg8Ofnn8NmoXg9KIvoL+Kz+eW93XweWIL5g
         tllPaILZROUBjViB2O6PymVvOwJOB85f+6Mpe/bNJdl37LnEFwCteJacoBGV9U3opeO1
         Dcoz7Auo290YXLUTokZmt/o3NP2Y6kuM0hMfMM7eG2+WbcQulE66nkwcQXqTRFok2Sjq
         tpNLcPK6WZ5dsNOh85d/o5CkalMd32nlh+XI1JIlYzOqj4eY1vlKG6/zSYMFIC1L9UDl
         iQd7Aqu6QSoNeqMYa59Jw57eqgWSpF8taoRDS+uQy1GfXHrUw+IBNhx+qnRln7tBmah8
         YcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780488157; x=1781092957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=owyXeRKGW+c5fp41gUIIcTObCbc3vEQMYLzPXAcYr0Q=;
        b=hHQOQI7898xecy7a69Ym+fU/cf8Q6PzdYQ2FxHFFf0fwV8A5IAbREiHqstG/CWUWKF
         4DkE4C3V0MsJMdTjJmGfcGevyuLPgoz1EqkS5zsQpdF9Ao0R9ZVvCrG7OVtIk9sGS7d7
         Lak/ANGOmSSdzhIxnAuwRg2VakSFyGMLizjNdHb3IR3dS/JUG0uo5MZtGWxdB76aOsTJ
         1Rj90hCO7uVvFLiOGhPLpkSYsgkmChW3iXK9fm30LSYZy3Stoa0J1g+Vd73KHXvPmIZ3
         XJsFOHh7/zRFY0w0FAq4cLSPtAZLt0PcXAgaiwoC1iAOsgzzXC3R9A+/3NtvAjTYVBIZ
         FTwQ==
X-Forwarded-Encrypted: i=1; AFNElJ/b84w/rhRswmD7EpsBW5o9Uf3hnpL3fKI8hQ9lm1USix9Al+ytYdkGmuI0l5WfnoNTUrS/kCzWOmV2EEqb@vger.kernel.org
X-Gm-Message-State: AOJu0YwwcpX1ACpjq03bR4swws7tuuEAk5O+EQ05E9xK0N5P7f4W8Hro
	J76IQWui6/Erotf3JoD1Jyx0vICN4z+CwAiAbRiOJOgtSiepBVSP2Ul/PfNq+OEh+1wHVIMX8I3
	6kyU4fvhmqA9YTj/WxF23xLlwquthXhU=
X-Gm-Gg: Acq92OHr1ndVRx4xo/65aFnycB0jXrTMzaGcrvzg+1YlZmuMjD22KsbnkpXCrqXll4B
	Xc2YdQIBN99LRR14Nk475+D3UQx+c/GkQdKBu62IHZbvVbR5GWEzif2i3ZidXCCnw9SUMFkr4SU
	Zb1AR9AilC8o1SwpSGEI91qaAFNBuiBi3CdTHLcVfU37JLhkbz7wTfPvPO5PeODCWgSgS2f3v1l
	yTmm60v3A1YI3C2tuc1NNv6agm+IQ9WPdIEOOWe/4scKtCKEBEvFoCvlHFLRmBMdvoWHpksFiy5
	M5yL8G/EyvzVz8zCVW0nKoAjB4fRbsrbJqN3pL0nU8X0YfqnbZeoqboWZ7ZH8CY=
X-Received: by 2002:a05:6402:3481:b0:689:5dd6:23d8 with SMTP id
 4fb4d7f45d1cf-68e70507e29mr1573150a12.10.1780488155375; Wed, 03 Jun 2026
 05:02:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603001516.26234-3-anonymemeow@gmail.com> <20260603031117.20950-1-anonymemeow@gmail.com>
 <CAOQ4uxgudh_W2Gcs5qqGce8yO6503yjrGzEwbjTKkT+DLAqufA@mail.gmail.com>
 <20260603-schindel-drehzahl-planlos-e334e6899cd5@brauner> <CAOQ4uxgEnD6aN4HTh14=SPzU25_2xOXxfnY+60udOqNp3nnm4w@mail.gmail.com>
 <20260603-mehrsprachig-altlasten-unverantwortlich-4fcd029306b0@brauner>
In-Reply-To: <20260603-mehrsprachig-altlasten-unverantwortlich-4fcd029306b0@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 3 Jun 2026 14:02:23 +0200
X-Gm-Features: AVHnY4IzzOPc2WXnsxze_5MVuuPE-8Jvx1fyG-ilbzTKOVcHbvMdWDxuMx9yETo
Message-ID: <CAOQ4uxj-3Jdzz0JqjnG8qfjJAQoFGYDK8K8MPwza6MuLGgYx-A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] fanotify: allow reporting pidfds for reaped tasks
To: Christian Brauner <brauner@kernel.org>
Cc: AnonymeMeow <anonymemeow@gmail.com>, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 1:25=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Wed, Jun 03, 2026 at 12:58:09PM +0200, Amir Goldstein wrote:
> > On Wed, Jun 3, 2026 at 12:28=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > On Wed, Jun 03, 2026 at 12:00:42PM +0200, Amir Goldstein wrote:
> > > > On Wed, Jun 3, 2026 at 5:11=E2=80=AFAM AnonymeMeow <anonymemeow@gma=
il.com> wrote:
> > > > >
> > > > > Sashiko said that pidfs_register_pid() can fail under memory pres=
sure,
> > > > > since it allocates memory using GFP_KERNEL without a way to pass =
in
> > > > > __GFP_NOFAIL. This can cause fanotify_alloc_event() to silently d=
rop
> > > > > the event even when the group has an unlimited queue length.
> > > > >
> > > > > Should we make pidfs registration best-effort instead and still r=
eturn
> > > > > the allocated event if pidfs_register_pid() fails? But IMO this w=
ill
> > > > > make the API semantically ambiguous. If the kernel guarantees tha=
t the
> > > > > event pid is registered with pidfs when pidfd reporting is reques=
ted,
> > > > > then a later FAN_NOPIDFD or -ESRCH can only be caused by the task=
 being
> > > > > invisible within the reader's pid namespace. But if we allow best=
-effort
> > > > > registration, the event may still carry a pinned struct pid, but =
pidfs
> > > > > registration may have failed due to memory pressure. If userspace=
 reads
> > > > > the event after the task has been reaped, it still gets a FAN_NOP=
IDFD
> > > > > or -ESRCH due to failed pidfs registration caused by memory press=
ure,
> > > > > IMO this should be reported as a -ENOMEM instead of -ESRCH. But
> > > > > currently it seems we don't have a good way to register the pid w=
ith
> > > > > __GFP_NOFAIL or __GFP_RETRY_MAYFAIL, so what would be the preferr=
ed
> > > > > approach to handle this situation?
> > > >
> > > > Thanks for noticing the oddity and explaining the options.
> > > >
> > > > We could fail the event in case on ENOMEM because the system
> > > > is likely is a bad shape anyway and other events are likely to fail
> > > > allocation themselves, so I am not objecting to your patch as is,
> > > >
> > > > but I am slightly leaning towards the semantically ambiguous API.
> > >
> > > As usual, I think a semantically ambiguous api should be avoided.
> > >
> > > > I don't think that we are going to change the man page to say that
> > > > FAN_REPORT_PIDFD is guaranteed to return a pidfd, maybe we just
> > > > add a NOTE about increased likelihood of getting a pidfd since kern=
el XXX
> > > > and mention the known cases of pid namespace and ENOMEM.
> > >
> > > The pid namespace shouldn't matter.
> >
> > DO you mean that the event reader inside a pidns always gets a pidfd bu=
t
> > it will not be able to query the pid of the process outside the pidns
> > or do you mean something else?
>
> So they will always get a pidfd since fanotify is correctly using
> pidfd_prepare() directly. But when the reader tries to resolve the pidfd
> to say a pid or retrieve info via the pidfd info ioctl they would fail
> to do so (well, the pid will resolve to 0 which is the global indicator
> for "can't be resolved in your pidns").

It's fine by me. I am fine with failing the event in case of ENOMEM.

Thanks,
Amir.

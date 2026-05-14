Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F80388360
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 20:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778789731; cv=pass; b=YCNc7oqpRUFfbBzOGfpGkRR51RIZq11POpSxGuuGiUlYFAm+kydMcnrbHmtVdTxSBuFTHSKgg04s1yxHebQokEcND8NeTfNIXUTAv7hxnWvz1q5vHZo1FS9PQ1wrIov/Xyx+d/JCTp2DUQ4wDJqhr3ITvj7aroRD0N7enRHJbkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778789731; c=relaxed/simple;
	bh=L23g/GV6s5dbwKzNwqZYuRfdnx5W42pO/aIZUxIvmnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gs5jHh8McRUAJMAkKtrs9vMx0h0KwYyG30hw92u0v9eys2wc9SO1ZRwFWTKktP+fBceatusu0oBLCa50kFrtm27pHKy6+CfZpRv+/ErkRleJlW80AkHTUQ0E31j2ketsVV7jqo7g5tXoSJFLR6TR0rxVeBIoYdQCCpSDLkyCJP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=f1PuyjQw; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="f1PuyjQw"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2bc763e2ba8so30501245ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 13:15:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778789728; cv=none;
        d=google.com; s=arc-20240605;
        b=RRfd35HPzRTEU4XEOtXGI4c4pcbgzZem4IK71gLUfW7fyF9f4HJdiax9G3ODTZz/jW
         D2BKv8ZGUrbjTJZZf1H3W/vhqXTdm4lrORkVEQ8OmY7hmOb/seKWlnpfHqWBqZF2Xj2P
         psyNMM2qG59FWImudIq0xHalWEOwvokXZW1TRYwu5+cLQXn5ulluwYgLax81uwpQVei4
         FUeuRPiVVfkwGidyFyH5GhgJUo88hEwxhy8h7OmT3FhaeXC0VJRg/FQUHK3MBWtL27Jz
         M4WB9NXIXTN0smI1xYeclSdRcP5xyNgqLZ1w392D2umerHDT7c6+dLqDfT8wFM2WzViI
         NMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dSkJycESPksBK1TkswZjGhIZC6pa0KpxZLEtY/1MYi0=;
        fh=lVlSQ7GIYx10prCmxgjOEBitZlURrU98O5AD23prdPw=;
        b=Csm+UAFoNtgWMlUsQTpDIzoutsb458fwgYrnpWvyNLuynnA7pLOmcpaLQWUpLrhCXM
         urgkm4XARrLzlQErI1GKKeuGQDDI6xW3gNJb68BJShKcv+vldDapiHaPBY0DG+RDH2l7
         HZUoVODJL+jHf7NDYXH9MsPdDGSxnH6ADJXL6icltx+BBEksqz+2BveSGT4iilJNBkd/
         tdPVe04B0HUoaSSUxK5oq0d5yb7vcq40nvdyDBf1lKGHppIiTfrbA6FGFlsGPdGAF0YO
         QkKDxMQnR2Ao5eA7cEx4rKsZVOndmTGpHrEPh9YjxOFA/cfMfJ3aWoyotcWNESSYT7Yw
         7UVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778789728; x=1779394528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSkJycESPksBK1TkswZjGhIZC6pa0KpxZLEtY/1MYi0=;
        b=f1PuyjQwJ2UPuKHYXu4AJK5jjx5qZA4xMN8oFmbMM5S8Ac7A8EiC4bFv8+yK3zvR58
         RprWQ6iZssF/m9KgvXeFW+e/fzXz+kFwBq0KrD4Gi9RSNABJXL/KRxqv69FLRbbZfium
         OtPKil4Kj04QLGDjz1ygQEO3t899yWsx+Qrt0cueifTj5DPn7bxlo2pF0kxZg9lR4ls6
         6bCpNlNg9E6Re+ogkUPfb7zhGQWImdudVZqXjBIyWFlx7ecR8ijcCmF8CKrT11IYwuEl
         fi3RvMyvB5buo0+DFYZV+OWp3hDZRXe8/92UMlTyLvVYMn4mdWrmlukj15scfYShu40H
         4oVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778789728; x=1779394528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dSkJycESPksBK1TkswZjGhIZC6pa0KpxZLEtY/1MYi0=;
        b=IQ2Hyr7BehIt6+p+bjBsaVhIqXalx1AqNPMPYmR4Q34wt5TNo4OSr0CkDTdmnZE6wS
         LHkCR6k2k846XXZnpetahn8wIDo9CHCUM0s7Nn3pjGyG78PS0PuNdUrH+/ftvKwhM5it
         lGIpnxCNFYpD55chCejOc0nlBazsVC03jgQKe4yOjnht1E9RPwQWpJcaNw2ifNzc3M6a
         RGzTRRvuUBe602G3QNJEZWty/yLzlBuggf9YEMaNogS33Xf0NMHJL7s/BYrognWcZPCV
         pk1Hl2N+eWlsAZNeR4UfTl7JJz4klHVGvwHIdAa6tIyUnU53vEf6bPfK3m2Ua2O516pJ
         00fw==
X-Forwarded-Encrypted: i=1; AFNElJ9fdyNn6l0KyZ6FWvsozySWX9WQwsfcTaKvEAldg7uPy4kfCxM/2P5uv4FrDMJOYrznKhXo/rO98vn8Q4an@vger.kernel.org
X-Gm-Message-State: AOJu0YxOn5LEtY4MDZb49hPoNVH4O6AsvaM5A1FlFt9L4ljfc0vh8jdn
	auZy64qSFTBSY1P/PEWp3Mhas5Fn1akhgQCol1OtA2lxZFH/jHPgvsuAwSea5d1vKHGIqQV9kbd
	7L0O/S5hfiEVspv0JdvWJsxgpNADh+DNMhuEg2TGD
X-Gm-Gg: Acq92OEtwoBS9Riyyp1wfUQXEI1Tl5cXzhdjWJ2XlTqOVfqlcXs5CIwiTrtOvsR5NBF
	VM7vk9baDxTmqpPuT5A0kJlbQV/X+pFS0dB1QwESh9qNDrd6WLtPn9zw3LB3It2u2jnjt8WtBjU
	ImslFQZYnGknO2Tf/xZgOedOxZRgAhw06v5e+udbRZdXOEqP+PcD93gkLPfZS4IL9AvWUqbm6Vx
	vNhSniIU8XU2/e4D5j8f9jaKLvsNRpLidd0pw2LW1pBJGJBbWUBha17suRvuMVG2y7VtZbs3xpv
	P+U2l8E=
X-Received: by 2002:a17:903:94e:b0:2b9:f59e:aca5 with SMTP id
 d9443c01a7336-2bd7e9e7777mr8938935ad.39.1778789727707; Thu, 14 May 2026
 13:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509213803.968464-1-atomlin@atomlin.com> <20260509213803.968464-4-atomlin@atomlin.com>
 <CAHC9VhQthq7y2akbQSdJwBEex1MQYWG49wcJK3b8gSQuQ_d1cQ@mail.gmail.com> <bscbywzzx4nmxzbuw2bkzltb7rrmgmzy5u4gqy5pfpmafcnlto@eznniiguusqb>
In-Reply-To: <bscbywzzx4nmxzbuw2bkzltb7rrmgmzy5u4gqy5pfpmafcnlto@eznniiguusqb>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 14 May 2026 16:15:15 -0400
X-Gm-Features: AVHnY4J6HtYDS9Lrpjl43i8SgHkaXzBYbs_PTjoO3Mw_C9TveMyo-g1mcK1Gb3Q
Message-ID: <CAHC9VhSWrJc=aE1Sg4xfv1ZMmh=JqZFLWGeG2SnzOFqXxcUbtQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] security: Expand task_setscheduler LSM hook to
 include CPU affinity mask
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: tsbogend@alpha.franken.de, jmorris@namei.org, serge@hallyn.com, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, stephen.smalley.work@gmail.com, 
	casey@schaufler-ca.com, longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, 
	mkoutny@suse.com, chenridong@huaweicloud.com, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	kprateek.nayak@amd.com, omosnace@redhat.com, kees@kernel.org, neelx@suse.com, 
	sean@ashe.io, chjohnst@gmail.com, steve@abita.co, mproche@gmail.com, 
	nick.lange@gmail.com, cgroups@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 3:49=E2=80=AFPM Aaron Tomlin <atomlin@atomlin.com> =
wrote:
> On Mon, May 11, 2026 at 04:28:09PM -0400, Paul Moore wrote:
> [ ... ]
> > > Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> > > ---
> > >  arch/mips/kernel/mips-mt-fpaff.c | 30 +++++++++++++++++-------------
> > >  fs/proc/base.c                   |  2 +-
> > >  include/linux/lsm_hook_defs.h    |  3 ++-
> > >  include/linux/security.h         | 11 +++++++----
> > >  kernel/cgroup/cpuset.c           |  4 ++--
> > >  kernel/sched/syscalls.c          |  4 ++--
> > >  security/commoncap.c             |  7 +++++--
> > >  security/security.c              | 11 ++++++-----
> > >  security/selinux/hooks.c         |  3 ++-
> > >  security/smack/smack_lsm.c       | 11 +++++++++--
> > >  10 files changed, 53 insertions(+), 33 deletions(-)
> >
> > I haven't looked too closely at this patch yet, but based on a quick
> > glance, can you help me understand why it is included with the other
> > two patches in one patchset?  The other two patches look like stable
> > level kernel bug fixes, while this patch introduces functionality to
> > an existing LSM hook; one of these is not like the others :)
> >
> > Unless there is something critical that I'm missing here, I would
> > suggest splitting this patch out from the other two bugfixes for
> > separate handling.  If there is a patch dependency issue you can
> > always mention that in the cover letter.
>
> Hi Paul,
>
> Thank you for taking the time to have a look.
>
> You raise a perfectly valid point.
>
> Please note, the cgroup-related BUG fix will be dropped from the next
> iteration of this series. As per Waiman Long (on Cc), a solution for the
> BUG was already proposed here [1].

That's good news.  I saw some discussion on that but didn't follow it
very closely.

> However, I suspect the MIPS-related patch will need to remain coupled wit=
h
> this feature patch. Because the first patch fundamentally alters the
> signature of the security_task_setscheduler() hook, the MIPS FPU affinity
> code must be updated concurrently to accommodate the new parameter.

I generally dislike when bug fixes depend on new functionality; it's
backwards in my opinion.  I would much rather see the MIPS bug fix
patch submitted as a standalone patch and then have the LSM hook
modification patch come separately, perhaps with a note that it
depends on the bug fix patch.

--=20
paul-moore.com

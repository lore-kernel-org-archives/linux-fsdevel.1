Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E15F40099B
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 07:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785309749; cv=pass; b=bc/YuQynhl42sLeNXSW0ycjLX4hCjn67sQ7gGQNzH3VXlHu9FaPPKE11THfGuuNzcTIY5l1NMvHcM7FM5A03klUPFrhkvkREiiL0xBhvgL0fs4g0R8F4xQy/Zr2lEpIdZGxg8N4ujYawmolp/KTVQ90r4vJl5xqXX4DxKurvdSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785309749; c=relaxed/simple;
	bh=Ay8+sv6/4lBX+GsE1qrkhABbt8LsmqB3xe1G07IhnUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=neYrSKIL669DxwAHf5yoa71eAi3cdKSJ4xybKgCgaVX3FqLHxXEQSy7a3YOgNl2ba6bcVdOCxuSRPXIYuk1dCrrKTYv4Rbw1n5I9ADwUGSnhQ7+9DWP+8Ev4p4jQTwR/b+umNypafieu/BR4gyc/E8tufvgjrn0kc85MYbHoJSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8xpaO0g; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8xpaO0g"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b0148201fbso461138e87.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 00:22:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785309730; cv=none;
        d=google.com; s=arc-20260327;
        b=j8Oq+iTSkb/5DiJGcSs2fqNwkYgwejQTw2+deZn07AWZlbcVnyQlSUCwah9GJiXj9n
         nsLHIwnmfzVE8QqNi4kl20asZG8Fr2XxcB5XZo4PH4PbGGMhQf7Z3W/sK7JtG+BjrGGu
         KCHzuQn0oVncZhjk737JhT6RQGtY5M2MeKADGhbZnqvyPXBi8oSL4X5fKLP+10IRiNSL
         iLMRalQORsJiQizgumsr7h7KpTWK8qXZxCet+2U6dIKHqBMVs64ntU1iTHL2NgtF/O2l
         uxgz98IaQv8Hj5cOeLIGnQEe1GfAM0zoNiauo5syllLmFilmK+CsPvAARjk06ctz66UQ
         YEsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3qT4Vz1MKpNr1zEAkpXZzSKAkJu2HpLA8tmiTX8tQCk=;
        fh=4KohLurvk/TbKGVG7oH+aZfdqu1ZGTFgBFBZt3f/hwg=;
        b=d9HSqyGPpMRFwDy5DZzQbGbJT5Oiqa6hGNcqs9jRTuESNhTrGibETQyamAbFx3IMnj
         eYr/m9wVEE6JL/MLogU5n57CDulRsaO4lYIRbyvpwNg+2mlgiDqBj/p0/Q2TyqUjISlS
         oCHX942DRcAYHVBjj5qyIebs25MrVOiZFXBge6Oh+lFbHBWuERnmTdyhQIvO749MC0TY
         ++6fnp4uc4xGibxwOfrujoqYM2J+GNtnSFdELv9f3BOxcZdjeSPrHglaXMKwv1g9qA9Y
         R6/576Dw0S2fTW8Ggq7gEOjkRAqvSdp7LXtDlR5KWnnJWvxjSsoJC/8wrcdA06uA1q5/
         4yrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785309730; x=1785914530; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3qT4Vz1MKpNr1zEAkpXZzSKAkJu2HpLA8tmiTX8tQCk=;
        b=N8xpaO0gHKQJf5a5/TS6bhwVq1PcHBarmaKfo9ijrIxh4plK/tZYPDfWrjvZJEey6y
         KobsvmETMd2tJ1P5zpdQ/E0vPQpT1JyAOgm1iNf7RGhtfZL3i7wdCPkh6BvbjekYFcyq
         BX8ofkqb1KvmJ5LW1lOPZD9bCTJnw1uLWmc32e1MejAl0jRw4L//tQOdA04pblXavKrg
         Gvp9d6m1YnNipF9QjfdrZvCvJ3x38yXARMBWZHan5D3gqymbW41b4WKdXioEUcIDBb/m
         +IcM41oIPVL863HQumarTXkFHwI2hhGO3bFwISXKtZ/dfmgJ/p5H9tQnq8e33NBVkBSR
         3gBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785309730; x=1785914530;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3qT4Vz1MKpNr1zEAkpXZzSKAkJu2HpLA8tmiTX8tQCk=;
        b=tBeVQepfjqHQLqyc7XUoa7YLqikvmiFfdS/XB33ytILwu85/bC5Jehy68THA2PKaJc
         xV2XJcjFnskLhfUdcFiFQdYsKxSIEoLVd0LtwSrc2XOpcV/q0KG81c1Am9DZPm0vIq0v
         p2MQ98aMHpBvEpQaviYGfEcaD0VZ6sM1PwAy3K/BDb9RrRCCQ9xy53UyARRikD5M5bbM
         dizMYyBfqWzyOQSmmZYxUm1SKr8gsGgEVXxp7/EXVqwCitXO/sZ5O7QRO2/XIVN9FgoJ
         WEcdd2Ymeh4qNovQT4mU71u6omyOiAkqID3dvasK96u/5oCvi8OciCcTjeKbtvscaBJw
         ND8A==
X-Forwarded-Encrypted: i=1; AHgh+RoCTaYptaEyYi1lb/c88KnmIg8nn5jOzc25AoWuf4kFdkSTuJj8CZsGRP84QhLSRMIUaXOgTikfmapDfNZ4@vger.kernel.org
X-Gm-Message-State: AOJu0YxJaZGk8gXEE/+n6ZalYDhW1dQeJaPlyRhzKgwOFr/eKI0UIeaW
	h+m+XJ+ES1GEGA0uwBhghtlmRcTrYgRrzGOgQXn0NZLcu/LqHtDgThi3Gd4mrQNKkXwCSYWzBP7
	3ElzVc4KmopSCDVS6Ynxs+PSIQxVG284=
X-Gm-Gg: AR+sD122w3sVjZdbr3aFHsWIitTL+W+vU2HvgcfzHVx5QK05nOd45i6nmDs6zYbWE3t
	lRwQoXDeqxeoRcqeSE7WqRFa2L3fQrIqlqQnA35XQXgL23rpxxQAUMmS4xsc0RkdTjF7G5CZ189
	RLXNhr63v0WRoI9aEUna/SVoJZ8B7Psx/r6gdsfOiboerrpZQTwRPwk+lTJJZRFE8SFnHj257m3
	GzO9mViwqqdsNYPm/3aAEPRWLJYAbZQlxAA8H/2jWh3g0a1dcsx7itnfH/nXBlQB5yb9juKClps
	zYMxE93GHIrchFowKgbIdpXzEz1JnxiW/ZkN3o0YByBUjbC0lhgWIA==
X-Received: by 2002:a05:6512:3996:b0:5ae:a9ec:9fc4 with SMTP id
 2adb3069b0e04-5b2d0277768mr1283782e87.63.1785309729997; Wed, 29 Jul 2026
 00:22:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANGjgd=RwMy=29OYG14b6kkoF1uBHz67jTGge5Nubb-XemMvBg@mail.gmail.com>
 <rbrddfiyruub77dds3hhsal2lyxen3kqybenrlitmdamnstqbt@ywzf5g5xgpjc>
In-Reply-To: <rbrddfiyruub77dds3hhsal2lyxen3kqybenrlitmdamnstqbt@ywzf5g5xgpjc>
From: Chengfeng Lin <lin2530632123@gmail.com>
Date: Wed, 29 Jul 2026 15:21:56 +0800
X-Gm-Features: AUfX_mxFMOoBYpqgt3cLodxaBIPibJGL0H8GSUwbC4ezKuqfEZrQiUxdFCEgfzA
Message-ID: <CANGjgdno26kBChG0fyOZiwHJe+hLh9BsUqeY81HZen6FDHj-Ng@mail.gmail.com>
Subject: Re: [REGRESSION] fsnotify: concurrent inotify watch add/remove slows
 after 94bd01253c3d
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

Yes, your understanding is correct. To be precise, all synthetic benchmark
cases use one process. P1 has one worker thread, while P8 has eight worker
threads in that same process.

For the one-process, one-worker version of the same distinct-inode add/remo=
ve
workload, the exact parent -> child -> parent medians were:

  1426.416 -> 1445.261 -> 1439.104 ns/watch

The child differed from the two parent runs by +1.32% and +0.43%, with 0.89=
%
parent drift. This was below the pre-registered 5% threshold and was classi=
fied
as no material signal. P4 was also below the threshold (+2.08% and +0.36%).
The stable slowdown first appeared at P6 and increased at P8.

So the data supports your interpretation: this is a parallel scalability
issue, not a measurable single-worker regression in this workload. I
understand the trade-off. Thanks also for mentioning the rhashtable work; i=
t
sounds directly relevant to the contention observed here.

Thanks,
Chengfeng

Jan Kara <jack@suse.cz> =E4=BA=8E2026=E5=B9=B47=E6=9C=8829=E6=97=A5=E5=91=
=A8=E4=B8=89 04:04=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello!
>
> On Tue 21-07-26 00:00:32, Chengfeng Lin wrote:
> > I found a repeatable slowdown in a concurrent inotify workload. An exac=
t
> > bare-metal comparison points to:
> >
> >   94bd01253c3d ("fsnotify: Track inode connectors for a superblock")
> >
> > #regzbot introduced: 94bd01253c3d
> > #regzbot title: fsnotify concurrent inotify watch add/remove slowdown
> >
> > This is a focused synthetic microbenchmark, not an application benchmar=
k. It
> > uses tmpfs, 96 separate inotify instances, and 96 files with different =
inodes.
> > Eight threads, each pinned to a different P-core, concurrently add one =
watch
> > for each instance/inode pair and then remove it.
>
> Thanks for the detailed and throughout analysis! TL;DR for the ones too
> lazy to read the whole report: Heavily parallel addition of inode marks t=
o
> distinct inodes contends on the superblock's inode_conn_list (and the
> corresponding lock) which can reduce scalability of adding inode marks.
>
> Just as a verification: Do I get it right that you observe no regression =
for
> a case where single process is adding inode marks?
>
> If the single-threaded case indeed isn't measurably affected, then I'm no=
t
> seriously concerned. Adding inode watch is comparably rare, I would
> consider workloads which intensively add inode marks as kind of
> pathological and so a scalability regression is acceptable tradeoff in my
> opinion (at least for the time being). That being said I have experimenta=
l
> patches sitting in my local tree which replace the list with rhashtable a=
nd
> avoid pinning inodes by inode marks. These patches should improve the
> scalability as well as a side effect. But I have to find time to revive
> them and push them to completion...
>
>                                                                 Honza
>
> > The matched control uses the same instances and pathnames, but all path=
names
> > are hard links to one inode. A keeper watch keeps that inode's connecto=
r alive
> > during timing. The control therefore measures watch add/remove without
> > connector creation and destruction.
> >
> > I used a fresh boot for each point:
> >
> >   6c790212c588 parent A -> 94bd01253c3d child -> 6c790212c588 parent B
> >
> > Each point had 2 warm-up rounds and 25 measured rounds. The kernels use=
d the
> > same normalized config, compiler, Kbuild metadata, module-signing key,
> > preemption mode, and equal-length release strings.
> >
> > The machine was an Intel Core i7-12700KF system with 32 GiB RAM. The wo=
rkers
> > used CPUs 0,2,4,6,8,10,12,14. The CPU governor and EPP were set to perf=
ormance,
> > Turbo was disabled, and the runtime setting was preempt=3Dnone.
> >
> > The primary medians were (lower is better):
> >
> >   metric                         parent A      child   parent B
> >   P8 distinct, aggregate worker ns/watch
> >                                   4182.614   4920.865   4274.895
> >   P8 distinct/shared ratio       0.248777   0.292725   0.240657
> >
> > P8 means eight workers. The first metric sums the time spent by all wor=
kers
> > adding and removing watches, then divides by 96; it is not wall-clock t=
ime.
> > The ratio compares each distinct-inode round with its matched shared-in=
ode
> > control round.
> >
> > Relative to parent A and parent B, the child was slower by 17.65% and 1=
5.11%
> > for the distinct-inode metric, and by 17.67% and 21.64% for the ratio. =
Parent
> > drift was 2.18% and 3.32%, respectively. All correctness and affinity c=
hecks
> > passed. Updating an existing watch mask and pathname lookup both change=
d by
> > less than 0.3%; the shared-inode control was slightly faster in the chi=
ld.
> >
> > A second parent-child-parent sequence checked worker-count scaling. At =
P6,
> > the distinct-inode metric increased by 9.03% and 9.56%, and the ratio b=
y
> > 10.75% and 10.85%. At P8, the distinct-inode increases were 19.58% and
> > 19.11%, and the ratio increases were 17.62% and 16.80%. Exact P1 and P4=
 tests
> > stayed below the pre-registered 5% threshold. A 16-worker SMT run chang=
ed in
> > the same direction, but missed the variability gate and is not part of =
the
> > main result.
> >
> > I also tested two diagnostic variants at the child commit in this order=
:
> >
> >   full -> lock-only -> full -> nolist -> full
> >
> > Full is the unmodified child. The reductions below are averages relativ=
e to
> > the full builds immediately before and after each probe:
> >
> >   build       list updates   list_lock   P8 distinct reduction   ratio =
reduction
> >   full        kept           kept        baseline                baseli=
ne
> >   lock-only   removed        kept        14.27%                  12.70%
> >   nolist      removed        removed     21.43%                  20.46%
> >
> > The lock-only result shows a cost from the list updates or the extra ti=
me they
> > hold the lock. Removing the lock recovered about 7 percentage points mo=
re.
> > This suggests that lock acquisition and handoff also contribute. These =
builds
> > are diagnostic probes, not proposed fixes.
> >
> > Before sending this report, I checked v7.1.4, v7.2-rc4, Linus' master a=
t
> > 1590cf032971, next-20260717, and the linux-fs fsnotify, for_next, and f=
or_linus
> > branches. Connector creation and detach still use the list_lock and
> > list_add()/list_del() operations introduced by 94bd. I found no equival=
ent fix
> > or matching report in the official linux-fsdevel and regressions archiv=
es
> > through July 20. The exact timing claim above remains limited to the di=
rect
> > parent/child comparison.
> >
> > As a topology check, I traced eight unmodified Ubuntu inotifywait proce=
sses,
> > each watching a different subtree of a Linux 7.1.3 source tree on one e=
xt4
> > filesystem. They created 4,177 directory watches. For each process, the=
 counts
> > of fsnotify_add_mark_locked(), inode-connector allocations, and
> > fsnotify_detach_connector_from_object() matched its watch count. Watch-=
add
> > events from all eight processes appeared in the same 1 ms interval. I s=
tarted
> > them together on purpose, so this trace shows that normal software can =
create
> > the tested topology; it does not measure application performance or how=
 often
> > this concurrency occurs in normal use.
> >
> > I understand that a05fc7edd988 ("fsnotify: Use connector list for destr=
oying
> > inode marks") uses this list to avoid scanning all inodes during unmoun=
t. I am
> > therefore not asking to revert 94bd.
> >
> > Is the extra watch add/remove cost an expected trade-off? If not, would=
 it be
> > useful to develop an optimization that preserves the connector list and=
 the
> > current unmount behavior?
> >
> > Evidence bundle:
> >
> >   https://github.com/lcf0399/linux-regression-evidence/tree/245fec71aa0=
5eb2dbd68f11e4c98729f22bbc541/fsnotify-concurrent-inotify-watch-setup
> >
> > Standalone reproducer:
> >
> >   https://github.com/lcf0399/linux-regression-evidence/tree/245fec71aa0=
5eb2dbd68f11e4c98729f22bbc541/fsnotify-concurrent-inotify-watch-setup/repro=
ducer
> >
> > Thanks,
> > Chengfeng
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

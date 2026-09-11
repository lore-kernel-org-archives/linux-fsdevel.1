Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E8B392807
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 13:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789134228; cv=none; b=a/kXavgjw0Wfy8mRclZnpWHm79LoChVVC4OqqCYMpqLGTqtzivANd4AIIliq1Nyy0yQvuIb5/QRKU/H+vsgaAAlHuZJoS6B7CU8Bkr5Sg29wBHm2inljYK3V5btvB81RrfXQODTFHyjmFDSjpe8rW/s+wGMO5OJCPvNYKSFZwuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789134228; c=relaxed/simple;
	bh=zvNf1eO2L1S2f2f1Yt7nZWN3wztelLiP/o13rCP6Iho=;
	h=Date:To:Cc:References:Content-Type:Message-Id:Subject:From:
	 Mime-Version:In-Reply-To; b=KC6FESMfx08qCWFHdFR6T5I51UDZCntQd1ewMDQW6yEyg/QqZQkW2eeZlkoFEycAzzDfhO+xnI8bDGbNwl02nsGAz36egTp3lfGR+P35TcozkV9tHSt6zNP0nQ1X4u/uIg+C0DAcduDyHNx4rgxr8qhuaz5h4xp0SRNMcAylxW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VvckQfvX; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VvckQfvX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1789134220; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=zvNf1eO2L1S2f2f1Yt7nZWN3wztelLiP/o13rCP6Iho=;
 b=VvckQfvXblL6guHHSxBIYcJKL21BTS0eVA+TZhzn282YlDDhT8YGW+8VZtZMfGAQMgwTLz
 Mv+IcqR6LdXCCP+59VYL6QccQ1Q4aOyES1TPB0p51FEWJR41UYYPtN6Yobc3+0xGAJAg/P
 gUpBdYHCH4ihLOeEu/navenbGskDObrQzYs9kYJzQ6/X5Bx2gb+bPi4FXEKaE5qYp0RSmF
 s95dGRvjeS4nGMj4vGwhLIuZXvP00fvfKVYgcyhQr/V/0jBD93/trSrJPqTr8cEUuI6ypQ
 vXzKvVKle0UrgGgM+XUs+P3o6GOMpxDb2S/y7B8bc3FZg4geSZTg17aWzrr5TQ==
Date: Fri, 11 Sep 2026 21:43:35 +0800
To: "Jan Kara" <jack@suse.cz>
Cc: "Jan Kara" <jack@suse.cz>, "Alexander Viro" <viro@zeniv.linux.org.uk>, 
	"Christian Brauner" <brauner@kernel.org>, "Tejun Heo" <tj@kernel.org>, 
	"Jens Axboe" <axboe@kernel.dk>, <linux-fsdevel@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
References: <cover.1788836830.git.yinxin.x@bytedance.com> <dce170b76e9501d555b0af70cc8c45c248577400.1788836830.git.yinxin.x@bytedance.com> <matvd3klv4w7buhnjkdpllkautw3zu2e5hpjfdedvvoozpbfxj@z7joalz5an74> <b0a5d388d0b2cb320744535d7f9d8f59e469aa88.aa79b65b.6b2f.41be.bcbf.08bf9deeb395@bytedance.com>
	<22ia4tpnbik23zb4lgkb7rn4v3rbaeburhtxg5ymdwv6dnfar7@iustvvybmr3i>
X-Lms-Return-Path: <lba+16aa4058a+8f3a14+vger.kernel.org+yinxin.x@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <b0a5d388d0b2cb320744535d7f9d8f59e469aa88.dc1597c4.579e.43cf.b119.f992cf777e6e@bytedance.com>
Subject: Re: [PATCH v1 2/2] writeback: snapshot foreign flush pages
From: =?utf-8?q?=E5=B0=B9=E6=AC=A3?= <yinxin.x@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <22ia4tpnbik23zb4lgkb7rn4v3rbaeburhtxg5ymdwv6dnfar7@iustvvybmr3i>
Content-Transfer-Encoding: quoted-printable


> From: "Jan Kara"<jack@suse.cz>
> Date:=C2=A0 Fri, Sep 11, 2026, 19:09
> Subject:=C2=A0 Re: [PATCH v1 2/2] writeback: snapshot foreign flush pages
> To: "=E5=B0=B9=E6=AC=A3"<yinxin.x@bytedance.com>
> Cc: "Jan Kara"<jack@suse.cz>, "Alexander Viro"<viro@zeniv.linux.org.uk>, =
"Christian Brauner"<brauner@kernel.org>, "Tejun Heo"<tj@kernel.org>, "Jens =
Axboe"<axboe@kernel.dk>, <linux-fsdevel@vger.kernel.org>, <linux-kernel@vge=
r.kernel.org>
> On Wed 09-09-26 10:08:08, =E5=B0=B9=E6=AC=A3 wrote:
> > > From: "Jan Kara"<jack@suse.cz>
> > > Date:=C2=A0 Tue, Sep 8, 2026, 19:01
> > > Subject:=C2=A0 Re: [PATCH v1 2/2] writeback: snapshot foreign flush p=
ages
> > > To: "Xin Yin"<yinxin.x@bytedance.com>
> > > Cc: "Alexander Viro"<viro@zeniv.linux.org.uk>, "Christian Brauner"<br=
auner@kernel.org>, "Jan Kara"<jack@suse.cz>, "Tejun Heo"<tj@kernel.org>, "J=
ens Axboe"<axboe@kernel.dk>, <linux-fsdevel@vger.kernel.org>, <linux-kernel=
@vger.kernel.org>
> > > On Tue 08-09-26 11:23:52, Xin Yin wrote:
> > > > WB_REASON_FOREIGN_FLUSH is best-effort writeback for foreign dirtyi=
ng. It
> > > > should write pages that are already visible to the target wb, but s=
hould
> > > > not keep extending the same work with pages dirtied while the work =
is
> > > > running.
> > > >=C2=A0
> > > > Make foreign flushes use tagged writeback while preserving WB_SYNC_=
NONE
> > > > semantics. Use the remaining work budget as the per-inode chunk, so=
 a
> > > > tagged pass is not truncated to the normal periodic chunk and a lar=
ge
> > > > inode still cannot exceed the finite work budget.
> > > >=C2=A0
> > > > Queue b_dirty only once for each foreign-flush work. Later passes o=
nly
> > > > retry b_more_io inodes skipped due to I_SYNC, and the work exits on=
ce
> > > > b_io and b_more_io are drained. If the budget is consumed, redirty =
the
> > > > inode instead of requeueing it to b_more_io so the same work cannot=
 loop
> > > > on a continuously dirtied inode.
> > > >=C2=A0
> > > > Do not refresh dirtied_when for foreign flushes; later dirtying sho=
uld be
> > > > handled by later foreign, kupdate, or background writeback.
> > > >=C2=A0
> > > > Fixes: 97b27821b485 ("writeback, memcg: Implement foreign dirty flu=
shing")
> > > > Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> > >=C2=A0
> > > I really dislike how your implementation ties the two writeback deadl=
ock
> > > avoidance schemes (nr_to_write for WB_SYNC_NONE writeback vs folio ta=
gging
> > > + inode dirty timestamp for WB_SYNC_ALL writeback) together. But befo=
re we
> > > get to the implementation details let's discuss the purpose a bit:
> > >=C2=A0
> > > In principle I agree with you that the primary purpose of
> > > cgroup_writeback_by_id() is that it wants to flush inodes that have f=
olios
> > > that are accounted to our memcg. It does this by a rather rough appro=
ach of
> > > flushing the whole wb. If this races with other dirtying, it might ha=
ppen
> > > that we won't actually flush the foreign folios we want. Am I getting=
 your
> > > concern right? Are you able to actually observe such situation in pra=
ctice?
> >=C2=A0
> > Yes, that's the concern. Concurrent dirtying could consume the work's
> > budget without sufficiently flushing the foreign folios charged to the
> > memcg we're trying to help.
> >=C2=A0
> > We haven't confirmed that specific situation in production. What we've
> > observed is long-running foreign work with many subsequent works queued
> > behind it. We haven't traced the original source memcg's folios closely
> > enough to show that they were left dirty because newly dirtied pages
> > consumed the budget. So that part is still a concern, not an observed
> > failure.
>=C2=A0
> OK. So I fully agree that foreign dirty tracking and flushing is very
> rough. The basic premise of that infrastructure is that foreign dirtying
> should be very rare and amount of foreign dirty pages very low and thus
> largely irrelevant for the dirty throttling. The flushing is there mostly
> as a last resort solution to have a chance of *some* kind of forward
> progress in corner cases where the amount of foreign dirty pages is
> substantial.
>=C2=A0
> As Tejun wrote [1], bdev inodes are kind of breaking these assumptions.
> Still number of dirty pages there should be low compared to data pages bu=
t
> for some workloads that isn't necessarily the case.
>=C2=A0
> [1] https://lore.kernel.org/all/aqGmmw3rv_2f5Jk4@slm.duckdns.org
>=C2=A0
> > The idea behind combining the two approaches was to get the budget righ=
t
> > for the target wb, while keeping the flush from chasing concurrent
> > dirtying. The first is about not holding up later work on the same wb,
> > including syncfs. There's also a fairness concern: an old inode can kee=
p
> > getting newly dirtied pages written while later-dirtied inodes have to
> > wait for another work. The second is about making the flush more useful
> > to the source memcg, although tagging alone doesn't guarantee that its
> > folios get flushed.
>=C2=A0
> If you look at the logic in writeback_sb_inodes(), it actually goes to
> great lengths to avoid the fairness issues you describe above. We only
> write a limited amount of pages from each inode (see
> writeback_chunk_size()), then we switch to another one, cycling through a=
ll
> inodes queued to b_io list in this way. Inodes on b_io list get fixed whe=
n
> the writeback work starts (see queue_io()) so new inodes cannot appear
> there. This is not bulletproof but it avoids the practical livelocking
> cases. So generally I don't expect your systems have practical issues wit=
h
> foreign flushes not really flushing what they should.

I may not have explained the fairness concern clearly. The scenario involve=
s multiple foreign-flush work items targeting the same wb. W1 can run for a=
 long time while its eligible inodes are continuously dirtied. Inodes dirti=
ed after W1's `dirtied_before` cutoff are excluded from its scan, while sub=
sequent works that could flush them remain queued behind W1. Our concern is=
 therefore head-of-line blocking between work items, rather than fairness a=
mong inodes within a single work. And this is still only a concern, not som=
ething we have observed in production.

>=C2=A0
> > I see your concern about mixing the two mechanisms, though. Would you
> > suggest keeping the budget-only approach for now, or is there a simpler
> > way to address the concurrent-dirtying concern?
>=C2=A0
> As I wrote above, at this point I'm not convinced concurrent dirtying is
> your practical problem. If you can show foreign flushes in your real
> workloads often don't end up flushing what they should, then we can discu=
ss
> how to improve the writeback behavior (or foreign flush behavior) to avoi=
d
> that.
That makes sense. We can drop patch2 for now and move forward with patch1 a=
lone. Once we have concrete production evidence and a clearer understanding=
 of the problem, we can revisit whether further changes are needed.

Thanks,
Xin Yin
>=C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Honza
> --=C2=A0
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
>=C2=A0

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215069;
	b=HzjqP4BJtAjiF0X0/WJTya5eEUChb36JSPeLOuM8Ud8pAveXqR73wjArgNfTvI5hOWZH
	 rmxEnLyICAsDabnga+MAEJxiJ5ZH0SMbVZteyV9B3m6Ni3gIY/s009auRUswPQy/YgrCO
	 g0hGoSqK5swDua48wRJkDkAc8y0gTeQvwZR9EF2Dd4zbhMhmCMJCUo22mGqGhJvsIYgSL
	 KO1mFwnSTcRlJyLlgtQC/Bt3iP64fKjTvW9VCAov6vZYNg3byS+8VMNxhPjL+TBMvT60I
	 Sm+DR+e5Reghv3o5OGceR0FIk6O+lY1/6wd5hpK2mFzqBq5jX9+rf0O3OI3FwMAqO2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215069;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Content-Type:Content-Transfer-Encoding:MIME-Version:From:To:
	 Cc:Subject:In-reply-to:References:Date:Message-id:Reply-To;
	bh=A7lUCQ6TfilbbMdtLH7yLs5PgdPcrQehFFZLhkZSAUY=;
	b=y8jaQrDDLJZttpUjmzFaCNgc3YaRNEPqx+wnRZ5ErDsAir45fEy6uq9IAuS76r3te3S9
	 LMD+XB27ixDP8nSPbwa0Fjr6/p97hfvFw3yvSVOWwCGnS9INo1uoYpaTKppqcvVyhBgaJ
	 um74p70f59snwvNPkPeK+pXEO7K2BGnajcufiLUUBKVXjBdllFzeOGr/o8t22+pm46fyc
	 85GK6DiCcD3q58yGiWRRU1d8wMf3nBPqxO6Z3+8uUsDbtYgcAfpupNK0hkABOv63Nx2p4
	 H0A5hP+On1KV1jfz9pq8d3BO3LkuaViwcbOcINk0/9NVc5avBjCIYFGPa7HQH4JfHNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=NOtwMs8N;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gNZnB5fB;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524AC606A321
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 09:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 524AC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=NOtwMs8N;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gNZnB5fB
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 52B2414000E3
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 04:04:17 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 09 Nov 2026 04:04:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1794215057; x=1794301457; bh=A7lUCQ6TfilbbMdtLH7yLs5PgdPcrQehFFZ
	LhkZSAUY=; b=NOtwMs8NH1d3FV0LZSmtHIUQqvFRHhZNPuPFCIuJ/+xjj3a7w+h
	iBwOfbo1RaE1meOpNzGWP2tYBivj/PIYFh7F7Vba148rKiMNkNCnLn/vHOngWFsa
	eMb+WpTBOsM+DxOSOQsiDjxdA08eprbEJQOLP7Mz5IRqmW/xCA7ivnrWR5n0dDLx
	hmwIBwQeCMsFrcu7w28OG8BiVuAYC2zHWO0bB/IZrDl/YMf0LhgDDV+DzYhVehUX
	biT1K4hibIpLajFrEfzPgt4FXpMUvy52DD8yfnKV0Wxn0Dqi/ir71BaUWNZbOD1v
	LyJEDwGVYlhYpNqR2Kx772gl70L9RIv3X+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794215057; x=
	1794301457; bh=A7lUCQ6TfilbbMdtLH7yLs5PgdPcrQehFFZLhkZSAUY=; b=g
	NZnB5fBKRVmT50nRyPlaPpVjG06opfD5E7+RjGybfo6S1aqFOcu2a4h4drFKpAnA
	dA56UfWU2DVVZdAJs2CUFbSfRl+5PWutuk79Hi9o3szI0UskXyfxqtUGh3ItSX3s
	z6lCAemvudO4Nu/iXr1nJCSnW5Qey7QMBLydGS3raSUh/kvjFZu4TWWUH/3hwKT/
	waaeEkrLJgpOxitapE9K0sVgTjPmQKLq1sx/e9gX4qzWoW2+/SejW4yYbEISKMIG
	dkj5qD4pTxbpU62+qz35qZ4cis9nXzuKfzO1Ig7Rz8NySQxKz93v7JeyEcQnYKn1
	7HW/uC7K2uKDHfN4MmV3Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794215057; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:BFDmQthAqopumf/7MRQtEVx3zOLAulXeyQKjpyZcyFhFnLB
	4lVQmorVj2yeY2rEybH9sHUNJ8uutuWYS8q5rFl5NXoVBQHybWks3JN4uBaJOxV6
	gZadq59XhI9hSiuob34qYcbGuXMv5AR9qlt7C//N25aRhCyYjWev3Q9WamD+zmpu
	V2VF24muCFTW3jFIUJKgsFmTC2TDexPpxb8P946esq8G+tNdArniqwLBOE0bZlkh
	G8mMaFo8W3a5ez++9u7iF1aEroquHXeQVfrNVUb8VWsspuuxVviW9T7ujzFQYDXj
	faf6mfw7pyXSif1MXfNxTYCq36cNNiRQpvUWOBA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,reply-to,
	subject,to;
Message-Instance: m=1; h=sha256:uhH+5jEbgf0OVZmwsBe73BkFdI181nPpwXKWwE+fiLM=:fyDyBEYQH4WiTFivwx1RXK7atpp+u470SuFc2CH/LFE=;
X-ME-Sender: <xms:kIzxaszuj1S_lK9wMdJIlPW_hv2Q2bKfa-h2CSCQuLmzDi7P50YxkA>
    <xme:kIzxalOqcGtwHnkSYIpU7cbiaDQczzL_p2rLndktmHIjQy5tyqyN1ssEsS9NfNzJm
    Tz4LL8GNu34w73hSZhLpFJOotJ3h2bvIJ93fjEOal_MU6WW0Q>
X-ME-Received: <xmr:kIzxailHA3hDjTjZ_gsp5zWzTDJL8l6h5IRBa9xk6adjbqQ7HyYk7XGCAOJnEIiVb4ZZmHDBLNUhjxTKgVa3MQRn9lMpeg0>
X-ME-Proxy-Cause: dmFkZTEkdVYupBKa/zOjHLtNrVKec+EYMaibjw/u5rBeZjZiGACUvEg0eAwNXw0YYafcgW
    aolGBNXQD0wAqIeXlGuNDPsw1jVaFpBm2Xob+NeVXjFi1QdLRD9Hw9U1PzNOLzQvhg3WZ1
    8EfSfCQjKzklnab0Epo0ev5xdB/D/huMLtM07FveST6oxQMCk931g6q9Rak1k8rzXm2A6+
    H+xf1kLn9Am+V2E6PlIg1dV84YG1sN4RLYYEFFU1dTmmcrTx6grJCErSrTLBuPzVKZaOEz
    DoSPsAXluiEf3ZmBu/zRs/Wz85Mr4s9SrR7ujSpqHqzadNlTYJOIPQ5wJ1DMrnV+nFBIOx
    dwRqVgEY+1jkM6d1uKtuwFas8wF1z1FsoO6EbFfIg+FTPuic9MYfrC5RyozMi3rVQjLumZ
    3SueAc1zSJ/pWCDUXNvmNMoo/ceTtCfMAjutxMlTrjmuJ6CPYyqUkbSwJOXImWJv3oyVDg
    C9j1oXQKYizJ+7YiigwDkHGOYlgMMLeVDWoj+thI7VnEDtcVEfgqVua6Ka64EpZcf0LJy1
    gG6zi1puVxl2cxjJ8blm+A6TK7ng1n+NJSsKmIUOoxQWbnsEqVz+OTf9G26SgCmGc4GBV1
    u1rN3BiyjVkmtbOId5zDQLVRdxPWNJw+mds9skpllbgbaTRi/m7XVS+AIlkQ
X-ME-Proxy: <xmx:kIzxaqTYwURi1DLdT4-rL9Hn9JFSvRF23cRyHebd1aA45q6JYl6TEw>
    <xmx:kIzxahWSYyfuEi2_h2f7weDPvnU1bbgUAZWbG4HimBKijOVFEVAjtg>
    <xmx:kIzxauL3y5M7Tt7fqFRbl4iJfLyTWP2EhQ_mj-RnCL7SoBNiNxik4Q>
    <xmx:kIzxah3QiyKACXh8QQHlTYvIEaGWX8EP-UA1HCjdWfFyeHvG8ohTxw>
    <xmx:kYzxaqbNrIhI5asWDBGvJJCCXGem2l9_wsTau-QNjtcz_1CDtsqutTDo>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 04:04:13 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Shuai Liu" <847807867@qq.com>
Cc: viro@zeniv.linux.org.uk, neil@brown.name, brauner@kernel.org, jack@suse.cz,
 linux-kernel@vger.kernel.org,
 syzbot+2ed46b6b748df855347f@syzkaller.appspotmail.com,
 Shuai Liu <847807867@qq.com>, linux-fsdevel@vger.kernel.org
Subject: Re: end_dirop() can unlock the i_rwsem of a re-parented dentry on
 PREEMPT_RT (DEBUG_LOCKS_WARN_ON in filename_symlinkat)
In-reply-to: <tencent_EE9EBC53933F6E9658D6848B7B89F4370B06@qq.com>
References: <tencent_EE9EBC53933F6E9658D6848B7B89F4370B06@qq.com>
Date: Mon, 09 Nov 2026 20:04:09 +1100
Message-id: <179421504912.1728055.8601875536308970773@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 06 Nov 2026, Shuai Liu wrote:
> Hi Al, Neil,
>=20
> I've been digging into this syzbot report and would like to share an
> analysis and ask for your insight on where the invariant breaks.
>=20
>   syzbot dashboard: https://syzkaller.appspot.com/bug?extid=3D2ed46b6b748df=
855347f
>   Title: WARNING in filename_symlinkat (PREEMPT_RT, still open)
>   First reported: February 2026; syzbot's own retests are flaky
>   (10 of the last 15 retests report "no crash"), and earlier fix
>   attempts posted to the discussion thread did not resolve it.

Interesting - thanks for looking into this.

>=20
> 1. What the warning means
> -------------------------
>=20
> The crash is a DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) !=3D current)
> fired from inode_unlock() called by end_dirop(), via:
>=20
>   filename_symlinkat
>     -> end_creating_path()          (fs/namei.c)
>        -> end_creating()            (include/linux/namei.h)
>           -> end_dirop()            (fs/namei.c)
>              -> inode_unlock(de->d_parent->d_inode)
>=20
> end_dirop() re-derives the directory to unlock from the *current*
> value of de->d_parent:
>=20
>         struct inode *dir =3D de->d_parent->d_inode;
>         ...
>         inode_unlock(dir);
>=20
> while start_dirop() locked the parent's i_rwsem *before* performing
> lookup_one_qstr_excl().  The warning therefore means that between
> start_dirop() and end_dirop(), the returned dentry was re-parented:
> we took the lock on inode A but are now releasing inode B.  On
> !PREEMPT_RT the same mismatch presumably happens silently.

That is certainly one thing that the warning could mean.
It could also mean that the ->d_parent point was corrupted.
Or that the ->d_inode pointer in the parent was corrupted.
Or that the i_rwsem in the parent inode was corrupted.
Or that the i_rwsem was unlocked or re-initialised since it was locked.

None of these seem likely, but we shouldn't exclude the possibility.

The original version of this syzbot report (e.g.  2nd Feb) was caused
by i_rwsem being re-initialised (aka corrupted).
It was fixed by
  Commit: 2ff7cf7e0640 ("gfs2: Call unlock_new_inode before d_instantiate")

The corruption happened because unlock_inode_new() reinitialised the
i_rwsem *after* it has been exposed in the dcache via a d_instantiate()
call.

That bug is fixed in the more recent instances.  But something is
causing a similar symptom.

It appears that syzkaller is exercising lots of different filesystems
and we don't know which one triggered the problem.  It would be useful
if we could get a crashdump - is that possible?


>=20
> 2. What I checked and could not break
> -------------------------------------
>=20
> For de->d_parent to change, something must move `de` itself (d_move()
> family) while we hold it.  I audited the plausible candidates:
>=20
>   a) lookup_one_qstr_excl()/d_lookup(): lookups hash under the parent
>      and never re-parent an existing dentry.  No window.
>=20
>   b) d_splice_alias_ops()/d_splice_alias() during a lookup of a
>      directory, which is the classic way a dentry gets moved to
>      another parent:
>        - IS_ROOT alias branch: __d_move(new, dentry) under
>          write_seqlock(&rename_lock) moves the *existing* alias into
>          the freshly allocated lookup dentry's slot; the destination
>          is a new dentry, not the dirop's held one.
>        - !IS_ROOT branch: __d_unalias(dentry, new) takes
>          s_vfs_rename_mutex and then inode_trylock_shared() on the
>          alias's old parent, and bails out with -ESTALE if the
>          trylock fails; the moving victim is the alias, not `de`.
>=20
>   By static reading I could not construct an interleaving in which
>   the dentry returned by start_dirop() gets its d_parent changed
>   while the dirop's exclusive parent lock is held.  Either I am
>   missing a caller, or the mechanism is subtler than the alias
>   paths -- hence this email.
>=20
> 3. Instrumentation result: ~48k iterations, zero hits
> ------------------------------------------------------
>=20
> To get runtime evidence I added two DEBUG probes to the tip of the
> paths in question (both compiled only under CONFIG_PREEMPT_RT):
>=20
>   - end_dirop(): read rt_mutex_owner() of de->d_parent->d_inode and
>     warn with full context (dentry/parent pointers, %pd names, inode
>     numbers, d_flags, filesystem/superblock, comm, pid, owner comm)
>     whenever owner !=3D current -- i.e. log *before* the kernel's own
>     debug check fires;
>=20
>   - end_creating_path(): compare path->dentry (the parent whose lock
>     start_creating_path() took) against dentry->d_parent at the end,
>     to catch divergence even if the ownership warning never fires.
>=20
> I then looped syzbot's C reproducer (gfs2 with lock_nolock, mount /
> chdir / creat / open(".") / symlinkat+renameat2 racing threads) under
> QEMU/KVM with the syzbot-provided PREEMPT_RT config, across ~48,000
> reproducer iterations.  Result: zero probe hits, zero false
> positives -- the probes print nothing in a completely healthy run,
> and the kernel-side check never fired either.
>=20
> So the window is real (syzbot hit it) but extremely narrow, and my
> repro cannot reach it locally.
>=20
> 4. Questions
> ------------
>=20
>   Q1: Is end_dirop()'s contract deliberately "unlock whatever
>       de->d_parent points to now", relying on an assumption that no
>       path can re-parent the dentry while the dirop parent lock is
>       held?  Or would it be more robust for start_dirop() to
>       remember the exact directory it locked (e.g. return the locked
>       inode alongside the dentry) and have end_dirop() unlock that
>       captured inode?

Yes, that contract is deliberate.  start_dirop() finds a dentry and
locks it so that the parent *cannot* change.
So assuming that it hasn't changed is the same as assuming the it is
behaving correctly.

There is an exception in that an alternate dentry may be substituted
(returned from d_splice_alias()) but it must have the same parent.

>=20
>   Q2: Which callers of d_move()/__d_move() do you see as plausible
>       candidates for re-parenting a held create/remove dentry?
>       Candidates I could not fully rule out by reading are callers
>       outside the lookup path itself (rename on another mount of the
>       same file, network/cluster filesystems revalidating and
>       re-parenting dentries, overlayfs redirect/merge behavior, ...).

I cannot see any of them as plausible.


>=20
>   Q3: If no re-parenting path exists, could the divergence instead
>       originate at start time -- i.e. start_creating_path() locking
>       one parent while the dentry handed to end_creating() was
>       created under a different one?  My end_creating_path() probe
>       compares exactly that and never fired, which argues against
>       it, but a second pair of eyes on that layer would help.

I strongly suspect a corruption of some sort.

NeilBrown


>=20
> Happy to share the instrumented kernel, probe diffs, and full boot
> logs.  The reproducer is the one attached to the syzbot report, so
> anyone with a PREEMPT_RT build can try it directly.
>=20
> Thanks,
> Shuai Liu (=E5=88=98=E5=B8=85)
>=20
>=20
>=20


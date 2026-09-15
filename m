Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8602EC56E;
	Tue, 15 Sep 2026 21:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789506698; cv=none; b=kYiGvxVWqetXaxttuwVLKcwtDUk+w2FFoAC4wOIlBy1EVBcZ/FOCC1dp1uQ8dJs7WSTAYqYkNv4vgaI8elQeCUE8PpBPDZBbd4ArqMZ5uPgDSaK/4hB4FBWZnpymX7cxVWGY0/77KK3WjLqxJtLMuvpG3OWqIgl53bMZndJMock=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789506698; c=relaxed/simple;
	bh=7m/LfB5eqSXSTcWcaok29C/d53QcpBaw0BchZMXFQn0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=jM8UO+uFmX0O2LAjk7DC1PwQYnCeLIx9oInSSYTaeGXqsmUMJwBnkz82DtVl20uCBsyVesCyhpgcorn2XxhFgPmBI0WcZVwziE7UWn2Bc+oJ12L4UFeLWXmrYC1rKhWZUbvvWKoFQx1klkch1XWdOAL7s9o68kzQjufHFnbfoR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=jLsx+uQh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YPAMGe4+; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="jLsx+uQh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YPAMGe4+"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 719EA1400B1E;
	Tue, 15 Sep 2026 17:11:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 15 Sep 2026 17:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1789506695; x=1789593095; bh=wlRPC++UeFPy4gQOfeKea0ETgVx3aJhWLrd
	IDhSMnCA=; b=jLsx+uQhizaM3h4Xu7W8ubL8JES3+vIXIg4vdtl6UyNEM/JC+1o
	kIt6z2BH7fTwuIpEaXYnq4/clFrqK4Z2Ai9m8M1K0ENoAMaWnrU+/yETRYt0RcRZ
	6mvqRXAgK2xrLs/JWqWXHBRexm8Bes/w617PuQCmwph4cukF8u7SvwkXxxZ+PuNi
	9b4YYJ8yS+YCOJqKRS+yjSaBjavEh9LNFNz8eMp3JeYaYAmeTlO+5unJxvissYxf
	NApQWsY0qBAoCSv4i9d5rs0KUay1UxE5yAX4WS7leohe2W1EFmu1l5O1Hu6yuKqa
	92Qcx8C9R4zlgh3onqPoaEunXq+MONkPiug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789506695; x=
	1789593095; bh=wlRPC++UeFPy4gQOfeKea0ETgVx3aJhWLrdIDhSMnCA=; b=Y
	PAMGe4+qnQO7L3gwwGIY7XEvMcyg9V0ZLOPmIT7CyO0LYR4DFZAiPAdMYhVYTOTN
	uhcy6dZhs4iJkmvQCMnBJd/EsJgLQ2j3zIpGCebcutTPTUGrmCSB2x3Eu2Wqm8OK
	VoeJsGnuHAkLRHDnXEwoudmaYcN3tQnoA+iK+ypaJi8bITtu+RgtQiOUjiZ0Z6Oe
	6apkRkIt/VKYtkRdp+I110McyTgeMW0Jg58I3n1RQdSsXa+8acPVSXNTTDtSy0KQ
	HOpSk+ccbD5Q7qXSgtH6qauaaZrilmbzE5RVcbyMYyTDLMiyJuBnRhgOUYjFAG0o
	Io7bvQF/eCBqo7ONSnsGw==
X-ME-Sender: <xms:hrSpalNUYkJ7SaVOe68I1D970n_o2OySkbW-Wc3FldR3EIgPgZggDQ>
    <xme:hrSpaqhZ2IRe4yyuAUqUmyjNzpPEHn-agmGlf_Jj6OCkwX1AYq-_ggeU_HUgcNfQb
    2H9YLC1Ugjpx6hl8xj6_yJt7TW4EORv840CRYw2LF1n1EUOCv4>
X-ME-Received: <xmr:hrSpan7xqM6i2219bZFj2f06S-e2SdAJZ6VK2Rjn6MSSa72XmYXOt4FbhY2Wj6vhdv4_TfrLtDnJUVlqYyyagZFvFUpG8eI>
X-ME-Proxy-Cause: dmFkZTEquclsFPOAisLAp25DF0TVJ9SQ0uyDeSOaqpRwt+7y1FvvDa/T1/q9no/c7OhXst
    T/qdPKim4gMePkid7BtrmwX2QCRvmqDX7v+XKVfJiyew3WsJsUgQ8ISEzg78z0fgucXpTV
    KkU2tnkNy+oKM/QNqc1O3xt2bKEoSWx8R5AjcdLXXycvIMCA+TNwEGY4Pj/pJq2sn8cFdW
    jgXJeSyR0JHXB1qnigSQ9Kj/PCr0S9Qiay/Ifd1aLKgy0cMU0+kK25cwckq0VLfmRHhAIQ
    MAFuLWNhwmA53RfdTqBRhfYF+AjVEDmBYPX47PwgC5jnVukr3B4HTrCNGl89NSqBp23loS
    QWo1r+HwYhr2EC1nOaTHQjb1L6+X+C1XGnllz1xm6GyFs+NDUdVa3gFUpFsZlx/wlh3Zzg
    MiN64+Qe7ka454OvZIzE0HdqkujHXyHgtU/D0k4kYtuETl9zvHtqmf0CtOIxDJ+AwL2ejL
    fA/DOVVLDEBnVY/tse6MAIg7mr7UUHP43KBU08vWfBi3oL+tw/0mS8sUuRIVlSWkMe5BxY
    c3WAe9wFFzi9NNtzgdFpuCIYJMDF2imIXPmTeyi4XEvEBuBgy6c5pTquEZBNKfwHBk6MTQ
    q5BmXLVXZTuaeABo2nXVtnPBP6jAVQNWyaYhgorjQzKLQEvSajacbNS81tyA
X-ME-Proxy: <xmx:hrSpah28mri2aH_0Dj7RXnYzSrBGmQHm3tSnWB6CpMmKKMogpBWMsg>
    <xmx:hrSpaitWILEHVSkPfUfCsfL6Rla1Ql_qjnknRIGJWYgbNPLzUivEMA>
    <xmx:hrSpan4IdUOcd4C0DZ_VPjBLxQv6izK2jiLHBMoEb1C7M_mxAJrfcw>
    <xmx:hrSpaufNpL9-0Wmaka1M6kQbzV7T3HA-k2OrDdXWtoZp7SOYITTc0Q>
    <xmx:h7Spak3YlHa5tYS6Weex3vAL5g5nkq2hDXq5lTdopx0T_wRK5pzLXIt7>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 17:11:32 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>, "Amir Goldstein" <amir73il@gmail.com>,
 "Miklos Szeredi" <miklos@szeredi.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] VFS: prepare for changes to directory locking
In-reply-to: <20260904215142.1060510-1-neilb@ownmail.net>
References: <20260904215142.1060510-1-neilb@ownmail.net>
Date: Wed, 16 Sep 2026 07:11:29 +1000
Message-id: <178950668966.207413.3037594112799627037@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>


Hi,
 is there any chance these might land this cycle?  I was hoping to add a
 bunch of follow-on per-fs patches, but I cannot without this prep.

Thanks,
NeilBrown


On Sat, 05 Sep 2026, NeilBrown wrote:
> The only change in this v4 over v3 are to replace lock_sync with an
> acquire/release pair which builds correctly when lockdep isn't enabled,
> to add the 7th patch which I previously mentioned, and to include
> linux-kernel so that sashiko gets to see the series.
>=20
> Previous intro:
>=20
> Hi,
>  As you know I am working on changes to locking for directory operations
> such as lookup/create/remove/rename.  The ultimate goal is for the VFS
> to lock the dentry, not the parent directory, and to push the i_rwsem
> parent locking down into the filesystems where it can be kept, removed,
> or adjusted as best fits each filesystem.
>=20
> The next step is to change the order of locking for d_alloc_parallel() -
> which allocates a locked (in-lookup) dentry or waits for an existing
> dentry to be unlocked.  Currently d_alloc_parallel() is ordered below
> i_rwsem on parent, so you cannot wait on i_rwsem while holding a locked
> (in-lookup) dentry.
>=20
> To push i_rwsem into filesystems I need to push i_rwsem below d_alloc_paral=
lel(),
> so code can wait for i_rwsem while holding an in-lookup dentry, but won't be
> able to wait in d_alloc_parallel() while holding i_rwsem.
>=20
> There are two broad changes that are needed before that order can be
> swapped.  This series sets the direction.  Subsequent patches which I
> hope can also land this cycle spread those changes throughout
> filesystems.
>=20
> The two changes are:
> 1 - don't call d_alloc_parallel() while holding i_rwsem.
>    This involves introducing d_alloc_trylock() and changing
>    some places to drop i_rwsem before taking d_alloc_parallel()
>    for this to work they will need to know if the lock is shared
>    or exclusive so LOOKUP_SHARED is added.
>=20
> 2 - don't d_drop() a dentry while it being worked on.  This might
>    not be entirely needed yet, but it will be needed soon and doing it
>    now is a convenient time, and it helps make the end result clearer.
>    Calling d_drop() effectively unlocks an in-lookup denty.
>    It is OK for a filesystem to do this *after* an operation has
>    completed, whether in success or failure.  Doing it before completion
>    will allow another dentry to be allocated maybe too early.
>=20
>    Enhancing d_splice_alias() to handle hashed dentries is key to
>    removing the need to d_drop() in filesystems.  Though not strictly
>    necessary, this allows d_add() to be removed as there will be nothing
>    that d_add() does which cannot be done with d_splice_alias()
>=20
> This set of 6 patches makes core-VFS changes. After this I have
>  - 7 nfs patches
>  - 6 afs patches
>  - 4 smb/client patches
>  - 3 cephfs patches
>  - 2 fuse patches
>  - one each for shmem, code, configfs, hostfs, procfs, ovl
> and a patch to d_add_ci() which affects xfs and ntfs.
>=20
> Once all of those have landed I have 4 patches to remove deprecated interfa=
ces.
> All of these can be found at
>    https://github.com/neilbrown/linux/commits/pdirops
>=20
>=20
> If all goes to plan, then in the next cycle a few patches will invert the
> lock order and remove LOOKUP_SHARED.  Then we can get on to the really
> fun stuff! (branch pdirops-next)
>=20
> Thanks,
> NeilBrown
>=20
>=20
>  [PATCH v4 1/7] VFS: fix various typos in documentation for
>  [PATCH v4 2/7] VFS: enhance d_splice_alias() to handle hashed
>  [PATCH v4 3/7] VFS: introduce d_alloc_trylock()
>  [PATCH v4 4/7] VFS: add d_duplicate()
>  [PATCH v4 5/7] VFS: Add LOOKUP_SHARED flag.
>  [PATCH v4 6/7] VFS: add lockdep monitoring of DCACHE_PAR_LOOKUP lock.
>  [PATCH v4 7/7] VFS: reserve a d_flags bit for fs-specific usage
>=20
>=20


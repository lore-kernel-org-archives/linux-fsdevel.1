Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A460440E8C1;
	Fri,  4 Sep 2026 21:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788558802; cv=none; b=nBDpcr4DZhhQidiZgJhnjjimoQytAeu1QEIe2z7pBlhHegB66dXv4wkZJ0V92eAFaoBKmS7PSLdvFgL8u6gMZRKQOucfqfeEn4Gnm5GTprsN0sLoN0NUSDZnsDdys7HzbiVFRf+AJjEfjRCCzZekIrpw98qsDD9g+8A6yloxEoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788558802; c=relaxed/simple;
	bh=7TkQW9u4kiL+eS+poIo/QByRdTwXvkpEsvOrSCHZ0Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kRj2Kd5nuqYVSrxoCCf2UEuT/rH6gRvj3FU8htqsK1JLc/BQlFWvgvxDwYyJ57VHt3nuytK5Hiyb9/3m5GGEPsSU42ob+BwLEEuP11/TQ1i5ePXyFdrDik+gdWJ6AqblAQFsc81JqCp6CPcCJkqGdu2zGDwbnCP0BPSRyGBTTz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=HzBQr7v6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LvCkIllw; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="HzBQr7v6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LvCkIllw"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id AF45BEC017A;
	Fri,  4 Sep 2026 17:53:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 04 Sep 2026 17:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm1; t=1788558798; x=1788645198; bh=ZZ+voDUruj
	MOePoj7srzp30HyTtLVfN2kVCzQKaHP1A=; b=HzBQr7v6QWXuW2h19ogkISZuYW
	EQE7PTLvgxymXhQf7Usz0U5YVZZOEzdIZxZBOMMI1ttsIae+N2BOdifW3D+fe8Q1
	VKu06BRUMCdfy3DRM3M8Lv8vWa5yCeq6lcCyLjYJCQ34KD1U1OTgacSyN4goOIwF
	e4CHEJbIe44EHCnzUBg2G48J9kWdn0doZhTw5IBlByh+6lam4EdYiXQcR0yObk4f
	mgTmjC1FYFLRJpHObNiyCy+sou7VqAJxzizr5X4QHqXsZ2+6qjW55T76JRmOxFKv
	bz/VxMMvvL2UqrlhuEFGvKQTrUi8DPFIvoRtsp9ppaW0uqj7eB8QV+WPgnUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1788558798; x=1788645198; bh=ZZ+voDUrujMOePoj7srzp30HyTtL
	VfN2kVCzQKaHP1A=; b=LvCkIllwd3S8Mqj3u/R19LjXEJOvhPr7lgUVRsNBjQIw
	r2eaMGxGBuL+3sXIOqgohEQ72wUxGBGDACK/X7uD27ypM1r9s+wHDDanxRUejkU/
	E/74PBuNFfG3dwHEXrmj/I6PO9OW1ST/ftcsG2FFQFnW7ZR4OrszeM0phlGmEg44
	Qa6sSvLBltkKby3VSNrTOULkGWHpdPY+Z/rzmcbn057RU0AGHSI4izN+kZbc9Rj/
	Y78g02DTp+A4IT3ziEcW2CKD0wTIjCv9w6EzDSRSNtdU9W8+puEt31356Yba66IS
	wr8cHCt8n1qJ4QH3MSu77Beao0MPTdhh7c2wYAjGBg==
X-ME-Sender: <xms:zT2basKi1Cak4LhWRrS2AzZk8r6SkACTAallHP_9nCXlgshF5g3eOg>
    <xme:zT2baut4Twz1rQ62VuUjyy6YYtJe6FWSc8Agwuh3lmxKsvNFxXJSfLR5Wg-bKNXiS
    ERetoOcbe_FemCB4AchXfqWYT13Wk_7ohsnSZvNzbXCacFs2wq6>
X-ME-Received: <xmr:zT2bagVzO24dzEKSAmkQBz0G9zU1dV2RIhzLguOETXSTOzBP4bA9Ixyshcoj5FSN_n_OYyFFlZhyZamrKb9dSnCRUyHfcdM>
X-ME-Proxy-Cause: dmFkZTEvbYg38I/Eoo2MytY10OVTq+pkBoAr0oMR4YrqWLXitHJLWxTLohw2MPBlLZNraE
    V/sbg44k554bhZ40Dwdbi3skwaGYHrJEombZ+Ju9dXHbuA9cJe0y36x5iRsSN5eg4CwqD1
    wvyAijdRCfozutPpK87gkZTBYY6RwNoBwtevOnONdjRzPfGuiv/qXKIDwTa7SW9fGYcfn6
    auUkiOaYV1shnUqUfSdDQD6BVG2S+T56cKXa3lHbDcmfplSaF2/EmgN2bTpLhzVuFdMGx8
    39cT/hQBNLoct/nf/jSZhTtfaEOACmmZxpjJTUb5oV+V4fmKtlSLiaqaY6H0pXfhWj5VHY
    NCxT87AJAlWGOBn9dnjGGYXAWmMye/QuM+a23k/hu3HlvKP0EBnS2+7yfkxogzfUN798qv
    Wpd8IiiB0BLZWmc5hGUkj8US+TWnXGWEsmCy3vY1UuiAI3VaJuNkKalehefoLKDDnGh/Sj
    Z3+UKA7pi4Tc4Kj56t7yKFCLgoJA85tsXtcSdy/czsCrnEWGJBCSI5hlz1KUkbzE7powJ8
    XRMB5sTXhlRttUml5cu1oeRUFEzOsZY548UN5Ljl8q01NMkfMCCD4H3OsUmckO49gjgnPN
    /Y5ShS8q+qEuLJtOfwBNbM7UTMrhybTuZJzbBXgyNMnWhDUbINdVhxu+0zRg
X-ME-Proxy: <xmx:zj2bapgsz8TfsDXrDD3vPMux1xkbnovujZtRVxH3hw7os434ygZO-g>
    <xmx:zj2baoq85lvuIGVR8ec6bhLg_FQJBXNRuJYHcmfFKcH81CkxYr8BsQ>
    <xmx:zj2bavH4e_v6Lc9Yir__x26eGMSLGxRTutM5Tjg0owvLKcn6XXS3Ng>
    <xmx:zj2bat6ApLqYUTSbSTIGQEsGU1QxgeYO-jOB5H0SFItk3mxCPUDr4Q>
    <xmx:zj2baizIXNJrtsxZnJ2n-E9V1TeKMm2l2SlurrVeato1u_pT_hMFg0Kk>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 17:53:15 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/7] VFS: prepare for changes to directory locking
Date: Sat,  5 Sep 2026 07:48:09 +1000
Message-ID: <20260904215142.1060510-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only change in this v4 over v3 are to replace lock_sync with an
acquire/release pair which builds correctly when lockdep isn't enabled,
to add the 7th patch which I previously mentioned, and to include
linux-kernel so that sashiko gets to see the series.

Previous intro:

Hi,
 As you know I am working on changes to locking for directory operations
such as lookup/create/remove/rename.  The ultimate goal is for the VFS
to lock the dentry, not the parent directory, and to push the i_rwsem
parent locking down into the filesystems where it can be kept, removed,
or adjusted as best fits each filesystem.

The next step is to change the order of locking for d_alloc_parallel() -
which allocates a locked (in-lookup) dentry or waits for an existing
dentry to be unlocked.  Currently d_alloc_parallel() is ordered below
i_rwsem on parent, so you cannot wait on i_rwsem while holding a locked
(in-lookup) dentry.

To push i_rwsem into filesystems I need to push i_rwsem below d_alloc_parallel(),
so code can wait for i_rwsem while holding an in-lookup dentry, but won't be
able to wait in d_alloc_parallel() while holding i_rwsem.

There are two broad changes that are needed before that order can be
swapped.  This series sets the direction.  Subsequent patches which I
hope can also land this cycle spread those changes throughout
filesystems.

The two changes are:
1 - don't call d_alloc_parallel() while holding i_rwsem.
   This involves introducing d_alloc_trylock() and changing
   some places to drop i_rwsem before taking d_alloc_parallel()
   for this to work they will need to know if the lock is shared
   or exclusive so LOOKUP_SHARED is added.

2 - don't d_drop() a dentry while it being worked on.  This might
   not be entirely needed yet, but it will be needed soon and doing it
   now is a convenient time, and it helps make the end result clearer.
   Calling d_drop() effectively unlocks an in-lookup denty.
   It is OK for a filesystem to do this *after* an operation has
   completed, whether in success or failure.  Doing it before completion
   will allow another dentry to be allocated maybe too early.

   Enhancing d_splice_alias() to handle hashed dentries is key to
   removing the need to d_drop() in filesystems.  Though not strictly
   necessary, this allows d_add() to be removed as there will be nothing
   that d_add() does which cannot be done with d_splice_alias()

This set of 6 patches makes core-VFS changes. After this I have
 - 7 nfs patches
 - 6 afs patches
 - 4 smb/client patches
 - 3 cephfs patches
 - 2 fuse patches
 - one each for shmem, code, configfs, hostfs, procfs, ovl
and a patch to d_add_ci() which affects xfs and ntfs.

Once all of those have landed I have 4 patches to remove deprecated interfaces.
All of these can be found at
   https://github.com/neilbrown/linux/commits/pdirops


If all goes to plan, then in the next cycle a few patches will invert the
lock order and remove LOOKUP_SHARED.  Then we can get on to the really
fun stuff! (branch pdirops-next)

Thanks,
NeilBrown


 [PATCH v4 1/7] VFS: fix various typos in documentation for
 [PATCH v4 2/7] VFS: enhance d_splice_alias() to handle hashed
 [PATCH v4 3/7] VFS: introduce d_alloc_trylock()
 [PATCH v4 4/7] VFS: add d_duplicate()
 [PATCH v4 5/7] VFS: Add LOOKUP_SHARED flag.
 [PATCH v4 6/7] VFS: add lockdep monitoring of DCACHE_PAR_LOOKUP lock.
 [PATCH v4 7/7] VFS: reserve a d_flags bit for fs-specific usage

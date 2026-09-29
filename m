Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FA623C368
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 02:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790649470; cv=none; b=JcFmBSofYEOguHowb+mPwYdFmHkI3Hp+ArDBKIL1LqmsFq1a4eCgcoyfIUeJJoo3uNqw4Y72trNC5cTHoB2mCqJzFBSTR5lHvXzWl2zPbErt8ZW/stBGDb08CJcksZrkyqkgrqBeiTM5vhauTWp409rEWAsEGfNZLQNKguAyLVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790649470; c=relaxed/simple;
	bh=bbGEsdSrbxCG/IFM95J1kU97xrB35HPqU5tvGWcgCm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V7+KLoM+veoDTqJtXPq9ECWcZ22LImsjg4Ep02Sc4HtzsZjiIdFevBeRAb+Q/RWLxoisobHTWQgUlS3jqyTH5DZVFD/p2oqgN8uEPYcb/kDYptiNsg4+Z0Ty38X5Ez5R2IVm3l0HWMEMsbRYPlrxFfs2Rgj0TgD9RStYQo83IF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=fVQeZ4sg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QXB//UAo; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="fVQeZ4sg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QXB//UAo"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 7727C1D0012D;
	Mon, 28 Sep 2026 22:37:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 28 Sep 2026 22:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm1; t=1790649467; x=1790735867; bh=KmbCGPJx3t
	BjbOIaa8iwf7+9lQWhFuskqyEraUMPCrs=; b=fVQeZ4sgzCiiX/6GBEzVcE0e1f
	XIC4lmOUmE1aQrSn832UGU4aO/0B48/diSfJsXk9ed0QZzd1pnozs2iUf/8prFgo
	X5ogvkAY1FzdF0G4Bz90uyRcpr7F99Ok9/lR0oC5ixcYXUfBN4yQ+uLlQg4VC0yG
	QyXVmSj47ZU3AleGzFla3k0HxI2B3arJmAgcwZI5+KSYAe2bN4e0XV+aitiCuTGW
	Ee3koR/BTvcwG0DnUG3GGVH6u2gMm7rMu4FatOxt1x3VwuczDhKRoBCx/+8zf+qz
	PwV6C8f5x9tLxJjO/wiARcVGMNGK5f/sjXxNmo3kwoHy25XervBxw3iSH9yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1790649467; x=1790735867; bh=KmbCGPJx3tBjbOIaa8iwf7+9lQWh
	FuskqyEraUMPCrs=; b=QXB//UAojXJChaELwL0sjR+TvEjIrjETtwg4c9NumgxP
	UfOAyeH1UnFPUy2hQoOSDG03sjhjzbZcXeimn3Wl/FkM7MGr9ndf9n4CdoA+6SpI
	xZ2ji94tIxdaVCUyCf40kKpDi3/5Q8bquwCTKvQx4U5tA/M/ljlYKgVZaVep0Zdo
	fJ2iCDSQoKAGcy0Yiy5Fi1IRVeYTwwtfJHDmHtkS6NrTsGU4AIojJip1s0sdDubf
	ivND3YAmTLrmtiUGiK98pcWfmq2e74Cr0++syhWN32fhwhf1XqZ4Ec7aLIrva7fo
	jaGlIfphjIaMKaXyP9swK89l9AogpNJ8UDo9DH3aJA==
X-ME-Sender: <xms:eiS7avPRCQ6W5B-tCnBVp79q70fKJw9CkZgJySjZ788pKtpvWMIzug>
    <xme:eiS7atC3R0PnSc4Hfam1VDej3J1sNeMIODJf7Ag1vcVtNy8JLoMtmZ_C_h7jB1-b6
    JZCAROkfN7mys1BZYWG2gzMfXa5EvoI1SHyHV2UhBg1IdfS794>
X-ME-Received: <xmr:eiS7ao77i0Rqgheq7eLrT0sBH1nhxNoPvE_MQlDCPEDkFZoSxm95lNfQl5wKSf7xxACDEt3088_vvXqsYynf3_usVecRfA8>
X-ME-Proxy-Cause: dmFkZTEMTrzyLmTTJrOlqcN+v06KcRNTsAFrJ04A3gwF3TkSIMf4aWK902j5+kw2HP/Zlh
    PpzYqQXSOKjVvi33XSVUnmdEMY9xlMnuwOQQ6qq2K1yXMPcXs5y/PM6MrLscVekXwt+917
    MRtSeGEexSMlMdYJH1ediXLsCUkJUvASiDjWbPMMi0s9pEuwC717WBn7kRN1QS/1TqQLIB
    60Rksic7SzjanRVsThzn8GAEIKx9MXQ+9NBHVd8mcIUb+i+nDxPD3A9ssvR80jdZ4BRT6b
    ewuGtOXdLYTXI3ir0zEbaCYJwYOLztS5ifbS87fQstzY3HwpAPp15uZHO2Wff4hZvKT9ri
    ljkE/emNZVkTlkItUfb4YNnUbPrQCI18SbcDsH9/qrTvTO1unP2CxuQl3kfeCijYOH47SO
    PedqzWsBju2Ypnpm3HXqTU6dXAa+pvR8eTujPTR4937eJqM5tQZsu8GKf5OgCYBJWHh8hi
    wDyll9jKaYHLCUynlBOH82uCeVGJ1hQalTw+7YUSj/U9oW9CmAgGyHF9QSs28ZPwjra94r
    TM4L+KbEqUr8EJSrwuAlnR1HaRgHjGpwDJsxdUOro00+Rgmp1Who7W2ESOfadcSLOgXIbj
    4GsO/Gyv6Q95vhRdJ57ua0Jtj6Wcd5LWp6nnqiB9LbUUJGHFRmDUUoHKtr5g
X-ME-Proxy: <xmx:eiS7av4mhtckie1BrS8XgHHkppZy1R3HE8hLibhsnJnedYhQRGBOGw>
    <xmx:eiS7aiQ3DxV0I7ZRwHVCCA56J5kSHLXqdLqrkL2bZh2iHMkJm9vJeA>
    <xmx:eiS7av_ipnLuP7jW6MLRHyhr-DATVRQ3RONhshrmH_uOebTeT1apRg>
    <xmx:eiS7araCjq9N_XIXxJn-l3BO5p20JETMYOHQXPkSuz_-sbuofzD3YQ>
    <xmx:eyS7agtBUznytWB_Iex6VRJizGCKVTjDA-_DJlSHmBglRFCc5NLVq5rj>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 22:37:43 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernl.org
Subject: [PATCH v2 0/5] afs: prepare for VFS locking changes.
Date: Tue, 29 Sep 2026 12:29:26 +1000
Message-ID: <20260929023223.1429201-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous version of this series has a problem in 3/5 in that
it didn't handle an error from afs_lookup() properly - such errors
should be fatal and not cause a retry.

Original intro:

I am working on changes to directory locking.  The medium term goal is
to lift d_alloc_parallel() locking above i_rwsem, so d_alloc_paralle()
can be run unlocked, and consequently cannot be called when ->i_rwsem is
held.

The requires:
 1/ the d_alloc_parallel() not be called while i_rwsem is held.  NFS does
    this in a few places. New interfaces d_alloc_trylock() and d_duplicate()
    are now available and can be used instead.  In one case we must drop
    and reclaim the lock and LOOKUP_SHARED helps with that.

 2/ a dentry must not be d_drop()ed while an operation is ongoing, as an
    unlocked d_alloc_parallel() would then be able to create a new
    dentry with the same name.  In particular d_rehash() must be phased
    out as it won't be safe. This particularly affect the mechanism to
    block lookups/revalidates while an unlink/rename is happening.
    The mechanism is changed to use one similar to how NFS addresses this
    needed, though using the new LOOKUP_PRIVATE flag.

The patches depend on patches recently added to the vfs tree.  I would
prefer these land in that tree too with an Acked-by or similar from AFS
maintainers.

Thanks,
NeilBrown

 [PATCH v2 1/5] afs: don't unhash/rehash dentries during unlink/rename
 [PATCH v2 2/5] afs: use d_splice_alias() in afs_vnode_new_inode()
 [PATCH v2 3/5] afs: use d_alloc_trylock in afs_sillyrename()
 [PATCH v2 4/5] afs: lookup_atsys to drop and reclaim lock.
 [PATCH v2 5/5] afs: use d_duplicate()

Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0980146A66
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 03:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790391668; cv=none; b=nQwJ3IhhSVTtnQGIhEjUNlmI4ZeYt5rx3z2C6b9UpRvyB24YrEqOpsxhUKrdZZ9RPoQgnQGvOC3yS41x8a0tqJAia1LIX9uAnDyzMEwUlM1naVAkqpavYssT67I5BSncIJ+hpObLG4ePNdTncuhclSQ4s7Gij9USUJZtbcweLp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790391668; c=relaxed/simple;
	bh=YbE0wLiEcFPSuejH3NUSEKzK8XmGOFx9OMwAw7onyR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NlQvNkRdqhvGuCj8cE1EUTvPEMY8O71hIviDLMb97C/DyW55RW4lnBfC3r0M4mgx4Bse9Vr7lZfJPTSQbl1SZyvezkSsCr8aM9sCeS/b0Vck5oNdxj/Q27q7BLD0Pf8SphjLEPMLuDye9Cxidt80zPT68wmSmyugvcu0n5gkxBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=GQg9oqCJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C8hmUbKi; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="GQg9oqCJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C8hmUbKi"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 809C21D000C9;
	Fri, 25 Sep 2026 23:01:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 25 Sep 2026 23:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm1; t=1790391665; x=1790478065; bh=4xKh3xtbyc
	Pc/i+MRzyeV/sZDiv18YHVPGuDxDEyZDw=; b=GQg9oqCJousiCRVxqbuNTv1jou
	aU4yAOC+YEi77u2SGigvF/vasfMgcfTCwjYVg/sHYUTd6xzM17W0e4doUbBfoDjQ
	+f08wr8r7d7h87ghfR0I7vzz0aXcGJg6eSmF3H+ch5BMZnl1v5yLLVafoBI9YMl1
	LAHIFz/p21fJTT01yZr5Oafu79dG6f9YPhVmjed6+GwAJO+/wzMlrdvzLfFr/EnO
	pycpDfFbdlP9rTkfLaqflqtPn3jHDdoD8lw5Vq3v6KwAnl+uYLQQv6fy7Pp1qq2w
	UK869H9t78grAsL39csmi7k+dkaCZZMcJNH0I1d8dzQrPsQa8LLNCNnXCWeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1790391665; x=1790478065; bh=4xKh3xtbycPc/i+MRzyeV/sZDiv1
	8YHVPGuDxDEyZDw=; b=C8hmUbKivoosKBxEC8GZ7mBcrV40QLMl//TQ68c6q311
	xweWB1f/fum0+QaPD7WWGen87GITf9EDt4U9uwgRg/cv7Me9nsZzwGiEfbYq1Sud
	pKUFqqq559OxfFw77iJ4jJDjJajyjz6rIO9QOQAcnBPvXu6DgjZC8WYS2sKO3dob
	kifpfzd9ri2U4BrbXtbJwOleyifdnM+4PTXlYHM4FL5/bD1HQvUqQfOs0Tv2+Bnu
	HFQ84bQX9zTHG/A8H35twQsIXatz2B7OLziyuzhZA7+by6QYifrQRLS7o7P/qStD
	OCUQ7c1K+aLsQ63kYN9JVJ9k973c/APdk/L4t1t+gQ==
X-ME-Sender: <xms:cDW3avAe7dxugSwvgyqNUwvqyyosv14x49E4ABvhX4iKrI2Lj70wSQ>
    <xme:cDW3aoGstfJQDubIoAf-CvVDzk5HJg1m0bc8R5K7htYE1e_57ZwBHkbfVIxQ0IfZ5
    jdt7BHIAKtsWO7JMGp1PzvkfsjvQuu9rl5nVFGEJamekEr_AA>
X-ME-Received: <xmr:cDW3auMtYPwNuSyiKC1nOzcyFoqyU-hPTuWT1cwlWoabQI0m1Do7oAZ_o7EYiNpVcQ>
X-ME-Proxy-Cause: dmFkZTFslc/aXBKC39Pts+KeqvjzdRRiZHqLYniQWP3+vnViLHLtP8WgUk/nOO1dsaD5RE
    YW/fLz/f5/iLWduS2qk5bTSNbwOJdh7m20CR9J36mxDfq52/No2Vu95eRyyM2SR3Uxo2Xs
    4a1+E8SuQQLk13W3N+hbyoFR9dLiBQoWff/cZZzC/vG4PYPSHdZ4LN6gsCJjuiKXHav9pa
    YScRA4aWK72VZj9LRYAcrDPFylQlwjL6W/mE4m6Zmu4Uhw9VpBaRkefE4pemWkfm1sQy7R
    2U9lZgjDgT4qAeV7A33kDr8gnPiPHzwaPX3qWSUUmX6/wlCI17541hFz00tBZwpKbvq9tX
    RrMyhlQvfO4XnXfbospc3Cyy1fL945aI0kE1+/5ht4gpxCfXbW82/2mnLFIOHj6dnPwRfb
    VIsygEBal3b1qDWj1Yk9aZcjHe6+AZEQhPoLZm0jgzNdwRKmywSrSrEFJ84umKwuErsWkk
    VafoA3O+C3Zi4giTvIF65O+PiHopvaKbzvDrj9m8bSXSEiYRNywM+EKzkyn5dUIXHqUv3q
    uvrRI71UzHf+m6is+9+4Xkg0l1v16R+SzK6tix/YD71kVeQBfl2OVohfl+pfo9KhERZqUG
    7fK7kso+0O33MdjLVCgT+03uSXAiiQClJO0Gti88Qm14qnxUjMxhVumzJjxw
X-ME-Proxy: <xmx:cDW3ah4x_hI2bEWl3c846h0viKEwQGmNcyXKT38mggJjr8-oGg5Osw>
    <xmx:cDW3apgNhEOUbInFBKlYTcxQMS3u7-Xtx0tUUcmJ8rEMAp2dSfjH1w>
    <xmx:cDW3aucPMs3CejpXuduHrB8KldWWC8Wj1zvBXBgsSa4XdTnAhmi0cg>
    <xmx:cDW3apxLlRx2HWij9rQoBaLsyTsRIQHOwsaO0_1ZG0QfVQhjTwF8jw>
    <xmx:cTW3auD0D0WGU7hvlP55PsrfgJpBoKG5YCQ5c1rovYble_TFaSfLGdfw>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 23:01:02 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org
Subject: [PATCH 0/9] afs: prepare for locking changes.
Date: Sat, 26 Sep 2026 12:57:19 +1000
Message-ID: <20260926030052.467448-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

 [PATCH 1/5] afs: don't unhash/rehash dentries during unlink/rename
 [PATCH 2/5] afs: use d_splice_alias() in afs_vnode_new_inode()
 [PATCH 3/5] afs: use d_alloc_trylock in afs_sillyrename()
 [PATCH 4/5] afs: lookup_atsys to drop and reclaim lock.
 [PATCH 5/5] afs: use d_duplicate()

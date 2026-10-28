Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793160637;
	b=MOzdRx0VeIgXE7BDEXIhUdk597GwDYCaNV81j7a1KQ+1hCzfOmNXg/gi8l4IwmDa+6Je
	 mr+hqPp8s7dkQEh0ZPIJp2AsdVkQ1PGMTChbojo/TbFi1RfGG+VhQTgsjd3slvX4PAxF6
	 EdBwFDCxgM8aUA3nce3SGyohf/cjM7Lt5jS3k7/sfo4KyeKjxzMtZZ8zGu/TNq9SNXWV0
	 X28DbG3ZgLpJf1ux8axLLefVdmNL0Pq5kyIRzCU+WzxMpzfBRO20gsYSgRigK7mCKIVja
	 N+bYCvfgs9iARve8CcbEelvvvnP1zo4q4kchqE+VoN55H+Ea9T9bXorZVWeT1Sb0RqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793160637;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:Reply-To:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+Os/wGDI48EnuXQYbNa9+MpD8MZtnI7eLwbaeKbbebA=;
	b=dIIZEFOkYivZxzCV+Bdlp0BLQXskfHcfPwN+6u1qqX8cx36ig/TXrsaXtqpSg4Hkd8yU
	 JncvArqBrwlJMM9OaLdllwh42h02DiFw2r/vWn7vaVMCTrHgC9vICKWa9BbRW3/090NV4
	 sRFNKQe3VITBLVOpO+sYi9vj/9pxAtAaDAiMMQjNtnst8VWL57hvPbV4nxiXs9kZJxgHJ
	 s7+/vMNV7Cu+ZsQS+JD3Sizsw0GNDCyH2wk78C/7wujNCOrIyuKi4e0pwuFMSCSiDf3J3
	 LwfpuPbv7ALWDPXgnRK4ZkNNfN0DxqRsDGdr6UzRkfv6eYkyW573GHV5+ly6ONuMBaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm2 header.b=VR20w+fz;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Uzapc07n;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2CA606A31E
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 04:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA2CA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm2 header.b=VR20w+fz;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Uzapc07n
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 65DD81D001CE
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 00:10:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 28 Oct 2026 00:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm2; t=1793160635; x=1793247035; bh=+Os/wGDI48
	EnuXQYbNa9+MpD8MZtnI7eLwbaeKbbebA=; b=VR20w+fz2VlLmFsEcz41OscxGb
	ROW5dTRThTVQ0zod8voxmbBgFMUUwXaA+FaOsKyd9iHmWGNYyTSYgdMgZdkizG5y
	CRgSiidpUIG1sDVywqXlPFAuZGm7AxNbsyHr1QbpHVdcl/71e7n4q7CQdg90/tFy
	9d6jC1zpYRsNsGuKOukeV4d/h7JW4X1OgyAcwBKV//2E98ZOJfvesLm33FfBuy7g
	e0bEPzkYvdAGbvdiyx1Bntr389lQBhR63Mas/d8byh36ERkGGOjnhe5gDgtqlubX
	LNKqdOcbS7+CPQJcvXp5eMdvXAOLv6bgPgB/LJhKfojTONdG08HH++7d3bmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1793160635; x=1793247035; bh=+Os/wGDI48EnuXQYbNa9+MpD8MZt
	nI7eLwbaeKbbebA=; b=Uzapc07ns4tqqMlI15p0ycBNyHaH2B1+yn4Vm+Sj3m7+
	MVG2bJsaOfLACH1FFZ3iTcegB7yFlWMzUa8UBjUy8elyLYQm1TWvCdRSh0MFPO1J
	c1ZkRf5JIFgiALAOOdhxRB08nuQdazzShYA6AqBvz+r6a8nEBqXcdxTdpkfXqjLf
	PehhpPYMipuKcXazlReUDfwGhABYHTid4r7GuCbK+mSz1i9tNn6t/FJzY2Qi1BuQ
	9re2/WZ9mxpPYXKFEdC5p7K9Tc88n8cFpZZBHcLeBzxm5EfXZUF51TfYRuCQTjas
	53kPKPzu3u+VZs3JM9nOhouTNsv4xCLtppEfiikOJw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793160635; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:F+lfUQjH0ShOwCWfcLBlSqQtma6IPk2D4XKXFdL40MFj3ox
	yRXxmAtTK/V4Fgtit01bW4jVRgu5VlTu4cNcDxKr2fR5e7fGPFHEWzvKOtoUAsiz
	bBXIWm+NjoBG0fwSxJTMIpSQtN04A2p3ZDVC0mvVJFFJsgXmywxEE0DyEhGrtA3W
	MNXSndQiziFGY73saXESxMadQyD4E1I50IyWTACL3S/ZpXRwbIzsho1Yfa7p7fIS
	t4eLMfREuElSJPw3xPILNCRbrEV9YiNUNsGtpKNQt+vpBLDrlo/wwOjwcg9N3icF
	xVQPK6Br0NznZ9sVCl0ADjnZ5Ej03Ko5orVXkyw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,reply-to,subject,to;
Message-Instance: m=1; h=sha256:zkOJSkRCX0gsvC9BGE2uURceI33wARzriW3is6W1uhs=:caXNQt1ke6gMVh/5SwPUEr3UDciYTgtzD6rnStDFUlQ=;
X-ME-Sender: <xms:u3XhaqEQUgCRNVBlw_LpYye4SI69QEgp3IVpbXZwGOGqOHCxGK4uLA>
    <xme:u3XhaplAxjJ4BmEf3i9DMl9nrwJklkPkN7l3krxKQKN7293xtmFhkMintI_qntrBO
    P_3X56flV9CPqBRdjwS6Zq0GTdpcwkFsftrBKS8URlrCf9UPqRQ>
X-ME-Received: <xmr:u3Xhatc6ze6nzmrYByepH-biAfQn6mXmaQI1bJ0avNK5HA3jJ3cVUqNh3y0hy1DEsg>
X-ME-Proxy-Cause: dmFkZTGhTTeUoCsnm6RHKzjdb7/xiE8Gs/plhpAczfX8h+Qet11PX8HIznUfGZfwq8a3ef
    N3N6G6wmRyK36Gl34Zf8DT6wrMhOAnK+LE2UInojha1WeXhzcBJyyqOH+nVUZTbmjr6oEn
    +TC/l6cFPdwjrd2os45ll1C8zR0O2I6U/tlSH0xvDxDz1VJZWwqhpn+GkhMS7VOzsnyV1i
    cYCDZA8qOEBssRGDX/nO8O7Nu/IHah4DKiUVF/yqsVrlor/I09oUWWZ+Y1p6S/H/E7qXl2
    kmBryyKm33eivz/cXxd6zPnIafSYlx5iNSMgHuz8MV8nBW6SlA9J+ce2Rwe8wXsHu7qPtz
    j9J6QrXVwi+szLJAIzU+dn1EnvLRk8tQOYUjALR9QzDo+H2ZgXxT8NF0bz2k/gs3A1CAf9
    rhWO5jzb9lvl8XOs9VdQ5Vk1ujM9M46irUDLuIToSMm0JL1pzxGGg2ZsNYTIZImIDs/czE
    gHvWVoKOu2HwTo6upSofRcV+d96RTz+QG4rLavSfKHjrBorTmm8cRcAGemc/4rxLjI+ute
    2h8pX7kgg0EmZIlAsF+29v85dMFIuOtEHBk1BpKM1ypTuh6FBMdyacL4x1/5FSnjsMxQPo
    SycU4D0WcTadWC8pW3QAdkHcfCenEkdGO4E1SM3ZcIu2vE8q58tdgWUEhIFw
X-ME-Proxy: <xmx:u3XhanEKWLfkvXGS9iCY92FH8LDqW5BsYgxR8JQIG1ArrbPp4F6Ryw>
    <xmx:u3XhajgT1ZdYYGM87UfqGMKc74TAqNBrf4U41i-55TMFN4dm3YIBrw>
    <xmx:u3Xhar3pzhlWvN80v8KX7hXiRZF5YNXokrX3woFAfIi71y3WDu4dOQ>
    <xmx:u3XhaueMpgt-Lq_mnwNHeZVXMzbi3T0I88OCHogUvHe0JpxyOGmJ2Q>
    <xmx:u3Xhanp4NdPNs2xDG5VMBLDE6jpTIK6ndvVWOwAM85Ak5Z-flbq65LZ1>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 00:10:32 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jonathan Flynn <jonathan.flynn@hammerspace.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/9] nfs: prepare for locking changes.
Date: Wed, 28 Oct 2026 15:06:28 +1100
Message-ID: <20261028041023.3738553-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the requirement for this are upstream this could go via the NFS
tree or the VFS tree.

Thanks,
NeilBrown


This v4 fixes the problems with patch 1 which Jonathan Flynn helped me
to understand.  And *actually* adds Anna's Acked-by.

Before this v3 fixed three bugs found by Sashiko - all
error-path related.

1/ patch 5 - make sure d_drop() gets called in all error cases
2/ patch 8 - dput() sdentry on all error paths
3/ patch 9 - check error return from d_duplicate() correctly.

Original intro:
I am working on changes to directory locking.  The medium term goal is
to lift d_alloc_parallel() locking above i_rwsem, so d_alloc_paralle()
can be run unlocked, and consequently cannot be called when ->i_rwsem is
held.

The requires:
 1/ the d_alloc_parallel() not be called while i_rwsem is held.  NFS does
    this in a few places. New interfaces d_alloc_trylock() and d_duplicate()
    are now available and can be used instead.

 2/ a dentry must not be d_drop()ed while an operation is ongoing, as an
    unlocked d_alloc_parallel() would then be able to create a new
    dentry with the same name.  In particular d_rehash() must be phased
    out as it won't be safe.  Various techiniques are used to avoid the
    need for d_drop(), particularly that d_splice_alias() is now able to
    splice a hashed alias.

Further, the first two patches here fixes bugs that I found while
developing and reviewing these changes.


 [PATCH v4 1/9] nfs: fix open-blocking with d_fsdata
 [PATCH v4 2/9] nfs: fix nfs_call_unlink()
 [PATCH v4 3/9] nfs: remove d_drop()/d_alloc_parallel() from
 [PATCH v4 4/9] nfs: use d_splice_alias() in nfs_link()
 [PATCH v4 5/9] nfs: don't d_drop() before d_splice_alias()
 [PATCH v4 6/9] nfs: don't d_drop() before d_splice_alias() in
 [PATCH v4 7/9] nfs: Use d_alloc_trylock() in nfs_prime_dcache()
 [PATCH v4 8/9] nfs: use d_alloc_trylock() in silly-rename
 [PATCH v4 9/9] nfs: use d_duplicate()

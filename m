Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794255834;
	b=RUbG0CntwHSWqatu//XVCKp11/sON2mOnC8Ig+X5GbYXTWbQ1RVdx3MMkazM7k9meXN1
	 EhSj2Xte+1tMyDxxY648DOJrz9UJmpxcTKJmyycHZQypV6lV3hTX/CdNJdx/14eJ04h5C
	 pJCK9vS9TqF76jeRetJ7t3mCeGIMeFx2sQMJryPFsU6NIV9Yefz14WhHkz0UDeTR30uoS
	 jbfaPr+vkxDUWC1pvAg9I19/9FRQHZX3enth4oa6iqS3lWeMSMnEWYOjABg/GpD0fcHQ4
	 hBdmDfOO8CrXUrJSk3Kg2KuAU5g6NQE//XJByX64Fi19zVBUkaXyw7QPJ9hpyWdcsRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794255834;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:Reply-To:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YgAFQd7bekj3d7oevT9/mkDM82sDq88XmkOWnMQYsvw=;
	b=j3Ue5hbWBTnnpddiulnNhCyZG6bTr/z42OssrwX51WCyRt/Kf7BKtFVN4o7ozPdewp/x
	 +3Z4KbHRfooQYHM4Y/x1TkMzMkDt/e4KWBzlLmd2WSJg1lQ4JdtgQ9wsRi26eaBllC2mM
	 9tj44MKjNsC29B+sN5jL/u8Wa0ePoV9J3vfd5KDxvLdDnRHWs3l68Xh8gGjOhra/K0q2v
	 zOvQKm4K1/kUoouSD43oS7QZwmRCGFuL4XI9dIP45vZp84ZYTLPauOMeMUrZZ+XzFTraK
	 BnLXxfPDmPrZPCArrhM+Ewe3E6943TmNCaM3H6SlpLQnOAIH7KA/K7VtybIsoiba5fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b="V7/TZ9BP";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vl6so0Ty;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708BB606A33B
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 20:23:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 708BB606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=V7/TZ9BP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vl6so0Ty
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id AB3A6EC01D1
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 15:23:52 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 09 Nov 2026 15:23:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm3; t=1794255832; x=1794342232; bh=YgAFQd7bek
	j3d7oevT9/mkDM82sDq88XmkOWnMQYsvw=; b=V7/TZ9BPvMZmCzesF1rCMPstjL
	gv9sCFN9awQqzHFbOf6HPF7BCbuC1nBgrJehw9N8pU0MKG2uDkG8C2j7xjk7EcjX
	hEXn+d9yCBTnp2hG870p1iPovQn3gcAC+FhcU2decsOJacO81J+KsvbJYQUkMNJv
	9l5/90Fp4oG73FmAteT1RoSdJ5gIltDHzzlwlcObz+9rzfO3lrHX+c6s3QnvtDSA
	+DbF+2ceU5LV45TRezm6p8fBO4aWq/Nln0aPrRFxXovWN+BF6fvBO1Pom2+9nE82
	4mFlSN94C4RSF5+pTMZRkL5jXNYL30f+iO3jV3zubpwYgHhEXyrtyJN3A5fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1794255832; x=1794342232; bh=YgAFQd7bekj3d7oevT9/mkDM82sD
	q88XmkOWnMQYsvw=; b=vl6so0TyDCypo65LT2FOy0VQ0BefABHm5OaT2QmMxJ94
	8kgoJdiRKCd4EbdDjEzOPBMmQlfFWUtgl+/rrbTd+7PxZlLzHOGjhbm13ymsrX2l
	mshk8+FH9Zp/uz5jD9NhhKoKl036ZF4mExBQu8vmYtPrq+k1fUVuus1L1zbKG1e9
	1fnbZAhozyS89mm/74FXckr4DdDjOC1zKXte1dUnWO4JQHmU0CWvGn8EW9TWiFqE
	CHdG/pSr8fNLWex08A33ZOvlFQGBBx0erRgJAtXMjpVTjz2SiBA7JyAJvHMBRTTk
	sUnYK9O1JDpHVhJ7wFH/0ibgkFRtwT+u5izUgSq1+g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794255832; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:P4v4DWC276QmPQvHwZ5qBLCpVasDwKb4pWm3kLl/azEALQM
	Deinj0+Tu5Li4yp/5E/HG641HhFFYtJnfM4tFojaysb7LIs8ynRrTL+VjjY7jI2m
	2Wcbxy1fsk4IA478pk/PO/zKi/1egaG3owZ996CfxfsW0vhUrpphFi3pp04/KhQJ
	uaJUEmKA3jVCRR+mSgU5O60H+1T8QX7sqPaUPvcB5QwN94tCnDbExWvQpNknqFuT
	La/OVpv2vJa6RGn/CO9jcgkEFLl0Ce2g3nwlWQOwMNtnqUa4ezDhwi7dbwPif3iH
	OYiLblaqdUUtiv1Ck7A5aO3KaV8sOBCn3JzNT8A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,reply-to,subject,to;
Message-Instance: m=1; h=sha256:ZuVE5KupMboxf8CJR5q9TNrICTq3KeBKw2JNTUYCMkE=:pYqqfF3ON6NV4H1AoY3rAvBK1gVr4WtDfU1tarkcu18=;
X-ME-Sender: <xms:1yvyamazFYUtfzqihhtMEdIK9V-CMslgvyrMEgSKJvLvLpOBRA3H1Q>
    <xme:1yvyanqM62FPzOrrNjdotbLW1ifVWtWcE6KEtx8Boq34V-yBFAVD4HMA0xpuN5hgF
    XVuGzrB1i0yYXdbV0b8dZsueQM21wneCuaJjS0auq6W54I_RBw>
X-ME-Received: <xmr:1yvyaqSvRpW1oVHVay9UNrCHtXvN41YIO2t5sOl-kHHl3VEK3IOAw-_b7eW83nO1UVg5ChONZIheXFAJOsW300peTEJm58U>
X-ME-Proxy-Cause: dmFkZTFb9ERLq480HsM4xsch1wsVTeR4VK1aOwVAMqkGvq1SNe0pnoHhuxUvqWWxaaBhxb
    38E1ZY7E3a6l5iRZOf77TQwuVyacb2k4xro7oAvHDhyIl2HfVZnhdpZ+UdpZwTDy6lN/Y5
    3/c1y0VJVZGHmXMmVWGToQdDCO3N5v7Gn0Stv9OUvbNbgh/fyMlV4nR/+4lgGGPnyCtdQ3
    3mGQsa+nqqTvgGKJZaNBOih+iHGhbIoUZJpFfTiBHyzNc8evEwmRrcSEUqBKl/MPYCKi8d
    hKchU+Zcd1stBG++Mt2GMUfELYtmZKj5i3LvD9pjbeOj708zAGetmj+eaRh2LfdH9n/mj3
    NQoQ6P61St0zI19naVawRN3yRGCPbyS6hTywNrdrlD8zZggrQUDu6SqDx7Xa0Rey/Hj0v9
    KfaF6rrelKJVdyXCtLKAsW/XU2qoEBZU7/Gh1iwmQ9BISgZS1Q5sBhD8G7L0lvAtApTxg/
    ywtJWYkqif+yfsKSF5VoY7nop3Lx4OuQO9eMLNPdzJb5XqrZJqvuQhI7FdGFRUfLahoFxC
    HPs5ynvO3r0CMNGVRwUP6dQGZhf2pxumhg3cUBUfpwYfogfiSEPsCOhLrK/jKLqWspVqb8
    UeulRmZOjWTRHo1szNn+ZmEOa5P7258ev9jSGt575GItWDiflLGQICGG0d9g
X-ME-Proxy: <xmx:1yvyarrz-ioqEg_BjgEf_d3ZOh-9TxrguY95TwC9JAIkBcCnOcrmHw>
    <xmx:1yvyak39FY977EA4yRb2yUQLZPnRFZxWogAnVap7n1Hddamn6imQbg>
    <xmx:1yvyaq5yHbSDAYQidgkFw_7NLts4MKprMLn80nyO6_pOcgVX4qxUPw>
    <xmx:1yvyaoRhS4pRYrrg-nWY3BQfjs_y331-3BIHPBhoiFP4OyPxUi4g7w>
    <xmx:2CvyapNwe2-kh_MnJ9BB_5PfxjGJ-pxs2DU-n7nIxLEHA18x5ukTyrf7>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 15:23:48 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] cephfs: prepare for changes to VFS locking
Date: Tue, 10 Nov 2026 07:20:22 +1100
Message-ID: <20261109202339.1380828-1-neilb@ownmail.net>
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

This v2 drops 3/3 which was deprecating d_add() - there is no rush for
that so I'm not going to push it at present.
It also fixes the first patch to increment "skipped" when d_alloc_trylock()
returns -EWOULDBLOCK.

The VFS patches that this series depends on are upstream, so this can
land in any tree.

Thanks,
NeilBrown

original intro:
I am working on changes to directory locking.  The medium term goal is
to lift d_alloc_parallel() locking above i_rwsem, so d_alloc_paralle()
can be run unlocked, and consequently cannot be called when ->i_rwsem is
held.

The requires:
 1/ that d_alloc_parallel() not be called while i_rwsem is held and also
    that d_alloc()/d_splice_alias() not be used (unless the filesystems
    doesn't support creating objects).
    cephfs uses d_alloc()/d_splice_alias() when priming the dcache from
    the results of readdir.  A new interface d_alloc_trylock()
    is now available and can be used instead.

 2/ a dentry must not be d_drop()ed while an operation is ongoing, as an
    unlocked d_alloc_parallel() would then be able to create a new
    dentry with the same name.  cephfs calls d_drop() in couple of places
    before d_splice_alias() but this is no longer needed as d_splice_alias()
    handles spliced aliases now.


 [PATCH v2 1/2] cephfs: Use d_alloc_trylock() in
 [PATCH v2 2/2] cephfs: Don't d_drop() before d_splice_alias()

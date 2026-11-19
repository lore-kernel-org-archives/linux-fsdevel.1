Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795057195;
	b=1KctKtcXZZnInmLCCqLdUYVvpSrXwUAovCyh+fbBdltfZxaVt+5Lxdi4IGcQGkLOdtK1
	 xlZSQmQqS6/ZUwGvKYgmCA3u66nDloqMeQyk65348RhoiRz9qOw4ldd1pC+p4h2GS/2YV
	 D1WYod20wjBwAC5lZOOf3uclREJAIyp1T2ag2BIzQB/w9Qq+nSNM65JMPiGSc8eGc60Yn
	 3P35V9ES6BK2NH3x71OxcnLx8CIaRn4/HqSDHhkWimG5CbXuZxwTZjGzNb2FHUqSdoiQP
	 RKO1B4YQRR/NaVW0k5aXSoCMU8SKiCt3W0X1L1BYfXRe1xnxRi+BajLvC1Y6ALLhTvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795057195;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:Reply-To:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+rsFthucoYMmPhK53831kSMdKEwqRQMG/xnxdDq22co=;
	b=TRlPnFUSNPW78AIw4dmcMr62fVl/XmPvrvacDTrWyL4hZrvpFo33sYWJRkFJheYaBERm
	 PiIpfJNhcU+izyU43EQAjYJaQR9mm/VxyAg4RrwMi+cyL9La5bzHBoJLtIuPRg9wSZHzQ
	 8MueiZOr072NnKL9j9DwodGMsxvhZfVbNledNH3mdi9V27hoxJa+DeNY3QLQ/D3epjsIC
	 BSwBR/q1Z+ycr/8TIQ/KNsKivbzaZomuxnUAKrHjqI9q6iXZSC0vMS0LANGSBeCKxs1lT
	 WoKCc7UBW8LRKYkplAP8EvNMsFAOcIQUgwc2xEkZPDa6YsxW0sKHEaZodSOMDmBxAOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=rwlZu9yx;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=wpP38+OD;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF3D606A338
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 02:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDF3D606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=rwlZu9yx;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=wpP38+OD
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E38BA1400185
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 21:59:53 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 18 Nov 2026 21:59:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm3; t=1795057193; x=1795143593; bh=+rsFthucoY
	MmPhK53831kSMdKEwqRQMG/xnxdDq22co=; b=rwlZu9yxpwOQ3sCz8ASM0myTgd
	r6a+1B4uLlgAte9jm1aMtTeQxBnlu8lWsZUBwahoGz7oFPYn6Di0f2lRSFXB8poy
	AF0Qv7vmfg7VNGQKUCeBNtxQmFbn8ZkOpQSJvG773afp4SuqbpAfwuW4qBc8qTkO
	WcN8NUXK3K3Wq8AO4DksI7TKwo/3ZkqzGhdakmiQC6cY49lb5wOKWu/FTfNNT8hB
	vd87nu5FYyAhp3/dQ9QH1Espj4JbFqxNdrZi0105cWoT6xMqkt2SGAuMBOLK4Vyi
	ilrtZ3WmKmeYikgxtOZB0PqeOFXnZ76hWkIZOXrAEfvvhaZXPQHs3emYXfkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1795057193; x=1795143593; bh=+rsFthucoYMmPhK53831kSMdKEwq
	RQMG/xnxdDq22co=; b=wpP38+ODmloepSVBIrPbx9qcXA6q0WLsfUlI7ZIMz437
	KlOWcAedaHJtPIGvcHPvYwJZy2Ho9coyfHvLazU2RVv8mNDHJGe0m/keJg6cFxiN
	2usz7C7IDsMjffGfo7GLpJIV3M7G/UKK8/ZFZpMNKt6TtdKmU6EYeOK4N70z1j+X
	4ztuEevMCAiMT8BpB+YPYW76wgiYEgraLQdkVwU3vw+5A+vdkyysT8PTzUfVCSUi
	7goAy517+WOMIHz2W9k1ozvdyvOiAB93AkA8CnacgJ3gb7nSIQuhMuNJzYgLSu86
	u0GXvSkt7mFBXKv6YcE+r++Qv4hWSE/1mym/vJqx+w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795057193; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:gA4PtJ8PpyLtSKySkjIlG5nZkJZ0pZGCf3a3RSTmuV+oHa9
	pjcxcpq9B2E5p8GXFWh+eYzCWkkn+GUHJeIY1Lh1rwbAgOEWVKy1mAg3bgcN0D+g
	02R4UmO9MFdbsk8mfdF50EboXg4o6wQoQPYMQkE40xZZpSkt0ZPQMCbBwpcbhTEE
	HdyugI9gzypitDvN6IEEHN+cNQIY0Llf+tRqUi0/HuwVgzIeIrmUZW9Z02nGBg16
	l041LOcaVV0jKAgkkD2hpLH14j0ZjM4fE4vTGuPVzfEXlnxTE+xho4i+tF0tWYHb
	wyAGDAuESsaLTEcbCoXpnuumA0FbBtxw1VYQ4kg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,reply-to,subject,to;
Message-Instance: m=1; h=sha256:IimJcZIauzysgvEX/dSb/kW1fzUmMG72gEXvAv4SyHM=:8NfcA7QmovTFkNGyg84//NH8LzemLxZt4jc4w/hsq3Y=;
X-ME-Sender: <xms:KWb-asIfOdGXnthoNijD8svx6rQOtWuDiC2b9O-WEfxqVqmg7ce9NA>
    <xme:KWb-auuxZh0QQJ1lmxyRKJh6A_P2rGB4oP2JDP4vAnoV00yVN20jrWH6z6it_fYU8
    5HjBe95da3sI5JSURC-f72bXQuLKkSyIf75wBGmvZ6fzXQ_QtV2>
X-ME-Received: <xmr:KWb-agW4VB7MljhDjcMeOD8mQUxwOfcptFj_icGDNrYu8oysAjuBY9wE9nlA2XpoEBB2beQ60sALzkgnwIGS7Czw9yV8SmE>
X-ME-Proxy-Cause: dmFkZTFAEaDYVTqHrBqTW3/SJlTS85H+qFLwAN47fSvVtTZEyXLKNBoiUF9qRQqHORP382
    YFIZdgXmhX73QUef5J+h5+tV7zpD0cCoXBcfPUgri1ExEe1bnq3vm9tkY45pitTrGiKkTE
    Dox2Ca6MxPONke7MuAajL+lF5z36oKFuZdJMPhWLhitMGAb5G+fCJ9VL3f6fVwVo1i0Dv5
    NMWY4PEJEUScTQ1bKWEg/fB3xcBPlenbU0lJxv0eIoF6y8kLhTM3nIkmOIl/I50zXpCRT3
    rksDLvl0KwZYfbLyI8ysLMsSnbi2Xa+fhQuvZ3HiHPeKCZhWI2Hj42DOq1UkSiXECNhdX6
    TQYttxWUjlqkbn49U9yv8JylDQKN+RwJonH0ybU/O0/ap0XT80eXVTfotdRXEi4S6FlrHt
    tABcsxoL74vnTgrTtuqcAuS57YF3VMIlkr0EHOEEeRqagWqViyMHTSKWdnfHQztsEMZD5x
    qs3WMNKDpEVyZSOp+o08uUJ9q9bxFCZOFi0GbnoZtY1tx6qjugiIDjQrJVNGjU/RFFRb/A
    rC4yznoFn9uReXUiodTjl58OsRisQTyzikLGAQz89kEgw7Of5i1lENuR0q5XzSYC1toSI3
    cv14LrYQnz8bkfbS7oIoKSh661OaihzEJLvv+DVBDxjDkcnWA/2Lh1G2YWkQ
X-ME-Proxy: <xmx:KWb-apiNjw8bBOArD0EnJEjbX1eIEQhlQHuBY9tnKceK6O0dBZRtqw>
    <xmx:KWb-aooJ9nJaBDF_jBwTe9jqnGIFdQ5Wl-kSOFXRyPG0cXuzp3mn1w>
    <xmx:KWb-avHBLYg6SQ4vxh-t0pC9-dXYthpbn0bXRFlTJURtUgWNsxTzdQ>
    <xmx:KWb-at4V7ajwrYK38n_blrjwvyqtUeWOvmWvIQpouDW1Acl4zDx53Q>
    <xmx:KWb-ahYQ2d9ayS_ez9vgEznxP76Sf8-Fj84MKMDZqHK_bTgpF3Qh6MRb>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 21:59:50 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Kent <raven@themaw.net>,
	Jake Edge <jake@lwn.net>
Subject: [PATCH v5 0/5] Fix easy bits of the negative dentry problem
Date: Thu, 19 Nov 2026 13:57:00 +1100
Message-ID: <20261119025942.2848130-1-neilb@ownmail.net>
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

This v5 add some fixes for autofs to the first patch, as it is one place
that does care about counting all the children.
Otherwise it is the same as v4 which narrowed the focus to fsnotify.

I think (hope?) this is ready to land in -next.

Thanks,
NeilBrown


Original intro - revised:

 I was reading about the negative dentry problem in
 https://lwn.net/Articles/1079407/ and thought I would have a go at the
 easy bits.  Given how involved some of that was I'm glad I didn't try
 the tricky bits!

 So I didn't try to reduce the number of negative dentries or handle
 them differently to positive dentries.  I just tried to address
 specific symptoms.

 This series addresses two reported symptoms.
  1/ refcounts on parents can potentially overflow if there are billions
     of (negative) children.  This was the easiest easy bit.  The first
     patch is all that is needed.

  2/ Walking the ->d_children list can take arbitrarily long and can
     trigger soft lockups.  I haven't addresses the "arbitrarily long"
     part, but the "soft lockups" is relatively easy.
     With this in place I would feel more confident addressing
     the "arbitrarily long" part if that seemed worth while.

 The core idea is to use a common helper for all walking of
 ->d_children, and teach it to drop the lock and schedule when needed,
 inserting a cursor to keep its place.  This simple idea requires that
 nothing should be holding any other lock while walking ->d_children

 [PATCH v5 1/5] VFS: don't count references through ->d_parent
 [PATCH v5 2/5] fsnotify: update children flags only when adding mask
 [PATCH v5 3/5] fsnotify: don't hold i_lock while walking d_children
 [PATCH v5 4/5] Add d_for_each_positive_child family of iterators
 [PATCH v5 5/5] Use d_for_each_positive_child() in fsnotify.

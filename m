Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8846F5474F;
	Thu, 30 Apr 2026 03:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777518554; cv=none; b=aGORjZ1BoJmClMbF9awRcufTm64aDgvFc5xtSS0oUgQhbWL1mw8zSkpUanCjzbg3wmdMxsjwrgiVsGTi9f7mfLexx6ZFYmCxP71gv8b8AVp19MNOWkWxfdUr+nGkPlsgPtT22bl4+q55CfwQKWtSQo3TmCtMWvysCUF358Lk5p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777518554; c=relaxed/simple;
	bh=a8LDTuqZAH9oA57hmQkjMoUsBgVyGLcOBiJHfzlP8tM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AZ4I/EUKjWdEcwVctvn98kbjKn8hKKj4b1518PZKiz1Io84ia3kc2GXnNFeacKPhoCsS7faeWYjzMBNUCSxhU5jTHz74exP5Fz/TvZ5BAMB60dAcXzhpMvJvXDtmn/VnRLKLnC185ny17aqF5fUYMNGGCIs23spdyZeDHlMgbDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=SysrEw42; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tQSDnhdC; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="SysrEw42";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tQSDnhdC"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 74CC47A00EA;
	Wed, 29 Apr 2026 23:09:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 29 Apr 2026 23:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to; s=fm2; t=1777518550; x=1777604950; bh=D447f0ggT4
	8dgN9bjFVq1QpgbaNCFFwOUy/NhI/3usQ=; b=SysrEw42aQSGSG8Ac2kXPQkGmh
	PPf3iO4rmBcr8q1Y6cNn5Lv35KVAjnZS5Lg8MPQTzxk/8Bd9wsHs8Oizmk8aY9o4
	QJ4297m1OBAjv4Wh7Jd05JwT7nugMPbize5VlIxmy+fPvg230wLg9WiIfSvjlIR/
	cOgYXyoY75OYQG74f+XfdOc38NrtJQeEo1I7cbxivHdN//c5VGdVnVzA7iYIQ3s9
	1iOCdXfAagLZJ9YiU6jfVWiTQY7zj63GEnSfnNBARmUmJmVGoJX6fbJ8k2IoxF8j
	cx/bl1VWsrR3unEHNB0COJrSyY1Psqn0Q+wXpf1e76tvjMADXvu3/N35TOEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1777518550; x=1777604950; bh=D447f0ggT48dgN9bjFVq1QpgbaNC
	FFwOUy/NhI/3usQ=; b=tQSDnhdCAruevXYWIOTbCcsBP+Doghlha5xAyNX1Pqvh
	M0awxyENM5qM/XdXZvtjG/P8esEaeSKtpVoQarR8UyD6RyB9tIoDzcuVJ3/Dcafv
	gFiuPsW2ULfcVJqM7KAkK602sRyWu4X/KztjBAOiX6qksi0JrdIbqVwHTeTsvpKN
	2uivZzwH9Vba6/zxKJq+7DHPDXJfMW5OQXN6iAgIErchf9xAEoKtcIJNHAUFyBlr
	s6eV0XQZiusGAlnXaNu2+M+SZ3T00Le3N6OpZFCbg4x2OO0/4WjBD0knBRlKyzMg
	y5wTi38fuwRWtQ46M6DoWoNNfpHEIDJknskoEph66Q==
X-ME-Sender: <xms:1cfyaUnm2cF_MQmI0syq4Ixz9pt89Rq14IyfzB3CxyPs3VjrYI79ng>
    <xme:1cfyaQt4Fm99GoGzpLmqWhTrmiQWUxMbBjyE--2N58lF80cX1HhOJuDjw3ysA_Fdd
    ukZONRoehy20zZqsFaQDD4XIY6z95rY31q-tkwwxN7YttXO>
X-ME-Received: <xmr:1cfyaSa0G74P779l83k7UOcDcJGUW32ClLSt3AcCtuDA_YfNSZ_CilWfDhq1ktVkUGat0w2HyO6w_DlHuocNczoq2NBxO5Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekiedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkfforhgggfestdekredtredttdenucfhrhhomheppfgvihhluehrohif
    nhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeegte
    efgedttddviefggeeuveefleellefgjeeufeeukedtleeiieekvedtleevleenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofi
    hnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpth
    htoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehtohhrvhgrlhgushes
    lhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepjhhlrgihthhonh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:1cfyaQAILl5Nj_gMj_nHcvAt2NgdkgnqSRRE8nQYPWix50KNz6kgFA>
    <xmx:1cfyaS8ea-ZYMyow8-t4OXIpiNY1y0X3YAX1-6Nl6-Oi7qTzadxsJQ>
    <xmx:1cfyaUQQFbfnjLDYgJPjkgVAEO68HnmM5Osf4nRJWboubLckNolGzA>
    <xmx:1cfyaeXrEE_7EOq_1GJgXCBe6eIswfWda-Sr5r4-jJtgo43HyEM-Fg>
    <xmx:1sfyaWcVpkQTb7dxfv8l-EB7KSEycWd-tuDRZz1DiX0WXTeBLTg8f4E6>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Apr 2026 23:09:07 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/7]] VFS: Prepare to lift lookup out of exclusive lock for directory ops
Date: Thu, 30 Apr 2026 11:56:53 +1000
Message-ID: <20260430020137.3305302-1-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following are 7 VFS patches which modify or introduce APIs that will
allow modifying filesystems so that they will work with a proposed
change to move d_alloc_paralle() out from the parent i_rw_sem lock.

If these can land in a non-rebasing tree, I can work with individual
filesystem maintainers to start using these APIs.

I haven't included d_alloc_noblock_return() as it is only needed for one
fs (ovl) and it is not yet clear that it is the best approach.

I also haven't included the change to d_alloc_name() as that is only
needed so that I can deprecate d_alloc() and there is no rush for that.

Patch 2/7 is exactly the patch Al proposed in the conversation for v3.
I have taken the libery to added a Signed-off-by by Al to match the
Co-developed-by.  I hope that was not inappropriate.

I have been testing this series over NFS mounts from XFS so patches 2
and 3 don't seem to be causing any problems.  The changes in 4/5/6/7
won't be tested by this, and some cannot be tested until filesystems
start using new interfaces.

Thanks,
NeilBrown

 [PATCH v4 1/7] VFS: fix various typos in documentation for
 [PATCH v4 2/7] VFS: use wait_var_event for waiting in
 [PATCH v4 3/7] VFS: enhance d_splice_alias() to handle in-lookup
 [PATCH v4 4/7] VFS: introduce d_alloc_noblock()
 [PATCH v4 5/7] VFS: add d_duplicate()
 [PATCH v4 6/7] VFS: Add LOOKUP_SHARED flag.
 [PATCH v4 7/7] VFS/xfs/ntfs: drop parent lock across

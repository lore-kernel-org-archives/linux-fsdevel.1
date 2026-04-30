Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F99B345752;
	Thu, 30 Apr 2026 03:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777518627; cv=none; b=CPED/YF2EULDJl3pW4TSYYu/SDDdmAvGK9coGBuN1DjrMHoRR+s1/rymmDl5Lgk9DjuZa7cM+AsMyFUDfNHCGauiGS5tF07cSMdI5p7GTD/kbpPLfp/UdpaFtxX9ptre+mRjrV1zzZVleahSYgiZTvGGzDteXwrREDnTPbNC6WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777518627; c=relaxed/simple;
	bh=Af17cpjWLrgjln+x15PYEXYO/pHIZybmrmOg/uu6FGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZxZ8A0Lvmt1Lvg6sOe8ExeFDbZHeR8ZUMotnlssjMHMMTviokrXEvJav+mPeJT2kN2jnjAoYbSN80Fy4erXUGna7+DxV2l02zDVmZI5tJb51p/Px2JSNmlnieQ7NTMXRZedoCA3yG1UNVck1M3tg1B1CvDb5avE2BsvvVwS17D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=sbzKRjkm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fO5anVE8; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="sbzKRjkm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fO5anVE8"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D47757A0105;
	Wed, 29 Apr 2026 23:10:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 29 Apr 2026 23:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777518625;
	 x=1777605025; bh=2Sazp1M0TdInI6mi6hF1QSnGjDghjOgL8lkwZNivMpc=; b=
	sbzKRjkmaIgAmWEnGYEDu3JGNlMrAh9myOo52gOPSRqsK8rZpcfDiS3j3ae33sT3
	R7hS4WHRgenom2as7aDE5NyklOZzE2S2agejkQhMxQm77gEcbYPVmpDKQmh3Vl8h
	1cXuoPrtuMlvpPM2jGM4FMfWJookmgnkQoiCuLy82PzfaKpbuQ77UsHowqg1w1hv
	FzZ8fhaQteWiNA/QegM+Z6wxUON7jlZbPOEvmm3wmWPBp2Yb6d1XaiUntt4ldeEn
	6FI5JEb8JtOPr63HcbTCI2FVgS7MzYrN5DZNeHhMuDwoI6R4oWq4ZZPYiRfLredO
	hLhkJmVK5Vn+rA+2koboxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777518625; x=1777605025; bh=2
	Sazp1M0TdInI6mi6hF1QSnGjDghjOgL8lkwZNivMpc=; b=fO5anVE8Wbuz0nXJX
	3poYHhg9KfFFoHUiLtByyUQBsll4Is10h8/fnymXfgUSVBqjYoXaUxrmRwafIRWZ
	g8wGMUmXucz2SMf8ITuHOLmDsxSLe+v9M07ff2kOoIeayTwxY5YpmIJns/lEnCML
	SajUDPMP0KI8I02y8TPZ5f2ATc39MguzkM3kjL11ZDWvXyL0ZqkU4E4wZBZd2jUF
	jjPQGg9jk6f3CphEBE0VDmuZHDyqIpkM+E8ouPi+kpPbZk/ACEe3tqoaQLA4rltT
	NTqbiUoMbhMjhXmgi/YWLwgm0EA+zE41aqhWMrhDFPDHrnZr5oSmQ8Bg3Kch9GK6
	CQSvg==
X-ME-Sender: <xms:IcjyaV2uZ57KjNBdEX-NxJkga1xnEH0Z8_rjNa1flFnJZ8SU2uDjSg>
    <xme:IcjyaeqrPC-LqKLGUCeZlflOw0qXymu13wYo2y1_lwpnb6lQjInb6J2DMWTkaB9On
    0uutl0x5ZnYkhyygW8UtGtfVaUugkSf2Edf19u_BEgutjUP4Q>
X-ME-Received: <xmr:IcjyaZhDH4701DJ0RDQJWT0jBEjs_guwo6pn4lb8-Z-V4BcTuJrZRZzBwKryHKLOgZm9kQa7x3lyDB7YT29vZ7mSuZmOmwE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekiedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehtohhrvhgrlhgu
    sheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepjhhlrgihth
    honheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:IcjyaS8Nt8fE2RQZKDO_KJanm-6doNNF_Y76TQrAkTcI8jAnK_c3tQ>
    <xmx:IcjyadUGnekXDt0Sq_MybxNqZFCd5Gb7cGGJ0AjwH9rMslirswJISg>
    <xmx:IcjyaeD8_J-U6xWrv2ABlL-StwKm3hZmlosfq80vz8GRMUs2kF9YNg>
    <xmx:IcjyaaHnb5F4tXmLDJx8PV0f5oiuTw3IBnHm05lFHaEo52yAOOzu0g>
    <xmx:Icjyaa9FzJoXAaL3WpKWeqOwjFNEGQOD7gjr0M-LoLUEFg9LqKlLpSLX>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Apr 2026 23:10:23 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/7] VFS: Add LOOKUP_SHARED flag.
Date: Thu, 30 Apr 2026 12:03:27 +1000
Message-ID: <20260430020505.3308841-7-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260430020505.3308841-1-neilb@ownmail.net>
References: <20260430020505.3308841-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

Some ->lookup handlers will need to drop and retake the parent lock, so
they can safely use d_alloc_parallel().

->lookup can be called with the parent lock either exclusive or shared.

A new flag, LOOKUP_SHARED, tells ->lookup how the parent is locked.

This is rather ugly, but will be gone soon after we move
d_alloc_parallel() out of the directory lock as ->lookup() will *always*
called with a shared lock on the parent.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c            | 7 ++++---
 include/linux/namei.h | 3 ++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index a6349b31fdb6..e77ba9d31857 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1928,7 +1928,7 @@ static noinline struct dentry *lookup_slow(const struct qstr *name,
 	struct inode *inode = dir->d_inode;
 	struct dentry *res;
 	inode_lock_shared(inode);
-	res = __lookup_slow(name, dir, flags);
+	res = __lookup_slow(name, dir, flags | LOOKUP_SHARED);
 	inode_unlock_shared(inode);
 	return res;
 }
@@ -1942,7 +1942,7 @@ static struct dentry *lookup_slow_killable(const struct qstr *name,
 
 	if (inode_lock_shared_killable(inode))
 		return ERR_PTR(-EINTR);
-	res = __lookup_slow(name, dir, flags);
+	res = __lookup_slow(name, dir, flags | LOOKUP_SHARED);
 	inode_unlock_shared(inode);
 	return res;
 }
@@ -4413,6 +4413,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	struct dentry *dentry;
 	int error, create_error = 0;
 	umode_t mode = op->mode;
+	unsigned int shared_flag = (op->open_flag & O_CREAT) ? 0 : LOOKUP_SHARED;
 
 	if (unlikely(IS_DEADDIR(dir_inode)))
 		return ERR_PTR(-ENOENT);
@@ -4480,7 +4481,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 
 	if (d_in_lookup(dentry)) {
 		struct dentry *res = dir_inode->i_op->lookup(dir_inode, dentry,
-							     nd->flags);
+							     nd->flags | shared_flag);
 		d_lookup_done(dentry);
 		if (unlikely(res)) {
 			if (IS_ERR(res)) {
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 2ad6dd9987b9..b3346a513d8f 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -37,8 +37,9 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
 #define LOOKUP_CREATE		BIT(17)	/* ... in object creation */
 #define LOOKUP_EXCL		BIT(18)	/* ... in target must not exist */
 #define LOOKUP_RENAME_TARGET	BIT(19)	/* ... in destination of rename() */
+#define LOOKUP_SHARED		BIT(20) /* Parent lock is held shared */
 
-/* 4 spare bits for intent */
+/* 3 spare bits for intent */
 
 /* Scoping flags for lookup. */
 #define LOOKUP_NO_SYMLINKS	BIT(24) /* No symlink crossing. */
-- 
2.50.0.107.gf914562f5916.dirty


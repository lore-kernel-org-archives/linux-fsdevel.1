Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E94345CCA;
	Thu, 30 Apr 2026 03:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777518584; cv=none; b=fnOnrtxanGT29oYjDR5Ms46bv0msEO8HEZTP47w056m3VQLUx6G4HhvOa54s0g7piuUqCx81n2xbL6Ediy8e7ZTx8QexxDFFZxNkg88eVdlxZt+y+8NyxIApkzayZLBZpmGA2DvOrjJp+S6KxUd7wWxcgYYUkvDZu+Qk+22nUaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777518584; c=relaxed/simple;
	bh=Af17cpjWLrgjln+x15PYEXYO/pHIZybmrmOg/uu6FGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbRFRyQzRBkGsH8tciGLtPylG/oHmzG9j92qU6OvtC8c+gxfQve3BzBnCbcXKZkd4YeBcAIt7Jg1AVot8yltH0DkSlXyFEf/jQmPNCOnEo83g+5umhLcMjEpG1UEuqGnXfgbOlcNWM2TAIRNHgbHOcEG22HgCXWFN1lwR0m1oKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=a0Y62ua1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HCOULj61; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="a0Y62ua1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HCOULj61"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 6989F1D00187;
	Wed, 29 Apr 2026 23:09:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 29 Apr 2026 23:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1777518582;
	 x=1777604982; bh=2Sazp1M0TdInI6mi6hF1QSnGjDghjOgL8lkwZNivMpc=; b=
	a0Y62ua1vVCLsl69JwzQxchZl1shpnRTPoaHvWI3PkzJGk+Hurdz/mjf1utsz6+2
	qI+VFakyW8s6gXyMAbQxYqKj3cAl2y2XbU6fJg7PoinOYPFS0QGz5f9I+Z1s3RjT
	B1/sm1PD5aNttS+kn1/hBGB4tLJctn++xxK+PsnxNPC4IW/qzMHKOLFiGZ3XIlZV
	R06RJafSBj/qPSqVrUs7t0GbHWBDbvb63g/fmcQmKPV1x/2ywj+sqc37IdsBRB9B
	Abq0Pbe7ndqd4yaEX3rmpzfaPDYAK6bz4Mjn+ooDI1qauFfpi3/QjHgFxeJgTgBQ
	9uQ1dLSHDOM7H6oUdpdvUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1777518582; x=1777604982; bh=2
	Sazp1M0TdInI6mi6hF1QSnGjDghjOgL8lkwZNivMpc=; b=HCOULj61wXs5YEkWO
	SnnwnyIKL3CEVfQtpnrfq//f5jPaXJ2mdAK0gXQhd8cA+uXRYtglOjTztf5PhpCp
	owjxux6a43GmNCherHrt1iEE/FQQCuonEBeOfiRiPPOM4mrSVkvbfnSYSeiL9bS2
	HRd7UzormfXmbxr+I4plXNrEDFCgc2l1paL/3sigNf4DWGwBSK+Ge4CFBTGvETla
	5WutSQB3OOSZvIA9R6b/BGjSyrPzKwMeWpknrb+R8p3Ikro4lnheUQ9gGdBkh/yp
	yNmQs0V0UF2R7kS65+yDrXAno4MvA8hh1BM0a39VlmN75XftzkEyBj+OML7uXOrh
	A/jEQ==
X-ME-Sender: <xms:9sfyaT-ptLQTiw6OayJH1gq4ElCjFKbyjl6yvpQu8rFV3atfx2bP4w>
    <xme:9sfyaSSKwhvJ0SK1oD6dLMKLVFlF7pcuMtMbc0xBjoKkr7ZvNb7rnvV5m5UNCrVaM
    2X48_iS5hwLGodrkf9jg5vXggH9RWvO6KIJ4iHk6QW1pxazEw>
X-ME-Received: <xmr:9sfyaUr-PrLS94T4O5rIWzSZmRq793NHoo2X_qGzUtGTfrvcpM27u8PwXNYd9HIild7IQTZybKpr3CsDksr8tVhkx0O9bKs>
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
X-ME-Proxy: <xmx:9sfyafl2DSOJcGQiTQGiS4c6mlwho66LYhI_jV0BwOg9F0wxFaFdRg>
    <xmx:9sfyadeNqyLmwUz1Bjok2okJhyQw1yTlc2_Ap-itbbqt2zzXWKv5Hw>
    <xmx:9sfyabpEUCpNKtRjS0VYPq_9XieWIyHf2AROCDDzBnGTCAYGynk75g>
    <xmx:9sfyaXNba5KzOjWt9zcXsTxuPc4Txv2orhIe_lSRevMeeoza7mwbCg>
    <xmx:9sfyaZG9M2HbbMhn2w-pqtMDaGJlKAXI6S1n6d07rlMSDHmZHbaEsNVl>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Apr 2026 23:09:39 -0400 (EDT)
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
Date: Thu, 30 Apr 2026 11:56:59 +1000
Message-ID: <20260430020137.3305302-7-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260430020137.3305302-1-neilb@ownmail.net>
References: <20260430020137.3305302-1-neilb@ownmail.net>
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


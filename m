Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685CB361DA2;
	Tue, 31 Mar 2026 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774920631; cv=none; b=a+Zu+GTUlvIV6qkdyUBMLD3M9n4lhva14BCSaU9yi9QjFY+Ky83whjGG/iltAS8odxF876VMWrt35oKd3CDWE+hA6zZeRjGM1rkDlMC4BIvQ3f/Ko0qat9lVUDHTvovLN7mSaXYtX6lvyH/6OdNkBZiYqDgWMmQ2XLMmKDkHJVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774920631; c=relaxed/simple;
	bh=QwXtXOf7jYOyNON3k4INnHhmNa4DnKTs3UmlR0WNN4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahGvYeLbM2YbGXO1bpPcJy1IEzKF1AQ9iXnaNHi/HBUPn5PhOoVTzbkDa6c/v8nYmKeC/vyiGNgd0HnGGkIL8qaXI/EfqNrTP6/d7WqFEg4dR1s+TD6cDcq1h2eTrSM196A17412lsnhhcxJyqOLooC7EtJvRoRLsSc5nWofq28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=TOuTZPMv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I3MRLV1B; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="TOuTZPMv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I3MRLV1B"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 92F57EC00EB;
	Mon, 30 Mar 2026 21:30:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 30 Mar 2026 21:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1774920629; x=
	1775007029; bh=6KDde5DhWzz5okBA1igZHYy01UUgchyUxpv5kg2XGDQ=; b=T
	OuTZPMv9TawKueM4aUqUxM1o1MWUT65xCvdz0fNaNVaF+8W9l1uweIJEpy63x5em
	hq6b4vGxlBtoRmONT3LOTVAzf1r8bgkH4Ohc6SoqKx2sjAqmCC0bfYHuwIb06Ct0
	0CIyVFE1Jtz0t+/DeSbgETDQuttjQq/l2iq7eJgQcj3ZX3Fw3LPcusZo1mzN0x3G
	CW1zScCslQ0faZRQDI/XED7KuKMQslTjQj7gzdj0yhA/4nwElWjf9PtXsHnBTdU7
	+L9+EIOruCQahgtSVKdyz+8/yXvY3MaPhliyx4UZKzNpWbbQw4VcMW4gsjYg8504
	a8KKDjn4HzH4xUWezjYsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1774920629; x=1775007029; bh=6
	KDde5DhWzz5okBA1igZHYy01UUgchyUxpv5kg2XGDQ=; b=I3MRLV1BGz88iBDPu
	5APTMnh1a62avHvjDy3z0mVUZXCfqiUmBRM4NccZiAoLYeNYOWHSNeubDy1GaPgZ
	q2vnAAG8U3o/fBM3sM5sxQRw7VKmRkZGg1bAIUd86nmHJrTYfIH48hWa/T4l6wva
	K4PeFSCdLQNK/3UdpJtGFEwWQpGOKHUFzOMXp69ZCF2b9ZGUa33KTZEGeRmtoXFf
	f0EvcgQaKA6prVtut+5F6+fTJWD+DhZKxluVtPtUscP/WuWYokOwCT3g/glw8k4R
	1SnwcXBrwAQmFCTfZbJ3yKBy6/pKT1JiEz1fRw7sZ2Ds0buNfyfm+n7OGojFNk20
	lGZ/w==
X-ME-Sender: <xms:tSPLafWlLLAJnHdCL1FpOR1GL67DvK7pYJ3ELPWIAhyBsqE76INDhg>
    <xme:tSPLaWEFf3PkbiLgwXGwM48ssslHWXXFySBloBxEpw98Mrn-mLJ2gGoGuEEV2at5k
    AKPwo9uYU3KZnJCItEarMTGHbIF6A3ROX1t1XehZcBSe8yp>
X-ME-Received: <xmr:tSPLaSOMUtWyZy3Gzd7bCyJiiO4RvtpiCnqtXAUcGQBCP6Ipn6giP6R5YrkltJfDlcTMR5mhNkJVBlJR70hQcYaZGZLEImEUqCAbFz7ElMrR9SXjICKOERMDpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedtheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepkfgrnhcumfgv
    nhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpedule
    egueffgfehudeufedtffeiudfghfejgeehvdffgefgjeetvdfffeeihfdvveenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthh
    gvmhgrfidrnhgvthdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvih
    hrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheprhgrvhgvnhes
    thhhvghmrgifrdhnvghtpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuh
    dprhgtphhtthhopehsrghnuggvvghnsehsrghnuggvvghnrdhnvghtpdhrtghpthhtohep
    fhhsohhrvghnshhosehrvgguhhgrthdrtghomhdprhgtphhtthhopehjrggvshhhihhnse
    hrvgguhhgrthdrtghomhdprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugidqfhho
    uhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhgrohgrrhdrshhhrghosehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:tSPLaaVot1mw1resbW0q2zffxTs-UGRQ7WViJ8T5bBQccGiUq4OsYg>
    <xmx:tSPLaRwKN1lkukb8sHD9qfW6FCD42pdh_1A2153EKbEPJnMf4GW1dw>
    <xmx:tSPLaSP0jEWoAPzXFQJKW-xh6TzOGJi8awjXNEM8R6V4eJeoinWdNw>
    <xmx:tSPLabpqTIkYK2hP4-lMtUzEgAcYQHDIf8dSmfeUu1RpuSaTOD_lkg>
    <xmx:tSPLaY2m-1_o1ZRqUi-bWMSgftVXEMSBHd9LrDE-Hw8wzG8wYQjCVDfm>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 21:30:23 -0400 (EDT)
From: Ian Kent <raven@themaw.net>
To: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: Ian Kent <raven@themaw.net>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Eric Sandeen <sandeen@sandeen.net>,
	Frank Sorenson <fsorenso@redhat.com>,
	Jay Shin <jaeshin@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Waiman Long <longman@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Wangkai <wangkai86@huawei.com>,
	Colin Walters <walters@verbum.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] vfs: limit directory child dentry retention
Date: Tue, 31 Mar 2026 09:29:09 +0800
Message-ID: <20260331012925.74840-2-raven@themaw.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331012925.74840-1-raven@themaw.net>
References: <20260331012925.74840-1-raven@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If there's a very large number of children present in a directory dentry
then the benifit from retaining stale child dentries for re-use can
become ineffective. Even hashed lookup can become ineffective as hash
chains grow, time taken to umount a file system can increase a lot, as
well as child dentry traversals resulting in lock held too long log
messages.

But when a directory dentry has a very large number of children the
parent dentry reference count is dominated by the contribution of its
children. So it makes sense to not retain dentries if the parent
reference count is large.

Setting some large high water mark (eg. 500000) over which dentries
are discarded instead of retained on final dput() would help a lot
by preventing dentry caching contributing to the problem.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 Documentation/admin-guide/sysctl/fs.rst |  7 +++++++
 fs/dcache.c                             | 28 +++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
index 9b7f65c3efd8..7649254f2d0d 100644
--- a/Documentation/admin-guide/sysctl/fs.rst
+++ b/Documentation/admin-guide/sysctl/fs.rst
@@ -75,6 +75,13 @@ negative dentries which do not map to any files. Instead,
 they help speeding up rejection of non-existing files provided
 by the users.
 
+dir-stale-max
+-------------
+
+Used to limit the number of stale child dentries retained in a
+directory before the benifit of caching the dentry is negated by
+the cost of traversing hash buckets during lookups or enumerating
+the directory children. Initially set to 500000.
 
 file-max & file-nr
 ------------------
diff --git a/fs/dcache.c b/fs/dcache.c
index 7ba1801d8132..298b4c3b1493 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -86,6 +86,14 @@ __cacheline_aligned_in_smp DEFINE_SEQLOCK(rename_lock);
 
 EXPORT_SYMBOL(rename_lock);
 
+static long dsm_zero = 0;
+static long dsm_max = ULONG_MAX/2;
+
+/* Highwater mark for number of stale entries in a directory (loosely
+ * measured by parent dentry reference count).
+ */
+static unsigned long dir_stale_max __read_mostly = 500000;
+
 static struct kmem_cache *__dentry_cache __ro_after_init;
 #define dentry_cache runtime_const_ptr(__dentry_cache)
 
@@ -216,6 +224,15 @@ static const struct ctl_table fs_dcache_sysctls[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
+	{
+		.procname	= "dir-stale-max",
+		.data		= &dir_stale_max,
+		.maxlen		= sizeof(dir_stale_max),
+		.mode		= 0644,
+		.proc_handler	= proc_doulongvec_minmax,
+		.extra1		= &dsm_zero,
+		.extra2		= &dsm_max,
+	},
 };
 
 static const struct ctl_table vm_dcache_sysctls[] = {
@@ -768,6 +785,17 @@ static inline bool retain_dentry(struct dentry *dentry, bool locked)
 	if (unlikely(d_flags & DCACHE_DONTCACHE))
 		return false;
 
+	if (dir_stale_max) {
+		unsigned long p_count;
+
+		// If the parent reference count is higher than some large value
+		// its dominated by the contribution of its children so there's
+		// no benefit caching the dentry over re-allocating it.
+		p_count = READ_ONCE(dentry->d_parent->d_lockref.count);
+		if (unlikely(p_count > dir_stale_max))
+			return false;
+	}
+
 	// At this point it looks like we ought to keep it.  We also might
 	// need to do something - put it on LRU if it wasn't there already
 	// and mark it referenced if it was on LRU, but not marked yet.
-- 
2.53.0


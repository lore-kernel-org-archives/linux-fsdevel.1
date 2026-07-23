Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8599B283FDD
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 01:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784771638; cv=none; b=ByymXRaonylAdETK3Eh9+CLmt4BCYkEvJqrS45JCWKfXTVwinJUq8vG6iymSKz/D1qwppMNy70nbplP3gRodsfocaeUVi+CmvV4O/E69WZU4BdjHwoGNhMmDRjudJqN7EfO657qgvUKSVanB1sj/uSTtYWlU/djoRnUhHRChDo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784771638; c=relaxed/simple;
	bh=nMsGPJNGNFVxxwZJuOq1WP0DUfxE/K1X7m5S2T9JGU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMwmkJBUy1cb3In/xNYUMe5Zn1oGDqFwmkI4P+NZRVsutoCV7HC3ZWBudDr2ayUcfJLztBfWHCoqJxVxKqN45mttNCA0Cy+P94sJ8m5i7PcwAOysMWdrHLFTPpDMagGDXm8t/9tgP/gl6lG9yorrk1ypvfCx8b1VBKh2F9UsENo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Ig1EnLEs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HcpwOZh3; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Ig1EnLEs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HcpwOZh3"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id BFAC21D000A7;
	Wed, 22 Jul 2026 21:53:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 22 Jul 2026 21:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1784771635;
	 x=1784858035; bh=Luafv2VGdKltGY0gPgZDXpvFE7NaorMP+fo2Bpb8jIU=; b=
	Ig1EnLEsrRLrY+ePamaErtkBvX3K0ePyVxpHjvRgT66laovURX4d/aGrlcFVJNsA
	BDGZMqZX8psIE/8id3VZma9454MHS2LPedsOzdE2hkgfx4nIImB2NksLoxopyUz6
	5u7YGEJGaXE++XvcYq3mxlk27dqr/vd5W6cMa3Q+azO3+G/I1M/iZecVijfe+VK7
	7ZOkMi4/1ZniMmh3DySG2Jt7XQuVcxFzHSX40TrUi0bxuSSioVTf7pudZMziXHqQ
	x7lEyq3yLajS2O+hgiMlUiH+g033x+kQhG0Vhr4cIzQCgvUJ8Kbt5Lxywnp2xK+/
	5oCqH24rF7hGVrf4LQuV8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784771635; x=1784858035; bh=L
	uafv2VGdKltGY0gPgZDXpvFE7NaorMP+fo2Bpb8jIU=; b=HcpwOZh3GlBbqCY65
	Jnuy0bjkID1Yogw31mchZ8lbp9k+UCdXEr06bESdvTWHS0q4i8rniadDwGhPlDMn
	5vy9VtSST3kaQ/pbbxZtfYQBNvKIWOSqcEpt0Vm6ewspdCq9Ka4VCEldjJoSA/dd
	FoAW7QXr1ZcEENI3LTXdETZdzbioppgEQFrqBsQd0ekFgYqCFoYIeVvC7ZSR7GF2
	gaiu7OIKM5R/LmJStVwNVWwg4RW15H22FIC8/LKU2DVY72NoQY8BygEvBQht88YX
	AbqbIEr+gf031v71QvBgvKNJUwOOtMD5ydCfiB8kJ7FCksXz0+eyIk1/073dCZ3O
	XJZoQ==
X-ME-Sender: <xms:M3RhamX7qq-Ot2rb096erIlH9IB_snm5ceDCw6s0FHuTjNOyzq21ww>
    <xme:M3RhauAVXA9MYDlOHBn9AkcVis7X_t_b9sMTRZ0pdhbcPcsbWElidG5pxOi8QhUbd
    Vh2-gQNjp9kQtg4fi7po9REc2GWE_ToX2cRyPa7T78y8qtn7uw>
X-ME-Received: <xmr:M3Rhat6jRzhldNEW2B4TdprSlc7aAtXqvzyZ1YB94ZLcXdJdlysuE3c3UXz3xKbhPmM8W6jLtv3rw44zykQ0vtNDVvPtnF8>
X-ME-Proxy-Cause: dmFkZTGA+a7oFH+eKnjwbhHC/8v4r6fQL2b4aUZ+ZIYz4ZbCd2lTQejYwSUR06DWEzL5WL
    mc+PFbP+CvpAtlPr/kFV4jcB2l0r1/JNZGQtYZLaw6BBrlXqe0A1A4agnK4oqn4aAvafTN
    JwQ2EkfozeCy/xauhvbDqLKITCSDGZS8GqckoC/D/+VNosrNC3AUpjToiM4vMbncdpKcBV
    MkOeKq0fYayK0sMiAV14VpvYYRXZWHvcYtrbk4lBJqS9anY5zygmmiN4IuSNtCZL3Jfyvi
    c0NALS5YBVgvjS0ItZCuBk9AIOKmu0HK1C5Wy2CtwmatMHULuQizIO5dlfalvpsigF2zcc
    75U8C5tFsvnni23iAcLPWLkV9n84AKOgyQUXk74VRqK/GP+ykodteELzVjksksLaN8zHnk
    VW3ZelRFieLpeE6gRCobQfGd4vLywCRFayWygvy2KRRSKvMfqSTuZqSrj4ZA4FcVUKkFiK
    1jirp02pJM1yLcHInuGvReit7Yny4Uzjym8jw7sG+rB9yUcy24ed+dpQzkoOKyIZjqVP04
    mfJCEAAwvBH1r/xC4tVleda0jel7pukR6nmpZ0LfyfqMgCsN4hctpdyTq2T5gVVIGofpYz
    nB3EYKaXCQOEUuA2tKitFiW7iBEPkKmfD3jCGN2ym36zhs7c7Ku1jDdSIMzA
X-ME-Proxy: <xmx:M3RhahwgjwPtHdHtX5xU45RzWJc6V5apnZFkhmQW4moWvoRYruCRuA>
    <xmx:M3RhasxmrJ99eD72eaYN-7L3rP4ST6ax96YfoHC3AsR8VfcrURh2oA>
    <xmx:M3Rhahw3dBIjXIVpOj2tQgAGYGY52O6mI5ndEHnTtAiLGPgTOr7eog>
    <xmx:M3RhauZb5I9Htk5dhdk4zPBUwPlOwM6FQm58aEDaAKAMYmaI-xGOdQ>
    <xmx:M3RhahFaCUudlehk-LY-POAa-Mx4RK6JBlFL43hBNmzOgYQXdl6A5t-K>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 21:53:53 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/4] VFS: introduce d_alloc_trylock()
Date: Thu, 23 Jul 2026 11:49:48 +1000
Message-ID: <20260723015330.3093207-4-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260723015330.3093207-1-neilb@ownmail.net>
References: <20260723015330.3093207-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

Several filesystems use the results of readdir to prime the dcache.
These filesystems use d_alloc_parallel() which can block if there is a
concurrent lookup.  Blocking in that case is pointless as the lookup
will add info to the dcache and there is no value in the readdir waiting
to see if it should add the info too.

Also these calls to d_alloc_parallel() are made while the parent
directory is locked.  A proposed change to locking will lock the parent
later, after d_alloc_parallel().  This means it won't be safe to wait in
d_alloc_parallel() while holding the directory lock.

So this patch introduces d_alloc_trylock() which doesn't block but
instead returns ERR_PTR(-EWOULDBLOCK).  Filesystems that prime the
dcache (smb/client, nfs, fuse, cephfs) can now use that and ignore
-EWOULDBLOCK errors as harmless.

Unlike d_alloc_parallel(), d_alloc_trylock() calculates the hash and
performs a lookup before an allocation, as that is what all callers
want.  This done using try_lookup_noperm() necessitating the inclusion
of namei.h in dcache.c.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/dcache.c            | 88 ++++++++++++++++++++++++++++++++++++++++--
 include/linux/dcache.h |  1 +
 2 files changed, 86 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 2fff76c0f6fe..0f6f9c4681f6 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -32,6 +32,7 @@
 #include <linux/bit_spinlock.h>
 #include <linux/rculist_bl.h>
 #include <linux/list_lru.h>
+#include <linux/namei.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -2751,8 +2752,16 @@ static void d_wait_lookup(struct dentry *dentry)
 	}
 }
 
-struct dentry *d_alloc_parallel(struct dentry *parent,
-				const struct qstr *name)
+/* What to do when __d_alloc_parallel finds a d_in_lookup dentry */
+enum alloc_para {
+	ALLOC_PARA_WAIT,
+	ALLOC_PARA_FAIL,
+};
+
+static inline
+struct dentry *__d_alloc_parallel(struct dentry *parent,
+				  const struct qstr *name,
+				  enum alloc_para how)
 {
 	unsigned int hash = name->hash;
 	struct hlist_bl_head *b = in_lookup_hash(parent, hash);
@@ -2830,7 +2839,18 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 		 * pin it and wait for them to finish
 		 */
 		dget_dlock(dentry);
-		d_wait_lookup(dentry);
+		if (d_in_lookup(dentry))
+			switch (how) {
+			case ALLOC_PARA_FAIL:
+				spin_unlock(&dentry->d_lock);
+				dput(new);
+				dput(dentry);
+				return ERR_PTR(-EWOULDBLOCK);
+			case ALLOC_PARA_WAIT:
+				d_wait_lookup(dentry);
+				/* ... and continue */
+			}
+
 		/*
 		 * it's not in-lookup anymore; in principle we should repeat
 		 * everything from dcache lookup, but it's likely to be what
@@ -2858,8 +2878,70 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 	dput(dentry);
 	goto retry;
 }
+
+/**
+ * d_alloc_parallel() - allocate a new dentry and ensure uniqueness
+ * @parent: dentry of the parent
+ * @name:   name of the dentry within that parent.
+ *
+ * A new dentry is allocated and, providing it is unique, added to the
+ * relevant index.
+ * If an existing dentry is found with the same parent/name that is
+ * not d_in_lookup(), then that is returned instead.
+ * If the existing dentry is d_in_lookup(), d_alloc_parallel() waits for
+ * that lookup to complete before returning the dentry and then ensures the
+ * match is still valid.
+ * Thus if the returned dentry is d_in_lookup() then the caller has
+ * exclusive access until it completes the lookup.
+ * If the returned dentry is not d_in_lookup() then a lookup has
+ * already completed.
+ *
+ * The @name must already have ->hash set, as can be achieved
+ * by e.g. try_lookup_noperm().
+ *
+ * Returns: the dentry, whether found or allocated, or an error %-ENOMEM.
+ */
+struct dentry *d_alloc_parallel(struct dentry *parent,
+				const struct qstr *name)
+{
+	return __d_alloc_parallel(parent, name, ALLOC_PARA_WAIT);
+}
 EXPORT_SYMBOL(d_alloc_parallel);
 
+/**
+ * d_alloc_trylock() - find or allocate a new dentry
+ * @parent: dentry of the parent
+ * @name:   name of the dentry within that parent.
+ *
+ * A new dentry is allocated and, providing it is unique, added to the
+ * relevant index.
+ * If an existing dentry is found with the same parent/name that is
+ * not d_in_lookup() then that is returned instead.
+ * If the existing dentry is d_in_lookup(), d_alloc_trylock()
+ * returns with error %-EWOULDBLOCK.
+ * Thus if the returned dentry is d_in_lookup() then the caller has
+ * exclusive access until it completes the lookup.
+ * If the returned dentry is not d_in_lookup() then a lookup has
+ * already completed.
+ *
+ * The @name need not already have ->hash set.
+ *
+ * Returns: the dentry, whether found or allocated, or an error
+ *    %-ENOMEM, %-EWOULDBLOCK, %-EACCES (for a bad name) or
+ *    anything returned by ->d_hash().
+ */
+struct dentry *d_alloc_trylock(struct dentry *parent,
+			       struct qstr *name)
+{
+	struct dentry *de;
+
+	de = try_lookup_noperm(name, parent);
+	if (!de)
+		de = __d_alloc_parallel(parent, name, ALLOC_PARA_FAIL);
+	return de;
+}
+EXPORT_SYMBOL(d_alloc_trylock);
+
 /*
  * Move dentry from in-lookup state to busy-negative one.
  *
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 4b1ff99608e0..7afe16d4664d 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -257,6 +257,7 @@ extern void d_delete(struct dentry *);
 extern struct dentry * d_alloc(struct dentry *, const struct qstr *);
 extern struct dentry * d_alloc_anon(struct super_block *);
 extern struct dentry * d_alloc_parallel(struct dentry *, const struct qstr *);
+extern struct dentry * d_alloc_trylock(struct dentry *, struct qstr *);
 extern struct dentry * d_splice_alias(struct inode *, struct dentry *);
 /* weird procfs mess; *NOT* exported */
 extern struct dentry * d_splice_alias_ops(struct inode *, struct dentry *,
-- 
2.50.0.107.gf914562f5916.dirty


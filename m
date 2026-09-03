Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C8836AB5A
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2026 03:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788405916; cv=none; b=FKrIMVGGUub385kIa2YkcCKJtxlit8DaHdNNR427zWnTaTS7MO3x3iZeVP35yhR5u5nGwviGxVv7bP21S4zHiTaqwENtK0gv8QwPPa2zxrMak1MdNnQP42epzIYFP1T2SYAG/DwW0q9MkRDeYbYJX7dZhgC/DLgdt+6z+07v6aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788405916; c=relaxed/simple;
	bh=litQKQpxq4Wvyjuf2fzuVAMeubOciQd5GfzX88tQytw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=muKGsfmQekSFGeCQrBAxT3fg3A/zN3rVdbcg7QRnygR5d6edS6ZJX+y5bAw5IU7AOnMeprAfHIfyiF+6Nj8Lv+kVMFBTxxrQtkk20x746nh29pT8AvgTk92P62juIiPd1LINMYlhRYjLYMtS3plGKWiPOwYR9SwU69fJT9Y27UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=DsEg3dVV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZBjIWKCz; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="DsEg3dVV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZBjIWKCz"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 594AF1400138;
	Wed,  2 Sep 2026 23:25:13 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 02 Sep 2026 23:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1788405913;
	 x=1788492313; bh=Kt2NwALlbn71BGQUotT5OMUi/Oh7eR7WXE5EosRsD0I=; b=
	DsEg3dVVOZtAJnNVJDC/U759i7fo0x8apuk5Jw4mbdTr6dxOnZkCCaDbKh/mRk6T
	l+wLM3Qn8ky148F2pJ4enMCqoH0BxQtsVYp3xfH44zxAJ62GI+rZDls9Dltt2bkH
	igVtu0WDqr1M2Ol36MS+WhprfsZf0nZqm4HmJ/2EGT8nTW8irpbmkv+6MlyYeEfz
	mIRV8oYW+VJDgedGkEsdoCXqc0QhADyP3Hd70KPONz+MTWlP+kAXkiOWDpvo4NV4
	QGddpdaN+NbbCuVj6wc3wR0OWeP9Vk1AKI64AAd6ruPXKSX68AJxxQ30ZABVK6Gu
	7XAnuCntCPRmrnN4vpdkYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1788405913; x=1788492313; bh=K
	t2NwALlbn71BGQUotT5OMUi/Oh7eR7WXE5EosRsD0I=; b=ZBjIWKCzuCVqk5zBj
	//uyNEbz+uyAYYBIrg87DaiGXRjhuc8s2VHQ1unnmNAbN1ebcsAez3CHLJnrSV9V
	PKlJUnPOsd+wZAVDcIYzkxKqNCZbP/VxKb9wDCYSXbR4CiWTVfnwGVB8gEYoW5tN
	Jm2Ts8mNQ28aYM4FqzwBCNu4ymh7dq4dG1p9fs3qB+anZU/qLiqgOGIUudglLSSS
	Z15CndCDatH9KPyZ8ASaKzFTKV/t9I7fC5lyluEOwl+Wa5SGOUB/fdEnEo7cgYsd
	kNM4DsTt/tnwZxgZMLlyJGT5D/mRVChyl+d0sJ82POlxrj3Nal20m2zviez4QThW
	rGaJg==
X-ME-Sender: <xms:meiYamyam6TwFtZ557obae6kjqT8vqTeaBvSZ-o7WtFDHEpZx-ODjA>
    <xme:meiYasUn2ziouxEnDzH_gFLqAB5zuuNKbYPorYGkuurGciRo-65ZtBGFCtRTpjPPU
    dOkCgCO7PZIGw-y94AjiOrHgS0ImIDHtLSD7vofcP95xs4lsg>
X-ME-Received: <xmr:meiYaoNIgQ5a2WTCgDQ2WpATw-kw93UHwiGs9Dljq43CkkBRt_a3uRlmALblPKIi348THgbRPsLtJ95EO5zDAK6cGt8zwF8>
X-ME-Proxy-Cause: dmFkZTFXt6cUefGPSewwwFqdKdDzyta/nNOStoIf8ygsd3d55Ylv2azk0WUcYGr/qWGe89
    /agY7xGpogS9PXkreI4nrnEfEmH4ukRCYLCLQ3ife4R0W6dMBF5Im/9SUb/nWmHvjbtfji
    C94zMCN8ZKwE6V7UAH/g5bDmuGJ60zEKAcm0MCk2H/yiC+xmz/8AzeGfH/ZAapoxNSHcuj
    2NAwOe/HPAaVDALEsfGdSX4FygHdBou8gRiZnt7cvbj+wi4KWShvSMjFP4ENhF65bJ2jDU
    hJYERCmXGNC3cGgAODpYVa2vdRDJp2cxqVzJcwEfZ6JwMc6xSMdbQ9cS0F1GoWnjdMdMpy
    bdZUEHmF1CYcl5flXfzvujNrK/5uOm+4oYlPVtm2FmttE3tONBjk+IspZPlmtaZ95qnCD8
    pg6YgzfqARskNPyHsxonCRmycLqcPWvST3KHTbVWth86HaENCqRXP7NRIwJW/MKA6Jm5DI
    bpr5k053PDHwcRiwSPCd4qtKGxo5+b3mahMr09WI4IptphjYJc8rCMb0yJJaQ80hC28Bsh
    bcuOb0xVVgfNi9+Kf2aR5bXsXIZKuXimBcxEVnBkuY2zfC5Smunbm2tj/+/liFv+ayem5R
    aNUsXrrPUMB6iZ8Zcx6Ct9D1gBGQHNM3M/FfCP+spZ2IHfuJ1gXZdtZ+NFeg
X-ME-Proxy: <xmx:meiYauCMXlXAg_uqjxf8z47WhiJ_n0XV0Oh2jtN6LRbqPOsrmqN-bw>
    <xmx:meiYalf53_0LnSmKWjdGNHzj2fqpcvXTlcsndt9BDO-B8pqGvyvDww>
    <xmx:meiYatNxfhVzoS7mFhQ9Ek2owOz1DgSo90HEFsBIe7_zoo7OpO1oPg>
    <xmx:meiYalKX3NHzLEyjQL3fQpaS78Ju2Juqwr9DBlJuObhmo8JFOcl1aQ>
    <xmx:meiYammQW94SJjF93Ajf-VQIpCwbm8lcAxiBXM-Bxk16JLf6S-kPTbaq>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 23:25:10 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH v3 3/6] VFS: introduce d_alloc_trylock()
Date: Thu,  3 Sep 2026 13:01:33 +1000
Message-ID: <20260903032431.142777-4-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260903032431.142777-1-neilb@ownmail.net>
References: <20260903032431.142777-1-neilb@ownmail.net>
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
want.  This is done using try_lookup_noperm(), necessitating the
inclusion of namei.h in dcache.c.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/dcache.c            | 81 ++++++++++++++++++++++++++++++++++++++++--
 include/linux/dcache.h |  1 +
 2 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index fd74753e7715..43149c7849d9 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -32,6 +32,7 @@
 #include <linux/bit_spinlock.h>
 #include <linux/rculist_bl.h>
 #include <linux/list_lru.h>
+#include <linux/namei.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -2756,8 +2757,16 @@ static void d_wait_lookup(struct dentry *dentry)
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
@@ -2830,6 +2839,12 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 			spin_unlock(&dentry->d_lock);
 			goto retry;
 		}
+		if (unlikely(how == ALLOC_PARA_FAIL)) {
+			/* mustn't wait for concurrent lookup to complete */
+			spin_unlock(&dentry->d_lock);
+			dput(new);
+			return ERR_PTR(-EWOULDBLOCK);
+		}
 		/*
 		 * somebody is likely to be still doing lookup for it;
 		 * pin it and wait for them to finish
@@ -2863,8 +2878,70 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
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


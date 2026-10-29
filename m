Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793236186;
	b=fyXlnp8hxcO0Yb0f5ba00u3TBqtVqfni0Bfs+b2VZWG64UmDZJnUnUaYOwd0crkhiWyC
	 ulI6dkkLg8otQ2aax2K63NmVYAanydk/0WLUlaZY7dJbin/ApsBEkCb3dkVebIjjPQ/zo
	 Kh9L6ZWX4gR8FdxtWGBJUrCCRbei8nDmMYBPSy8OAhZS/277zXCY8BgMxAO5nw1uQVRct
	 UZcZDCR5ydAYkpjibnch5H3aKPK25vBQVjwtEeLJasgQ3yrko0ft1F07Bdxh7a+PI2GMk
	 h5ZMV2lcz1G2Q626jiM//4y+VFbKGiT12KP2Z9UQUGxEPZ/kMy7x1x1b6zeGITWG0Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793236186;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=BiXk3LnzLtcIKZ+RZXwhxER6LjCnGDowXDanueGKs/U=;
	b=ow3PvqpxaZLnLtPPIJeukLaplB/Cyo8kGMvTv9HxlEtKsrzuo2P+7m/EulVcKbFilWJS
	 JPGIlSFeb0y/XomdhjrJFxUHCWDfIt636QJB3XLcjJvC7KMhKkIhRwDnrJ+X5Jcrv3L/b
	 hc3S5VzwyGn7+3zR64pnVho42EVWaZO47rJ7YLd33EPJr52lS9eGwRKAyAq6f7/lkzxq2
	 +nnDnTyZmHh6FWSWzN5m1KD+6/oZW+Ol8vzTenf73uF949+cKsiYQgIdY/uHRQA8rypeg
	 H7WQK3K5GZ4uk5cOoeaByzeEiQ2HCUs7XSA2lgzFgc6/Y+fhpJm3QHude/6OTxVEtzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=k6POx+Vw;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E15260A261F
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 01:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E15260A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=k6POx+Vw
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-91c79a9a739so21023136d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 18:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793236185; x=1793840985; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BiXk3LnzLtcIKZ+RZXwhxER6LjCnGDowXDanueGKs/U=;
        b=k6POx+VwXLuS454Rk3RAfevv5Rbq9wlQ9A1Hq01ZklXUQj3dZym1TOKwDFnVB/Qdf5
         l+FWo37Mxpduis8Co7XeDKm4cklUUanpXLPfec5gZ9UDu2TC90yzhu4BCUfe3EhfmMJi
         CTuTtmoS0hpdzcm9YS3RP9zN7tNV9E2Glvi6QjDjAnVZ83uVJfK0GrmuPyBYKElQ0fdV
         g0UskdWXxyu9IZ9ocSwFu5vTSBlVobRQFItoe+ZLI1yeIw8Bui63Pi/GvoYmSUXX2YPp
         3iXLqMFBW1jQJtTKOWrCOehxjMd7EJTKaBPRqaYaZFLfxiUa/c8bArsTkFyh13csNAu/
         DTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793236185; x=1793840985;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BiXk3LnzLtcIKZ+RZXwhxER6LjCnGDowXDanueGKs/U=;
        b=p2QLC5+dctAjtzT7L+iRGf9EvwBUZi9glbF/jlFDU7mu1Pv5HRIB8WsmEZPRl5Jsb2
         RckBu5OlKuOUWmOGnox94alJFetw9sEnQ+aRH2nKGF2U2dNGSFzmdmxpzxg3M28mNYno
         hi19iKo0RMtZXOWzR1nS4OuOH/g5JxdX1jZkiP6nWnGJdVj/3SEMjfRdneiHTcwYPH+1
         Vcq1BrdGtwHtr5kjBBP1QIkqR71gx6ZmqVoPuzOIHWtI68llwB9+24eORVZ4Awigs10g
         Xk8hKbhBxk4wXA2wJOEpuXBFftk5iiR+7v/ldWimMXTlVNpxJR25qpIzauKxdVsEscFR
         SgBA==
X-Forwarded-Encrypted: i=1; AKwUvByjhFj/b8Q4pUp75zVc9n6xu2UHHgo/wdxxhI/DFpu9ezsuzBAQxH7Xu5PrlaQ6+L1uMrDBWjv+CZtfth19@vger.kernel.org
X-Gm-Message-State: AFq9FYKW46zCAAon+IIdytmL4gBVIbq11auR7NoCSUQoIpqYnyZlUeas
	ksowalu2mqREo10uI0BdFz40eb3PSKgRR1EvDad5xw8+B/HES1iStHOGKLhGD4y7kIM=
X-Gm-Gg: AYBFou2FmMTChD6zAmzI3364NYj4acAZlIo7NPu3VkYwk9wkMqzzicNT3BEgnJG5fUG
	bL2Itrb4fkXPPaZKAfjXjQb0wswO4ynsBmx+HasF7lo4RHnT+kesGQUpnnP7DMTr7cDP7T4jQn1
	qb1FWxssXd/t/Ll5sTsEL58YXs8whXe9XwkYWT3qP0y23QpQcet9hXaEMY+xWgq8I4yOHlg0LXH
	qJnXmIgiaKzv0SDucemkuNiNY9C9OXlALaQFzWPNnGEuckddaXK3SkZ3r9JZdlD8+HSLsEa8IOM
	uH/DMLl6GX1xaqEAfQZw5P0Rdeww4GXtKEk6SBrS0KXOT8f07MQhLGFZ8ac/wdjRJmyVxfF/Y3n
	2ZR0IWztm4e9s5hImbAB+6IuLHPVq4JOVNKjzXW6Ivh4rlkIK/MSikWnfwGmHqdGhCQejMrp5oa
	p6rNe1KF+K6cVqSiesGrIVj5mginQRarRsDUmeUSxvZmwkfN0Sy4IrnerSaLjoxicXYEmaoPGRI
	lrgp5u5p5BrJ3IZCf+lpfI8mVWrqzyrLQ3kqiEhDo1Fc50sXHxf/T8hPv2tNBCe5853b+68x2og
	Rv3UrN9XUIMOY42yBcFaEWi2FAVvhko0yNWHJavGt3y4OpBgr00w0U5F8UcS8Dj573k=
X-Received: by 2002:a05:6214:29ec:b0:91b:5d39:e12a with SMTP id 6a1803df08f44-91c7d22de42mr64701606d6.51.1793236185031;
        Wed, 28 Oct 2026 18:09:45 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47c944casm145482086d6.32.2026.10.28.18.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 18:09:44 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 29 Oct 2026 01:09:21 +0000
Subject: [PATCH v2 07/10] ovl: look up overlay inodes with a key structure
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-b4-ovl-containerized-sync-v2-7-4e9f08e4a052@toxicpanda.com>
References: <20261029-b4-ovl-containerized-sync-v2-0-4e9f08e4a052@toxicpanda.com>
In-Reply-To: <20261029-b4-ovl-containerized-sync-v2-0-4e9f08e4a052@toxicpanda.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>, 
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793236166; l=4274;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=43+Lm/Ais7eqXSWDLdD6bjwW5pngZaUXCbET4re2J68=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLiynhSHkVt6Pf5rMela6oglTCjXKZlOYkIz1IHWlaK8xQYb36CdTGfwdwJO576Efcyy49sV5hN
 KyrUmOfjWSAk=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A following patch adds fake overlay inodes, which are hashed by the same
real inode as an overlay inode or a trap inode.  Pass a key with the real
inode and the kind of inode to ovl_inode_test() and ovl_inode_set(), so
that all lookups share one test function.

No functional change intended.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/overlayfs/inode.c     | 57 ++++++++++++++++++++++++++++++++++++++----------
 fs/overlayfs/overlayfs.h |  5 +++++
 2 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 5895ee5aa771..88cec47d0bc8 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -1069,17 +1069,50 @@ struct inode *ovl_new_inode(struct super_block *sb, umode_t mode, dev_t rdev)
 	return inode;
 }
 
+/*
+ * An overlay inode is hashed by a real inode.  A real inode can have a fake
+ * overlay inode next to its overlay inode or its trap inode.
+ */
+struct ovl_inode_key {
+	struct inode *real;
+	bool fake;
+};
+
 static int ovl_inode_test(struct inode *inode, void *data)
 {
-	return inode->i_private == data;
+	struct ovl_inode_key *key = data;
+
+	return inode->i_private == key->real &&
+	       ovl_test_flag(OVL_FAKE, inode) == key->fake;
 }
 
 static int ovl_inode_set(struct inode *inode, void *data)
 {
-	inode->i_private = data;
+	struct ovl_inode_key *key = data;
+
+	inode->i_private = key->real;
+	if (key->fake)
+		ovl_set_flag(OVL_FAKE, inode);
 	return 0;
 }
 
+static struct inode *ovl_ilookup(struct super_block *sb, struct inode *real,
+				 bool fake)
+{
+	struct ovl_inode_key key = { .real = real, .fake = fake };
+
+	return ilookup5(sb, (unsigned long)real, ovl_inode_test, &key);
+}
+
+static struct inode *ovl_iget_locked(struct super_block *sb, struct inode *real,
+				     bool fake)
+{
+	struct ovl_inode_key key = { .real = real, .fake = fake };
+
+	return iget5_locked(sb, (unsigned long)real, ovl_inode_test,
+			    ovl_inode_set, &key);
+}
+
 static bool ovl_verify_inode(struct inode *inode, struct dentry *lowerdentry,
 			     struct dentry *upperdentry, bool strict)
 {
@@ -1123,7 +1156,7 @@ struct inode *ovl_lookup_inode(struct super_block *sb, struct dentry *real,
 {
 	struct inode *inode, *key = d_inode(real);
 
-	inode = ilookup5(sb, (unsigned long) key, ovl_inode_test, key);
+	inode = ovl_ilookup(sb, key, false);
 	if (!inode)
 		return NULL;
 
@@ -1142,7 +1175,7 @@ bool ovl_lookup_trap_inode(struct super_block *sb, struct dentry *dir)
 	struct inode *trap;
 	bool res;
 
-	trap = ilookup5(sb, (unsigned long) key, ovl_inode_test, key);
+	trap = ovl_ilookup(sb, key, false);
 	if (!trap)
 		return false;
 
@@ -1166,8 +1199,7 @@ struct inode *ovl_get_trap_inode(struct super_block *sb, struct dentry *dir)
 	if (!d_is_dir(dir))
 		return ERR_PTR(-ENOTDIR);
 
-	trap = iget5_locked(sb, (unsigned long) key, ovl_inode_test,
-			    ovl_inode_set, key);
+	trap = ovl_iget_locked(sb, key, false);
 	if (!trap)
 		return ERR_PTR(-ENOMEM);
 
@@ -1218,12 +1250,15 @@ static bool ovl_hash_bylower(struct super_block *sb, struct dentry *upper,
 }
 
 static struct inode *ovl_iget5(struct super_block *sb, struct inode *newinode,
-			       struct inode *key)
+			       struct inode *real)
 {
-	return newinode ? inode_insert5(newinode, (unsigned long) key,
-					 ovl_inode_test, ovl_inode_set, key) :
-			  iget5_locked(sb, (unsigned long) key,
-				       ovl_inode_test, ovl_inode_set, key);
+	struct ovl_inode_key key = { .real = real };
+
+	if (!newinode)
+		return ovl_iget_locked(sb, real, false);
+
+	return inode_insert5(newinode, (unsigned long)real, ovl_inode_test,
+			     ovl_inode_set, &key);
 }
 
 struct inode *ovl_get_inode(struct super_block *sb,
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index d3a897e46ccb..f884e6695d2c 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -66,6 +66,11 @@ enum ovl_inode_flag {
 	OVL_CONST_INO,
 	OVL_HAS_DIGEST,
 	OVL_VERIFIED_DIGEST,
+	/*
+	 * A fake inode: not the overlay inode or the trap inode of the real
+	 * inode that it is hashed by.
+	 */
+	OVL_FAKE,
 };
 
 enum ovl_entry_flag {

-- 
2.55.0


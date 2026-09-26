Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE3E54706B
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 03:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790391685; cv=none; b=fX5xBl7f5f2E3qX+dV0XJ22w/s4llwozsRyP1SDqeTsbS0RUb+uPJ5sHC5rJqsuHihSJc4sVGNqrFQoLyUOIkGGtgGLi6DyaX+lpBBm1eVyD3ykgsZSKHl2jMbEE7eIUEH5VeD1T5SbLVhr+1/bBZ9C+P+zEk3b5k0xSIfE1/i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790391685; c=relaxed/simple;
	bh=q7Sb/x8RkVZ1dRFmpjwm7qUgRG6nFm9xkEw67112AQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnyiZr/TpHMzMcjj7wNrm5ZipEPrdcUhtjzkWxo1vv3OOZSl/jLVYwe48omJUJlOdGEIseh8u7whI072uMKVfK5zVBJE+lbr+qM4Wavm6qElgVXJzg8vS3FTZWA+akPDHZotm+wXiBk+jpI5M3qVsZ4PagYop96vwI1ez61T2pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=ThGWSS1d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kkttJmRv; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="ThGWSS1d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kkttJmRv"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E299F7A00D7;
	Fri, 25 Sep 2026 23:01:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 25 Sep 2026 23:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1790391682;
	 x=1790478082; bh=zPEqKhlFB1dqYy1LHDsPZyyEtsG7g5LcdaXuq6fNQxg=; b=
	ThGWSS1dIcOPEz132flipMn7AIdlSGSVliThCAs3vqsKYJpnhmf/hMRcRt0KonLc
	jvpVYQkj9dWIqav5A8F1c5yr6bT+qZQjH5FPEoBnKCYA4xS0tamTDZflllwiOHss
	5JexxVJoUA0wi33Owei73Dys0Kibqr5CjvmM1gGGkkIzdjTqlcJ9Jh8Lnj8ht6kI
	IMwU7T80Fvgx2CR7u7M6nXDiUhX4D2YF63puVSx2jsBwAqaC5+/xhU7Vmsuq0o4w
	LZg8IS/9g18IctyOM4rSxJfCtmNWXILEW5VkrFNqyPhOIe7kge+49F71p1nZKW9+
	ZV1C3mEUhYn/3t1s2f+LIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790391682; x=1790478082; bh=z
	PEqKhlFB1dqYy1LHDsPZyyEtsG7g5LcdaXuq6fNQxg=; b=kkttJmRvnBaLLBWiZ
	qTZAV718uBxY616VXSkVDRlT1KpV3XFI+uSgu+9X3Aw7nKxcw/r3N1niNza/ZNhn
	Fee5DRIL6IS+2TWpEtOFMdhf0NPSdpyD1Oy7usOYrrTmYdJJGnA0W1I6q/VZUovg
	dkqy3Ufu6HmHDZQF+CPbL3srVeHWnEiM58xQ/rb2IUl0plOifffGphVjykF4JFW1
	ovee7cQsEzxx0FFW/t16eHApfh5RvIoCxsDRZHAc6qIJJJerYV3LJzzf5BAq6724
	kt0i/3Ke0u8QmI/URqFQRDEP7oCNB2ypyYOn2I5QDppIkZ50KED9MEr6AWDBClv1
	7Av4Q==
X-ME-Sender: <xms:gjW3amm9AQIw8UwKfoLGN8Qts3vkBulz23s59y6i62pjazEkWddQ8A>
    <xme:gjW3agbcaUju76nUVJVVD_NbmzfFIMY1E-B--vfl6U-QviIjGp4LJ9jq8BWroMiJf
    OnfphygZ-DxEf_hdSbgdDrElGjlZ2e3cnDmOiHdKD_8fjWl6A>
X-ME-Received: <xmr:gjW3aoTnZYEOKvgkem1Cg--uVmRFO1Oqf0x94va2LGCwgASwSnIKoy2rQZcNGzPP2L3Cu5kt5koOFsflyfSfBIYkafW3LE8>
X-ME-Proxy-Cause: dmFkZTFnwImKnvPBt4+pNt/+NbJrrzUUSqUtgPvPUpEaLbzFFmJLhjm26R/Xp4ceHDw60n
    KReVqiMJ65hsskB+BMJomNdVJgjduGP1UIhj3W+2NtqwKYnwXx911EDjMWeYwFQwyeSS65
    AIPtdf8px2nwRP+yamxxb7XjbiQ9Th2+8PoMlan4UHiOQ2TV6d7xvaHFy/Gn/QRGsedx7B
    Gib0f4da8e2docjnNZa2BkSfbnbOK7bTJgNc6Bl2VXUs8SM6OHJ2HLM7q0HR1OpttxjrdJ
    c42fsDzR6p5IaSOhiWmwEfSeniGKe2GJsPi/zhBVvZiE8/CU+slb4gGfkRnZSCeSss15Qo
    eZ1AkuYkRzKVZMQJImhMzzfcKUGBs4rnvDLbCu9drA38N95hmXWe1Ot/56rxWSL0uMIobx
    kTyiTcElkexZGmpPB9VABQdenvjsDOOKJKI01kg4AjBkYVNxyeIlLb/IsZfBwt48ezwubK
    InQ5OloOyq20sEf06nFc0VrCJkJyNU7oRRykGEIwTLsFLO1MprvWuuTwGoK6uTa1c1CVu7
    GVRRI8N+kpDAq93CXcmbZeCj9LYt+/223m8KJZavINcUYY9Uhe1BZi4fQlrtUeJZxP4Ktx
    FWcJYuBFYWCFOx7KiENGypFKUq8KWPpTVHchiIjM3oTvlvWB26vxKPPwPfyA
X-ME-Proxy: <xmx:gjW3aqvgoJmmxjVt2RVyBFPI9CWKErsGCO60BOTYUUj7rB9ZxCXzVw>
    <xmx:gjW3aqF6fdxtSovTCP8yfkL50M117vp1277ElqaK3cdvjiXoadHIBg>
    <xmx:gjW3arySp1kuObz5WghTYKeTQyIrdrl2Er9masK7wDvngia50rq1lQ>
    <xmx:gjW3ak1ehdBLGnfKxKz4E3r5YoN_0ootAy7bKeidoGh30JiEjzVPuw>
    <xmx:gjW3asY837zbvrQ--Tj5a7jybI1mJ7tN7czTe-fHypLFmw-26KiVjIEF>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 23:01:20 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org
Subject: [PATCH 3/5] afs: use d_alloc_trylock in afs_sillyrename()
Date: Sat, 26 Sep 2026 12:57:22 +1000
Message-ID: <20260926030052.467448-4-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260926030052.467448-1-neilb@ownmail.net>
References: <20260926030052.467448-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

Rather than performing a normal lookup (which will be awkward with future
locking changes) use d_alloc_trylock() to find a dentry for an
unused name, and use an open-coded lookup_slow() to see if it is free on
the server.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/afs/dir.c       |  6 ++----
 fs/afs/dir_silly.c | 53 +++++++++++++++++++++++++++++++---------------
 fs/afs/internal.h  |  2 ++
 3 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index c790fa9432ab..1edaa7323428 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -19,8 +19,6 @@
 #include "afs_fs.h"
 #include "xdr_fs.h"
 
-static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
-				 unsigned int flags);
 static int afs_dir_open(struct inode *inode, struct file *file);
 static int afs_readdir(struct file *file, struct dir_context *ctx);
 static int afs_d_revalidate(struct inode *dir, const struct qstr *name,
@@ -967,8 +965,8 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry)
 /*
  * look up an entry in a directory
  */
-static struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
-				 unsigned int flags)
+struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
+			  unsigned int flags)
 {
 	struct afs_vnode *dvnode = AFS_FS_I(dir);
 	struct afs_fid fid = {};
diff --git a/fs/afs/dir_silly.c b/fs/afs/dir_silly.c
index 982bb6ec15f0..5400dfbcadf0 100644
--- a/fs/afs/dir_silly.c
+++ b/fs/afs/dir_silly.c
@@ -112,7 +112,8 @@ int afs_sillyrename(struct afs_vnode *dvnode, struct afs_vnode *vnode,
 		    struct dentry *dentry, struct key *key)
 {
 	static unsigned int sillycounter;
-	struct dentry *sdentry = NULL;
+	struct dentry *sdentry = NULL, *old;
+	struct inode *dir = dentry->d_parent->d_inode;
 	unsigned char silly[16];
 	int ret = -EBUSY;
 
@@ -122,23 +123,41 @@ int afs_sillyrename(struct afs_vnode *dvnode, struct afs_vnode *vnode,
 	if (dentry->d_flags & DCACHE_NFSFS_RENAMED)
 		return -EBUSY;
 
-	sdentry = NULL;
-	do {
-		dput(sdentry);
-		sillycounter++;
-
-		/* Create a silly name.  Note that the ".__afs" prefix is
-		 * understood by the salvager and must not be changed.
-		 */
-		scnprintf(silly, sizeof(silly), ".__afs%04X", sillycounter);
-		sdentry = lookup_noperm(&QSTR(silly), dentry->d_parent);
+newname:
+	sillycounter++;
 
-		/* N.B. Better to return EBUSY here ... it could be dangerous
-		 * to delete the file while it's in use.
-		 */
-		if (IS_ERR(sdentry))
-			goto out;
-	} while (!d_is_negative(sdentry));
+	/*
+	 * Create a silly name.  Note that the ".__afs" prefix is
+	 * understood by the salvager and must not be changed.
+	 */
+	scnprintf(silly, sizeof(silly), ".__afs%04X", sillycounter);
+	sdentry = d_alloc_trylock(dentry->d_parent, &QSTR(silly));
+	if (sdentry == ERR_PTR(-EWOULDBLOCK))
+		/* try another name */
+		goto newname;
+	/* N.B. Better to return EBUSY here ... it could be dangerous
+	 * to delete the file while it's in use.
+	 */
+	if (IS_ERR(sdentry))
+		goto out;
+	if (!d_in_lookup(sdentry)) {
+		if (d_really_is_negative(sdentry)) {
+			/* try to get an in-lookup dentry */
+			d_drop(sdentry);
+			sillycounter--;
+		}
+		dput(sdentry);
+		goto newname;
+	}
+	/* This name isn't known locally - check on server */
+	old = afs_lookup(dir, sdentry, 0);
+	d_lookup_done(sdentry);
+	if (old || d_is_positive(sdentry)) {
+		if (!IS_ERR(old))
+			dput(old);
+		dput(sdentry);
+		goto newname;
+	}
 
 	ihold(&vnode->netfs.inode);
 
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 5815ce1f1bfd..d3fd108041cf 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1109,6 +1109,8 @@ ssize_t afs_read_dir(struct afs_vnode *dvnode, struct file *file)
 	__acquires(&dvnode->validate_lock);
 extern void afs_d_release(struct dentry *);
 extern void afs_check_for_remote_deletion(struct afs_operation *);
+extern struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
+				 unsigned int flags);
 
 /*
  * dir_edit.c
-- 
2.50.0.107.gf914562f5916.dirty


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794257539;
	b=zmXTn5uGqRTXR62ZJ5ym1Uv/hT2EpQKXQgWwxJTvI3ahGTQQrbFiKaIOUkIJd191DWMQ
	 faGb19Exfk//AhbvNF+BjbMuh+YCL1YWH8CTdKAHF9pniWY51pv6atCyhIfkvKqZMxqHw
	 JExVsgzMr197JszLDn0cM1y0IyJ8q429daMNP3B7RvZ+5U8BajOswKH9ROrhDbSzy0mIP
	 UjGUwn3bR1p8dM9kNQnYzkahPn0bNWWJpgPhcOlK2l9GqgbgpOCItr3U8Pa4I8mKdToRV
	 QJvjaZYoRI8hKaDglvv9hECgpqMugV6+eyB2N6fAvnXbSgIc1MyqLRjhr2QvCJd73cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794257539;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=dyk2Y6IvRzcJbTyhO1VPVJeWMWSpr8fE3byR/HVy4hw=;
	b=5ltpA7aT8YgiF4uvDhNscN7PT1JWoaCQjnwJjhjbHMvun6jQNj7Sc/vewl4uX2/j2JxL
	 YExeECPwzUZD2sGcMuDKPkpjgdsea1dxZbgiUe+FFdEOj7m0WybGIRdot6BYeTOu9RW3f
	 OR2vVNNLrDzY/8ZpdE6luxD5YvZDNfJHnZMlVq7y70A3WnGTQa0QgC8LxLxo/mgg3b6ok
	 Mhpp6N4UL8R/6Fip/36KgRC7O/JoK7U83Wjds6bf/BVWfGi9Ih7Q8lByO93N7xdxa+W0R
	 8FDlIliUW2dJd8upm9XMTa24VT5UWyKHf3VsHTSIPY4RH+GvC6THnzpE0X9xpTyEEQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=Ae9DNwY5;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=i+XPhPtA;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19142606A334
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 20:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19142606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=Ae9DNwY5;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=i+XPhPtA
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 54321EC012A
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2026 15:52:18 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 09 Nov 2026 15:52:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1794257538;
	 x=1794343938; bh=dyk2Y6IvRzcJbTyhO1VPVJeWMWSpr8fE3byR/HVy4hw=; b=
	Ae9DNwY5DdqHKicFMT7uj8FUbSGzMMy0/3Cbw+Dogl51p5H+SxuqsCfZMr5FLhlA
	85ogC4ptC7/rtPDr/9thF1LHfwhAwsEFHFnIWuPmNYaRC8/UEgDUTlhGONUdp67p
	Lj81k6VapcV62LHvE0nmG2b8edJMxZJnT96ZnUQ9sua34cRYypAUxC3STKC3cUWK
	WftkhMsQg/btDNsIzF2lFjQRMgxxVIyWz37vK2PF1rSwr0U86kBpV0+hwWUXFVVN
	z+/6i5U2NS8z8fnWrvXi41QC6CgExpE3zz3uo3Lbw1LCIqZMEsHTNZo2mcFzoUr5
	2vkfNfyrcSqk2/KqLBW4mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794257538; x=1794343938; bh=d
	yk2Y6IvRzcJbTyhO1VPVJeWMWSpr8fE3byR/HVy4hw=; b=i+XPhPtA00D9BC6VL
	Mu64Y4Ds0QidG3VAcqr/H0AW5vLjXnTPUTXn1GlWK0jkW+uq2AV5fBhCzbvVAXm0
	NnRIUHkZ94lr2fLXpo4aFUmTIX6MhSKu0IB7/SWY3hK2LJmBRoO2OUKYIydvxwO0
	0znlyfwFnX1McF5OnG2TvyQfFX5TC6aFm2bUygXXBNkOnKv+fxDQwRhnJgI5JG5S
	RWeyZznZUOD/WfqG2Mjs6bQ8IVhPic5v173t3J6nznBQZpW/adpjdDsnBeUaVT9I
	QnnOJmjPHCrrbkmiOIPgrXAj3M3+KDCTiJfEClt5tWzjEFmC6YTKxLAR5UlC5t2c
	CM4fQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794257538; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:uzkiD5jpiqOnM0ItL7h19Dj1x+69YyW1VFy98KiQ5inWAoL
	ZvFJvQ0OtV+7VMRZmuLfwQgYd1+57UquarzHXy56JwvlG8sj5RDYNwaXpfsCmo+q
	wz8Z1mkYszdtZL5sYWD6K6G4Kkb4ssw4ECrmg2JrF9h5hY66SoBGixSJlzxzv+oV
	WZKyj/JI4PZqXa/YDQq2/70+tHOmTT7ect5YDqAwF7XasNPLuBBNoKv1n2LxQ6nP
	3yRkxJ/SMsj6DO5cVOatbGZsZRa523d8FKYJp6sKbspH/R6gvzYGHlr8F7MjaYHw
	ZGErNcLi3Lz5skpZGcqSfGUaAwFBQ+Az5wb9FJg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:OjlggicRpXsqoHxwCfthU1rEz95a1BBPwmeqIYH//3E=:oo0bAeJSgMQhHyLRODIO+1r2n+AS/TNK1Wi+tD/AeaA=;
X-ME-Sender: <xms:gTLyanCj1z3C4n3Ykjk26YIj3sCfClqGJo-jxH0i8RaVFnT7o22kUg>
    <xme:gTLyary8Xz_NRpf-v1oqmGFUz69vgCAAare85jUNCNMhio3wrYtNyBA2JA4Ye_KxS
    d7pjSzWu3ryCD8jcdNjWIOoBXt2S3g04VTVrgsIQxdO-WWV>
X-ME-Received: <xmr:gTLyar6H8vvfhcPIfdKkRYImEvi9uG23pYclk0pqsFnNOzs9-tMjB3986NkwUleeDQzLkQ6kVjyf7drtQRkJVo2xyVQPAZk>
X-ME-Proxy-Cause: dmFkZTGc6Wfopr3yByBODvVP+Oeb+FLkCIAHSHXx7lKy5HW2U1upI0iembimvsk8AEpSZE
    MvwARY+UFbjHd9YV6pYDviSr02W6QSVyDIHPRBaIeKkb1ynLuXblQeWa4vWXWMBoGY2ylR
    8MibvhVLpjf6RGg5myDdFApSiNfnMFCWLo2DKnZNkL1ttRA6R81HrKhVsSTnWD3U90M/g0
    eiWpkBEA+yo88el8kYtfl23LMEmQaTJAZ92kFH+xvZejbh4XlaDKRH2fIaheAZzuwljtfD
    vNWLVebH1mhryAUvGEemIVHPzuHDbGpFhYTwQXOwD7SZCf79zoP3iXyu1/YWAyCQeXFgWE
    QPd3f5JCfXOhTVB+Z70v9tEBZtq6BY+heOk22T+qsbZ+IxEUgsiFzmKX5zpNN6uF7KA7n+
    5sq4kvGcQEcQAJZWz3n2dzLxHVlZmh9RNhejVBfWCZlJfZ8Dy93QyrDzn5ZP8ZrSZbuRwq
    g8pdDvdVuEBfc4BIwN8gHC8x4p/jaLWVdJjzbk026IDIjrwuIukmB5RLbVzEbaab5Kpz/J
    7OJsmA8X+WvUhTrk4MiIXOSX9Gn8DvsoR5pInNsTujVQuCgJeHuES2sIW9lDn5PMGGeUAF
    fUz1IbrJFhO1u19jcMx4fsk+z+aNRkSqWZGeHyjm2iiv/RwqYMDv8cZ3CvOw
X-ME-Proxy: <xmx:gTLyasxSRQq-GkAvvM5RC1pSbuS9swBoRlJFFQr4Z783LAwtOzr2XQ>
    <xmx:gTLyavejwrOLSUwsAOy9JU7MgEuiDmzUXVMtk3ipxK0VzCuWTmuQXQ>
    <xmx:gTLyahAlFYBZybcH3C5dk7EAMlIBaciaaVrKYbUhLwRXnF9QG8YaZw>
    <xmx:gTLyaj5hXlsrJkwt2aiEIs90BsemL0k-WjFN-rbMLdTMc8HtD1LRtw>
    <xmx:gjLyao_CfJ8IE9txg1VIi96KJfA7HqeRCb6PVVAEYoOHJh9f82_Mntav>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 15:52:14 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernl.org,
	"Jonathan Flynn" <jonathan.flynn@hammerspace.com>
Subject: [PATCH v3 3/5] afs: use d_alloc_trylock in afs_sillyrename()
Date: Tue, 10 Nov 2026 07:48:25 +1100
Message-ID: <20261109205132.1561271-4-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261109205132.1561271-1-neilb@ownmail.net>
References: <20261109205132.1561271-1-neilb@ownmail.net>
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

From: NeilBrown <neil@brown.name>

Rather than performing a normal lookup (which will be awkward with future
locking changes) use d_alloc_trylock() to find a dentry for an
unused name, and use an open-coded lookup_slow() to see if it is free on
the server.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/afs/dir.c       |  6 ++---
 fs/afs/dir_silly.c | 56 ++++++++++++++++++++++++++++++++--------------
 fs/afs/internal.h  |  2 ++
 3 files changed, 43 insertions(+), 21 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 20c68a8b3028..580fe51fd08f 100644
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
@@ -969,8 +967,8 @@ static struct dentry *afs_lookup_atsys(struct inode *dir, struct dentry *dentry)
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
index 982bb6ec15f0..e07c882c4fc7 100644
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
 
@@ -122,23 +123,44 @@ int afs_sillyrename(struct afs_vnode *dvnode, struct afs_vnode *vnode,
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
+	if (IS_ERR(old)) {
+		dput(sdentry);
+		goto out;
+	}
+	if (old || d_is_positive(sdentry)) {
+		dput(old);
+		dput(sdentry);
+		goto newname;
+	}
 
 	ihold(&vnode->netfs.inode);
 
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 1542b53e2cd8..60687671f18b 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1111,6 +1111,8 @@ ssize_t afs_read_dir(struct afs_vnode *dvnode, struct file *file)
 	__acquires(&dvnode->validate_lock);
 extern void afs_d_release(struct dentry *);
 extern void afs_check_for_remote_deletion(struct afs_operation *);
+extern struct dentry *afs_lookup(struct inode *dir, struct dentry *dentry,
+				 unsigned int flags);
 
 /*
  * dir_edit.c
-- 
2.50.0.107.gf914562f5916.dirty


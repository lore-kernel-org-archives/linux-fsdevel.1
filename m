Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578397;
	b=GqGk0YKG2y4O+ztc6iCJuGKPxxpx+5o/lwzVYrRMQQ1SIyjRt0AnRtuiQsKp0QU6vscd
	 srfHrMOMIFeiNWnt9JVzkj29U53u7nStaLXyfEXB/5joye7bbk06KhTHJPZEeVXD+9Is5
	 eMeN0rocw+oKR+OnSmP8i0AoaIruFpYHOL6PoXthYu+DrQYxtVwXr86mCoy26glq19s48
	 WkVR+OuGweFudcY+H3p+ymCC9mu8vRQno5uAqfW40wM3dhUCqCoG3aJjsBA9+Beu6dl4y
	 OGHOX89OyNZz3Y9OCA13W/tkZTFMCcRw132sn7aZYbCYNaGMgABem+tjk/o5KqBE+ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578397;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=0FaBaABBTMMOUzArdca6QeHZ4IeycD5fAytGFpgX4bE=;
	b=d+qSD+i1c4vXSQaQmhW5JCU5JUbsO2CS2Juq02nV1kPlE9nurqJySsR7DoQSTeTM9DTD
	 1MujxA9QU0JKZbA2rdmB6HaSEPcntuL2bp5obZk37FPV/nLjg8NejNdR1+IlWBqMKuNr0
	 vAQQclYSaN6p5ndejwsXmpHJn8zOuk/8uzgSfB9RcNJpxiOccRuzXwEowHivutPnnQMPc
	 d4xONKb61pkZTsXdkXxwqzazp7rnmFDmWL/sz3m8DPXGyePFKYGNyScfPAUoeyBbcM5EX
	 IRTvVCmY6Fbp2sS8puLFX1NQneTChDFSjmtc0SJLapPzsiSRG45VwG+9mF14xMsD0bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=hddkiWNu;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Dtsjk7qU;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F1A606A327
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 03:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68F1A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm3 header.b=hddkiWNu;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Dtsjk7qU
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9988D1400319
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 22:46:35 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 24 Nov 2026 22:46:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1795578395;
	 x=1795664795; bh=0FaBaABBTMMOUzArdca6QeHZ4IeycD5fAytGFpgX4bE=; b=
	hddkiWNuNn9I/494d6oMhaaXoC7/mGRRa+QmiZbyhXXBOviABsKjE9rNvqg6hUOV
	cho+gnzmSMXgABbG7MDUv9F4nafa3FCeb5tqu/m3wDgOyL9YCgMUPyxHwiEADfkx
	rqg+IHMrYdsnkWtD+XNcIOwojextrjmpu1Ul8oNSQP2rGRIzXWKVrS7S7IoPqZBz
	HrENy6WLwD8fCfh1dQCxWEDEzu0rsAuzEyzE8h1We6DSw2TAgQCxQ2cuvONYl9ZZ
	nnghYFaH2KVtY/e1KgR6sTOrJgY1U+fq376InQ4h20qn7oAtsXMw4yVZwe3djRLT
	SSJP46PkGdJc8Ez9dW9aeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1795578395; x=1795664795; bh=0
	FaBaABBTMMOUzArdca6QeHZ4IeycD5fAytGFpgX4bE=; b=Dtsjk7qUnEU/ST9q/
	LhuuDoy/Z0N+n0mkBxGBYLXPTEovEAceMpS/omrv2CBZmhUyt69a43kUZQLkp1H1
	7sOMGNT9deyoJKjw9Mj57/WIJnk+tigTo2TNpn6fAJrP9Ujwf447Z0ip+zg9PXf2
	s7A6rhbChjwVn2XXz+1VMliTQxe6z01NAQA3YGt6RuBWUzqgYeVCGbpfspAlzV1H
	MrFuvnJ90FpGszlt9RKv+QQE5BiLtJWau/IdQ3hFIHTJ1TQYsKMJRrsPk4TYztal
	pca50TWm++Sq30+sPMph0/RVISn41UN78KWinTscScwxaEDShfpfq4VFRjnqvM/N
	lggUg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795578395; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:uEoTbqsRIcxfYsMpSiBEmiwVOQHIOW5TPHbXlTy34I6nHXp
	g9m2nJpqZHAE1MvinVmzw3QSUo4nsywSSjtpxytLSwSEWnmmHHvbwXn3XqZ0Suok
	B6092K7eNAdQd/NFMvniY1xOnEOAlxtkqoIeeUwKk1nZv4/KNFEiwPDeU1/odZug
	mkpOwPmE6htPhUMGrNpW1rmMJfGWctsjFq7XZFmu8UwvJXm0lEGuJgAPeTkoV6uH
	oi7f9xVLiqxu8u7KorK4QwlCY5CrpDwEVMNFGAjxcEg6/oE8e+FNgp+6usOG9xs6
	QpvIl7RA3HWL0vUoQ6f/yY5WD61887xrv6ykLfQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:Iqaao4Cg+imi/yjtItJycZCXzUrgTnyhmvZE04RbLCM=:CEmtH/13/UJWrZaqiO5WuYIJ2zLw0Zm6AtOxB8Cb//0=;
X-ME-Sender: <xms:G1oGayKC3SdgtotPEjZV0MnaA8l5NeYvd16MXdqjPvOeYyN8QgNmqg>
    <xme:G1oGaxFSdoQHeJcv5esO7O0BkK4YoxvSVj_fBH-672EyqjwUZpNLJxDbw-Xnh8oDd
    o-wHLG40rJIGw_XtgYCj_6JXoockplx0PNunjmv6FAcaesvYNk>
X-ME-Received: <xmr:G1oGa3yJt8v3X86hDxvXpkBc90Z4PjGrR7CeTGRbYmYDAjuW1fuoAr7v-urLDak3ML0ekp7a9FP1qokvjh1rJTC6hcRmwYo>
X-ME-Proxy-Cause: dmFkZTFR427OSMpMhBUq2c/PRD6RmqRpXHsHavEQEoZib45veoj0ON4Fee0fFpAMf6IRZD
    7ioshD0AaEWr7quPZ3VJk4MkgPxfK4VajmEfAasmF1N4QuQ1Nx4fAT27aU1zZmPYaReDqx
    rfP5UHReFgze/pUM1YUaeJAgJLGWSi2iJU/qcqRk+B4M1TsPMqQDofdX/Jn7SjcVJvCtNm
    zdB65WAuETFQQDYBDZIOHXvboBphMIm2vyy1TKs+e7zZqPSqTzzCVyEWo2arAfhj68hGFx
    kBzHUYnaQIV/eTYhsd/MgvSt0+AvaXUSwYNCdWWq7bBlwHpxfTlmsOfayzrTTRF9w5P7pd
    eSH8UsdivUd5G0zLQNK8oSkMSRRE8Hq3XSl1uyHu8FFMtgZjlmJtR2daSxBttEI/io9e1Y
    0CysaAkupJB57Bj5Dd8ofTawd4EV7U8QWi7ZHJPcQO8OP2I8k/9NVeceykzt9UlTF8i3u0
    UOeOzS6sjMp9WcpgSMvKzKNI+RQZVx1nd6pDfuudslDByRqvklpUhPCr4rATrogCaxpwd6
    xpegNLlOe+yPN4LL1PoObvTqPwFU0IKZ0qvIl6/iUJO/9pJUl93Hyrm6hJykpNtrhuC0sB
    ORxNhy8ZFlwuKsS1dj5A0Di7UJlpzJ32VJNrrD8UdPRoZNTI4ewKLIJAEkMQ
X-ME-Proxy: <xmx:G1oGa-gpsQ0DExuIR76BYhg-xzOV7Fk-MqPomG-T0eCKx6LIF0w12A>
    <xmx:G1oGa0I8VOzIUEiX-L94SXOVivy9g15AprtpVDCDcwG1qcqfXK9Ldw>
    <xmx:G1oGa5DLqpPjP4TGXbdg4093ZIuonUivJUagYK951_-M4hpvb4EdXw>
    <xmx:G1oGa9RUqA4hhX61OKuebhrKpj3oGHEZ_J54VCFxVOie53NwfLyuVQ>
    <xmx:G1oGa2nrYOrfdruSeYTeGSNCcp80tF9XyuY2lWgz8VrB1mAUjUF-vwtC>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 22:46:30 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	coda@cs.cmu.edu,
	Jan Kara <jack@suse.cz>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	linux-kernel@vger.kernel.org,
	codalist@coda.cs.cmu.edu,
	linux-fsdevel@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-afs@lists.infradead.org
Subject: [PATCH v3 05/11] afs: use d_alloc_trylock in afs_sillyrename()
Date: Wed, 25 Nov 2026 14:16:43 +1100
Message-ID: <20261125034543.4084039-6-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261125034543.4084039-1-neilb@ownmail.net>
References: <20261125034543.4084039-1-neilb@ownmail.net>
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
index 32b05aa8e208..672bd83ff112 100644
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


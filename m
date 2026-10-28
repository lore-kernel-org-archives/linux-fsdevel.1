Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197866;
	b=48j9M2D90eNGzO0VjNYHk8RSwB94pj0M/Qedm1IIvqwsLamRJ+pZLmvhQ2SibHpWLAPO
	 oM1x/T//BqBkxGqD/eMlwfCqWHHLF4+BGug9vIj4+c9i3/b+FumO/TVhoONYA4XHZ6+uN
	 iucULgI1Ks1lBhZ1qh8ZcQPKEZkl2cvEmxUXQt/328Iiv3L+aKhM08eMeRFFK29tUiAhL
	 Z1s9f4uZsBe3oGRzXUgf0LFUNHnCRydS3xY8+Bk0Xhtt8BvxId0fsbX2AILxpvETAfZJw
	 YIUTesaWvoTmy613sLJnwSfoXdy/FkqUfWaND556qTXbCREOqeLFLZKPciyZ4pczgBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197866;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=rZyjUVv6oQMhPdN7DmC2x8achQB4AwJYOLdfogUpEb0=;
	b=EF3ofe01oFkBsU237nhrLTRRFvxFIgQ1wQjJINv8VJZcdJO9TU/fYc3ZMsD5RuCcefN0
	 3IW763Pu9aI6vM2G/RM0QbFC1mfliWpz+EzZfUxRgyXivdR+SJBh7YOcahPfuC79yAdSA
	 28Jpls1W0/BOoy2LAMtRkFvQvICvxc6En/yaa68aDi3VgS+v4uMLedE5zqFfryy8MGlLE
	 UyZAE1uyUkN4bucyLpKrj2bSg8hlMVe55ubqvmob+93sYqftALSjDOQ7VAoIE0P3BNSZJ
	 w1WnITVnoIB2QI2ElXwvMULu8EiS34+JM2ZOw6djhVm/8PpAeCSSLyCcUMj0u9rDcGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j+5gX8Yj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0017606A31E
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j+5gX8Yj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0111C1F01828;
	Wed, 28 Oct 2026 14:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793197866;
	bh=rZyjUVv6oQMhPdN7DmC2x8achQB4AwJYOLdfogUpEb0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=j+5gX8YjA5STPCO8jXNLgCSGpOPTfshI3n9h+Q3l1GqZwBDFHMEyQAhmnDQgJFh8a
	 Qx+pxrNcVD2C/4FBewIS+hnRDLX2NsRxgN8eTW+nXs6Maqqcss0yEcJIin90U95BrR
	 59HY3tMfA1gfnAZzt0At5NSZ/WYUguMMCt99J6SZkc0SYa7Rj3vCUyO0Hq9QDBitZ0
	 EHlm4lp/p9QyNorXZGM/0k66cCbhFOCZ0CQLCDZ/KDXTh0ImQjSwRZezef930C0Aiz
	 n2VE2X2/ijV/KuZDGYhDHKA6j+a6CDtcTmhC5JOyEcTg+HjGfAMuwAH6RzMcCf1skz
	 PihlVu94PWF3Q==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 28 Oct 2026 15:30:37 +0100
Subject: [PATCH 1/4] namei: make the walk flags a named enum
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
Message-Id: <20261028-work-mount-trap-b4-v1-1-f20d9d0730d6@kernel.org>
References: <20261028-work-mount-trap-b4-v1-0-f20d9d0730d6@kernel.org>
In-Reply-To: <20261028-work-mount-trap-b4-v1-0-f20d9d0730d6@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Miklos Szeredi <miklos@szeredi.hu>, NeilBrown <neil@brown.name>, 
 Chris Mason <mason@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2624; i=brauner@kernel.org;
 h=from:subject:message-id; bh=uVZqtbIjMe0TcDw5M8De8Le37OIm1XMH5IQX3NVHa2U=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ9YldxEv+uLpq5WjJTT2f9oT6Bf6zsa/9oLLaWEr3Fp
 6KftqSxo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCL3jjL899idbuex9fT1cPZf
 k+sc3jqX7xXexqFikHbJqu/EjTM9Pgz/nex8rLluSvHMPJzFOuOzgO8XVfPsmpoj+qcPRj7lNhb
 lAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Port WALK_* flags to an enum and move them up where the mount traversal
code can see them. The next patch adds a flag the mount step will use.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namei.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 22c4f328b8a9..0fa9a5b7b377 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1565,6 +1565,12 @@ static int follow_automount(struct path *path, int *count, unsigned lookup_flags
 	return finish_automount(dentry->d_op->d_automount(path), path);
 }
 
+enum walk_flags {
+	WALK_TRAILING	= (1 << 0),
+	WALK_MORE	= (1 << 1),
+	WALK_NOFOLLOW	= (1 << 2),
+};
+
 /*
  * mount traversal - out-of-line part.  One note on ->d_flags accesses -
  * dentries are pinned but not locked here, so negative dentry can go
@@ -2002,10 +2008,8 @@ static int reserve_stack(struct nameidata *nd, struct path *link)
 	return -ENOMEM;
 }
 
-enum {WALK_TRAILING = 1, WALK_MORE = 2, WALK_NOFOLLOW = 4};
-
 static noinline const char *pick_link(struct nameidata *nd, struct path *link,
-		     struct inode *inode, int flags)
+		     struct inode *inode, enum walk_flags flags)
 {
 	struct saved *last;
 	const char *res;
@@ -2094,8 +2098,8 @@ static noinline const char *pick_link(struct nameidata *nd, struct path *link,
  *
  * NOTE: dentry must be what nd->next_seq had been sampled from.
  */
-static noinline const char *step_into_slowpath(struct nameidata *nd, int flags,
-		     struct dentry *dentry)
+static noinline const char *step_into_slowpath(struct nameidata *nd,
+		     enum walk_flags flags, struct dentry *dentry)
 {
 	struct path path;
 	struct inode *inode;
@@ -2127,8 +2131,8 @@ static noinline const char *step_into_slowpath(struct nameidata *nd, int flags,
 	return pick_link(nd, &path, inode, flags);
 }
 
-static __always_inline const char *step_into(struct nameidata *nd, int flags,
-                    struct dentry *dentry)
+static __always_inline const char *step_into(struct nameidata *nd,
+		    enum walk_flags flags, struct dentry *dentry)
 {
 	/*
 	 * In the common case we are in rcu-walk and traversing over a non-mounted on
@@ -2262,7 +2266,8 @@ static const char *handle_dots(struct nameidata *nd, enum last_type type)
 	return NULL;
 }
 
-static __always_inline const char *walk_component(struct nameidata *nd, int flags)
+static __always_inline const char *walk_component(struct nameidata *nd,
+						  enum walk_flags flags)
 {
 	struct dentry *dentry;
 	/*

-- 
2.53.0


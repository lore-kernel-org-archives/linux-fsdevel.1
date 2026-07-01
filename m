Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8CB239085
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 22:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782945777; cv=none; b=AWxQF9R5dMZlqmxYKN+8gEQ9Z6kJdFRHSMp3gAx5f0zbAbVvZR/2/p6oC91NgIqW4Npw080HcdZz3acrwSNcV4CvCB3S5xedctct+ahuSCe5UHAAPBk2mA40HCSo2iwRN/BXOpneV8LLSudjTy4cddhvMu2uzM/dp+c93fZYFE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782945777; c=relaxed/simple;
	bh=JTUe7ZrQKBgCCKMLlN3QL8qqPxoPgPJ6p7iURqdPFO4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=fVRlnDn17WR9jcLiFpCCmlz+lTJcsRt0fUjCEGhFvMACd77T4inOTEZfP0I4TnOdmVKoIy0B44skJn+xnYVaytmuVBGME+Ai/xsgBntCfsMmH9w0GO9NsD0PaFcLorIeaF6aJHw6DLhlD3M9DoI+F93L2z3z05Ou66HC4rTqi8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=ipKYB9y1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ChVWUbrZ; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="ipKYB9y1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ChVWUbrZ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 52EAD7A00AF;
	Wed,  1 Jul 2026 18:42:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 01 Jul 2026 18:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1782945775; x=1783032175; bh=oD1VI0RuGlWlKJ9fEAsevQuRXnenezHIFfG
	zH9+Eq3g=; b=ipKYB9y1BxKMaMW8K6K+r0nr9+bcRILCyciJ7LzW+1l+wdhCgVz
	bbKoDhMEcN3sge4zbPD/uZb2GJG9XqByOpDbriJ0erCkBHyIVXtfi4H65K7XjcTc
	y2hQrUEDAZ5GympeTYvxwyVy2XYGG3BSE3LM9wBuB/kay9MpWjmUNzP9hN+GJQsH
	VHWE3AJ+4Xy6HaNGwOLkt+wU7j+i5GfLIrp6qdSNX0I8gWFcIwIV6wBHv7gFKeQr
	EQZLz1vHiBpqRG9EMV7IE6GRauUidcRzvQu1P5HUWwyNMCl3lT0+CbgG5fZOfGvC
	/hAU7QyW5fGR6IoCmLbDf5yWNmCfF3CVKJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782945775; x=
	1783032175; bh=oD1VI0RuGlWlKJ9fEAsevQuRXnenezHIFfGzH9+Eq3g=; b=C
	hVWUbrZ0GzjfT5itszwOL7bgbxiIEVnkqsr3vVmPN0NdZJ1ArH4NRc2k3IG8HiIQ
	2oK2NlVUwPpx97CNM8FX4T+d8xr20iRFe83gqZZxfoY0rT53ReKnAJSQP0G8VHot
	V+DWGvojXtbNL1zm04Rd+E0ch2lFaNy2VCkmpyqcshHXd7oxdgJFoOAZF7TlJJS0
	Nm7r3WW7tJXJ0xiHrLGllhjPM+M6QINuhuE4QG3CWjRcLujFlofZezJU9JDoWOMB
	fyBT83kjPeE+ksuPeYODrptHAfz2aCdOdUlW5AoWFbYFkPraUz6mco6kY5WBvGn+
	l8cYyxxMKExO7WNVXWN5A==
X-ME-Sender: <xms:7pdFalxHmsw4Rlne1beEJM-NKrPjmLXQimWwm8Qp9yw9h2FCZhUB1A>
    <xme:7pdFauNjmU4uSwR4jyLxV_V5Tk2H6BBhNUZb7ZV1PKpBp1kJVmqVH0BzC0r8hPuW3
    0lj_RrQi8clLF0GorzBspeRLflS5Q9gF2TS7VyZ5q9Vx3wt4A>
X-ME-Received: <xmr:7pdFaq7Bioxi51crUMs7Cl5B_NjSZUaTrr-uQT25jyJXBPSQJaims0qeJCHMfgozmb_BzM-UswKFYip7eIP2OVlPYTpX1mo>
X-ME-Proxy-Cause: dmFkZTEZAfJTTpA58Hv6KwQp8DPQvsjjPFaue5CKpDtOLs9Bh0U7FeSsVVY0z1Tj2985w9
    aLCLbEOZ6SzDhuLpu3qm3BS2aAOzRx4SSDTDWaZoBOkeFF9Rhh5YshLGsluhtZE75eRbfR
    nl5Weq/Rgx5O+PIjAonNwoqoWHXFTvm/sWYqj/CU/ZYlQHI6Kpxx4mTD4d+oV0sQRwLYWj
    orAd90bMg3K0q3/ydlOGvLfQAu5UUsXtknSpSMuRD52afd6Tk/WIP/txJ0MCc8lpP5KHTU
    MwLJL+u0vldOtgxdSfc4PdmL35vqIMv3JgJiwnFg3FjRLFXz6pphEDDsnZTuvFQMT0OCTU
    yuLcagqpItGaBRirj5Ll2UME+0jBn9Qy6PHCT7WML8t/jmYM8mhhtk4zK7QLMPuxT40/Lc
    WM+y7WktfqoRAkS1tvGLicNNWLLJzm0ni5AM5i0o5O/41sQlwK6Os9d+o75zCIF9xGbcQB
    0bchYrinUUGUJ17ETLCzcSOOs4wkmCSE2qEmv9BdlP01zzMwCjTQkkrqBs6xreb+qhKknN
    W6zy2CofOa91j1ID2JMRvcXuJciZF6tDOyydqIgKmj3fFFMypYTmiyXF3mbTDLwFW8ahfP
    5cv0sxFvItGmi3C+H9zGhjFPcC/tHcZJCayPqJRSNWgG/4lQVspBK87cJMhw
X-ME-Proxy: <xmx:7pdFankM8Ojj0B2RJrdJL0h84b4A-99WEc9pxSNhhtI71f1LM-8rdA>
    <xmx:7pdFajRguY-hfcvB422baKIkQXIiyHS3iCUyS1YE2PKBtUb7lasu7w>
    <xmx:7pdFauEdOmqvykwe688TH2ETENcn4DpYyo7updXuLL_B5xpXl0Wrrw>
    <xmx:7pdFagGueIGd8u7fogfYt6tb1m1rMur7xrjYUnkO9SVxl9QJzhZDOw>
    <xmx:75dFalR0k7nRF3n2qiXIQrrrWswr5hxhQ5JEiE7gLi18CwLoCHO773sR>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 18:42:52 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "Jori Koolstra" <jkoolstra@xs4all.nl>, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fixup: Remove excl arg to ->create inode_operation
In-reply-to: <20260701-zahnfleisch-manisch-chiffrieren-266179f4694c@brauner>
References: <178290671516.27465.15984496764174914338@noble.neil.brown.name>
  <20260701-zahnfleisch-manisch-chiffrieren-266179f4694c@brauner>
Date: Thu, 02 Jul 2026 08:42:50 +1000
Message-id: <178294577084.27465.9288356265750603629@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>


From: NeilBrown <neil@brown.name>

Remove mention of the excl arg from some documentation that was missed
in the first patch.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/locking.rst | 2 +-
 Documentation/filesystems/vfs.rst     | 2 +-
 fs/gfs2/inode.c                       | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystem=
s/locking.rst
index 08d01bc62c31..c274c5eef733 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -61,7 +61,7 @@ inode_operations
=20
 prototypes::
=20
-	int (*create) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t, =
bool);
+	int (*create) (struct mnt_idmap *, struct inode *,struct dentry *,umode_t);
 	struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
 	int (*link) (struct dentry *,struct inode *,struct dentry *);
 	int (*unlink) (struct inode *,struct dentry *);
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vf=
s.rst
index 7c753148af88..651b83b00440 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -415,7 +415,7 @@ As of kernel 2.6.22, the following members are defined:
 .. code-block:: c
=20
 	struct inode_operations {
-		int (*create) (struct mnt_idmap *, struct inode *,struct dentry *, umode_t=
, bool);
+		int (*create) (struct mnt_idmap *, struct inode *,struct dentry *, umode_t=
);
 		struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
 		int (*link) (struct dentry *,struct inode *,struct dentry *);
 		int (*unlink) (struct inode *,struct dentry *);
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 9e23c8d55962..17bfa283b320 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -963,7 +963,6 @@ static int gfs2_create_inode(struct inode *dir, struct de=
ntry *dentry,
  * @dir: The directory in which to create the file
  * @dentry: The dentry of the new file
  * @mode: The mode of the new file
- * @excl: Force fail if inode exists
  *
  * Returns: errno
  */
--=20
2.50.0.107.gf914562f5916.dirty


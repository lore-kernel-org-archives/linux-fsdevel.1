Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4344E3EA973
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 11:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782990958; cv=none; b=gFBQ+6ZySeIuuKE+EpgMEQj2UzImpd2S8OVzEmIpUKcOZpfYMz9Y7NqdWAY9JyFaRpiQlCrUxfxtoBtSywBQtdLHk3XeYPKrjgu/KZAgyuZZYyMfPbXTSkXZCos/Cq6cYhP797+RIpGcxZKv5d0cZXMj8TGrnIqAARBXFlLsSlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782990958; c=relaxed/simple;
	bh=9Shl9eQkbfR/Gxd0RH0fUUw+bCT5mPwD0tFe0fAitvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoW2Aun1Y34rbNmU2ZtZPAFxceNDTVhpjngy4ZcoQWgVJ+7cNHvh1o1mmPn/UxEZZlSGMBmYgeLYXhLIB3JYct6ObQ97QKnZ9nSl6Pv+FJX7bIZxmIhR3hPXhTlBrJp2HEywGznVXDEl/LduKvCFjig1opznfZeb4SUM4ZpybfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=PAqCJvGS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a3jM2hdA; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="PAqCJvGS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a3jM2hdA"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9A6C8140021D;
	Thu,  2 Jul 2026 07:15:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 02 Jul 2026 07:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1782990956;
	 x=1783077356; bh=KlyDeL9KYjJ1VBmZO/ntGu8F7AZTk4TY1SoY2h0aTsE=; b=
	PAqCJvGSj5/9kjNl+nCVyBMNC4hv/iti6IHGOhCTSR1EDe58R6Ql0L1HNvWCOhTh
	kVbHaaFo2jONHny4a5EqdeeYGk7j3D85x1jOUKtF2nWdU4+3eBKzcCDzFeup3Fpf
	V6n7x5r2X/dCtEavUnRgjKPiHaoqJU3NkXWXoAudu3MPfekJecDoaNeaWdyd7CUY
	qv5HvybJuxiiJPx1GxP2aLsi9hOxPI4wRxyt+PLQzG9h0KuAKv877qHC3VgVKu50
	RbWmEd0pjtxP443Kq2rl+bEBGz3n6joLONrpUY4aXZsUQ2bHhmAgM2/ljAng2raL
	/yD9ZSR0K86KvtPys3265A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1782990956; x=1783077356; bh=K
	lyDeL9KYjJ1VBmZO/ntGu8F7AZTk4TY1SoY2h0aTsE=; b=a3jM2hdAGjUPUkzr2
	DjxLZdUOzo9/+INdy81WCL1puapRnZ2qnaxB2MbmXVPIU6f9A9Zsw12HvR+oyT1X
	x5KJ/WkRj9X5bosbRu3Ldf0GmBkbDwpZ1wlUs/+vgzFH7TNCWmWpW/zeDngdJnA9
	XGPg+6wyJp6ZSafqaY1L7fvyN42bgsZoUFfieC3S/Bffa0/gq6rh3wEAbvQfpMNe
	hnd+gybbHNJ/hpOEWtB87Yeex7eJLxl/G5MhQoQztSSsQibOWeSZ2u0KzD5UOgP3
	OzhraKQD8koXAIQAv42HSBIU6Bc7ELPkt3ETxoiKC6f1+Dc7Pyy7piUbIbH5aKSr
	qa1pA==
X-ME-Sender: <xms:bEhGalkh9MrNo4SBzdmJKoLINew8zlTZO4GnG0bjag4Rp4GudEQ48g>
    <xme:bEhGapyC8K9HClSH5tscFAV8QOuJMJaTO_bP-kiHyd_heu1y0CksjimPQhOWiaqP6
    m7u3Es3CymqziP9bhGLJELuK7K3r9Jpmejz22bx9Re3qkRdVA>
X-ME-Received: <xmr:bEhGanMMyQT3GQ0PUgh8PfqvoxqQHowdnFls-uKR8xS0oTL3axaYwUljs2VwgFOdh7dcjO9Bp5B_ipOV9KwaUoF2LIaZBsY>
X-ME-Proxy-Cause: dmFkZTGMTUCV519fMcyG+v+a8zsTTzY5NPtMnp/53bj8T/yxuJ7F0NzQx7+PNzUGvUx7u9
    ofjerIewE1jsmS1O/XsaHGjEWB2LzXzuRIs7xWkTQxLVXnswpEo438zH25GMC7eElJsgt1
    8BWB90VNK6roJIgsK+ePpXeNOIFwd2zfZLlIGZDisnNw92Ovs/2zWqO+4yx9+7VmjM/0MG
    j2ej8xqVW3F39qAIEbNKaUlt2UEHestQAKx2xK45ZYPBh8mttXZ34IS+Ah4YY7KsGZviAe
    hzk4Z+DSnu2xxK50uTGFFHlCLZ4RCitx4YWntO3QnPJhkQflUHQrU27Pxij20tyKFYRkJM
    eqyTn2ga225q5IK/C7rKH6YJxanIn7M+uMdiNpeKQWdwK7EDwm+PXqfr7qybSCcEGNrkCQ
    ycBXhi+ekY3S+GhGaO8RBBSb3rZGlFaxnyztaq0bu31aStNl0G+E7Sqq6qqK+IqHnyqPwZ
    rZNICVeWRfh9kRDf+LQSo3AXBzumc7Ay6qB0lUuwEzyHejjYr/hajaJ2JY0e00Rf9+EkQX
    VNGRQpbj8NGNXYljIrXs5HBHO6uecRh0dz1dG2bXkO3FTLTDeksLc2gjyHI2XV1onqK3I4
    1O1JirkdtJWXHXjX0+pvruryLP85GeuSVtdHHuPgW2OuXPO+572JtG6O3NTQ
X-ME-Proxy: <xmx:bEhGalrgPtaL4e8QGaWEs8i95ouQ6L3vycWjHjWeT7RRBGcw609Bzg>
    <xmx:bEhGagG9Ed6w_heRpM7KuumWsTaqv1nyV8XWnJOT3Fw1kQRwJ40afg>
    <xmx:bEhGairPNXw8gqVRIL_EsSBfugkx0eJHWC23SqUABBv6P9vfZB1p8Q>
    <xmx:bEhGahbANgj8wNRD8xtHsSg9DKV3u_dR8PWZRQYVcLfX1p6I6Uo8cw>
    <xmx:bEhGaqyhh59oddpdTR7A6tu5m0LT4ujO-6Vdit7bqxOwlwRFbSaw6uuG>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 07:15:54 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH 3/3] VFS: add vfs_lookup_open()
Date: Thu,  2 Jul 2026 21:09:21 +1000
Message-ID: <20260702111529.3559835-4-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260702111529.3559835-1-neilb@ownmail.net>
References: <[PATCH 0/3] VFS: replace dentry_create>
 <20260702111529.3559835-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

vfs_lookup_open() is a limited version of lookup_open() which is
exported for nfsd to use - to replace dentry_create().

It is limited in that no filename is given (thus no auditing) and no
LOOKUP_ flags are passed.  A few "intent" LOOKUP flags are deduced from
the open flags.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c            | 59 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/namei.h |  3 +++
 2 files changed, 62 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index cb33a01d16eb..737c4b2422dc 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4562,6 +4562,65 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	goto out;
 }
 
+/**
+ * vfs_lookup_open - open and possibly create a regular file
+ * @parent: directory to contain file
+ * @last: final component of file name
+ * @open_flag: O_flags
+ * @mode: initial permissions for file
+ *
+ * Open a file after lookup and/or create.  This provides similar
+ * functionality open_last_lookups() for in-kernel users, particularly
+ * nfsd.
+ * It uses ->atomic_open or ->lookup / ->create / ->open as appropriate.
+ *
+ * Returns: the opened struct file, or an error.
+ */
+struct file *vfs_lookup_open(struct path *parent, struct qstr *last,
+			     int open_flag, umode_t mode)
+{
+	struct file *file __free(fput) = NULL;
+	struct nameidata nd = {};
+	struct open_flags op = {};
+	struct dentry *dentry;
+	int error = 0;
+
+	error = lookup_noperm_common(last, parent->dentry);
+	if (error)
+		return ERR_PTR(error);
+
+	file = alloc_empty_file(open_flag, current_cred());
+	if (IS_ERR(file))
+		return file;
+
+	nd.path = *parent;
+	nd.last = *last;
+	nd.flags = LOOKUP_OPEN;
+	if (open_flag & O_CREAT) {
+		nd.flags |= LOOKUP_CREATE;
+		if (open_flag & O_EXCL)
+			nd.flags |= LOOKUP_EXCL;
+	}
+	op.open_flag = open_flag;
+	op.mode = S_IFREG | mode;
+	dentry = lookup_open(&nd, file, &op);
+
+	if (IS_ERR(dentry))
+		return ERR_CAST(dentry);
+
+	if (d_really_is_negative(dentry)) {
+		error = -ENOENT;
+	} else if (!(file->f_mode & FMODE_OPENED)) {
+		nd.path.dentry = dentry;
+		error = vfs_open(&nd.path, file);
+	}
+	dput(dentry);
+
+	if (error)
+		return ERR_PTR(error);
+	return no_free_ptr(file);
+}
+
 static inline bool trailing_slashes(struct nameidata *nd)
 {
 	return (bool)nd->last.name[nd->last.len];
diff --git a/include/linux/namei.h b/include/linux/namei.h
index ebe6e29f7e93..86d657b24fc6 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -97,6 +97,9 @@ struct dentry *start_creating_dentry(struct dentry *parent,
 struct dentry *start_removing_dentry(struct dentry *parent,
 				     struct dentry *child);
 
+struct file *vfs_lookup_open(struct path *parent, struct qstr *last,
+			     int open_flag, umode_t mode);
+
 /* end_creating - finish action started with start_creating
  * @child: dentry returned by start_creating() or vfs_mkdir()
  *
-- 
2.50.0.107.gf914562f5916.dirty


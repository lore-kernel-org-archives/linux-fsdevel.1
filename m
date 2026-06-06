Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B9730F52B
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 06:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780728605; cv=none; b=KqiUX3Urp2+eSwVoynjtfJsUBL3nsAXUQJKIgNzvSNhSTib9iVPfTI7T6+PzVVLxdr9mBYOYALSvYs4oJ00gb6hBd/JouTcXNfgI6eTbb2BNkkx/tf6p86CrBweW9i66nsJfE6aF8q1G3vdDXcPMfzeuDg7qlGHTJFN5n+u+meI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780728605; c=relaxed/simple;
	bh=6yeTATCCCg0VVMOWYBLSkYGle7rdlGF4tDmxjAT+Eq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=objqT5OhjBTLP1HJeqgsvZ93ncIZWfRQbFlr/TtEyRHOh8hATEuWvElj1eqTyDpvFZcaoxS9A0UvSSrwFTd6Sv1rcjXMCRL7WzbEnimhDQEfRZdJu5RDsfyqj1knbUMamhzE9ep7tuEKnyWbJ6sLGn/nFPzr+xKZjjqy4NIjsik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=StJGZrCL; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="StJGZrCL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=KV/5jXS0HvKVgQT8rChu/MCfE0HNhpZdvG68MIPqSp4=; b=StJGZrCL/YsjsNPYlCqRL0V2dU
	hzqU1U7lflckbYP6vYiSXYRUohs7OCEwzK4IfwzWkRkGLwDFtP/MCs4bvSLCd+V+Elnc9y2Zavs8d
	+LQuyL5Q8gvIkzWE17vhrpi9/eoLGzKpwdo/52qchDyjqiGrt60MhfT6OLcR/EvHdpnOi/6pm9xn/
	GGKDZpVfZyqyzADhLYDGDRGBb+tvAB47O91pAHWLibVn3TWmCMsy3iYWfW1Cucgca9YpMjhlLMuVO
	7oncRlmNTclgk9cNN6e+VnOOUu/lcreyllAtm13KsI0AP83cDxmfVKptIvKtkK6Af6TKClhaJea4s
	84mNIUHQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVkr0-0000000BQMQ-2v9k;
	Sat, 06 Jun 2026 06:49:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Tyler Hicks <code@tyhicks.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 6/6] gfs2: use d_splice_alias() for ->lookup() return value
Date: Sat,  6 Jun 2026 07:49:56 +0100
Message-ID: <20260606064956.2722874-7-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606064956.2722874-1-viro@zeniv.linux.org.uk>
References: <20260606064956.2722874-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/gfs2/inode.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index e9bf4879c07f..6a3581e3ba93 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -987,12 +987,8 @@ static struct dentry *__gfs2_lookup(struct inode *dir, struct dentry *dentry,
 	int error;
 
 	inode = gfs2_lookupi(dir, &dentry->d_name, 0);
-	if (inode == NULL) {
-		d_add(dentry, NULL);
-		return NULL;
-	}
-	if (IS_ERR(inode))
-		return ERR_CAST(inode);
+	if (inode == NULL || IS_ERR(inode))
+		return d_splice_alias(inode, dentry);
 
 	gl = GFS2_I(inode)->i_gl;
 	error = gfs2_glock_nq_init(gl, LM_ST_SHARED, LM_FLAG_ANY, &gh);
-- 
2.47.3


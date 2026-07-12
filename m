Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A684F35DA43
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jul 2026 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783878900; cv=none; b=Hu6UmcwxqkI8SZs0Zan/9IhZzOnnZjOYGFpG5p8A2oUWaK3fH2SUploBeN25a/zM9kLj0UYQ9mLsaxzmydCztmUsOCh04DaAAleF5VoT4vIhhVa4Ivs7sFDgoPbhzlTLaFAr6IbYXIgn9weoFh1VFPTAa+S0vnf3Uf4eSxUCMWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783878900; c=relaxed/simple;
	bh=u1sAIzE3h5PUzpTIElcpRCWWZ35nIPz4LbFFTOiI0Zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWI/CUlnlWp0T5Dm5D5ZysmnamI0BK0E5izxUVr1HB7qO/g3Ul1l6YB75NzDdnn6OYTkagmSgAgiMTbo2su6BrW7EOL1d2lWOAOp3/6n/HjLH2ODDoLFVRCpcxOVLFJwVIRlaHJyc7bNQtYKzYcaqniVqLhHWNUiPMsuxEEcQR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=e+P5PPnV; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="e+P5PPnV"
X-KPN-MessageId: ca5380bb-7e1a-11f1-bfba-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id ca5380bb-7e1a-11f1-bfba-00505699b430;
	Sun, 12 Jul 2026 19:54:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=fj65mfPONwi6t8foTt9z20F0U/WrZ8/1TJPyfzE1ABI=;
	b=e+P5PPnV4JALj5a3M4UjASFdcS9dUnAMcNgCWYueDv2e1jxvvCB+CikPyzKBLWApL9QiPAgWVfW3n
	 SoN7l5hV8Lzai4YxTzfeo3UGedA7Mkr+ZJ6+CTR0lWPbmkfdnjYI9mXLdpHTdMQ9WOatcqbBGe8iRM
	 V7waLD1gQPKb/RfnzR3qcsW7f8tg/hWhEN1aMMwBLMcze9NQ5GRQn4TrjiKvgKwl6UHBTWLkSoSaSs
	 ANFZwoaZ2fgVhEsVazVG34S1ZkdzAijhFIRnCvP6LfDk79AFU6pGNBYQ+CwEXvqzA/CKOfFkoJvfFj
	 nnC6/RpxzetS4o/fR1k2eCTsjl6Ecxw==
X-KPN-MID: 33|LyvFpbhfi1v5vz2XnhumPU3FSM/IeDFYQhkXJ6Vpdw5ConZBZLD53GzXk6Rnzi/
 WM2zo3QFFOQKBUmGPAI6AVKvab45pKOrLChDxr3HUuKQ=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|3K4Py3rfcoKEJY202Gyeo26/dkWbX/yq6WSLqwkx6KLZWXS8OeDdJBPzynsa5X3
 t2mBtU4J0fNTZD2JFROlEzw==
Received: from daedalus.home (unknown [178.230.226.124])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id ca243084-7e1a-11f1-87f7-00505699b758;
	Sun, 12 Jul 2026 19:54:55 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	NeilBrown <neil@brown.name>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH 03/10] vfs: lookup_open(): move setting FMODE_CREATED down
Date: Sun, 12 Jul 2026 19:55:32 +0200
Message-ID: <20260712175539.1565444-4-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260712175539.1565444-1-jkoolstra@xs4all.nl>
References: <20260712175539.1565444-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for using vfs_create_no_perm() in lookup_open() we need
to move setting FMODE_CREATED on the file mode to either before or after
that call, as currently it is in the middle. If try_break_deleg() fails
it is currently not set, but vfs_create_no_perm() includes a
try_break_deleg().

Going up the call chain of lookup_open() we see that it is only used in
open_last_lookups() if no error is returned from lookup_open(), so we
can safely move it to after the filesystem create() call. This also
makes more sense when reading the code as you don't have to wonder what
the implications are of setting FMODE_CREATED before the create() call.

Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 48ceac6e8848..a43e64717d11 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4525,7 +4525,6 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		if (error)
 			goto out_dput;
 
-		file->f_mode |= FMODE_CREATED;
 		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
 		if (!dir_inode->i_op->create) {
 			error = -EACCES;
@@ -4538,11 +4537,13 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 			goto out_dput;
 
 		fsnotify_create(dir_inode, dentry);
+		file->f_mode |= FMODE_CREATED;
 	}
 	if (unlikely(create_error) && !dentry->d_inode) {
 		error = create_error;
 		goto out_dput;
 	}
+
 	return dentry;
 
 out_dput:
-- 
2.55.0


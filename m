Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D35C351C35;
	Wed, 29 Apr 2026 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473217; cv=none; b=rsBYKrUkPilqEBNe0NOQV9qu5tZmgL3kXB75StmAQixjQnlN25kVn8wwA1s1EwGgfFiEtETP1HOQN/3Xzb1mRX0PCBBwcQ65KFzz/8x0P9kyF7zVEPL9pkCg3jF8xeqFzhn+fPEnN1Mv6xPMJk74O3He79GQ24txTWyQvpIcFYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473217; c=relaxed/simple;
	bh=hZZ0Nqf3pc2crIGZaHibR4tu96NpNUTg1wVtR82zV8o=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D7tgsaOl0uhw2YO2Uzl0r2m0d6Tj/l5lXOE701DKEEiitohAuEcfUOI33adaY8Eu0/jFlnfzzye3CWnRfL+2IvgwEVSh33mpiI/YZX3OJ53uFqeK7HjNb3T3NMRzjRnRxLD8nI0l5h75EF9WsBQHhxXApPfPMf5eDwoIMWlBwgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+/ixbb9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+/ixbb9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1692C19425;
	Wed, 29 Apr 2026 14:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473216;
	bh=hZZ0Nqf3pc2crIGZaHibR4tu96NpNUTg1wVtR82zV8o=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Z+/ixbb9uAJgbVD0MC6uVrCORPRZAM5M0flpikkz+UeBgpXc/ESVEM6tOIfIPaaDA
	 6d6/WIdQTGzVs5v3KDKT3l9dpxTyEGzpcyqN3XEOERR8/3jw3zNjnY3Li0g7edUuH1
	 gx9KtGOW5u44EyY0a4s0+VBUJcFAMM7bz+bpBjvej4hLDm6Y6lQvVRK+z7xCcQ+wCQ
	 l36PwWVxctmYCG7mtzD2X5SrecTnFndLhShr0ilWh/4n4uQZoVSmbDGG83FkCEE43Q
	 P95MB5nD65+TTo6G4I+CVE+pTHoA5VPMpJN0Qed40URf73YQ4DIiPtBa+i0wIN79cl
	 7OPG28o/mTCYw==
Date: Wed, 29 Apr 2026 07:33:36 -0700
Subject: [PATCH 2/9] fuse: force a ctime update after a fileattr_set call when
 in iomap mode
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747206531.4103309.3952036264187137944.stgit@frogsfrogsfrogs>
In-Reply-To: <177747206436.4103309.9048553717124547447.stgit@frogsfrogsfrogs>
References: <177747206436.4103309.9048553717124547447.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

In iomap mode, the kernel is in charge of driving ctime updates to
the fuse server and ignores updates coming from the fuse server.
Therefore, when someone calls fileattr_set to change file attributes, we
must force a ctime update.

Found by generic/277.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/ioctl.c |   11 +++++++++++
 1 file changed, 11 insertions(+)


diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index fdc175e93f7474..07529db21fb781 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -546,8 +546,13 @@ int fuse_fileattr_set(struct mnt_idmap *idmap,
 	struct fuse_file *ff;
 	unsigned int flags = fa->flags;
 	struct fsxattr xfa;
+	struct file_kattr old_ma = { };
+	bool is_wb = (fuse_get_cache_mask(inode) & STATX_CTIME);
 	int err;
 
+	if (is_wb)
+		vfs_fileattr_get(dentry, &old_ma);
+
 	ff = fuse_priv_ioctl_prepare(inode);
 	if (IS_ERR(ff))
 		return PTR_ERR(ff);
@@ -571,6 +576,12 @@ int fuse_fileattr_set(struct mnt_idmap *idmap,
 
 cleanup:
 	fuse_priv_ioctl_cleanup(inode, ff);
+	/*
+	 * If we cache ctime updates and the fileattr changed, then force a
+	 * ctime update.
+	 */
+	if (is_wb && memcmp(&old_ma, fa, sizeof(old_ma)))
+		fuse_update_ctime(inode);
 
 	return err;
 }


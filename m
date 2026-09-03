Received: from mta1.migadu.com (out-160.mta1.migadu.com [95.215.58.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF1E3F54D2
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2026 06:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788417922; cv=none; b=qR6oZ02lhsLGDQMOJADFV46sFRFPOX0FwPeJfYII2KryT3zTtGuNYGN42l69LcGiHHRAuFSCQFHMmuPX5KTBbg1OMTohc5NJ6Sjs8GBQhn1cgZc/9QvUNvGsxIZzSJSnHGh/apgsDYHLrGHuEk8HoGA4ILNzbCtxfpMeWCaeqUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788417922; c=relaxed/simple;
	bh=NcgsQkL++YGnbd7TXEBQmukOQ23cANjg8v+rYDuUlos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bPqql5M6R9uGmi/OOvgEXflLB81s14XlHKPcd4FAYg8N9YA+HQzZlJck5aYjkdqJ/AXJMY7RdbMBCsMPeQVZ2BrioJfiTVCQUfz4n3Od/PfQig4ZuInfksZ924v3XnIiu1ZJ05LC0+DtHBZqLaug8T+zIdka5eiSjTARrLOMkww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bnTSn2un; arc=none smtp.client-ip=95.215.58.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bnTSn2un"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NcgsQkL++YGnbd7TXEBQmukOQ23cANjg8v+rYDuUlos=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788417916; v=1; x=1789022716;
 b=bnTSn2un8fGjzVlusfJ2JjNss+kBp36opyOZa+3+bD4CUBxVo1l6d3fPZqs/5M4FSkILzAvJ
 Q+HeR5/+E0pDwMJV1RS0UNSQieteyDIFyzdSf9Intu0sBdD5Z4F/aJzku9YAskaEYdLMOs6ko1X
 LTjr8vol4xS3v2Tyqzx05tvE=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 232c423d1b9db787;
	Thu, 03 Sep 2026 06:45:16 +0000
X-Mizu-Trace-ID: 232c423d1b9db787
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: linux-unionfs@vger.kernel.org,
	miklos@szeredi.hu,
	amir73il@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH] ovl: reject verity= together with userxattr
Date: Thu,  3 Sep 2026 14:45:03 +0800
Message-ID: <20260903064504.1052841-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

userxattr forces metacopy off, and copy-up only computes and stores
the verity digest for metacopy inodes.  With "userxattr,verity=on"
(or verity=require) the mount succeeds, verity is advertised in
mountinfo, but no digest is ever generated and no lowerdata is ever
verified - the option silently does nothing:

  $ mount -t overlay ovl -o lowerdir=$l,upperdir=$u,workdir=$w,userxattr,verity=on /mnt
  (mount succeeds; after copy-up the upper inode carries only the
   origin xattr, no metacopy xattr, no digest)

Follow the existing pattern for redirect_dir/metacopy and reject the
explicit combination at parse time:

  $ mount -t overlay ovl -o lowerdir=$l,upperdir=$u,workdir=$w,userxattr,verity=on /mnt
  mount: /mnt: wrong fs type, bad option, bad superblock...
  overlayfs: conflicting options: userxattr,verity=on

This does not affect per-file fs-verity on the lower layers used
together with userxattr (e.g. fstests overlay/089): it only concerns
the verity= mount option, whose copy-up digest semantics cannot be
honored when userxattr forces metacopy off.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 fs/overlayfs/params.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index c93fcaa45d4a..29dfc16fecc9 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -997,6 +997,11 @@ int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
 			pr_err("conflicting options: userxattr,metacopy=on\n");
 			return -EINVAL;
 		}
+		if (config->verity_mode) {
+			pr_err("conflicting options: userxattr,verity=%s\n",
+			       ovl_verity_mode(config));
+			return -EINVAL;
+		}
 		/*
 		 * Silently disable default setting of redirect and metacopy.
 		 * This shall be the default in the future as well: these
-- 
2.43.0


Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BFD411674
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816889; cv=none; b=tTqdga0buAHhJNE3smuRGeOR2OwRETvrwtS8Atxc3PpDZMpOQZxWlKTrdrAUzOCgA3e2TSOTrXgNZ2oDPtqV7avzURfODwfvhK3Q0mgdpeLRGsq9TLDZjQJi4vXMCnL1IaguQnJV+dv/CxPTTnqC6kd/mWafwwc9PRRZ91os/cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816889; c=relaxed/simple;
	bh=Ek2HXrFTribJUGtQMaDUiihEAJM9dZhSWkHgw1Krz/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Znn7tctwpIFhCZbcOnhnDvFo8R79RpEw4UmdxKk86SUwiNQrCpLAOwj1e/hVh4BeLi2MgzLTp3owbphs5x7F9zTCFVPjRnRvcz87vijpA9cyQWbqGovDjXtijE/IFT0VLob0x71oIOJw43nHaWfqqVXgzw0yZyH9Ou86o13RbvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=tub4okTd; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="tub4okTd"
X-KPN-MessageId: 1b9ed0f7-7472-11f1-a055-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 1b9ed0f7-7472-11f1-a055-005056abad63;
	Tue, 30 Jun 2026 12:54:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=d+1+bL9caQ/HafZFUo5eK9NFX+r0gAVB0ZEzzI9NQZQ=;
	b=tub4okTdeoFctxYAoaI+kibTVafzKbzoG4Zwz6ldguUahrrAxX4IrWbDIIojaEIYPjJCFN3ANHmUQ
	 jZN3bkmCsofRyF+nb8B2JK3IViyEcFfmdLrdrkfHNaghnrek1F4cqkC2HBzO5lxK1nU0LlnFjV0uz5
	 KeFKYdc0/fRT2cojrNh58N4WvclycYRJT0Yf2JjkXgimGbA5/HR2Yvh7OPOeGQYsYem2WCEE43ci8p
	 1YdcZrRLWKo/O3fsY93dsH5VRnso+BaT7lxPRDVA/0THS+S+MibzSPV/DgE/pBxtIQV50+HV0R54Wn
	 EyoDcj8QipsW7IZDaiN4DH26F8EAKwQ==
X-KPN-MID: 33|Y6hGCqH7YxUbwkmRKJSjefpOnmWNci7hBWpQn3wk0hbw+GmZzuFTAxD3vAidwu0
 NV62X3u24FVUCXhlpGX6pYjDiategkCVt0vU9TKcCtEY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Dj5uwf+v8mrWOPVBbqMW8HV5RfCvkPot+YWCdiXcLYG/M5fc9I1Mexak8zqOA3F
 8iMGXJQm9FvBYAXoWLeUL7w==
Received: from lt-jori.home (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 1b7d12de-7472-11f1-91b9-005056ab1411;
	Tue, 30 Jun 2026 12:54:46 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 27/31] ufs: drop redundant S_IFDIR from mkdir
Date: Tue, 30 Jun 2026 12:53:56 +0200
Message-ID: <20260630105400.68459-28-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630105400.68459-1-jkoolstra@xs4all.nl>
References: <20260630105400.68459-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vfs_mkdir() now sets the S_IFDIR type bit in the mode it passes to
->mkdir(), so OR-ing S_IFDIR into the mode again in ufs_mkdir() is
redundant. Drop it.

Assisted-by: Claude Opus 4.8 (1M context)
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/ufs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
index 5b3c85c93242..718e96506532 100644
--- a/fs/ufs/namei.c
+++ b/fs/ufs/namei.c
@@ -174,7 +174,7 @@ static struct dentry *ufs_mkdir(struct mnt_idmap * idmap, struct inode * dir,
 
 	inode_inc_link_count(dir);
 
-	inode = ufs_new_inode(dir, S_IFDIR|mode);
+	inode = ufs_new_inode(dir, mode);
 	err = PTR_ERR(inode);
 	if (IS_ERR(inode))
 		goto out_dir;
-- 
2.54.0


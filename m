Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A9C370D4D
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jul 2026 17:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783878904; cv=none; b=ult7HaE4U6I961E1fGxKwOJQQTLaNX0tOM+3eMnuC1WvPgQOhM/WplCIx8dwtEGjAHwmZyLrLMR6I87vEMTE5feM9IOutrdZb9upWTqcRoASTtHr4zMIgH4Yw5PcvPCtYSYxqMdptzBOkE10dNwi+cPakaXNXM44yUN+/vNmn3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783878904; c=relaxed/simple;
	bh=B/ssqFivUuScnRyl1antmB5qUnloF8uykezthK1XEAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OxrrB5wmAVyub0DNutMVJ0EdrpUm5QyPTa2PY0AFBuskHIvXGZVy4WNi2GjggN4WSW56PutZuZsT+Q6cjgfyLFElvHTaWX8K/fUJdidXMvQ58qphIrKS0qER8sfmWM5OIs79ylDgxtnBExzvoqiKSkRlAaJEpObfAUqISGgW/uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=WnW9PB9E; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="WnW9PB9E"
X-KPN-MessageId: cdb89ecb-7e1a-11f1-bfba-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id cdb89ecb-7e1a-11f1-bfba-00505699b430;
	Sun, 12 Jul 2026 19:55:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=6ER9B9mqi/tHGjhbZgfWDC1U1E3LU23q26LPDnjE9Ss=;
	b=WnW9PB9EDBVIbd0jz+N+CVleUzBOWuylHPaO+daMTMKF4YHfJP9O2A6bPWPpZNOTatG9eFlLubmZz
	 +BO3Qh4x/YFvLbTxXvD+pjj3MOxvACiba6CdOtPxDMnqx6fOxLxl1/W5guE+xKzKFFBArm2qN9KAlf
	 3mNFSRA42ZdlIYshHvPw2Cp/v91zn9RFw8mybjUQ/7cPCjy06FlXmUK9j4ikJk/+ZUwYxhEqzzLP7c
	 MbWub036ZastQ6scXIpP6ylvCg+CcMlvLYk6KNaDz0t+N9m+wUsn3bqRmlr0FvrvIUWZff64wcWcxX
	 FDoz4liQYuauFu6yf1oVK8ln56QIieQ==
X-KPN-MID: 33|FVK+vc0Vy30CdWdPkqReXYKRZDzzaQU+1iBFgEnrVsexU6wcf1CZDxXGcYsO9ly
 jlm3SkTBz9ATMuihmFZ5vg5Li1jId9TNpyEQYocc5elY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|feovoX9SMsYrLzaiXyATpJF5uijiqWRS/9kBbAHKbTwaUYkiNBnEOysFLJ8xOQ2
 SDkve/DefN3c0Pq/C04Dqow==
Received: from daedalus.home (unknown [178.230.226.124])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id cd81035e-7e1a-11f1-87f7-00505699b758;
	Sun, 12 Jul 2026 19:55:00 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	NeilBrown <neil@brown.name>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH 08/10] vfs: refuse O_CREAT for directories through a dangling symlink
Date: Sun, 12 Jul 2026 19:55:37 +0200
Message-ID: <20260712175539.1565444-9-jkoolstra@xs4all.nl>
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

open(O_CREAT) without O_EXCL follows a trailing symlink and, when the
symlink target does not exist, creates it. Refuse to create through a
dangling symlink for directories.

In lookup_open() a negative target reached with nd->depth > 0 was
arrived at by following a trailing symlink; since the dentry is negative
the symlink is dangling. Set create_error to -EEXIST in that case
(matching the errno returned by mkdir(2).) Reusing the existing
create_error path strips O_CREAT for both the generic and
->atomic_open create paths and only reports the error when the target is
actually negative. Thus opening an existing target through a symlink,
interior symlinks, and O_EXCL (which never follows the trailing link)
are all unaffected.

Suggested-by: Christian Brauner (Amutable) <brauner@kernel.org>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index ffc63a6960f9..7d2f49b59b5c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4532,6 +4532,11 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 						    dentry, open_flag, mode);
 		else
 			create_error = -EROFS;
+		/* Refuse to create a directory through a dangling (trailing)
+		 * symlink. For regular files this has been allowed historically
+		 * on O_CREAT without O_EXCL. */
+		if (unlikely(nd->depth) && create_dir && !create_error)
+			create_error = -EEXIST;
 	}
 	if (create_error)
 		open_flag &= ~O_CREAT;
-- 
2.55.0


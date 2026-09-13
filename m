Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F7F3A4F47
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 18:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789325374; cv=none; b=r2qfPWSvQqujFcJ9c2ZRf/n6DD5LoQBrroObq60QNiWDdsaH1h2veIuDnHDU6A+7G6khWXcuqDxUxZcfX8BYOfVy7t2obD8FV6Gg2xUbvo3rAD1HsREHetvmCIPEnowhdJLM+MaqJEO2QeKCdP+KOZ+KWGhtO3XfX6LSi7gT6Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789325374; c=relaxed/simple;
	bh=C4D1/qb2Wwro6tn+oPvBlRjy4O2Ewb6QU4b5MpGFGls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WaCM+nB0ipO5m0s0zGSVzCSBlsfXTqWW5DjA5K5DD2Yo+UQIv5lJDT5qtdFEGRtuHZ3O2aAUBeGsEq1USuldWm2RBVcd5vDKVD3LXoEXF37UaDAsWrAwKmmqBp9QwINVmpNaKYoSd0zH+JUoIDbAa6O/InhgtCAyYzO8m3PeqHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=kCYtwrau; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="kCYtwrau"
X-KPN-MessageId: d6df4ab4-afa3-11f1-a059-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id d6df4ab4-afa3-11f1-a059-005056abad63;
	Sun, 13 Sep 2026 20:49:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=gaMm1MCPfV8HqhSz+lohLsmVbeKgTk3fNDTF3rakLhw=;
	b=kCYtwrauGLpplkQUiK9AB1g+BvKZJsA4spAumCxeV10qJQ5ns33cok0s4REnkOlf6opjLDYSMxaWY
	 7b9JIh/Mxr+wypZ6+NzC+rqolftBbCozMalBCqXaTAoqFEZE6a7UZzQfbNjRy6mRMb66PRPTh74WAp
	 2kTEkKC2XsjsqFxVlOkY0u3npAtxUoLvAD1pBefccsrB9blkT7yR8+IN69JYU//nnR+iI3FUoSZf5U
	 mv5q1n0+aThhRMrYwtWXDU3r+kplGV7wFHxw2AJyjSdw9dNoUUkNOn54Q0LeD0WAKj8o8wNQTpGR/D
	 WzidNfIuHr6lahgvmT2Zv0KmNIlOGFA==
X-KPN-MID: 33|1jkdTId/MWzF0abILpxJoeOSfNeTOI2S3xbjb8yleOGoGKyIQKgFgju02r44sha
 TfFHl0ewiaJAgFiL/HwUEWd3+Ko0UEhDYARZKAlASBDc=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|89qOjYjq9+hSS5rdYNM3I8MCNUUhxVP6x/QoQdKzLMHmARJqLV9jYi5sMogjveh
 5sYFBP075yu4kG/ZA0/SQ/w==
Received: from daedalus.home (unknown [178.231.250.207])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id d6a4097b-afa3-11f1-bd2b-005056abf0db;
	Sun, 13 Sep 2026 20:49:24 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>,
	NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v6 06/12] vfs: lookup_open(): lock the parent as I_MUTEX_PARENT
Date: Sun, 13 Sep 2026 20:50:10 +0200
Message-ID: <20260913185016.523376-7-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913185016.523376-1-jkoolstra@xs4all.nl>
References: <20260913185016.523376-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lookup_open() takes the parent directory's i_rwsem with inode_lock(),
that is, in the I_MUTEX_NORMAL class, before creating the last
component. Every other VFS path that locks a directory in order to
create something in it goes through start_dirop() and friends, which
use inode_lock_nested(dir, I_MUTEX_PARENT).

Lock the parent as I_MUTEX_PARENT here too, so that lookup_open()
matches the rest of the VFS before it starts calling ->mkdir(), which
until now was only ever reached with the parent held that way.

No functional change intended.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 90c8be0257be..0efd395a1a65 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4482,7 +4482,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		 */
 	}
 	if (open_flag & O_CREAT)
-		inode_lock(dir_inode);
+		inode_lock_nested(dir_inode, I_MUTEX_PARENT);
 	else
 		inode_lock_shared(dir_inode);
 
-- 
2.55.0


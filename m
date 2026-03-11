Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB543921D7;
	Wed, 11 Mar 2026 21:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266233; cv=none; b=S4x3hQCKSB9Dzj+fUVpFSW8MuFVIDz5M+jwergnJEXTAR3OCmDZ4+1ZKrmmKoSlKuH3yVeKy2CN3teCnYDNsC6nKxWyEVJmHtnwg+XXX2kbke4otMxdWfmJETKtChBePBj3mg0yfHJqHzrxpp+ibt1UpQzHCujUFE4WuSAqBVHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266233; c=relaxed/simple;
	bh=kCGkIgebJiB/9uZM7t6zxx/Mm1pOt56U0XKiWKzIPXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HECIrWkgDqwif4JUniWUWvJ5XR2wZ9hCHR/urkRd+iH2k5uVfGbW2WiF0CWj22RdmBaj2le95Y4toVF9EAljpS5p5ZTAX0Rtrnhkgw/sI7yWz9SjHc9+cDVpZrkVXpAMidNvu9Oc4i3JNEfZQO+ygQGnLSZyx0msX+wdY0HW070=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IH+wBB8I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IH+wBB8I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14372C116C6;
	Wed, 11 Mar 2026 21:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773266233;
	bh=kCGkIgebJiB/9uZM7t6zxx/Mm1pOt56U0XKiWKzIPXk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IH+wBB8Ib4O6g8lOeQd6N3JNlsGtOFYS9NPqYT6rk+p/T93lDEM6l1rVhrCqYlqj3
	 9ypTreuUdcgddpT9IdmHCVtAD68BpKrnVC6kYE1VoE8+yTzjzudkpA6MBoJRYBMUAT
	 xPhxfeeTsJjbqlx7CJnRvNWmxmcsJ0+li5gaFXjh/MCXCn7CucSqOTWqErOSMCCNZA
	 ngtP/L7tBqqI52algdoSprCfDzT3/hqS3Fv3fWBtXAOyPBQeiTA0j+Mw33cZVCJPzB
	 U1kIyCxo7e8GtHc8yUngC+Rnq0BVAbNPARotSg9j22AX7zakX4iPavKB/JgciDEsAc
	 fa9OYJnOi3GFg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 11 Mar 2026 22:44:08 +0100
Subject: [PATCH RFC v3 25/26] fs: stop rewriting kthread fs structs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-work-kthread-nullfs-v3-25-3dd2cbe92ad0@kernel.org>
References: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
In-Reply-To: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-9fd7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=672; i=brauner@kernel.org;
 h=from:subject:message-id; bh=kCGkIgebJiB/9uZM7t6zxx/Mm1pOt56U0XKiWKzIPXk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRufPKr5av5ezn/O5fnvt6wOE+fn9kn+q+YmMfXb5KZq
 +Vv3DK17ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIryojw5wmAQU+g9SHV2Qu
 OTK7OZyo2vW24sWTKIOF/DtW/VKR12RkOMz8ukyzKzP7qLiRaFXJxtZjYfXWi8Oy9hwKP7BaLK+
 UDwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Now that we isolated kthreads filesystem state completely from userspace
stop rewriting their state.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fs_struct.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index f44e43ce6d93..2a98cfbedd32 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -61,6 +61,10 @@ void chroot_fs_refs(const struct path *old_root, const struct path *new_root)
 
 	read_lock(&tasklist_lock);
 	for_each_process_thread(g, p) {
+		/* leave kthreads alone */
+		if (p->flags & PF_KTHREAD)
+			continue;
+
 		task_lock(p);
 		fs = p->real_fs;
 		if (fs) {

-- 
2.47.3


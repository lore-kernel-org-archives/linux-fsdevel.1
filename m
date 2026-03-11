Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0B3392815;
	Wed, 11 Mar 2026 21:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266235; cv=none; b=TwFIk5w99iIJwQSdN+eoLp7doftqRvwfLG4zkYaOHXS9mQvIXAZOFsISYmlbv3YGsli4w3+cbM+L4rhfG2PPA10q/scgN3e0AcKUZ/9gf0DHA5JykA16JjbOqCORQuzQNXbZkTxj60JOW+eWaH05fdRU1tkBj1cXCT8tj/8ewSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266235; c=relaxed/simple;
	bh=zpm4hd+wIcjeaifr6xKhl0IkBvsmP9oA9cAqeLdt59o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g3l7xsYI4AcfLxkf4Zgq3R+hhJW6cIGH8o62X5M+vJ8BCm6p7psatA8bhEx2s4Q/YX7Mw8KX7Wnkbsdjzfkg4lkr920p5WLSMYOPJlO9ulcN9VuY8xpdLIFGpmKOaaewLiXRKUKiboKa0A1B7DOj2Qshx9XaxLGcHFq4ne9Nr9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzbhvaS8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzbhvaS8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A30CC4CEF7;
	Wed, 11 Mar 2026 21:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773266235;
	bh=zpm4hd+wIcjeaifr6xKhl0IkBvsmP9oA9cAqeLdt59o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QzbhvaS8OsYWWBU/u8HELtc1386UwtP4FdC0+JzbwciFLlXk/reih9u2mHYQG5E5b
	 bwvYFe/0Ok5VNY7W4y8OyyQAqo0z2E5brbCyi3m9VNHIx0S5m6sqs3vEPW4wOKngwN
	 qxCPfZ7Xw9f4Lp6K3XW4FcvTcPrAOHDl+cSHBFTssSKKT4nUZDvKEBmIswrjHo5gvI
	 0AhTa/Z9MJHyS9egNVRhqd2dJPVgMotgRY8JvDi2yinY94BL7kGjMs43Sp0KmFn62p
	 OuyjbtC+JXkGGjwMr5QnRvrdgtsp6iSWlBOV0uZJibeMkShH/AWfYHyHWdEqiu6urh
	 xy6M8xongzAvw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 11 Mar 2026 22:44:09 +0100
Subject: [PATCH RFC v3 26/26] fs: stop rewriting paths for PF_EXITING |
 PF_DUMPCORE
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-work-kthread-nullfs-v3-26-3dd2cbe92ad0@kernel.org>
References: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
In-Reply-To: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-9fd7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=779; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zpm4hd+wIcjeaifr6xKhl0IkBvsmP9oA9cAqeLdt59o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRufPJr6a9V3trnzyf89/+uO6NNJVlF6pi14CeRyA4lk
 4/KdvNlO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZytY/hn2LPv9ddxqwMq7nU
 G65fsL9zxMxPdutU/y/BVaoxe1b+2c3wT2OnyQIPbWkDhzMhGy7KN17PPbbOoKfZivfu0Rtisy+
 vZwMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

If the task is dead or dumping core stop messing with its fs struct.
There's no point in doing that. Worst case it'll be stuck in a stale
path until it calls exit_fs().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fs_struct.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index 2a98cfbedd32..34699f3b6f88 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -61,8 +61,7 @@ void chroot_fs_refs(const struct path *old_root, const struct path *new_root)
 
 	read_lock(&tasklist_lock);
 	for_each_process_thread(g, p) {
-		/* leave kthreads alone */
-		if (p->flags & PF_KTHREAD)
+		if (p->flags & (PF_KTHREAD | PF_EXITING | PF_DUMPCORE))
 			continue;
 
 		task_lock(p);

-- 
2.47.3


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88CB37417C;
	Wed, 11 Mar 2026 21:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266225; cv=none; b=qjtiYd8uTrkv+ynas5lbzkTOOeKouKlw1hwGpOwBs47gV/UB3qniZcL7LHb1a2Oha4IJKN0xjYbzZ6kUJOOtYMthnuyoLhfTeq+I2vP56ecV8bupxGgQYBcKQWprQHcazMpYawuGqDH+d7siz9iXLlJpkJTLdS/ZR3hm1XSIm68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266225; c=relaxed/simple;
	bh=LEkYCP2B26VM04U/Xfgf30JgLqLChdLWXV57GkA2dNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OKuTEJ8lHnLwE2g+Sam6IuokufWD5TiQvroOdL2DliOvGInpD13zCBMebC7ihserlFCvT51sIVeumqfFEOTkkIRj+YxZMEaUwO0NeMHtEXazBf8hxCHTLI1tTO8drJ1HqbtUJB6dOwVVVk5v8SbEGS+xly4K3kzZDrfa5Dl/RKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKzPHBAT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKzPHBAT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D73C4CEF7;
	Wed, 11 Mar 2026 21:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773266225;
	bh=LEkYCP2B26VM04U/Xfgf30JgLqLChdLWXV57GkA2dNs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AKzPHBATsS/mL4PJnheBXkgfMRwEVUBgU9XYFk2v+qqiFhskqcja0yivodaLiIzvD
	 ZkWBwICPGmTxMtSkDcBOu46t+XeyWK5fZss6w3o8Zk8Gzz0sVbRhNz5omx14WkdRTg
	 Ig4nyleH/C0Hv8/OFJwfuTBPxJtNOa6KHjCsMEayRkbqW4IIthKRi+2ajVPwmYnru7
	 8oqGqXoEzCaIbJFGhSi2Pl4S4nSRv07nQd/ochmmwU9MvDrdl4fMtSanNTYRs6frZD
	 dUo1KBLnymW1sM03Ilw3bMEMciT9RlxJcCEMmrPPs+IhIohIK9x/iBhqf5nW2r2TgX
	 jkJGdNixFXa1g==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 11 Mar 2026 22:44:05 +0100
Subject: [PATCH RFC v3 22/26] devtmpfs: create private mount namespace
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-work-kthread-nullfs-v3-22-3dd2cbe92ad0@kernel.org>
References: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
In-Reply-To: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-9fd7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=792; i=brauner@kernel.org;
 h=from:subject:message-id; bh=LEkYCP2B26VM04U/Xfgf30JgLqLChdLWXV57GkA2dNs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRufPJTScfwXeA+tmr5OFctjcr4hq73h9wuZTz5rT9pz
 fbcJsbVHSUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5v5Dhe4bra/3P3wJ/HXzE
 d2KHctCdCS+2PTdya5w+SaMy/PoDVoZ/Rn0xQbMydT+xXj5vGXm31aDOqpVr+QGdNKcwA3WlPiE
 GAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Kernel threads are located in a completely isolated nullfs mount.
Make it possible for a kthread to create a private mount namespace so it
can mount private filesystem instances. This is only used by devtmpfs.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/base/devtmpfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index b1c4ceb65026..246ac0b331fe 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -413,7 +413,7 @@ static noinline int __init devtmpfs_setup(void *p)
 {
 	int err;
 
-	err = ksys_unshare(CLONE_NEWNS);
+	err = kthread_mntns();
 	if (err)
 		goto out;
 	err = init_mount("devtmpfs", "/", "devtmpfs", DEVTMPFS_MFLAGS, NULL);

-- 
2.47.3


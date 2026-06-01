Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F6E3C4572;
	Mon,  1 Jun 2026 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322262; cv=none; b=oLSbzOFQxh/Li+TWMZRDekMZpMOX4GqFAJfdhMpVoCKSHextZkfjRe7AZlt+Yelp2aHaulp8YY1zbt2FAfST9gxkUaYsN6fNpBbQsTNL7iT/dgeeFJSad4jpYGxTlkKVhNF/c7sFTc2uUSsIoFgTarqd3Nc3TGbhgTWrmmb89/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322262; c=relaxed/simple;
	bh=z7GBo2weiXPtLaPB9BVPXUk8vJr3dGQnDTEHCR8NQ6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rm7jppO1KaBTW2QixHzZGPAN8Tr/tVCwCMzfe5JbDFsxJtUWgYHGCbn4+xMH8JWZtv5SKsu5Apb/WAdu5wG8Z7chXOu73fXhgb9kN4yGy2+iSCNU6xpcYaHg6PI3rMJB0b/Xo/yn8EyklIO5LqYTKvCBk7zzMFPv/jX4V60Fn3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpHNy3ZG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpHNy3ZG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0211F00899;
	Mon,  1 Jun 2026 13:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322261;
	bh=Nmf3Ti8FB/Rw0EAEp2RpoYeHAFdBinkz4dUeZgaGrCU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VpHNy3ZGPI0gap5s12INMmIn25fJZczX8We3UHZ7D6u9hutISGSVnMNd88Mv7WS+c
	 pbIMELKWoOfA4vS7fJUYFWPxRzyzXhQ6e3yt4VyrAKelvalJ04jIKIgTkN5VNyuJM0
	 qUvILzY/1qKAZ6CFrfQd+T6Ld6vuQvR/J8L1sM9uwGVlRjDl4FIeeA1zwx4dYTmBgl
	 auejHFGENLBGol+2nhH/oANKIpi3QLhl9GXtfqa0SVtQ3+6BeW9eTHts5xkXw6aqZk
	 dALmq5rlHMI+Sx7HjOcPVulpnZmBM8iFCMoDiMYGl3x5nFUGW1NkPKH9y1zqu1Zc3q
	 XJrSmGEFVqDJA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 01 Jun 2026 15:56:54 +0200
Subject: [PATCH RFC v4 21/25] devtmpfs: create private mount namespace
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-work-kthread-nullfs-v4-21-77ee053060e0@kernel.org>
References: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
In-Reply-To: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-fffa9
X-Developer-Signature: v=1; a=openpgp-sha256; l=899; i=brauner@kernel.org;
 h=from:subject:message-id; bh=z7GBo2weiXPtLaPB9BVPXUk8vJr3dGQnDTEHCR8NQ6U=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTJ9i/fGm8yv551d8viJuXyFYpf8hqtl/0SPfu79Ynr9
 pV+bKwvO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaSU8zwP2FuU6LhG7kaH+/m
 HS5rXt9hE/6qxlVvVnjt9qxU1cy+ZEaGk4rsi2uYZhU+zVNb9HuByAr32L8Lvj38Jf3lteMEycX
 HOAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Kernel threads start in a completely isolated nullfs mount. Use
UNSHARE_EMPTY_MNTNS to give the devtmpfsd kthread a private empty mount
namespace with its root and pwd already set up, so it can mount its own
devtmpfs instance instead of unsharing a copy of the initial mount
namespace.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 drivers/base/devtmpfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index b1c4ceb65026..aef0fcc6aba1 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -413,7 +413,7 @@ static noinline int __init devtmpfs_setup(void *p)
 {
 	int err;
 
-	err = ksys_unshare(CLONE_NEWNS);
+	err = ksys_unshare(UNSHARE_EMPTY_MNTNS);
 	if (err)
 		goto out;
 	err = init_mount("devtmpfs", "/", "devtmpfs", DEVTMPFS_MFLAGS, NULL);

-- 
2.47.3


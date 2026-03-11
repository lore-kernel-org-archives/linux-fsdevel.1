Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026353382F7;
	Wed, 11 Mar 2026 21:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266197; cv=none; b=EKwRvC8Lkd/F7w+oGezB3fsEWEEMiE6ilOSR9dg3Ftm+s4Z/IQzWBz4aZcRvjBHt0oZiJTqz5Sh2ai+eBtEkw9jxzFp7U6HgGY+h02XLAzqO8866UWD1bLBMnnLRqbcTlu7JzGhMMjlmydsGSx+fo432jxnVkvzVut+TO8rdrl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266197; c=relaxed/simple;
	bh=mTnIonLZYMjXHvkplxKLW57Mj6daBEBoDy+9bwPX4hU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UbdoOplns/JjsRKY3zfTcStxtKEZHC79zABgQUFrFHNIb8EFELyLKMMD8s3aTGAOrj8FrKR0yB1VHiJ6+6J+A7v6gqpADDB5QAHQpqwBPfq1noAFW2MGG7abH1OMzC5lbbGc4NBpA0ITXGK9OKYORfyIbYcVFqFENeKLu5jtmVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXZM/JSY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXZM/JSY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96FDFC4CEF7;
	Wed, 11 Mar 2026 21:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773266194;
	bh=mTnIonLZYMjXHvkplxKLW57Mj6daBEBoDy+9bwPX4hU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eXZM/JSY2ts0xm1eJPI7BqangtZR1Y/4o5RysaRXL09Y7a4IHos3H0ylY0WIFAyhV
	 08isPlgNxorrz5r+wFLnvZ/BtLuB48RfB1xhv0F+NWrU2DZ8Ky4t+zS9Grq4wz53Cu
	 0YJURVpmBwNLfMAX5/jRZCymyDv27rnpXn1+S8hWSZihpM4dbkC8ie2kFiXiZd1ZS0
	 YMoSVGKwqMwssYZoGRFjLKmi821eNEF+ja7va6f0uiaeHXd8Ma6Wd1tjhi3/mdSOVP
	 gWU4lMRMV2RGmecVQBFxGz3PLvjImYsoRug/rYK1Jy8MZqdpucx/mgduTdSunvXPU6
	 F37YP6QaPTH8g==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 11 Mar 2026 22:43:52 +0100
Subject: [PATCH RFC v3 09/26] scsi: target: use scoped_with_init_fs() for
 APTPL metadata
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260311-work-kthread-nullfs-v3-9-3dd2cbe92ad0@kernel.org>
References: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
In-Reply-To: <20260311-work-kthread-nullfs-v3-0-3dd2cbe92ad0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-9fd7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1199; i=brauner@kernel.org;
 h=from:subject:message-id; bh=mTnIonLZYMjXHvkplxKLW57Mj6daBEBoDy+9bwPX4hU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRufPKj8Ux107V/2c9ucTJmSfcYCx1rCI3dxuHLUMHoa
 G97qku4o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLBxowMT+Vkvh3fWndK74f8
 G8eG6LqrTM3KPlsfbRLdXZfy3YZ7CcM/HTHrCMmJCWxFu1Yd3l59PpK3UJQjuuzLo8zyw4uUGhU
 4AQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use scoped_with_init_fs() to temporarily override current->fs for
the filp_open() call in __core_scsi3_write_aptpl_to_file() so the
path lookup happens in init's filesystem context.

__core_scsi3_write_aptpl_to_file() ← core_scsi3_update_and_write_aptpl()
← PR command handlers ← target_queued_submit_work() ← kworker

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/target/target_core_pr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/target/target_core_pr.c b/drivers/target/target_core_pr.c
index f88e63aefcd8..2a030f119b24 100644
--- a/drivers/target/target_core_pr.c
+++ b/drivers/target/target_core_pr.c
@@ -18,6 +18,7 @@
 #include <linux/file.h>
 #include <linux/fcntl.h>
 #include <linux/fs.h>
+#include <linux/fs_struct.h>
 #include <scsi/scsi_proto.h>
 #include <linux/unaligned.h>
 
@@ -1969,7 +1970,8 @@ static int __core_scsi3_write_aptpl_to_file(
 	if (!path)
 		return -ENOMEM;
 
-	file = filp_open(path, flags, 0600);
+	scoped_with_init_fs()
+		file = filp_open(path, flags, 0600);
 	if (IS_ERR(file)) {
 		pr_err("filp_open(%s) for APTPL metadata"
 			" failed\n", path);

-- 
2.47.3


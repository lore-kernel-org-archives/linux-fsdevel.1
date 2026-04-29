Received: from embla.dev.snart.me (embla.dev.snart.me [54.252.183.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5085D3FD156
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.252.183.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777478930; cv=none; b=igDE1ijGDxIqeaqllb1cfbUGEABsLqYkA3DW2wU+SEgm7SP2YLZOKYVuisoiCPF+CgDFy0udl6l1BozO+PNQRZodzFiDone462CH8SQuo+Zaq7u5owOm8zJ//SZAiBUHhMdNy8p2axh7/XSk+kYYf3OVRVsfEieCA3iMLPpQVyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777478930; c=relaxed/simple;
	bh=PZ45ZK5ltBvGkTAyFQ1TIPMzrOA/WwsbcngVdQhQSOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCLydzGGiQs2wf4/6RUKcipy2lrrXzqmKJdP9aNCs5UYZhf01lbTdqGj8qasWmArSD+y+/zuoYkCIixyh9eqsZKoXbFoPSO3dqgJLjlqmqORVSy0/TZBKlAKZOaORhZel2foneVlbgdP7p1JAkKw7oPYewLS7lF5+HGFWL9Rmko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me; spf=pass smtp.mailfrom=dev.snart.me; arc=none smtp.client-ip=54.252.183.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=dev.snart.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.snart.me
Received: from embla.dev.snart.me (localhost [IPv6:::1])
	by embla.dev.snart.me (Postfix) with ESMTP id 8CBFF1CBC4;
	Wed, 29 Apr 2026 16:08:40 +0000 (UTC)
Received: from maya.d.snart.me ([182.226.25.243])
	by embla.dev.snart.me with ESMTPSA
	id P2wgMgYt8mnfmwUA8KYfjw:T2
	(envelope-from <dxdt@dev.snart.me>); Wed, 29 Apr 2026 16:08:40 +0000
From: David Timber <dxdt@dev.snart.me>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>
Cc: linux-fsdevel@vger.kernel.org,
	David Timber <dxdt@dev.snart.me>
Subject: [PATCH v0 2/2] exfat: print warning upon block size calibration
Date: Thu, 30 Apr 2026 01:08:24 +0900
Message-ID: <20260429160824.409881-2-dxdt@dev.snart.me>
X-Mailer: git-send-email 2.53.0.1.ga224b40d3f.dirty
In-Reply-To: <20260429160824.409881-1-dxdt@dev.snart.me>
References: <20260429160824.409881-1-dxdt@dev.snart.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the block size specified in the exFAT volume boot sector is different
from the actual logical block size of the device, many implementations
including FUSE-exfat, macos and previous versions of Windows are not
able to mount the volume.

A possible scenario in which this can happen is when the user dd's the
volume in a 4K-blocksize device("Advanced Format") to a 512-blocksize
device. This is a design issue inherent to the exFAT format itself
which layouts the structures of exFAT volumes aligned to the sector
size rather than large byte sizes as seen with other modern file
systems.

Print a kind warning about this potential compatibility issue.

Link: https://github.com/exfatprogs/exfatprogs/issues/349
Signed-off-by: David Timber <dxdt@dev.snart.me>
---
 fs/exfat/super.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 075130fd992a..89a5f74a37fb 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -409,6 +409,8 @@ static int exfat_calibrate_blocksize(struct super_block *sb, int logical_sect)
 	}
 
 	if (logical_sect > sb->s_blocksize) {
+		const unsigned long saved_bs = sb->s_blocksize;
+
 		brelse(sbi->boot_bh);
 		sbi->boot_bh = NULL;
 
@@ -423,6 +425,11 @@ static int exfat_calibrate_blocksize(struct super_block *sb, int logical_sect)
 				  sb->s_blocksize);
 			return -EIO;
 		}
+
+		exfat_warn(sb, "blocksize calibrated from device logical block size(%lu) to "
+			   "volume format logical sector size(%d)!\n"
+			   "Other implementations may not be able to handle this volume.",
+			   saved_bs, logical_sect);
 	}
 	return 0;
 }
-- 
2.53.0.1.ga224b40d3f.dirty


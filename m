Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402124;
	b=UtC1G74iAvdqZcZM2mAxCQpb9lR/+fz1TqrLzqyjbu5lk0bOgcdRhYmpOr1zURVx4vuG
	 q2mSVzrpE0nio1nAIu39+sX0Iocqn/4J9Tnm2JBJ3Be+gdcuFSJrHNlOgWLFZ9W6i6U7h
	 b0QvFLsQ7KLUkBUPQ7Qw4erzTa4zaWmQoi7hXFWYlMoztWA5Wh2OA/MPoCZ/VCS3Oriw2
	 cqwHy+U53FRMiptD5gM94mVdCSkqJGV+nfgbpmaeCDS6BjWJMrHVv2T2qu7654H1XhhfT
	 nJFFR6/S62Igq0DNar9Zc/rRLH8Vac1Vx0rryotPEWP0nMAM7nAy18czAijVaETX3bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402124;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=w2/+xHZKQ2U7spoWRX9s3/PlBR0bd8B1wNdFaiAbagI=;
	b=xwv4GvQnhd5Lh+K7cIKp5AEUBjiPtGIZ8w9MBT6XVzCdtJ431qK7HQauXAGDNWJ51RGd
	 QQyf8EuRELN7Bggk0w/Hr4Cq6p8mg0PX5FTdZfKG4ucYEGWjB/uZYmRjwwpj1nuOODZWl
	 jdZd/A2hqpDDzqUNUScP6StbrupWyNXPbnwnZpdbBBWvu059zwWZBp3cZm8yOny0G+3nZ
	 Aztlc1GUnCGbC7jjikBCMvXZgqyM+Yqx06GalLEwUR46657R47QJxWX5x1jjjWNneqsI9
	 f19mzyKCCL09DJTpvNftMsySYP0DYcxp/QeD42P0fbRB0HZuF3/APDPwxcipbNjc9Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HvZBZsK7;
	arc=none smtp.remote-ip=74.125.229.135
Received: from mail-dl2-f7.google.com (mail-dl2-f7.google.com [74.125.229.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F373606A332
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 13:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F373606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HvZBZsK7
Received: by mail-dl2-f7.google.com with SMTP id a92af1059eb24-13985f8229aso2850806c88.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 05:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794402123; x=1795006923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w2/+xHZKQ2U7spoWRX9s3/PlBR0bd8B1wNdFaiAbagI=;
        b=HvZBZsK7tYvSumdzHkEQb7rSL9q5eY4Hda3xEbtuRJenmpkNB0i+OcZ2Nf8cTbbXKM
         P+YIMusWBQrxjebN+a+q03WLFO4jkF7MAIlxBBxr62Yth1ABBEZQ+1h6lCWIrKSRAQzw
         wzsp5iqL/G0DSX5Jtx55GrYYW1RC91+ns/WwXqfwNIz14a/dDqH7YUoSHQW+rf7FmE2C
         zWiVbdfg9xNAXLgZnMPisZ5hPJj2YPzf897YTf29mJ046Ye8+gYQL9x/xbzjuidhZ4ff
         n5ufoC0qFsLjkk23MPg2bshtTcHxWcVat8ty+IJLRWA0sQNN0lr4SxanfIpaNODwyppA
         QCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794402123; x=1795006923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w2/+xHZKQ2U7spoWRX9s3/PlBR0bd8B1wNdFaiAbagI=;
        b=gIQq0E8QJ/E9AxV6IWywKrHQo4RCzmeeux8FF68PSHbVW143th6kdhU+QEpGpwBwgu
         cR5nBmwXy+o0Kq5xRgg6jFAA+GVHd/mLr8PGHGdBnr3Gj2rTKxlRz/Aj09YwS8Dze+e1
         UgeN2ujmYgzpwjJ8x0xl7l5Jj8HWOWwS99tgnT5BqjrWcURd9xCCIUI8gt2qX2BJ9Coz
         LPUElvl14LSOfFr5xkxfY88W1YzXI+XhdvxVRrymQWbVUAesPAv7VLm9jdeT60X0ouNC
         gxSDro/lswg9OlMmNvxHCYrojGFCNDWDS/E0M7CNri4GCDP43do40++vV49EfhzIwxGd
         qK0A==
X-Forwarded-Encrypted: i=1; AL+hErHa0ehoRbs5JMQ7gu7iQ7NIaU4Ga3Dy5M7RE+ymeAh/bY/By5fj32CQOOSCqW1O6jE4RpL1nC1WHN1AB7IR@vger.kernel.org
X-Gm-Message-State: APuU4Z/1+WGUdYX/ORr7P3EuSSHyxr8JRfhYBRQoeWk+hBOC0pJ/mv6K
	Xq5XNSswGXxpRRjaZCv+TRseGubHBf/V7+3L2ZPWIfXuOy0Xg+1Er2nJtye0Jtkfjf77XA==
X-Gm-Gg: AYBFou1b7sqI7BDZggjNDrsZDlX5OpC+8ZYTRfTiYJMTMQmgEyS4N+N2DHg4532IJHh
	Z5CaSdUanFom5nGIlIe4sDIJ+7IQ3Fsg948PGsSZYjOpgFbnxG0/1qQdVTBHN4nofYkTEhy7z7c
	7IAkkN1u+TAq/KxEim3FOG7lO84UZ7pt5fkC2XqyeV45lNxFiRqvZvCEJEbUOX7u9x4gTXNT6JL
	h3drzRblumFRyWT2rs1ekPuRZkcBYTMpHe2QesmZvekN/U/RlFkp39DSbEMXj8lvhGtBIdreAZY
	zR1kb7SUXC4vEmNiNfK6Udk+aZb6qgDn2AvMi3pRbj5qZgeajDt3+LDuLm1ORKj2OhB1FGhmbpO
	nn2QC98uVE8awAzpyx7RXvPkloF8Qay+v0G018MXnfGrl2pTtBW/ri6CkEYZ1/ji0EfA/PCy/Vc
	Nh6tNeBKXQu8AhkEvl5l0sflKa8/m7a7KfXgOrXZyreiYr7TMq+QfyQhTLx4cjl/Wo/+MkrbQjD
	jrhCZZfV542yJQCQMnV5aG1A+pMKtf1qruqi3aj4LeZGnGuZmJ+6BbtZi/G45C+NH/Iy3+oo+T5
	oq/+7t9EHlzItk8Gs10u1/OoB75N/gYeSARxuq1EfthKuOs4x3vqg8sPQinlG5YD7Y0zwsISQEh
	yPi8GrYtbRzvSvtAIAv2dobvXk5n5JvwNliukyg==
X-Received: by 2002:a05:701b:450b:20b0:1b3:ba92:145a with SMTP id a92af1059eb24-1b3c0303655mr2388509c88.19.1794402122900;
        Wed, 11 Nov 2026 05:02:02 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11150sm21696634c88.5.2026.11.11.05.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 05:02:02 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: muchun.song@linux.dev
Cc: osalvador@suse.de,
	david@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jm5905938@gmail.com,
	dennylin0707@gmail.com
Subject: [PATCH v2] hugetlbfs: report inode limits without a memory subpool
Date: Wed, 11 Nov 2026 13:01:45 +0000
Message-ID: <20261111130145.96534-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A hugetlbfs mount can limit inodes with nr_inodes independently of size
or min_size. hugetlbfs_statfs() only fills f_files and f_ffree when a
memory subpool exists, so an inode-only limit is enforced but its inode
counts are reported as zero.

For example, a fresh mount with nr_inodes=4 reports zero total and free
inodes instead of 4 and 3. This hides the inode limit from tools such
as df -i, even when creating another file fails with ENOSPC.

Report the inode counters when an inode limit is configured,
independently of the memory subpool. Preserve the existing zero and -1
results for unlimited inode counts.

Fixes: 74a8a65c5261 ("[PATCH] Fix hugetlbfs_statfs() reporting of block limits")
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
Reviewed-by: Aveline Noir <jm5905938@gmail.com>
Tested-by: Aveline Noir <jm5905938@gmail.com>
---
Changes in v2:
- Add Aveline Noir's Reviewed-by and Tested-by.

v1: https://lore.kernel.org/r/20261101122653.53982-1-dennylin0707@gmail.com

 fs/hugetlbfs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 01c4d6f44ebe..e94ee8e17004 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1113,6 +1113,8 @@ static int hugetlbfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 				- sbinfo->spool->used_hpages;
 			buf->f_bavail = buf->f_bfree = free_pages;
 			spin_unlock_irq(&sbinfo->spool->lock);
+		}
+		if (sbinfo->spool || sbinfo->max_inodes >= 0) {
 			buf->f_files = sbinfo->max_inodes;
 			buf->f_ffree = sbinfo->free_inodes;
 		}
-- 
2.43.0


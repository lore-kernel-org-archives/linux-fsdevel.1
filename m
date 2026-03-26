Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ECB3F7E98
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 11:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774525890; cv=none; b=Tfw45tfTp99aYypubPgmX2xtgnxe3QACGpM0+DHwp9aSsPnluzNsqY2/ZwgsQ8f7Ox4fS1qxh/6lAKEF9KURLFijStxFn0DmLxd+2ICKX0Z8Qc6+wpuKMp6wEvhdoosikx9Au7y4DmKoEZ73Fi3cUrUlfTTtD+QmiPdpHAHHlT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774525890; c=relaxed/simple;
	bh=pC9PEN6xcigXR+y9OoBMieNE3DK690D2mE9mfGHI08U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K3EbT64QZzI0YHciL3CEUxtf3meQOLQrQmHqOvUKx8+s4zPwpEYBd3rNB9pGA8joDlvlcjl7ya7fcuGmeNIGX13dJJlvJUHnhrNrOO2zZPrGm/9fbn/6Ny26K5ucj5Wrcg09FcEdaClYIKwZgLc9haxXJoBy1f2rp2h3FGDE0c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b0b0064027so5715295ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 04:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774525887; x=1775130687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8OIUoLkzx4fPFbjMWyxt0ZBN9BymXVEe5B6otyEsY2c=;
        b=jzkiOybieivOZLEwbFStvuiovCyMIghXPlVkC4YDE6kx4YPEGCD8JjIwOkpcNJbjBO
         /fxX5hEjyhXKi9FghXlUJQ7nxhmh0BObeVTvqy7Y+p6CBASkXDwJFrOxHtdBlZ06wN23
         yWkgMEZQRAjfTSY/KlJSqijvxzWvj1xbc2ev2gEUPMEjm1OMFPzuL5G+s1h/PrlDxoZW
         OHMBBQuez5/UICGynO5pHn5/znXaEEDf5I77221M0BmCfiFbSV9KIFXmqdjPWgqoZuH5
         dL9lM698ZtztUUAgwccpbMH1qhrBzEgZuAFieeu6oiRjzRCAUoYXlVnkx9IFUev8aOey
         l2ig==
X-Gm-Message-State: AOJu0YwblRv7WlfWWvKqTJCXfwC82Uz+GZ+LSKcq1htMmZ0R7PWaFZ18
	BsN1LTvKbpG3ojcMUxJlAHXlUYYy1rS15Isg6IxuJLK75fmFY5fdvTaT
X-Gm-Gg: ATEYQzxr0/LGugc88M0Z7ZBVdh4VtbK3iLxQREYp8L4D3J2haOfDqCFyHZeaL9eUiLw
	DEzn9QoZk94bDPmcrkTcY4azaLRXutXbK61kd+p2jtEg3aWy5L41enMnAF3zTa8rLWSvwkrAvJj
	xQ2UJpvp9wG402xsYbrJ0cecUm+8RRqrur4d4B7oXqQ3BCUUILgQicDy9ojcHf6WPVWnfierMAU
	mQw/OrnInMFDX/wDXDI5Wt+lKJaliqHeN16yE+5SSEpAwNE6+6ZJ31QFmwRJXz5HLpbK1XVKOyp
	WFAGeiSqlbJavnHoIlnX+uj929P0319/7DIevgiflo7+AdPinX6lNIs+h5qS1jR6FJII7vh2s+J
	y8JHjTJV0t/eTDS+S+l4gKio0TwCCLX7n2HluCickM80c8oopSY8AGlAH9GtoXoBw0n9UZOf19P
	4rifwYTlZqh9TKn3pvTCM0cY11sbJruN1GBQS/+Q==
X-Received: by 2002:a17:903:2391:b0:2ae:4800:141a with SMTP id d9443c01a7336-2b0b0a87423mr84677985ad.32.1774525886966;
        Thu, 26 Mar 2026 04:51:26 -0700 (PDT)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc76ba80sm28425285ad.2.2026.03.26.04.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 04:51:26 -0700 (PDT)
From: Namjae Jeon <linkinjeon@kernel.org>
To: sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Cc: linux-fsdevel@vger.kernel.org,
	anmuxixixi@gmail.com,
	dxdt@dev.snart.me,
	chizhiling@kylinos.cn,
	hch@lst.de,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 5/5] exfat: add support for SEEK_HOLE and SEEK_DATA in llseek
Date: Thu, 26 Mar 2026 20:50:45 +0900
Message-Id: <20260326115045.9525-6-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260326115045.9525-1-linkinjeon@kernel.org>
References: <20260326115045.9525-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds exfat_file_llseek() that implements these whence values via
the iomap layer (iomap_seek_hole() and iomap_seek_data()) using the
existing exfat_read_iomap_ops.
Unlike many other modern filesystems, exFAT does not support sparse files
with unallocated clusters (holes). In exFAT, clusters are always fully
allocated once they are written or preallocated. In addition, exFAT
maintains a separate "Valid Data Length" (valid_size) that is distinct
from the logical file size. This affects how holes are reported during
seeking. In exfat_read_iomap_begin(), ranges where the offset is greater
than or equal to ei->valid_size are mapped as IOMAP_UNWRITTEN, while ranges
below valid_size are mapped as IOMAP_MAPPED. This mapping behavior is used
by the iomap seek functions to correctly report SEEK_HOLE and SEEK_DATA
positions.

  - Ranges with offset >= ei->valid_size are mapped as IOMAP_UNWRITTEN.
  - Ranges with offset < ei->valid_size are mapped as IOMAP_MAPPED.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/exfat/file.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index d7857aec072b..9a30c32b3a05 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -884,9 +884,34 @@ static int exfat_file_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static loff_t exfat_file_llseek(struct file *file, loff_t offset, int whence)
+{
+	struct inode *inode = file->f_mapping->host;
+
+	switch (whence) {
+	case SEEK_HOLE:
+		inode_lock_shared(inode);
+		offset = iomap_seek_hole(inode, offset, &exfat_read_iomap_ops);
+		inode_unlock_shared(inode);
+		break;
+	case SEEK_DATA:
+		inode_lock_shared(inode);
+		offset = iomap_seek_data(inode, offset, &exfat_read_iomap_ops);
+		inode_unlock_shared(inode);
+		break;
+	default:
+		return generic_file_llseek_size(file, offset, whence,
+						inode->i_sb->s_maxbytes,
+						i_size_read(inode));
+	}
+	if (offset < 0)
+		return offset;
+	return vfs_setpos(file, offset, inode->i_sb->s_maxbytes);
+}
+
 const struct file_operations exfat_file_operations = {
 	.open		= exfat_file_open,
-	.llseek		= generic_file_llseek,
+	.llseek		= exfat_file_llseek,
 	.read_iter	= exfat_file_read_iter,
 	.write_iter	= exfat_file_write_iter,
 	.unlocked_ioctl = exfat_ioctl,
-- 
2.25.1


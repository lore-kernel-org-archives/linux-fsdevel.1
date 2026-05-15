Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85032FFF8D
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778855018; cv=none; b=QJ/fDMpxR8Wf1D88ppFVX7kefmWw6pfBY5EY/AJgkLiNQNM81CXyCRnb/dIonrF0ihimOFQl0PMxa5cXr1oQ1sdfQJxjpTaAQBdSU8lY9Mi/+b8CfIZOwGthkDYsbEJgTCp2iT6cmg6LlMoJk+0u2DIxyF/zogEsKOwd8gS83o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778855018; c=relaxed/simple;
	bh=6Fx/3w1xEEg7EjXynoqxgB8ViKVnW/dwckxQjeeKoH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a+4TcgE8veg2L12YQ3RYkbmsToSXIAQhSVEj/KgJ4Y0AMPstI5lmkTE7uGmGwlfRduR7cdscP3bZPwg5/6u2NQYFtr9sj8bqtSEtPXaihxAMoeukxzH9Tg8o62EfDOEaoT4+LHKruPX8774MDQKVcxUf7ptI/BZTKpbbAnCPRNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmQz0DdW; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmQz0DdW"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50e5ad864a6so90132631cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 07:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778855016; x=1779459816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+g+9yWPWB6JQ65FM6GitniOIUqlSbPWyCQxbcWB+lx0=;
        b=WmQz0DdW4WTsUhC5sRB2rDLzq5yN2N30g3c72Gf6uSBke7kP3S1rbhVHgnzD8esh/R
         3v5zkXTN1xBvKFpVRffiumfERO3PvEZPB0tSyZZ7RM7lI202A9qqg8L5A/cq4PVZffJT
         cfi09bNdjXlIFufpADYNZN4lxZ/gFsIPYqyNE06U6FPyVWIH/5Qm7ZvisvgjWenuEiSu
         RanLs27FLuLIlqy6WcalZnRIKl+fvA6pWlapx30CSU3Jq/TwmPj7nm1wZpw+o8ZDkBFw
         Q9a/UOJN8c352DFWxDCEmW9OS4IIhQ7aQY3bILkm/2hPgo5ZY7C5u3hdVPzdDGMqP3pu
         nT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778855016; x=1779459816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+g+9yWPWB6JQ65FM6GitniOIUqlSbPWyCQxbcWB+lx0=;
        b=lDlkR5PNrB6eUx3wA2IPHL+tI/rHHZnILtJZ5AOMT3eSZMjFpTPJdb+/n55VCSJCWy
         V1czw/CdDQsEFfibQieBQiV0aNb1TnK5cqeNjR6Dz+dWv0p5LcZzwWm9i7H+y8kJuCWk
         ujMNS6eAVPobdwW8TB6ENBBspdTN1EH56hepw3oxCYIsBPqBXzpgPyBuRriiJKr9Ho9E
         QJVQFcC1NZD9rcxSsEibKPuQ08m7NQZNzuMTZKzuAxMwFioyis9R0GQVKf+E1aZu1OGr
         AbxQJY5SNq3eoBs6cNVTz1bXyFHJLBnryIRPruD7dOzlU4Z4GNJ+Rz+qjXdgIkmVVyh1
         RnTg==
X-Forwarded-Encrypted: i=1; AFNElJ/TXfiguuoEPBBR2lYDtfR6QdRR+r7o3babfoalyc9VFSWZpFK/0AcNg0Xh4izNeOO6if+0I31VnIWYcuo4@vger.kernel.org
X-Gm-Message-State: AOJu0YyPQ2YBfaISiDug4GFIjOObLU+tPuIFNLgQ2H0Z0uGkGEZRceRH
	Rrh+ecGbQy51KUgfLbVxPfnJi/MNrMRlPgxgwDK9HJU0zz6HXIOr4VYa
X-Gm-Gg: Acq92OH5oaWFLPIMKtSIvIvGlT6lIsWYs9iOtonR+hZuMhbTM5Hwcu5szjm42+EV9uf
	wOrIibGwdHxoJ0k6VRmeSHFlCWXd+nVmPG6TDW4ngRASkpgtCLwk0ptMspFFXKTJAL0//pjHB1j
	6/o4FZodgni9Djf+frHI/vNseTBpRAdu/88EtOW6WDUEP7Qo64c0JOo7q/LnJt5zJO3zIqkDrA8
	jgFVHmixdIQs3pwGupf56NrMiK98DqFN+7FOQAcrBoRx7nJDr/zXCfGNuKLR1/zXexQSR7zZZx0
	28Yj6E/7A4btrhvPaj/jybsONuEJYWyHGo98hEA6jT8MdLXHLUA4H5hELthMeDhRhZM2Viexe/o
	3vhncPiF9xlL9bM1JnxOMOI3nU6IufJkLPDn719Y29BreJQDgYKleT4T/5sM1FLsIhJKDJYIAun
	gFWqnUnvoJCsHJbfqWj2wzZUbrosHnknIkCkJX9Y95GudrQgqlc2qmV3xYTNJCpnwiW6tG++xG/
	nRZRyHPWQE/xeZzFRihKnccqpv7f5QxjnBtK55pd7E=
X-Received: by 2002:a05:622a:1e89:b0:509:30b0:8323 with SMTP id d75a77b69052e-5165a0a4269mr57007001cf.31.1778855015753;
        Fri, 15 May 2026 07:23:35 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5164568a275sm45240951cf.5.2026.05.15.07.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 07:23:35 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jan Kara <jack@suse.com>
Cc: Roman Smirnov <r.smirnov@omp.ru>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] udf: validate free block extents against the partition length
Date: Fri, 15 May 2026 10:23:27 -0400
Message-ID: <20260515142327.1120767-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

udf_free_blocks() checks the logical block number and count against the
partition length, but drops the extent offset from that final bound.  A
crafted extent can pass the guard while logicalBlockNum + offset + count
points past the partition, which later indexes past the space bitmap
array.

A single ftruncate(2) on a file backed by such an extent reliably
panics the kernel.  This is a local availability issue.  On desktop
systems where UDisks/polkit allows the active user to mount removable
UDF media without CAP_SYS_ADMIN, an unprivileged local user can supply
the crafted filesystem and trigger the panic by truncating a writable
file on it.  Systems that require root or CAP_SYS_ADMIN to mount the
image have a higher prerequisite.

No confidentiality or integrity impact is claimed: the reproduced
primitive is an out-of-bounds read of a bitmap pointer slot followed by
a kernel panic.

Use the already computed logicalBlockNum + offset + count value for the
partition length check.  Also make load_block_bitmap() reject an
out-of-range block group before indexing s_block_bitmap[], so corrupted
callers cannot walk past the flexible array.

Fixes: 56e69e59751d ("udf: prevent integer overflow in udf_bitmap_free_blocks()")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/udf/balloc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index 807c493ed0cd..cc6dc6e1d84d 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -82,8 +82,9 @@ static int load_block_bitmap(struct super_block *sb,
 	int nr_groups = bitmap->s_nr_groups;
 
 	if (block_group >= nr_groups) {
-		udf_debug("block_group (%u) > nr_groups (%d)\n",
+		udf_debug("block_group (%u) >= nr_groups (%d)\n",
 			  block_group, nr_groups);
+		return -EFSCORRUPTED;
 	}
 
 	if (bitmap->s_block_bitmap[block_group]) {
@@ -662,7 +663,7 @@ void udf_free_blocks(struct super_block *sb, struct inode *inode,
 
 	if (check_add_overflow(bloc->logicalBlockNum, offset, &blk) ||
 	    check_add_overflow(blk, count, &blk) ||
-	    bloc->logicalBlockNum + count > map->s_partition_len) {
+	    blk > map->s_partition_len) {
 		udf_debug("Invalid request to free blocks: (%d, %u), off %u, "
 			  "len %u, partition len %u\n",
 			  partition, bloc->logicalBlockNum, offset, count,
-- 
2.53.0


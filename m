Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0522343897
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 22:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789856764; cv=none; b=RH0X+Mqh9zHP7JgXw+vo10knPS67gqFUlsSqnFUc/lOJl7lFUZyirgk2K1ZabPptjK7RcZrZtzHWm9V3lZyuA+/MpMSdYjvmiH9ncOLJKM2qS8Hkxi/wzx2vkmh4OsMRtbYzx74LgS8TNRWZGcwB8eyQa8wiT0Y6SXAjRjgNYJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789856764; c=relaxed/simple;
	bh=On7nT1+UD5RkfkNRUFPhkk0A9cf/HTVYnuSICtWWV7w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ezRZVlUj7p4oiP7/zFmwfbjGVOjeEMyVFoQnl75CLp67iYnX6UUQUaJQ+MCytnTozbYdanr1rxW0dMs/hIHXFK6YmVeV0COSgOV8PdMWYV5beAZn+nIGm5JhNzu0C3pmLCWfk0Vix4pHe5GPknNfyN/AWbg6WrKIoAfxPIPFlGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b45qmjUt; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b45qmjUt"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccafb751so1548428a91.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 15:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789856760; x=1790461560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8ruoN6IwDeYMkJLCbc5KiLZHVo6kh43xiZeYEpvlWRA=;
        b=b45qmjUtH0sgzwaVNJgMJvwty2kP6Zpg/SvDzjik6zKGouwMQUFvcjmm0m0+2KQ1RD
         55gBoMfHDf2YQxx5dRr/G8s+CWEZEu8UNfVXcvAmEsEVXA6Qxz1GUocvyLmdbaqIltiA
         vJg/j243pnsDz5nvMxWIBjRCd4p+J5Ox6j6XbNAoS5BWo53galOJGBoidU8xnFVSHL7P
         SlZBUVbfEuFRf6jJl+nzP3CNrT2Ojr28iSSBywvw1a8z6o8qiUzolTSJ5EcTd764qzKy
         VSuF37k0WnVZKdolJqgoUEsYNS/oswNLSAkwFLp1mOdsiwrd7mV4C1712KXWRJ3Icylq
         LDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789856760; x=1790461560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8ruoN6IwDeYMkJLCbc5KiLZHVo6kh43xiZeYEpvlWRA=;
        b=qAHeUFmsf3noxJCZYSWrecoW2C4J8zmyVKUmIBZWcyB2yV2vtdliJ29XhHT360jxUa
         M1/ozLWGgP0Sr8znsLk0OOtsa9jV/FOauMeVptc/FmrlEpKTYBxbgQCedD7iPgMtk/y6
         kFkJ59tquW5/id5sVjHudqKrDLvOKOC41foMSevHldYactCGZh3mq84SMMTuih37qyG7
         stsRqGrbzXfNKTGrPwnHqYIEhcmed98FzLFUX0BC6Sc5vR/vu8tn5v6wgr2YsazKdODq
         sbjB8nT+HUkdQnZESoSWHV4VspTWZUwBgywudnys7utA/xxhYJjTG/ZqYMSlL69DLB2I
         o9hQ==
X-Gm-Message-State: AFuF++kf7ziTyaMP46FiiJp1ZjN/n0cCpCnrud2/C486HsQYZNI36/aq
	tFyhIBupPU9p86hXzKl3W9uFrZXqcCvyBO/DT1FiNGCg8+aFhpY1MU70
X-Gm-Gg: AYBFou0OPbmq+inK3s/D+YNtVht5BvhY5hahzrr1tWaYB2xQjMZowPNbeo9qxIgViDK
	0Obwik/rUWL/doaQErRjzurzPkEyjSGR9xFnr761CtXgCiS8/gCYIkFocuAEEmxrWI8N0I8J/6o
	alo7vrMJsUoCBpUU57XVsnKvwQ76JeOUkswJ0lXr9yK4GLfNuyffil305tnMxKrPew+US92FI/M
	vMFDPZStUbO8pL3SHB4L6dRCMjE6Ow5rGTm9sJRKiMU5hV0rqsNUkdHrYyjMpxdnwsEbu/qreHs
	mAcl/y5WOZZ1s6tfMA7T6qO3EWjNoEXvWtwblYa+OD67kWdTXWA33VqJyTri447qtC5dI7lp1tU
	bGpqnJfM0s9xEHd8wgOw5tT5nceLWU+iqDxGZP0mYzAZDpoOIG2O1eVQlmLYS7eujc5T7BdmNgB
	1yt936KNkz8aMqs1JyFT78y/WNSoj934Ix8mr2g5ujXpWhz1njWlfTzQ9il5OpkuMaMAD/Bj/6w
	gLnU+c5O3UXSx5ITYsSTLOafD8OtjSvZ7nuPhmTldNiZgaFfsBWUTBu53afPMiI0pUtw7LqkYOl
	3bDpxQ7f6A==
X-Received: by 2002:a17:90b:5251:b0:39e:6a7f:eeef with SMTP id 98e67ed59e1d1-39e6a7ff09amr6705396a91.20.1789856760014;
        Sat, 19 Sep 2026 15:26:00 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6ca50694sm7118589a91.2.2026.09.19.15.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:25:59 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: aivazian.tigran@gmail.com,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bfs: fix destination block offset in bfs_move_blocks() and check sb_getblk()
Date: Sat, 19 Sep 2026 22:25:59 +0000
Message-ID: <20260919222559.3793249-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In bfs_move_blocks() (fs/bfs/file.c), compute the destination block
number as start + i (instead of start + dblock, which shifts the
destination past the allocated extent when dblock > 0) and check for
NULL return from sb_getblk() before memcpy().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/fs/bfs/file.c b/fs/bfs/file.c
index d33d6bde992b..e6916c2b2671 100644
--- a/fs/bfs/file.c
+++ b/fs/bfs/file.c
@@ -40,6 +40,10 @@ static int bfs_move_block(unsigned long from, unsigned long to,
 	if (!bh)
 		return -EIO;
 	new = sb_getblk(sb, to);
+	if (!new) {
+		brelse(bh);
+		return -EIO;
+	}
 	memcpy(new->b_data, bh->b_data, bh->b_size);
 	mark_buffer_dirty(new);
 	bforget(bh);
@@ -54,9 +58,9 @@ static int bfs_move_blocks(struct super_block *sb, unsigned long start,
 
 	dprintf("%08lx-%08lx->%08lx\n", start, end, where);
 	for (i = start; i <= end; i++)
-		if(bfs_move_block(i, where + i, sb)) {
+		if (bfs_move_block(i, where + i - start, sb)) {
 			dprintf("failed to move block %08lx -> %08lx\n", i,
-								where + i);
+							where + i - start);
 			return -EIO;
 		}
 	return 0;

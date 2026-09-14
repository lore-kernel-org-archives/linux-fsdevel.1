Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CFD3B38BC
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 23:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789429207; cv=none; b=uNdt6TWySoOOu/CqmoXdOr0wN+ZIBteByTnX6Amw48gbAxIaAmAp+hTxg6MMcolH7OSJ1TM2U/78qhJ0RpcaT9Bc1aKvp+cT2gz76O9Gg2ZhuSHueBKGN75dOy0cnfPZGEfVWFjaQH66MZSDUPDyIFPB0L0hmcv8NQyIuDGtln0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789429207; c=relaxed/simple;
	bh=OVJzpWfHSM6a6wCkK3C71K/fLknshrLRt2xkWr7HMRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNt4DWt8kIgdqG1LMu2KsZc1RWOYTczseU8ev/q4NoF/KnKBl3aN+mSPcFfOdQjBi/0WnM2bamGCYaOV9fzN8xWSQLbi3UgoR3JviMKr+xvxoWmxYFgy5C+irfY86DDEAyV7PJEIJeA8dkoS4LRHSnBCdSQIsDpO9lftFtVPO8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=r88D3JeQ; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="r88D3JeQ"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-66e4aa8d882so2616854d50.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 16:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1789429204; x=1790034004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YUa9GDJb+Q4jhCXihDpgFN+RTSjVzxtIFk+RZAxtdhM=;
        b=r88D3JeQL2P3PXHbbiXZ7raadkNh4voYOcmqymra7LA/7tEtn3kohXpUfTVIVb8eoD
         5P1xcVOENJtkxzHusw07f/9oLWSpqD/pZHOwEt9vLarrgG2XNfdH2yUJ39r1SGQjFgUT
         OwIGoKP9CHO5u/k2VXI5pdp5hd+iZN0odEvMgCb5LO+OhC0d8mJpDiNcEdUNoVlKvKC3
         6XZyG2r4R8FtFR3V62vV0QBINPOueOqpLt+Cpy4dFGXQtQOsgVubJWxYFzC0cgCJzD/z
         5BcBPKplJRoWiQ7rcv0Q9vZa5ES3XcSwpcxcFHQJ+VT44PX+USL6NogjtTh4lZJDt/Kp
         LOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789429204; x=1790034004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YUa9GDJb+Q4jhCXihDpgFN+RTSjVzxtIFk+RZAxtdhM=;
        b=u+hvwUTrInAASMjcha/leH9MPgd6+GF0K2wXOJfq4CsnBahXlXZteQhIdqhLd0PYpV
         7hL8kZjDClxrBKQAJCI2YsNfTlbXACQSsnKDIuMhVkC1plrPGM2X2RgNd97pmPUTrdc1
         jhEEHZLDKvckUhNCsVMVS8DPXGVlGw82BC88LaJTZDxRfFa27hxW1LkWpPbE3n//sDPj
         yM7DLHcDFwzPe4NjKxRWoY9/5v4tNGulM8x9v2XS1I/kN0AnMymRK9KjwPFjze07MwW4
         lpf0YSW26xyBwx52IgjuwflQ1bZcOGxR661I4TM7yWonAb+NefzqDK6yIb17r2yuo8xt
         M0TA==
X-Gm-Message-State: AFuF++ltRMpnCf75Z1aGaNg4Uk2IkRqhNoS9/pEuxlE31W6VSZXiJEZ9
	WEY0DavIehTZsT2yLO2t2wegCsM4W6/GkrfFRR/8Ivh7BHNoej6tIX8fBFE1R7n/46o=
X-Gm-Gg: AYBFou2sX4WkSt+ZcwbrmqCu9nSRBv/dhgktmEn5xdswQyJC7FXPcLEMh/RheroB+pc
	rvzmtC3FS99vsclUrroVrxj4ZPnTj4sUc/cme7tZ7wuVLCRFWwivrsmbZCFHmpZzsoDyS8WZY+D
	u8qYhUZoJRhUGD33aCjOTmuePUjXQ0ju2+LhxcKZ/R8UCDdheLBmn4G1xXDN/UK0XWqILW0+rsb
	i7YRXvAgReLer9boyfHUXtFg5vaF4fjtMeSZZ7RMbXjf6Nf+laIXKefamgWwNU4lVu6n8KslPR+
	UTFjKO0H9KmJQWgFmaM2+kK+KUuoKmEhUcZyTh2dNGHbL4rI04bT4Ynl9xDnQwpsDbJZ4DE0L98
	TjH+baj6x1Zf/Gz5ofEjxhJ5iOxhb6Nm4F4DWSFLZI8DzQ4YUQNQXNNUiw7hygtgStzTm7e7gWs
	7HDnSWI1ddzowzcRSTliR4wwk0H3DTUs113S4YCeYBkUQ7MdXBtDRb3sPkkBhEuqWRWaC1Rq8rY
	JrhIy8D2eU41D1QiB9zhXIDPE7tYBaF95B/9Ytu+DkaqGMn2QVmKT5Dl80pVeT5yqw8Ns3u4C+4
	NR4Vz1XHJm+37YpQTFZtpIaJDz277g==
X-Received: by 2002:a05:690e:bc6:b0:671:1406:95ec with SMTP id 956f58d0204a3-6714dfd35f3mr1369775d50.11.1789429204257;
        Mon, 14 Sep 2026 16:40:04 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:df87:8743:655b:3824])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67125e3fa87sm5207804d50.14.2026.09.14.16.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 16:40:03 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	hch@lst.de
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	willy@infradead.org,
	brauner@kernel.org,
	djwong@kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v4 1/7] hfs/hfsplus: exchange hardcoded number of extents on named constants
Date: Mon, 14 Sep 2026 16:39:35 -0700
Message-ID: <20260914233941.2966421-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914233941.2966421-1-slava@dubeyko.com>
References: <20260914233941.2966421-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the magic 8/3 fork extent-count literals with named
constants (HFS_FORK_EXTENT_COUNT and HFSPLUS_FORK_EXTENT_COUNT).
No functional change.

cc: Christoph Hellwig <hch@lst.de>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 include/linux/hfs_common.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/hfs_common.h b/include/linux/hfs_common.h
index d6a615e74b26..8673933bbee5 100644
--- a/include/linux/hfs_common.h
+++ b/include/linux/hfs_common.h
@@ -171,18 +171,22 @@ enum {
 	HFS_XATTR_NAME,
 };
 
+#define HFS_FORK_EXTENT_COUNT	(3)
+
 struct hfs_extent {
 	__be16 block;
 	__be16 count;
 };
-typedef struct hfs_extent hfs_extent_rec[3];
+typedef struct hfs_extent hfs_extent_rec[HFS_FORK_EXTENT_COUNT];
+
+#define HFSPLUS_FORK_EXTENT_COUNT	(8)
 
 /* A single contiguous area of a file */
 struct hfsplus_extent {
 	__be32 start_block;
 	__be32 block_count;
 } __packed;
-typedef struct hfsplus_extent hfsplus_extent_rec[8];
+typedef struct hfsplus_extent hfsplus_extent_rec[HFSPLUS_FORK_EXTENT_COUNT];
 
 /* Information for a "Fork" in a file */
 struct hfsplus_fork_raw {
-- 
2.43.0


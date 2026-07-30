Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98259296BD3
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 07:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785395640; cv=none; b=AqcyyOJfDUM9pVhM5z3pgw2Y8j7wq24QUlur/DJ9FNHxtkrP31QBZZ7eq9YwKj/OB8/J3DeXJC0bHhs4JclqJLgL4KAQw1gjKXDN469f+0w7VHM9O8pvcq3hx2yg9fJIfvpqB5gRzVhaBpjTOpzz8SSdEcKv7Z1vWKL7qf/7o70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785395640; c=relaxed/simple;
	bh=VqAWR9drHd5aaagFAxsb9cXKpB8GAafaVAD01CXD178=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p4OkoRp0m8GvPESbWkAQh95fHfr0kl8/YeCXhjgNgzztDv+eupZi0lb1f7PvtpFwIgjSXCljbBrWz4+BzLE+FNWFK9U08ODHFBWxhhKnLsS+f0pn5I2C3HbL3sg6ix+BSUs/7Q+zB8RBx6LggR0HUxCQ22VmD2dTFN+J5fF1EIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=MpKYlVJw; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="MpKYlVJw"
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U6YIYI1963984
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 02:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=VlLo
	mZ2ihL9HFxlrx7gRVvKB0MpDdFuMFLp7qf/zQYY=; b=MpKYlVJwcHKHdws+WTax
	xNY1KC8xJ5UwioqCDfrXm10hsZ38GifYdzzDgdp5k3EXoevWleyY1dFEYtamvhpJ
	nWsGgJa6p/YoSuJF4WIywki9iMXIn1c5Wn4DkpQGgbayfJ6qYYenwE7IR3x6i5za
	dwukXaXhPCmDnx00K9b63BM+126tHcyEXiVmjVGTroLxLwgeaoTkFFz5LrgjZQxx
	gCxc77WryoG5AoO8xqG+CIpVGqcvPcJy1Hre/qmfzNh4Lg+NyHId2TO5o74a17H5
	PMqGOiw2sWKl/vs2sNdLr6yI8HY3DLjU7PD9m6sqBVNHZv4IJI6fROiKcTd5+32Y
	+Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fqrjyj5e5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 02:59:03 -0400 (EDT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-930f5da3467so211793985a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 23:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785394742; x=1785999542;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VlLomZ2ihL9HFxlrx7gRVvKB0MpDdFuMFLp7qf/zQYY=;
        b=mX/GA5p5MMAYoLn4mMQ9+DPckQYc+sqv79/npQoMNCpC/ris2dsIK3CpLt9RK1vE/C
         nOFDW2xrfiKsxoksqc2gvqbWNHV9OlKEr+T1cwuWyDlx0aW3ISLTjcPtzoX/i8TU2lWG
         cPlbh2Z9DCL5eFZ9m6m6K4ZOirMCFfTszKp1hqKrT8/kh+OsSxMkp59n1WRnoMM7w5qk
         mu0dtOFKLFTw2nq6l6PTIIUGnEG7TTj6rPhke9UvqNnf2LKDib3R6qSlAe4Fvxan8cs6
         pm/Fao7220pKYab80CePihKYKIISl0+uvsk9jw6VAfW2BR90MEW2TK0QVandWVScu4yo
         ONBw==
X-Forwarded-Encrypted: i=1; AHgh+RrFleuuW6VptrdsJpOOY4lv7behjuKRITAy2Jg5uGenIu4gSCGe10VOVs4XVxmZbKFfZZqZj5Uq/u+ShfUx@vger.kernel.org
X-Gm-Message-State: AOJu0Yylm8TlbBlWAx22CkMhyrqBzO+ORdWt9aJPNc4c9GDnXIaWlmvW
	UGDAKy1BqPSFSqiHgRpyVULQClQM0ttedc8xxM8+Jw0uPewQE0H+lYTOz97Suiv0VW5RRJPtzXb
	e/TN0IQzxxdp7FoSo9VwlIeGxIkP3DCnSxIhaBeiy+lvul+VeXai+VevX+0GEurk=
X-Gm-Gg: AR+sD11NPKpI2OsEUu7rnrT895GpGoccwsA5w0kkweRRpW3Pne+tBrQoNGruC20yRG4
	DRwnQWJh42BLfbHqjaGzt3gGyUvsQhVoJvLnQTi0cesXenQKH2sMl3J2C9XosMBL04IVwc8mhOo
	rZUzuAVPM6+hBv1NuM8J18MjlObq5BJ3q0+BJlgQyCEf4hqwN5vlYbqOffE8LjSeZ7sReDRiNqc
	dk4Ay527tnmkE9X6SAWXAAeDRWd/O/yxQQo2gHxfS2iSlI+ZUJGy6Pd9j/Y1PbtKE8/Q2+xCOXh
	FHl7qk/RrWEsYKf0YmDaYBYDk1FBHGTCewcrgT3iMFzBXRJDchVlwGdOaO6KNqO10a8vU98/q7H
	6DUlSszOPcLdav7/9UfcV6FkSGR7va13P/EHE+X8hKhJNjQ==
X-Received: by 2002:a05:620a:4728:b0:92e:94a7:16e8 with SMTP id af79cd13be357-93485f9eb93mr142633185a.15.1785394742159;
        Wed, 29 Jul 2026 23:59:02 -0700 (PDT)
X-Received: by 2002:a05:620a:4728:b0:92e:94a7:16e8 with SMTP id af79cd13be357-93485f9eb93mr142629985a.15.1785394741655;
        Wed, 29 Jul 2026 23:59:01 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933d3221bc7sm349752485a.7.2026.07.29.23.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 23:59:00 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 30 Jul 2026 02:57:53 -0400
Subject: [PATCH v7 3/5] iomap: use BIO_COMPLETE_IN_TASK for dropbehind
 writeback
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-blk-dontcache-v7-3-3e8e6850068d@columbia.edu>
References: <20260730-blk-dontcache-v7-0-3e8e6850068d@columbia.edu>
In-Reply-To: <20260730-blk-dontcache-v7-0-3e8e6850068d@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale <dhavale@google.com>,
        Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>
Cc: Dave Chinner <dgc@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        Hillf Danton <hdanton@sina.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-erofs@lists.ozlabs.org,
        Christoph Hellwig <hch@lst.de>, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785394735; l=3060;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=VqAWR9drHd5aaagFAxsb9cXKpB8GAafaVAD01CXD178=;
 b=vBSV9PuGaob7EwfUbiGv6fypiN4LKkZCFKVdXD+PIQv8LCcBMfs8U5vzkhknkhDiwC6C0Zrx+
 5R4OEUS3RiTCHa0v/202zDRtO2dKByH8pttxUhsn6U5qKVyhcv1ODCk
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA0OCBTYWx0ZWRfX6LkpX9Rr2YAw
 gY2mXDwXVPCmd12zii0RDL4ncbyyd0QdjXjWnMYlkKupaf8YEGAu4X6bJ/ByPuMk+XTGIzYZ5Yv
 zGK8wYJVgPyvdnP7OFe/X4y0yfvfITRH7IX6o1mpfcfec+1j9E1WclW5hlOJ0KRFhLlU09lzhhQ
 rSWjKwjM2gzmAx4CXAhxCmeJ+xgXbGA9Rd3+lGG1XtG8OuqHdZ2GnBETVaVv/MFS/k/ZCyfnzWM
 Ia2FxMate614h2Bu6B8qLZfv7AK/2XULRDWoM+i5fBTwX8Wyl8iJeMk1YmlvlTRXkYHUeRYQK/x
 mqaBxo1SI8IGP/vNJRLvbf0wO2rdIVy9ANHQUm592cRb9gv2FmorFhafR7Ecr1a60zlKcL3kORx
 CADtUL69DSELI1yq2D/Gbn4SoxJY4V+u4UVCkpSUdq/gY+Nyb12T0HMJC+GFVkngpwcluamDY7k
 XoDPS5yQSKwz6On+CyA==
X-Proofpoint-ORIG-GUID: L6CWmMz7O3v8c2RGUc5hfgN4GDG6ieCO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA0OCBTYWx0ZWRfX+YDVbffVTGOn
 6d1t7AVmQl9CgoQEn/aRe89Ar/baPSBu6aWXKau2kwRs6WZS10te8Ron6aR56U+oinGkPsDGpzM
 JgY1Sc7fWI41DWkwjZnZRmnsCcm9/yfkJv2CYwX9BTyPamhcMmIn
X-Authority-Analysis: v=2.4 cv=EYD4hvmC c=1 sm=1 tr=0 ts=6a6af637 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=aYi4XJYX91a15INjywwA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: L6CWmMz7O3v8c2RGUc5hfgN4GDG6ieCO
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11859
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=10 spamscore=0 bulkscore=10
 malwarescore=0 adultscore=0 impostorscore=10 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300048

Set BIO_COMPLETE_IN_TASK on iomap writeback bios when a dropbehind folio
is added. This ensures that bi_end_io runs in task context, where
folio_end_dropbehind() can safely invalidate folios.

With the bio layer now handling task-context deferral generically,
IOMAP_IOEND_DONTCACHE is no longer needed, as XFS no longer needs to
route DONTCACHE ioends through its completion workqueue. Remove the flag
and its NOMERGE entry.

Without the NOMERGE, regular I/Os that get merged with a dropbehind
folio will also have their completion deferred to task context.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/iomap/ioend.c      | 5 +++--
 fs/xfs/xfs_aops.c     | 4 ----
 include/linux/iomap.h | 5 +----
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index 30468d51b5ad..1ae8a8fb8503 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -238,8 +238,6 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 
 	if (wpc->iomap.flags & IOMAP_F_SHARED)
 		ioend_flags |= IOMAP_IOEND_SHARED;
-	if (folio_test_dropbehind(folio))
-		ioend_flags |= IOMAP_IOEND_DONTCACHE;
 	if (pos == wpc->iomap.offset && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
 		ioend_flags |= IOMAP_IOEND_BOUNDARY;
 
@@ -256,6 +254,9 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 	if (!bio_add_folio(&ioend->io_bio, folio, map_len, poff))
 		goto new_ioend;
 
+	if (folio_test_dropbehind(folio))
+		bio_set_flag(&ioend->io_bio, BIO_COMPLETE_IN_TASK);
+
 	/*
 	 * Clamp io_offset and io_size to the incore EOF so that ondisk
 	 * file size updates in the ioend completion are byte-accurate.
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 51293b6f331f..cd8de8c82d78 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -522,10 +522,6 @@ xfs_ioend_needs_wq_completion(
 	if (ioend->io_flags & (IOMAP_IOEND_UNWRITTEN | IOMAP_IOEND_SHARED))
 		return true;
 
-	/* Page cache invalidation cannot be done in irq context. */
-	if (ioend->io_flags & IOMAP_IOEND_DONTCACHE)
-		return true;
-
 	return false;
 }
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 56b43d594e6e..68af4935a107 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -404,16 +404,13 @@ sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
 #define IOMAP_IOEND_BOUNDARY		(1U << 2)
 /* is direct I/O */
 #define IOMAP_IOEND_DIRECT		(1U << 3)
-/* is DONTCACHE I/O */
-#define IOMAP_IOEND_DONTCACHE		(1U << 4)
 
 /*
  * Flags that if set on either ioend prevent the merge of two ioends.
  * (IOMAP_IOEND_BOUNDARY also prevents merges, but only one-way)
  */
 #define IOMAP_IOEND_NOMERGE_FLAGS \
-	(IOMAP_IOEND_SHARED | IOMAP_IOEND_UNWRITTEN | IOMAP_IOEND_DIRECT | \
-	 IOMAP_IOEND_DONTCACHE)
+	(IOMAP_IOEND_SHARED | IOMAP_IOEND_UNWRITTEN | IOMAP_IOEND_DIRECT)
 
 /*
  * Structure for writeback I/O completions.

-- 
2.39.5


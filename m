Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3355A38E8CC
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 16:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786553654; cv=none; b=YJzORyrjlU9V3MaGPXuHCwyxiky2pBCfnfH0UWYx52SFgVoqaDS6AVDKkn54tyLgHeuKhDo4e77hy5aXj3BqwLCGL1i7FsHvTpSqcExKQL40KGLTiIa+Uqvi5Dufli9aZ3F4W6vK3LYwMxIwaEh/bA76waIu9C2VTJoDVus8uWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786553654; c=relaxed/simple;
	bh=Ju8fmuPZjg1L0W9C2+ficq/zAigNIGkHDzHaRgpz6FA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oZGGyx5mANarnoxuNFu+7RS7fpGm3ILc8lCjwHsXBmkW9yfR8JBnMTN9IT2RP+4Jr35FDSoLPi7zx/lLuYV1iIEDI/LAcbAaguvMqvDv3mpusiWaqRRnw3zAMEyODYCx3JrfyoD2JvO3uWLC/D33DuybRq5YPBKJcA15Ksnead4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gvSKt3Mb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gvSKt3Mb"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CE1hjA3640453;
	Wed, 12 Aug 2026 16:53:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=xvNwpOUuJWPU0RQwyyELVO+m/7TUXAad9NzNuqodh
	O0=; b=gvSKt3Mb2bcFxu40lAu2pyKZm9WrY6+9kjWSYJEhF1A8bcigG56Uouk/H
	5NvB+lyNxNA1aEE97ubKN8srQVuwqT3CaK6O6ly+DUCU58O2SB6tiZYPTMRKWc/T
	dkP593j473+kvnDcNbaUkCJOBIlN0rJUnygwguk7Ig1eNuTKYX8gQf1MOYxoP30a
	IWiax2Gx1eXEjE/kSVmWOSC2Mq+yzjdYFe/V7o8GCxBiLcQINsAJtqow1G+HQT+p
	VuOPwi9I8V+kBLdmra/r4lJc8g/l6+Pq8DAen2q933yPRIj8pBGo3h6bVNyulSlN
	/UzCxtyyT4YDS5yo17hXgu2ekMpRA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9kjnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 16:53:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CGfFQj019680;
	Wed, 12 Aug 2026 16:53:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy6tfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 16:53:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CGrsjB52429276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 16:53:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86FD62004B;
	Wed, 12 Aug 2026 16:53:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AB9520040;
	Wed, 12 Aug 2026 16:53:53 +0000 (GMT)
Received: from ltcrain80-lp6.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 16:53:53 +0000 (GMT)
From: Sridhar Markonda <sridharm@linux.ibm.com>
To: jfs-discussion@lists.sourceforge.net
Cc: willy@infradead.org, shaggy@kernel.org, linux-fsdevel@vger.kernel.org,
        ojaswin@linux.ibm.com
Subject: [PATCH v2] fs/jfs: fix NULL pointer dereference in metapage_read_folio
Date: Wed, 12 Aug 2026 11:53:53 -0500
Message-ID: <20260812165353.64848-1-sridharm@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qvtPYo6iY09aJNPKTvdaX3QnQ4EzejWy
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7ca525 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=gjFPYyPF6jJtPP5HjYcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzNCBTYWx0ZWRfX89NQoCDntaA2
 CJMq96iJduvrU5w1XGr1633kJly7M4qCgYPmJHi8izjYpVRj7PvhIFEfQc7L4hn9h8mB3MHqWM6
 lSid2npore+m7NcNwpfvfsIAftctOgY/P5lnfHFsgy6eYaCc9YGcfsLEyhGupn8qKUHWHr4qNvw
 JR/Qhi078OGQWr4V/eWXMsrrhWQSqUYfnl90nrXwaqcjqBY/nQyvDwd7MLlR4OdXPA5H6WfzItX
 TG8fZAZJDfqK9Zkz9FSna89L9H9RJT5omgH1u2Ol+WPXkf604OAx9W6mP++Ldq3hTygbCk7nZ5u
 /T4YkoVl5cTv6COYb3nXgEFfrAE2tcz2GGR+vWhDbdmSTnel6U9y4xyEpmddIRHXDfGekA2JYrf
 JyaCtuhabRzCrOBmjumBkvAiT0ikkgmrusSDmZ7mlLWvCUQiFxCkotZTIlYNIIc/SYuTZXBWwOW
 q1yfitXXuWfUWaGoC1g==
X-Proofpoint-ORIG-GUID: qvtPYo6iY09aJNPKTvdaX3QnQ4EzejWy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzNCBTYWx0ZWRfX79FlK3Zt3qRT
 oT9KrFvHWMoIM6f15AUrc0V8nRjjPoKfZ9ezxTdxSmpCZHmUW1PzyfFk6UHGcuqeo+0ObHvJK9o
 pfJ72JDfWldkhkqHYZE2uwgSpR2Snn8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1011 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120134

This patch fixes a NULL pointer dereference in JFS found during syzkaller
testing on PowerPC systems using large page sizes.

Full crash report:

BUG: KASAN: null-ptr-deref in instrument_atomic_read_write include/linux/instrumented.h:112 [inline]
BUG: KASAN: null-ptr-deref in atomic_inc include/linux/atomic/atomic-instrumented.h:435 [inline]
BUG: KASAN: null-ptr-deref in inc_io fs/jfs/jfs_metapage.c:140 [inline]
BUG: KASAN: null-ptr-deref in metapage_read_folio+0x238/0x7b4 fs/jfs/jfs_metapage.c:587
Write of size 4 at addr 0000000000000004 by task syz.6.4880/59986

CPU: 1 UID: 0 PID: 59986 Comm: syz.6.4880 Tainted: G             L      syzkaller #0 PREEMPT
Tainted: [L]=SOFTLOCKUP
Hardware name: IBM,9105-22A POWER10 (architected) 0x800200 0xf000006 of:IBM,FW1060.51 (NL1060_148) hv:phyp pSeries
Call Trace:
[c00000006e836e30] [c000000000bf948c] print_report mm/kasan/report.c:485 [inline]
[c00000006e836e30] [c000000000bf948c] print_report+0x444/0x9a0 mm/kasan/report.c:471
[c00000006e836f10] [c000000000bf9c10] kasan_report+0x12c/0x218 mm/kasan/report.c:595
[c00000006e837020] [c000000000bfc62c] check_region_inline mm/kasan/generic.c:186 [inline]
[c00000006e837020] [c000000000bfc62c] kasan_check_range+0x270/0x380 mm/kasan/generic.c:200
[c00000006e837060] [c000000000bfd664] __kasan_check_write+0x20/0x34 mm/kasan/shadow.c:37
[c00000006e837080] [c000000001acb808] instrument_atomic_read_write include/linux/instrumented.h:112 [inline]
[c00000006e837080] [c000000001acb808] atomic_inc include/linux/atomic/atomic-instrumented.h:435 [inline]
[c00000006e837080] [c000000001acb808] inc_io fs/jfs/jfs_metapage.c:140 [inline]
[c00000006e837080] [c000000001acb808] metapage_read_folio+0x238/0x7b4 fs/jfs/jfs_metapage.c:587
[c00000006e837130] [c000000000950df0] filemap_read_folio+0xa0/0x268 mm/filemap.c:2501
[c00000006e837180] [c00000000095c234] do_read_cache_folio+0x2d8/0x5c4 mm/filemap.c:4101
[c00000006e837200] [c000000001acd974] read_mapping_folio include/linux/pagemap.h:1028 [inline]
[c00000006e837200] [c000000001acd974] __get_metapage+0x1c4/0xd78 fs/jfs/jfs_metapage.c:729
[c00000006e8372e0] [c000000001a947c8] xtSplitRoot+0xd8/0x874 fs/jfs/jfs_xtree.c:1242
[c00000006e8373d0] [c000000001a97a4c] xtSplitUp+0xad0/0x1240 fs/jfs/jfs_xtree.c:785
[c00000006e837580] [c000000001a98ea0] xtInsert+0x7c0/0xa18 fs/jfs/jfs_xtree.c:608
[c00000006e837780] [c000000001ac851c] extAlloc+0x7bc/0xc74 fs/jfs/jfs_extent.c:150
[c00000006e8378b0] [c000000001a8a7a0] jfs_get_block+0x3c0/0x868 fs/jfs/inode.c:254
[c00000006e837950] [c000000000e1af2c] __block_write_begin_int+0x3c8/0x1318 fs/buffer.c:2142
[c00000006e837a60] [c000000000e1bf98] block_write_begin+0xac/0x230 fs/buffer.c:2253
[c00000006e837ab0] [c000000001a8c454] jfs_write_begin+0x58/0x114 fs/jfs/inode.c:306
[c00000006e837af0] [c000000000949a30] generic_perform_write+0x2e8/0x754 mm/filemap.c:4319
[c00000006e837bf0] [c000000000964174] __generic_file_write_iter+0x210/0x244 mm/filemap.c:4436
[c00000006e837c40] [c0000000009642a4] generic_file_write_iter+0xfc/0x35c mm/filemap.c:4462
[c00000006e837ca0] [c000000000cf9cfc] new_sync_write fs/read_write.c:595 [inline]
[c00000006e837ca0] [c000000000cf9cfc] vfs_write+0x530/0x95c fs/read_write.c:688
[c00000006e837d90] [c000000000cfa4c8] ksys_write+0xf0/0x230 fs/read_write.c:740
[c00000006e837df0] [c00000000004ebbc] system_call_exception+0x26c/0x760 arch/powerpc/kernel/syscall.c:153
[c00000006e837e50] [c00000000000d05c] system_call_vectored_common+0x15c/0x2ec

The crash occurs when insert_metapage() fails to allocate a meta_anchor
structure. The function returns an error code, but its return value was
ignored, leading to a NULL pointer dereference in inc_io().

Check the return value from insert_metapage() and stop processing the
folio when allocation fails.

Fixes: 7fab479bebb9 ("[PATCH] JFS: Support page sizes greater than 4K")

Signed-off-by: Sridhar Markonda <sridharm@linux.ibm.com>
---
Changes in v2:
- Keep insert_metapage() in its original location.
- Check and return errors from insert_metapage().
- Update the Fixes tag.
- Test with xfstests on ppc64le (64K pages); no regressions observed.
---
 fs/jfs/jfs_metapage.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 41fe12e641ce..ffbb186e850c 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -573,6 +573,7 @@ static int metapage_read_folio(struct file *fp, struct folio *folio)
 	int xlen;
 	unsigned int len;
 	int offset;
+	int ret = 0;
 
 	BUG_ON(!folio_test_locked(folio));
 	page_start = folio_pos(folio) >> inode->i_blkbits;
@@ -583,8 +584,11 @@ static int metapage_read_folio(struct file *fp, struct folio *folio)
 		pblock = metapage_get_blocks(inode, page_start + block_offset,
 					     &xlen);
 		if (pblock) {
-			if (!folio->private)
-				insert_metapage(folio, NULL);
+			if (!folio->private) {
+				ret = insert_metapage(folio, NULL);
+				if (ret)
+					break;
+			}
 			inc_io(folio);
 			if (bio)
 				submit_bio(bio);
@@ -607,7 +611,7 @@ static int metapage_read_folio(struct file *fp, struct folio *folio)
 	else
 		folio_unlock(folio);
 
-	return 0;
+	return ret;
 }
 
 static bool metapage_release_folio(struct folio *folio, gfp_t gfp_mask)
-- 
2.52.0


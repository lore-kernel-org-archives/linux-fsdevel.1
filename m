Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675D23F5BDC
	for <linux-fsdevel@vger.kernel.org>; Sun, 20 Sep 2026 10:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789898890; cv=none; b=uctla/cDjRL3sLfN+30B8TrLG7PzpbR9IPe6XyS/OeaGPmaaz0drAcEE8ru1RHb7cGykLmnGCaP2Okr3euZ8EbOxfpRGK31pxPjafW49OyZLVchLfR/3yDN/4ti/eFXOdrmQRz/h5p3E6lXVNm29UoDQzzJQKb5NfgHS2YbQVrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789898890; c=relaxed/simple;
	bh=PNvMxKShrfNb5Zr4NthNn918fjYx5BRyIvLyub64Yow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Du7RFdUPZqZQQuadQPssSQtLibLWdrMJ7zVqFODB8ZWJP/wQH/6LNGU/mGSeGSIJ7FEFnkRYKqN8W7IrJmDzzWf59dnrA/Gyghm7/BvO0K7VtczhqmViap4/YmuJ0IDdqaW5Q/s4mymyC9ZecnTRi0/dX9d2r5WOX71HQe3LMWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ArnG9fMu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ArnG9fMu"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68K8ZVqh2273387;
	Sun, 20 Sep 2026 10:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=VKGRdchr3myeBi9/qSi6TB1aa46N1k
	x740EXek8WPKA=; b=ArnG9fMuxvzBzC1PHxTU9d7CyW/0Z1PotynXTp3pExTpTy
	fA74rug3a5ymbOu/TMMUHkw7dfs5X+k7zS8+SEDSHiRRstHQjXWByIqa7oylBiMB
	tSvQbmi7neRhy1UjBuQt4526T/p7PKTT9JxdEXdzaj+PAO8kKXEvsq71jSCbk7td
	0io4XHrbooIDKyP+QisB0zCfLplngVfLAPRFcIOPKgq4c0jZnvTRUnSapUw1z664
	KfUU1VysCErYV9cWjjGFWZOHZhA4tX6bRHb2H+LvEmqiHHUrFRUEQ3Wfw21KHsJV
	lkkPJIX1sefenFKpqoblv4ychtfZyosqW9eSQMQA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskduv1ss-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 20 Sep 2026 10:07:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68K8WdsO3610306;
	Sun, 20 Sep 2026 10:07:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt5qjh68w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Sep 2026 10:07:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68KA7hGW26935596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Sep 2026 10:07:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8AD520067;
	Sun, 20 Sep 2026 10:07:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2FA520063;
	Sun, 20 Sep 2026 10:07:41 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.209.136])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 20 Sep 2026 10:07:41 +0000 (GMT)
Date: Sun, 20 Sep 2026 15:37:38 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Sridhar Markonda <sridharm@linux.ibm.com>
Cc: jfs-discussion@lists.sourceforge.net, willy@infradead.org,
        shaggy@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs/jfs: fix NULL pointer dereference in
 metapage_read_folio
Message-ID: <aq-wauLgtawf7twc@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20260812165353.64848-1-sridharm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812165353.64848-1-sridharm@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ficmp2lrAggDomTzK0DZyKFdy7J-jEkM
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDE0NSBTYWx0ZWRfX3v+OUG2K5Jtt
 odHAqNgn4vig1RHo99M2mPKckvoSjmP82KCKNK6k8pHBpgNVQwIyxI0z+Lq0GzEdGaPA5wdVtUj
 Cm4oAcdm/oc8isLMF4FwZoz8FRkucIM=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6aafb072 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=ODK73_P4HK4WQ25XS_wA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: ficmp2lrAggDomTzK0DZyKFdy7J-jEkM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDE0NSBTYWx0ZWRfXxM1546neQF/W
 1sPujmcQXrWi4Uee4TGtMNoloGw/jmyZA8GB8Z8WYXnFYmEvqiZeBUgb0hX+/MZQIM/owt97wiB
 f5YgaPaZRl+4y+BTWzYUtUPyjOvvWKNJjN0/6pk7lnO5z3/Hc8ungB4xdhJbZ5CLC+kbc6iU42r
 X87VG6ZCPZH59Hj1c+SyQtA0xbdGoY+152uu2IADc3AJoECyn4RFE3/Ogu/ZAh3Sk240kBivybI
 SdXoRed6x60WhKsLyeSTeVya2BXR5AllhkUw0vtZhuRyAG/ChhMxF//vD4KwZj4kKV/K7OrHCd0
 hnz2mCeSg88OvgdyX0kOHIor4tSScx/aOYqNHGBJgwUj8V1FdtXJCaD4R20FwXdofbsZIgsaaLM
 Qz3HbO/l2vMwyGW1mu0OYVDhYSksimr4nuuM6aHAwKA7J6Y3oaEM0H7pv6n6RoNzOwyveWhR7SQ
 K9AcS5EUJ8yxQnJadWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-20_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1011
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609200145

On Wed, Aug 12, 2026 at 11:53:53AM -0500, Sridhar Markonda wrote:
> This patch fixes a NULL pointer dereference in JFS found during syzkaller
> testing on PowerPC systems using large page sizes.
> 
> Full crash report:
> 
> BUG: KASAN: null-ptr-deref in instrument_atomic_read_write include/linux/instrumented.h:112 [inline]
> BUG: KASAN: null-ptr-deref in atomic_inc include/linux/atomic/atomic-instrumented.h:435 [inline]
> BUG: KASAN: null-ptr-deref in inc_io fs/jfs/jfs_metapage.c:140 [inline]
> BUG: KASAN: null-ptr-deref in metapage_read_folio+0x238/0x7b4 fs/jfs/jfs_metapage.c:587
> Write of size 4 at addr 0000000000000004 by task syz.6.4880/59986
> 
> CPU: 1 UID: 0 PID: 59986 Comm: syz.6.4880 Tainted: G             L      syzkaller #0 PREEMPT
> Tainted: [L]=SOFTLOCKUP
> Hardware name: IBM,9105-22A POWER10 (architected) 0x800200 0xf000006 of:IBM,FW1060.51 (NL1060_148) hv:phyp pSeries
> Call Trace:
> [c00000006e836e30] [c000000000bf948c] print_report mm/kasan/report.c:485 [inline]
> [c00000006e836e30] [c000000000bf948c] print_report+0x444/0x9a0 mm/kasan/report.c:471
> [c00000006e836f10] [c000000000bf9c10] kasan_report+0x12c/0x218 mm/kasan/report.c:595
> [c00000006e837020] [c000000000bfc62c] check_region_inline mm/kasan/generic.c:186 [inline]
> [c00000006e837020] [c000000000bfc62c] kasan_check_range+0x270/0x380 mm/kasan/generic.c:200
> [c00000006e837060] [c000000000bfd664] __kasan_check_write+0x20/0x34 mm/kasan/shadow.c:37
> [c00000006e837080] [c000000001acb808] instrument_atomic_read_write include/linux/instrumented.h:112 [inline]
> [c00000006e837080] [c000000001acb808] atomic_inc include/linux/atomic/atomic-instrumented.h:435 [inline]
> [c00000006e837080] [c000000001acb808] inc_io fs/jfs/jfs_metapage.c:140 [inline]
> [c00000006e837080] [c000000001acb808] metapage_read_folio+0x238/0x7b4 fs/jfs/jfs_metapage.c:587
> [c00000006e837130] [c000000000950df0] filemap_read_folio+0xa0/0x268 mm/filemap.c:2501
> [c00000006e837180] [c00000000095c234] do_read_cache_folio+0x2d8/0x5c4 mm/filemap.c:4101
> [c00000006e837200] [c000000001acd974] read_mapping_folio include/linux/pagemap.h:1028 [inline]
> [c00000006e837200] [c000000001acd974] __get_metapage+0x1c4/0xd78 fs/jfs/jfs_metapage.c:729
> [c00000006e8372e0] [c000000001a947c8] xtSplitRoot+0xd8/0x874 fs/jfs/jfs_xtree.c:1242
> [c00000006e8373d0] [c000000001a97a4c] xtSplitUp+0xad0/0x1240 fs/jfs/jfs_xtree.c:785
> [c00000006e837580] [c000000001a98ea0] xtInsert+0x7c0/0xa18 fs/jfs/jfs_xtree.c:608
> [c00000006e837780] [c000000001ac851c] extAlloc+0x7bc/0xc74 fs/jfs/jfs_extent.c:150
> [c00000006e8378b0] [c000000001a8a7a0] jfs_get_block+0x3c0/0x868 fs/jfs/inode.c:254
> [c00000006e837950] [c000000000e1af2c] __block_write_begin_int+0x3c8/0x1318 fs/buffer.c:2142
> [c00000006e837a60] [c000000000e1bf98] block_write_begin+0xac/0x230 fs/buffer.c:2253
> [c00000006e837ab0] [c000000001a8c454] jfs_write_begin+0x58/0x114 fs/jfs/inode.c:306
> [c00000006e837af0] [c000000000949a30] generic_perform_write+0x2e8/0x754 mm/filemap.c:4319
> [c00000006e837bf0] [c000000000964174] __generic_file_write_iter+0x210/0x244 mm/filemap.c:4436
> [c00000006e837c40] [c0000000009642a4] generic_file_write_iter+0xfc/0x35c mm/filemap.c:4462
> [c00000006e837ca0] [c000000000cf9cfc] new_sync_write fs/read_write.c:595 [inline]
> [c00000006e837ca0] [c000000000cf9cfc] vfs_write+0x530/0x95c fs/read_write.c:688
> [c00000006e837d90] [c000000000cfa4c8] ksys_write+0xf0/0x230 fs/read_write.c:740
> [c00000006e837df0] [c00000000004ebbc] system_call_exception+0x26c/0x760 arch/powerpc/kernel/syscall.c:153
> [c00000006e837e50] [c00000000000d05c] system_call_vectored_common+0x15c/0x2ec
> 
> The crash occurs when insert_metapage() fails to allocate a meta_anchor
> structure. The function returns an error code, but its return value was
> ignored, leading to a NULL pointer dereference in inc_io().
> 
> Check the return value from insert_metapage() and stop processing the
> folio when allocation fails.
> 
> Fixes: 7fab479bebb9 ("[PATCH] JFS: Support page sizes greater than 4K")
> 
> Signed-off-by: Sridhar Markonda <sridharm@linux.ibm.com>

Looks good Sridhar. Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
> Changes in v2:
> - Keep insert_metapage() in its original location.
> - Check and return errors from insert_metapage().
> - Update the Fixes tag.
> - Test with xfstests on ppc64le (64K pages); no regressions observed.
> ---
>  fs/jfs/jfs_metapage.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
> index 41fe12e641ce..ffbb186e850c 100644
> --- a/fs/jfs/jfs_metapage.c
> +++ b/fs/jfs/jfs_metapage.c
> @@ -573,6 +573,7 @@ static int metapage_read_folio(struct file *fp, struct folio *folio)
>  	int xlen;
>  	unsigned int len;
>  	int offset;
> +	int ret = 0;
>  
>  	BUG_ON(!folio_test_locked(folio));
>  	page_start = folio_pos(folio) >> inode->i_blkbits;
> @@ -583,8 +584,11 @@ static int metapage_read_folio(struct file *fp, struct folio *folio)
>  		pblock = metapage_get_blocks(inode, page_start + block_offset,
>  					     &xlen);
>  		if (pblock) {
> -			if (!folio->private)
> -				insert_metapage(folio, NULL);
> +			if (!folio->private) {
> +				ret = insert_metapage(folio, NULL);
> +				if (ret)
> +					break;
> +			}
>  			inc_io(folio);
>  			if (bio)
>  				submit_bio(bio);
> @@ -607,7 +611,7 @@ static int metapage_read_folio(struct file *fp, struct folio *folio)
>  	else
>  		folio_unlock(folio);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static bool metapage_release_folio(struct folio *folio, gfp_t gfp_mask)
> -- 
> 2.52.0
> 

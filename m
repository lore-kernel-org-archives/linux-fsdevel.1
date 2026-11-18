Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794987126;
	b=47jCbIA9lOs87AnFbR93sJh9zY18UBcVXAPq6DJNK1vVZENFyxV6gf4C4Ty767zm4uYd
	 /EWArFmPpiVcFD+62mwhSZayvJVMmv79g8oS8bL7Y4KNBJ1ASctJ/T4+FCjWO4CyR3oWA
	 NqRFTNtGwUnKtaLYIv1R5sydXkMkng5U9YpEGfPsqul28LoRaj3/KtolFHTiNxnjRGuZX
	 ZrUf6Q9wIqBsP4aktq5CjCSoXyCgxwS77KyZaxsQeTXpW78uxhM9hMVqAxBMz/sfOFeZo
	 YqI28aaC04WQKPZVEbH3G5JR/PxD3BCsTL+7QmpdME6/H/ocVONXCrzM8ifG35Hh92A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794987126;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZJ+tzoNeQbwJaxzE6IqF470/57tlUDZlSxrmF/lpad4=;
	b=TO3jDefjKNQLiNrsz606dPAyxKnMsRDRrsDSYC85FssKRKTNmy/++1WJ/6poon2w6Ukq
	 sdEOhdoxtOMrnyCXPKW84BqUouCJai308bpt8v95N9VA5kzZtblBNFa20gCwh9RqkVJQK
	 376S8CaCy6oVtxlETtdgzdMKYxvN3Bz+blyb0sB1UlpwsyHppIU5Aqkj7jJhnXThHKgcE
	 rAj7TvlXrknNnifcNYYEjpj1q9QWBVqYi3yIyIYJDMMGIdok9BGso5PRyIlHuDmIXf+vO
	 2s6oKQczaAToky3qLZtqGF5RhHUFZUFBTDdkdvqdGbbzgJvBSnvm+mPdJitmfuwTO1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b="N6Tn3xa/";
	arc=none smtp.remote-ip=162.62.57.252
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A4B606A31C;
	Wed, 18 Nov 2026 07:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1A4B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=N6Tn3xa/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794987114; bh=ZJ+tzoNeQbwJaxzE6IqF470/57tlUDZlSxrmF/lpad4=;
	h=From:To:Cc:Subject:Date;
	b=N6Tn3xa/pKKDXQopCVZck6Ty4OGB3ZK40DuopE+6uYu8L9CcCAYIN1jFLXI3BsPIb
	 jVL6F7nEyXK0L6JP55kYSnELw6mJwLZT2YPlMybYhGVM/ANkXCXrjCL+gXLdBWzwAf
	 EsyKptnlRrPc0/BbN/JGDJTKqKQ7KtIRkTspq+lc=
Received: from [172.18.4.77] ([202.113.185.209])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 7F49606C; Wed, 18 Nov 2026 15:31:52 +0800
X-QQ-mid: xmsmtpt1794987112tm8p4f34k
Message-ID: <tencent_0CFF1B64C4CB09D8F436EAC6272D8A215505@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+QME67ve7kj+sazgtgCHtjTXsVFdyqeQ1UIk1VCVnNFaw2EUQDJ
	 mzAlGGoAxo0aCt/MtxlKnGp8h0dUF87iXZX/XpFRwBBc79TEJesANwzw+lfZbaqTgPG2DrFRVt1V
	 tKlIpA6jTH6pLlCFgstvLuG4fTagc4mX6Pqb8OVoQFOwMZ9AEdTqIegiJe+8zx6Z99nPW9iy1k29
	 kTQDRrnAHy68pKSPIma918amSFTo/+9XjbMe3MHM5FdRdZhwHNGwQZDUP4rbRqavdiAv37s4rzzl
	 QxuXPm1A0kO2rPwDua9ExSApMrlfogqmDTBlqzLJY2gJevC6/LTiwLoBYLMSEv6+fFMgK4NUd4SM
	 te2sbcaca/3QamFaVdNrRHuEGe16XrPu0Dm/7ILfmttu1K/zxAZ2NL1TAMQwlCRHx0FVnwreW3OC
	 xNSMFV38qsj0+esGha8KOEfhiJ0mAOWI26DeiSZ+mczHyVx2FUa/9STt0PkHeefiDnQUtfWslvOs
	 mQH1iPf2+GMPrwvzf3Nkg3t7tNNzR+52MQdwSWwZcygxna3+8G6NxQFmxsOVk0mAQ4bSpuFfS+YR
	 3ffC0ivUBqHRSCyF8zDhFytzezhz59MTzD5DUzKhROgSZK5g/yHfeaKMyB5ROoLGDbhKHjSLm5Ll
	 WF0yH4uMnhtxsuCcuR248iGIdo8hws05GOuB2FypKL7WZ/QTO0kYAkVcnX7sm4CUI9rzE4W44ARn
	 r52+oP8Fm008RWW9a+BrbN9BAMfI00V8BxacujQy+vxMRMw00HtdT3f8VshCxFR81BfEKAsjtyP/
	 /B93HYoPYOxdfU/Saw5pvY5YYRtT4Ep8bP9FCF/xgjYXcbC1XlIkGhbjt4wdIFm45RKm45Mb3Cs0
	 vW65OQEKEjG4CQUsjuAiPtVVsS86D/KLoK2k1RF4FcQPxLz+URR/B/2GwFD6FizX/GA8KNSGhZuE
	 QBXV8udqy+sRUoyIQUcgK+qdaUDx+neb6h0mPP5ZLhw1pMEXI0AEu1PJsHTWIdSxaz0VSxZEb92I
	 84ziEtsa9coaJQBIP/up++lxi4xBJYel5jH8jyJRruby95PASfbV06mbmvXu0=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Guikun Yang <yangguikun19@qq.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ufs: bound the cluster summary index in ufs_clusteracct()
Date: Wed, 18 Nov 2026 15:35:00 +0800
X-OQ-MSGID: <patch-ufs-contigsumsize-20261118@qq.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

fs_contigsumsize is read from the on-disk superblock into
uspi->s_contigsumsize with no validation, and c_clustersumoff is read
from each cylinder-group header with no validation.  In
ufs_clusteracct() the two combine into a derived array index:

	i = back + forw + 1;
	if (i > uspi->s_contigsumsize)
		i = uspi->s_contigsumsize;
	fs32_add(sb, ubh_get_addr(UCPI_UBH(ucpi),
			ucpi->c_clustersumoff + (i << 2)), cnt);

The clamp itself uses the attacker-controlled value as its bound.
ubh_get_addr() expands to ubh->bh[begin >> s_fshift], so a crafted
pair indexes bh[UFS_MAXFRAG] past the end of the 136-byte
ufs_cg_private_info allocation:

	UBSAN: array-index-out-of-bounds in fs/ufs/balloc.c:892
	 index 15 is out of range for type 'buffer_head *[8]'
	KASAN: slab-out-of-bounds Read of size 8
	 0 bytes to the right of 136-byte region [ffff...,ffff...)
	 allocated by ufs_load_cylinder
	Kernel panic - not syncing

Reproduced 3/3 with a crafted 44bsd image (clustersumoff = 440,
fs_contigsumsize = 0x20000, giving i = 1880 and begin = 7960, so
begin >> s_fshift = 15).  A negative image differing only in the
fs_contigsumsize byte (0x20000 -> 0) writes 4096 bytes cleanly.
Both 7.3 and mainline are affected; syzbot has no report for this.

This is distinct from the earlier "five unvalidated cylinder-group
offsets" report: that fix bounds the offsets against s_cgsize and the
reproducer set fs_contigsumsize to 0, disabling cluster accounting.
Here all five offsets are in range, cgsize passes the bound added by
the fs_cgsize fix, and the overflow comes from the (i << 2) derived
index with a large s_contigsumsize.

In a valid FFS layout the cluster summary array sits immediately
before the cluster bitmap, so c_clustersumoff + 4*(i+1) must fit below
c_clusteroff.  Check that invariant before the update and skip the
accounting otherwise.

Reported-by: Guikun Yang <yangguikun19@qq.com>
---
 fs/ufs/balloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ufs/balloc.c b/fs/ufs/balloc.c
index 628edfde3..3858699db 100644
--- a/fs/ufs/balloc.c
+++ b/fs/ufs/balloc.c
@@ -889,6 +889,9 @@ static void ufs_clusteracct(struct super_block * sb,
 	i = back + forw + 1;
 	if (i > uspi->s_contigsumsize)
 		i = uspi->s_contigsumsize;
+	if (ucpi->c_clusteroff < (i + 1) * sizeof(__fs32) ||
+	    ucpi->c_clusteroff - (i + 1) * sizeof(__fs32) < ucpi->c_clustersumoff)
+		return;
 	fs32_add(sb, (__fs32*)ubh_get_addr(UCPI_UBH(ucpi), ucpi->c_clustersumoff + (i << 2)), cnt);
 	if (back > 0)
 		fs32_sub(sb, (__fs32*)ubh_get_addr(UCPI_UBH(ucpi), ucpi->c_clustersumoff + (back << 2)), cnt);
-- 
2.53.0.windows.1


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012091;
	b=4tEhF7WYSUXWLER/rAAAZpStaCRB4CvDTlgkKPaFHcAkXMx6u17ROsirLmPjjK+Ua/O7
	 gt07d6AmQMwtzsbBJWaob7hQDLu9tqeOk+UP2yd0VZ8gk/Kys3GHzs5kUZhwFMhJ4NxBQ
	 cSS+7c8cHR/6YZXGHFS0o3ANpb3qHENy2Ioo5JWziXWCzCPELzWxYPMZYlEE0gkIFR2cO
	 dJ5CFi0/4Kh5qOdfOV7EC9XHVOIJBZqIMddWak9M2w5jb7OZnW2x9kXZ9AFNzU5Nrl2SN
	 5AqL07wUTGRN1qx9NEbLN+DxSRewqSjO9hB0+6F7LqX6JgDSSLvJW+kd9wrG9Twp6cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012091;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=z0NfzSuMNJzMm6fJy91Mlbzb6nrsdQGraeKpktuDd20=;
	b=t946TOM66vD4MreCuo/hqCHROVARmc6NxlzjQ00L6kGQApSFDU9gfM/PuV/DI3DAJf5k
	 5q5jF5JcOibGjjnlIiZe2iCuDJEhBGPFmb/xdisLDnsJD8tOOSnE7qTa+l0A3K+5G31j8
	 5CX1/tH9dnUiLtrOqDa3mRcBupWT/sbSGuyu2KmOUT7WQy7XqafLeQ87S1fzgaEZG5xlK
	 vzVW6isPj9del52i2KSM7BrjhDuwEO5keulK4QzJv9x26jQA/A2BirQMmnD75MAl04RPJ
	 h/zA5gkW31v++UXJQzAnLWNfMAO90OGa4Ia4AqivHKNESdQB5+Gzb+ACf4QM/fMvVrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=zvpMq2so;
	arc=none smtp.remote-ip=162.62.57.137
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E7E606A33D;
	Wed, 18 Nov 2026 14:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62E7E606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=zvpMq2so
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795012075; bh=z0NfzSuMNJzMm6fJy91Mlbzb6nrsdQGraeKpktuDd20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zvpMq2solct51FVeXtCFHrRDV7Jo6JVx/XLacR4DiPbYPev79Vs6p4lslTa50Uc4Y
	 QrQIWYtYxV6iEnZ6f7jK6aMnrSJF0Rofh+FjxfQFjjjXbrPm0VhT49N9cuFecwp/Em
	 mLq+onLKLBGp7ke+T99aejk+T6SMcoeBx0UOi5dc=
Received: from [172.18.4.77] ([202.113.185.209])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 6F50AE93; Wed, 18 Nov 2026 22:27:53 +0800
X-QQ-mid: xmsmtpt1795012073txy70oh01
Message-ID: <tencent_C7873BAA3F35E59B7F44D209D13426EADE05@qq.com>
X-QQ-XMAILINFO: M1rD3f8svNznSnpmPMr/e898YafaFf89GlSLFFqeBJIEIPjY0LJM8VdvZy0P8+
	 9pyMgPSb4tXGdUjUbraqUWU9Ocqm5kEXGbWvQB3Yythtm4GBEXMEypMS4QqHtcaCJWlewcR6s1/H
	 i114qSgPdk4pm/+chnauC3EzNlYBgoybU1gJHsVCJX5voq5yRcvVYbnAxuS70sTPfI1m7aigKJSz
	 sTOF5bPYlF9b/0YEnX94Zl0Sh2D3eDhEyGTBUyTHI1lT5l8ycXBa2Nb7hlMIWYRZWp/jfCxUhl+e
	 teev0Yquptgvx2t+iy2AJleuWnhsLkaTFTHI0yt8QTYqVZtq5Y2l4AiQOaHCaTTNya7t9FNikbPC
	 iqSmRsxiEKQiW/5X1eMfisAylVVulzy/sCoROqjyX5PUwZIcqB4+CkFqOfTkj6ECmRbuDZskcwXe
	 BVuycL102oq+fcz6RbrPiOyrw8n1XnwBeCqq+M/uYXnG8FMGaWF1xUQC3SVhi6QK7zzV5am4LZms
	 1Nwz+xzED4END7CjeHqHJmcb0fwgQQaI7OJLHCjey4nT8iynSVSVxf1vh7RUSytp1ZrgPY9iAJp3
	 qr3vK6eBtto8EIlW5B53MjWND5ZOye8yuQt0um7cZtP4h+Wi4yzZT8fMet+ZF/qzqZfiQGVoYNmn
	 xA+ZZcrAmeLIPw+tLcbrjPVQTVvSB1qgrbcvOpNSVw6Wkw4KkECxgla0SMLCgyvEbpVhLkzDnp6L
	 D4Ix3gGFHKibQwYonHKkAkR0+cmnT10/XJeRs0Ovb3B93CJm2vlEb7u2PvgtOTrZfMM9E9/SG+0P
	 M2qt1RsXc1NyrxBUFKZnyDEsqL1Nz//O2JcISbc6c4c4ALboN3OoFQDDs1YQJE81PFyCgDEludnm
	 scMCTAY/z8+0BVIwGkFXp9d9bqVjg0aLo7JmymVbiSgrKLXhINpuTf3khh1KasrNEfoItVjEPAX9
	 bmyOqQkvJKbYOKyf/8o0kCU95KWDsfjF0FCtIAar0wHJCe9C9wLdIC3n6fdQYs6px6H6DPyyre3c
	 vlwx9c8U5Z1yJmvRpBaperT6snzPRqTXcwL7eIF9EvAyvFlTDJWOzENZuFnCqO9UgiGLDiK5kiiI
	 eR/B+hN/7sX/a3gXM=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Guikun Yang <yangguikun19@qq.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] ufs: validate cluster accounting layout when reading
 cylinder groups
Date: Wed, 18 Nov 2026 17:00:00 +0800
X-OQ-MSGID: <patch-ufs-contigsumsize-v3-20261118@qq.com>
In-Reply-To: <20261118-besungen-fingiert-festnageln-9233af206caa@brauner>
References: <patch-ufs-contigsumsize-20261118@qq.com>
 <20261118-besungen-fingiert-festnageln-9233af206caa@brauner>
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

Thanks for the review, and for pointing out both bypasses.

You are right that a point-of-use check is insufficient: c_clusteroff
is itself on-disk, bailing after ubh_setbit() desynchronizes the bitmap
and the summary, and a negative back with c_nclusterblks < start writes
at c_clustersumoff - 4.  This v3 drops the balloc.c guard entirely and
validates the whole cluster layout in ufs_read_cylinder() where the
fields are read, against s_cgsize (a trusted, mount-time-bounded value).

 groups
ufs_clusteracct() derives bh[] indices from three on-disk fields:

	c_clustersumoff + (i << 2)     with i <= s_contigsumsize
	c_clustersumoff + (back << 2)  with back possibly negative
	c_clusteroff + (block >> 3)

and ubh_get_addr() expands the result to ubh->bh[index >> s_fshift].
None of these fields is validated when read, so a crafted cylinder
group header can index past the 8-entry bh[] array in the 136-byte
ufs_cg_private_info:

	UBSAN: array-index-out-of-bounds in fs/ufs/balloc.c:892
	KASAN: slab-out-of-bounds Read of size 8

A fix at the point of use is insufficient: bounding the index by
c_clusteroff merely plugs one hole, since c_clusteroff is itself
on-disk, and returning from ufs_clusteracct() after ubh_setbit()
leaves the bitmap and summary out of sync.  A negative back with
c_nclusterblks < start also writes at c_clustersumoff - 4, which a
one-sided bound misses.

Validate the layout where the fields are read in ufs_read_cylinder()
instead: the summary array (including the negative-back slot), the
cluster bitmap and the block count must all fit within s_cgsize, the
summary must end before the bitmap, and the offsets must have a sane
lower bound.  Reject the whole cylinder group on failure.  s_cgsize
is a trusted superblock value already bounded at mount time, unlike
any of the on-disk offsets being checked.

Reported-by: Guikun Yang <yangguikun19@qq.com>
Signed-off-by: Guikun Yang <yangguikun19@qq.com>
---
 fs/ufs/cylinder.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/fs/ufs/cylinder.c b/fs/ufs/cylinder.c
index b930ee1cf..b6b3a7547 100644
--- a/fs/ufs/cylinder.c
+++ b/fs/ufs/cylinder.c
@@ -69,6 +69,44 @@ static bool ufs_read_cylinder(struct super_block *sb,
 	ucpi->c_clusteroff = fs32_to_cpu(sb, ucg->cg_u.cg_44.cg_clusteroff);
 	ucpi->c_nclusterblks = fs32_to_cpu(sb, ucg->cg_u.cg_44.cg_nclusterblks);
 
+	/*
+	 * cluster accounting derives indices from on-disk fields:
+	 *
+	 *   c_clustersumoff + (i << 2)   with i <= s_contigsumsize
+	 *   c_clustersumoff + (back << 2) with back possibly negative
+	 *   c_clusteroff + (block >> 3)
+	 *
+	 * and ubh_get_addr() turns the result into ubh->bh[index >>
+	 * s_fshift].  Bound every one of these against the CG block size
+	 * here, where the fields are read, so no later consumer can index
+	 * past ucpi->c_ubh.bh[].  Using a trusted bound (s_cgsize) rather
+	 * than another on-disk offset is essential.
+	 */
+	if ((sbi->s_flags & UFS_CG_MASK) == UFS_CG_44BSD) {
+		u64 cgsize = uspi->s_cgsize;
+		u64 cssz = uspi->s_contigsumsize > 0 ?
+			   (u64)uspi->s_contigsumsize : 0;
+		u64 sum_end = (u64)ucpi->c_clustersumoff +
+			      (cssz + 1) * sizeof(__fs32);
+
+		/* summary array (incl. the negative-back slot) and the
+		 * cluster bitmap must both fit inside the CG block, and
+		 * the summary must end before the bitmap starts */
+		u64 bitmap_end = (u64)ucpi->c_clusteroff +
+				 DIV_ROUND_UP(ucpi->c_nclusterblks, 8);
+
+		if (sum_end > cgsize || bitmap_end > cgsize ||
+		    sum_end > ucpi->c_clusteroff ||
+		    ucpi->c_clusteroff < 1 ||
+		    ucpi->c_clustersumoff < sizeof(__fs32) ||
+		    ucpi->c_nclusterblks > uspi->s_fpg) {
+			ufs_error(sb, __func__,
+				  "invalid cluster layout in cylinder group %u\n",
+				  cgno);
+			goto failed;
+		}
+	}
+
 	/* these on-disk values become array and bitmap indices */
 	if (ucpi->c_cgx != cgno ||
 	    ucpi->c_rotor >= uspi->s_fpg ||
-- 
2.53.0.windows.1


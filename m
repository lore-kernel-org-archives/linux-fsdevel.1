Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794070893;
	b=32He3Db1/nq4qm8RA2qH02oyDKDCT1vPAi4rQ+EWzTispeu8w24cgjVKjVdrCbJbV7ra
	 XYKPgFnaXNRdpFnBCcZ/hIG5fIcfcavsUCxTBpy75o9wMfMjKuW08OehFjockBawjpXiP
	 0TkQAvt9svNXCSZk2Fl40VpNxbiAux1ROQVk0xCusa4gv3sYJD/miAYH0BcUASErn/aoU
	 G3IGG/NiWvujH76Lq2OgKmx4IPuul7AfKh4/qKqHDWCCLK4Ouoyyid/kX+GsDgGi9WP40
	 RD3EeKWfJYWfycWmAAnSErHdOgXPLUbYz0GGVacSmfDRj541bIGNpbPX2nh5BZC3YdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794070893;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 MIME-Version:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding;
	bh=P0Mg464w4ZvmDplbFMZOj2xQiWO0RAmoCk3+LD4U1WA=;
	b=fYUhzR77CJO9He7QEutcPTFydDmIef0KwsHLBl+FX1HDrl5O6KPRyEE3ijc2FLXX6xKj
	 qpiY575VKkbZZKcr0OX1zfc2vvJf3ityrzOk+DLHGHOgHnJ9LiF/x/VTavpR3oT83D4L6
	 ECFF+B+HxeJi5j/w4We3+GyX+NVi0YgWedfF+4wR+YxcuHYQo1tnNIB+CbeqypV86z7f+
	 kVG1J5N4UEBBTq8qNJMW5Mvz54CD4KgvNx0SnFNsIDb8AIY3S7/WGQXQLqg7g1Afofswn
	 x3bDVgHJKcEZ6dR2IgpjIwx/nebvWaAdVNl/lBt40FmdncuO1wC9NAl3o644+41M4og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=Oc8hJfOO;
	arc=none smtp.remote-ip=203.205.221.236
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C4B606D821;
	Sat,  7 Nov 2026 17:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50C4B606D821
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=Oc8hJfOO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794070884; bh=P0Mg464w4ZvmDplbFMZOj2xQiWO0RAmoCk3+LD4U1WA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Oc8hJfOOdBNNI8XoRupzZ3OKXWCeaAWRTJdA79OZQdtChK/r3jANPgEF9Y0ziD83w
	 MmrjA3uxhKLxCwRzKKnuQRK8wCxcFyMVCrEOFO1b0/6Cuu5ofZIuCB5kBIvaqdrvkU
	 gsW0FgxTwJSYsn5p2aEXp8SO391VjEAMC7Sdt1zQ=
Received: from [172.18.4.77] ([202.113.185.209])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 5632279; Sun, 08 Nov 2026 01:01:22 +0800
X-QQ-mid: xmsmtpt1794070882t4q79gmej
Message-ID: <tencent_BB8BEFED1159A70D5381A81D1F8EA88BD407@qq.com>
X-QQ-XMAILINFO: MZtEYADUG4AgCwYNHUf2pr66fvqds1hDO/jMzl7/7F/5ZEB0qq8c+VLBPAQ9IN
	 1doCtS+Mr92MhKSDcnOjIwLIQwZS0wrfiUPiPO6HTe7+SCNTpadYomxg57dPxkQh2RIN6ZConUMK
	 xMmuPQy/ykluUfa8WBcMBvsigcyysuTu0MLKmY1f2z9hiU06j4Vgo7jwqgitcyqYcqYHFnj/8NuT
	 4iAAtiPWkUY+4mD+lNNanbfJ3/lDWlrx8Av5yhFQ6PmB5jcF7Atk6tvLoGSq63OwYndhiCLzEDwg
	 lDS44wlwaOe7/TqN5uVEP7HUpT2ldkGhlV7ksY3X9V2shvrxmb5Fr4RBHvNMaXTP4XIN6yLqDXTi
	 i5X7FM2ENyI0BJb4wb0j1OoDHhJl7AtxvYTWkFQ2nliSBy82835adMmDD7XHFugPttcsxwi9pT+t
	 7ZOAFy4KOoUemLDpS8plwwI6dYiJDXwk0njbJabQp7Zcf4w0liDXBv3o3IjPj8eG+Qi6ETO/m9Rn
	 BcSU2RCIC9sGRguN+6RVf7qhuYEnjRA5S14BLuhXq2xom5FDsHg8byp45XZJchOz9vbk5J4xs7rG
	 +/qOLuJqs+YGl8bDqKRDxkBlgFdAboc1k2GBvTeeuHCRAwwmt1YYOjwmFYwkjG7MqghecuHhv8aj
	 FhMl4tOSlyT+KcrGWixq+g5mnUmnwcKphJ8lGWpZUHTV87gRLrcAXwEXT6vOYiU0GLeBOoe5U2iu
	 oEfkWvPuFKmqwOTUzMHWFFsS5VlyLD1/tlA6sUlx47PFeWBt0kMMTSA+zv5jyMW9uHZad1JzzCNf
	 7IBQYeKoEYcPJXzEXz7ifDKz5yj0/mnSpvAkZgzmp/jAME2ydv0bAM0ZzC6q7DLIwbF6MLA6z1bF
	 eeigbIdXh/JR12i/VCi155i2g4YiIo4pClL/wjP8brXeKMBIa9Zp+4fPOM/cemY1VnpqUibnl9UW
	 D/SSceGbN7DbIAxmHyIuqiVdAelQnJJVbCn1F5v+Ic1qNX4rKvq08JEe84wI95xuZAEs6kJcIW3s
	 /AhuiMlWIZg/RVEP6Q2RR8uJ6eTg2WpohoHxaAV0WFwQA99B2o/cY45TTqVxuJDjBu4HxcHg==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Guikun Yang <yangguikun19@qq.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] qnx6: validate di_filelevels against the block size
Date: Sun, 08 Nov 2026 10:01:00 +0800
X-OQ-MSGID: <patch-qnx6-filelevels-20261108@qq.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <c4-qnx6-filelevels-ubsan-20261031@qq.com>
References: <c4-qnx6-filelevels-ubsan-20261031@qq.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

qnx6_map_block() computes the direct-pointer slot as

	bitdelta =3D ptrbits * depth;
	levelptr =3D no >> bitdelta;

with depth coming from the on-disk di_filelevels byte. Nothing bounds
depth against the shift width: with ptrbits =3D 7 (512-byte blocks) a
di_filelevels of 5 already shifts a 32-bit block number by 35, which
is undefined, and the resulting levelptr indexes di_block_ptr[] out of
range. The superblock check limits the inode and longfilename tree
levels to the constant QNX6_PTR_MAX_LEVELS (5), which is not
sufficient for small block sizes either, and the per-inode
di_filelevels byte was never checked at all.

The usable maximum is 31 / ptrbits. Enforce it both where the
superblock levels are validated and in qnx6_iget().

Reported-by: Guikun Yang <yangguikun19@qq.com>  (bug report of 2026-10-31, <c=
4-qnx6-filelevels-ubsan-20261031@qq.com>)
Signed-off-by: Guikun Yang <yangguikun19@qq.com>
---
 fs/qnx6/inode.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 1111111..2222222 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -406,6 +406,7 @@ static struct buffer_head *qnx6_check_first_superblock(st=
ruct super_block *s,
 					  struct qnx6_super_block *sb1)
 {
 	...
+	int maxlevels;
 	/* sanity check - limit maximum indirect pointer levels */
-	if (sb1->Inode.levels > QNX6_PTR_MAX_LEVELS) {
+	sbi =3D QNX6_SB(s);
+	sbi->s_ptrbits =3D ilog2(s->s_blocksize / 4);
+	maxlevels =3D min_t(int, QNX6_PTR_MAX_LEVELS, 31 / sbi->s_ptrbits);
+	if (sb1->Inode.levels > maxlevels) {
 		pr_err("too many inode levels (max %i, sb %i)\n",
-		       QNX6_PTR_MAX_LEVELS, sb1->Inode.levels);
+		       maxlevels, sb1->Inode.levels);
 		goto out;
 	}
-	if (sb1->Longfile.levels > QNX6_PTR_MAX_LEVELS) {
+	if (sb1->Longfile.levels > maxlevels) {
 		pr_err("too many longfilename levels (max %i, sb %i)\n",
-		       QNX6_PTR_MAX_LEVELS, sb1->Longfile.levels);
+		       maxlevels, sb1->Longfile.levels);
 		goto out;
 	}
 	...
-	sbi =3D QNX6_SB(s);
-	sbi->s_ptrbits =3D ilog2(s->s_blocksize / 4);
 	/* (moved above the level checks) */

@@ -561,6 +562,14 @@ struct inode *qnx6_iget(struct super_block *sb, unsigned=
 ino)
 	memcpy(&ei->di_block_ptr, &raw_inode->di_block_ptr,
 			sizeof(raw_inode->di_block_ptr));
 	ei->di_filelevels =3D raw_inode->di_filelevels;
+	if (ei->di_filelevels > 31 / sbi->s_ptrbits) {
+		pr_err("inode %u on dev %s: too many file levels (%u > %lu)\n",
+		       ino, sb->s_id, ei->di_filelevels, 31 / sbi->s_ptrbits);
+		folio_release_kmap(folio, raw_inode);
+		iget_failed(inode);
+		return ERR_PTR(-EIO);
+	}

Tested on the image from the bug report: the crafted di_filelevels is
now rejected at iget with the message above instead of shifting out of
bounds in qnx6_map_block(); the unmodified image still mounts.

Fixes: 3735188fae42 ("qnx6: add support")
--
2.43.0


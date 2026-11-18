Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794987847;
	b=Ic7ncPLIc9i7+aWTr6PGNVia9Y4MuC4474WPdnoAAB0na9iZlvaYa1WUqkVz5RGFZd7H
	 qNa5zWqWCVVOFGhAAfAJxWnQlzYGMQtAmz4ZumezmdxnOq9oiCx9hsbR8hjXdvDS507le
	 qvQ2nDjUM1pu5UkoYw22TfPL7Jjseec1lwvFjbgh05FsQV2KVryaSrQE9sLwKqIT0yJ56
	 hIw7IqySv0njQmeF58NbB/vqd/o71EKY5eVnTFc+ixTAHR8nqFq0BkLng8zB4fhtNcYQ/
	 UaSpORm3PXHKFnMLbmB7UPnZRHRIG+pRWPngPwIx3q4MFGJCRsmXwg6FIvBjJI/Dvhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794987847;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hlXfyfcS9yj7Pl4pcoW52aPOtSssL8itfRvf+2bE8RU=;
	b=Vu3tqPV2rWywCuKWHDEKXtaLyMkUDQa5HCMRtKtAVA32cfnrHHN6aehtwBtZ7goFX6aM
	 +jU2WMcSr2wkQgm6OfXlYZIQ4Xif32+o3i6z541D9r4f6pKx6mxCy98kkjF7Zk2OKlIl8
	 +8iVBZO7ubfzpMKMrPmj9pxVi93/v/5Un5Wv0dNO/gkwkXPA1MbBQqVCyQOUK51owbErA
	 BtUn+BnWQ8BAUfldi7JMVLfoeBbgN20KKCIcKJ9vR/eWwCTCAR2VYdmPTGwXZhUOR+JuI
	 gtfNIaEy6jJUBi3FH+3Q+1XlJTXuXt+bV27yrTcWK+FwmqhD9aahlbMiRA37ZfKYrlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b="XvQG4/M2";
	arc=none smtp.remote-ip=162.62.57.49
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57A5606A31C;
	Wed, 18 Nov 2026 07:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C57A5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=XvQG4/M2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794987841; bh=hlXfyfcS9yj7Pl4pcoW52aPOtSssL8itfRvf+2bE8RU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XvQG4/M2N6397e/AHn8EOHoKBLKEcLNfzKZlZFA9rH62cpIK2c6xs2jwj1cxyoMcT
	 9gWfROR7yb5UfOUNpq5c87TG7bJJlTbk+2YYf6QHdzyjkrafpcZ20EMA+tWR5WwLZo
	 QzvRoyAzu8rqMh6TVfY2/f3SDHsj9ZVSXK3p94SA=
Received: from [172.18.4.77] ([202.113.185.209])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id AFB9C899; Wed, 18 Nov 2026 15:43:59 +0800
X-QQ-mid: xmsmtpt1794987839t15qu3y9k
Message-ID: <tencent_ABAAD2B7E6C8BB138AE97AD4BF0F49145F06@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5OcRVunGWqDjZwf5Nq2E9B0MttTVyEjqvoGxe7D2IlJ+qXJWs6l
	 b/SxTKSfSgYY3c/ecDDXLaeyw7TVnom10b/bZFbzm7bmQ+CkqlM98AqHb408JycHuHQzqKkH22VF
	 +D9BGIPVoueIZNITEeTkulyH70fABDp5YvM6pUuQilBf1A/wKXERJUHsYtm0SAVfnSqrReqLUQgk
	 u5gq2WVRAPgidxKd9MI8tG3PCPcFUPukeoQYQ6co0ufDsi32c8SrK7oA9B5BNIKQwNbUrNexIEoS
	 NMhnp7+yVdM6aJuknyjtGcFEUrPFxwv4lcVb8RLPJxFi6VCJrrEFxFQ/xRtvLHFjmkOh/3GvjSqD
	 XqXkAy7eZMoLH079U0pL++COUt+WOwqzk2WT7h61lUUjIqTTtUMBDe5IRzrvKIiyc/QgWd0j9I7v
	 D9rCAm4Knucl+1vp9nlQIGhizWK2BHt+P+UljrRNCg3wk3jO5y51g+8zA9BgfR2PVN4WGIJIOZZD
	 zmAakA6otz1BfkgGVBy8gC2qqTz3Wo6C+ajCTUbloIIGLOZ/3SwEMlbg+7lBaIAM/bAQmwA8CH5p
	 G78Yy82SJrzpq06wtaPYl85GOaSG7Y77fMWN8T7WSQuYhqEkA+n4sN/iY9/PlYj8qXg+WchO+h4h
	 K8y5heQfroblKjF4wICvMibZOUnEHjCV0vEeL/a4/7vukUaNrCpkQyf/JVDq+wWpBkSfUmeYs/AJ
	 66ksyPuAQEm94nr61jepI1fPH03s3USEI97k+YafxNdvEraJP7SwNN1PtqJlys9GYehiYyLfIkFm
	 B8ZPHWONSoajssJLek8ex2OCQzL8POgHEeawWGjlVByGvZnyCZrEXobK8R+AAg1hk6NltRkZvz/f
	 Qhx+a6DedQJQJqV3nD9n4lIM755anExcrwvrbJmZvuLcPUqW8+u0PxJncnh856m30ITTA3qmWgf8
	 0w9tGmVF0M+tht5boUaYcy6axYSTG7tusNVRqbunonRe4w00+dE1MhDIIgVAheJ8CQGtb6BPegOv
	 sPGES7VQbGY73FQ+cfSDDnnesIQJUelr2WNTLylcL+/sx0FyMMNxpcw+CRtSB2Ff5SxjY3jrwL1S
	 6zhQKn+W/oPKXA+z4=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Guikun Yang <yangguikun19@qq.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ufs: bound the cluster summary index in ufs_clusteracct()
Date: Wed, 18 Nov 2026 16:00:00 +0800
X-OQ-MSGID: <patch-ufs-contigsumsize-v2-20261118@qq.com>
In-Reply-To: <patch-ufs-contigsumsize-20261118@qq.com>
References: <patch-ufs-contigsumsize-20261118@qq.com>
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

Resending with the Signed-off-by line added; the diff is unchanged.

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
	 0 bytes to the right of 136-byte region
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
Signed-off-by: Guikun Yang <yangguikun19@qq.com>
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


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792604748;
	b=uXCP9q1Z80aGZAmqv/lUscHSq5mStnUeLd3lP5DgJ5VwB/vyfGMgiebT+tZkhcMt4obL
	 HymxZeFtCN6btG22yf6Ues2IH2bfhkym67hoSiLTZYyiE7cEK/F+nLrDKloOS8fhFkCxO
	 5NVaFfzJQhUVQUx9EYRnY0GGwMcKu7v6B3j04FDp2nFvpjQJ5/T0wRE/H78/cYfmZtH6y
	 hxmkYCNtXrQXiPSW+ZcUYUhenr59rUYYT5POkRJ39t0yA0Zu08L03LO+oxFT7gb/3VyXS
	 56EQemJiz7tJhOUQWl2FzavQMk3aXfIreE1173kRcgzuZ8hqEUzKg1GT3yiSnk/dFYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792604748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qMSnAmvn+xg6zpwC7JmIegT9TgfMe039TBaNzlGjfQg=;
	b=SVQF7lWAkf6IxvH72SA/Ij5mbj1o+LmVDF1/fvqrllSK8ap9TCpf4cX3yN05dbIXyito
	 E2MstU3KI0F+z3MphwjaLnI98gF4ZUDxW0/hguJ7EEN2pYa6cWqoF2G7rUEk1+5xE8PVp
	 fgScnT2U+WhC3YCCsidJXD+jUeQCZV6ocKeW0d6VoDBayYaRa5eD7NomanPlwosQ9DxnW
	 fKZEcI7YbusIXB5hGsPs2GkCl3mRtYtGjgLrOcx8VN3Dz9op0czdDf42/QGaSXua6xsiV
	 II/siKh8ErSvKzjCBoyJPW5ZKLP3c7r6tjo5Gi/VJkSw2ngtvrI6xeY3QanSIMrjdlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=E4K0X3i8;
	arc=none smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77812606A31B
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 17:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77812606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=E4K0X3i8
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b0a28a720aso10719527b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 10:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1792604746; x=1793209546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qMSnAmvn+xg6zpwC7JmIegT9TgfMe039TBaNzlGjfQg=;
        b=E4K0X3i8r+6CaMc7vAJpCu7jS+wDCnhpEaPPLdQvVZCLJD37G+UJgN38uvC4T8dzwr
         NOfzj9+2eIomAlkoy02RfEzQG6qRQAhSVRjTdMvDG+rn1IW9pThm8Zqz/2dKsf1gIsmk
         ZRTF66Ylj9OO0YQxDgt2uNJCVrMbUuVzKZy3NrjoQwf31cJ8d5szD90Rm+QWb7Rb+DYs
         bRUTIH8nvFu/pqvIKTJhTz9gkdpR7+EpTOWmaB4k8JGZHf5tsS4ZbU8ueDmBuLQzm0z7
         rVsGvLeT1cvTkdC41gXIHWzZ1zH8Mwtu1NverGxQJ1vrt7j2o3kdnqX/BhGPFAVSol9Z
         wRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792604746; x=1793209546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qMSnAmvn+xg6zpwC7JmIegT9TgfMe039TBaNzlGjfQg=;
        b=R3eTE6VmyTPQdUjwVn715Y84+m7LXQ0RI2EPlG7vjAVLc0jrSRuxLgB8wU8e/SW8Gj
         8SYyxHLlBZFbISSPdCEHmnGSVZroELMoI70C8IgvkZQTk2DpnCp1bgKRkTg1BMnGb/sW
         ZG/DIuT4+9l0jwBKL9b6vl6DEnEnt5QkPZQwVDSS2rEv4za9EFZTH6ceuwP1rVhokzhc
         wfqrOeR2q6pDTn1kgq9zON8dD6xJNhV1jfioBXIJS2U50uVB646chup6p8JTnxVtA9QD
         k5bQK+ERffWgIPANt2WiUZgNnG/yiWgr76luKqx9cvHCUlAP4O82LrMDgAENMpWpkrkw
         nIig==
X-Forwarded-Encrypted: i=1; AKwUvBzYsgfv9A/hlPzR2Ix8WQ93Qk3rOlCDIuxzq8ybPQyTBLq26h1Qp4UEVhmGwCsaNKDFXEPfSQHKysHS0imo@vger.kernel.org
X-Gm-Message-State: AFq9FYIAbwlnIKHm8JCOfYvLJQwB5x8EfU2i5wae92orhRNEXzB1yLrV
	upMfrYVYD0B06GJcGdTRlGwK8zi0K69ghloho4iXnpSdyvxpm6/fVFKO8RWstchboA==
X-Gm-Gg: AYBFou2k6NkB7oLOgz9A8irDOSy6c8s6duwwbSMUFrCw1RapIHnQWXAc9jzCk+wn5t2
	P49tjbzwxChtbQwsPEC6YnTDcUlLNV+4pfCS1KL2i19vQ9KYGujuVQy/vELsymWZ18ADYpYcMKx
	YG0iEqwpwG7Cj9yLEj0MInn9Ql1lsbn6jxlZUq/QdmFCDGdHkRkdR4p7u2kBwKe3jKrUxP4n2a+
	upXLIZcH2P+kCcV4E4fBOvp1NZ/nBa6Dv3Vz6ZvX9aYoptBGYLGB2IrFlAMRiEqEwmZxI+3fO4o
	G9bOO+/3/OThuK56fJBKZoi/VpolDng9P07bUWRTqY1VpJ0CVGMsK5ZI5dmDx39feWzU6kzceew
	ybF0+AbJC2dpmJ0ydrir4vyhBdypLZ5bHfwiobRBBVHxv92kZb2D28x/kBwCgU2dYsfwoyDOcxD
	g1zhUSUKZ5tK0JNW0dKvajQ96tiKAM74xxaxmG3CtcHWMMlg9NfO2aNXyQ4sx6mP5XZIdqFZS6x
	Ex6Y9IRmwtdC3jy64X4E9BGCAv7yll0A/rde776TAT77cAxFvE2dhVXMPKcvURTPdnTPo3HHIAY
	SaI=
X-Received: by 2002:a05:690c:e251:20b0:8b1:901:b9ee with SMTP id 00721157ae682-8b133e48cc2mr11819357b3.13.1792604745668;
        Wed, 21 Oct 2026 10:45:45 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b1300f3cfesm14789647b3.27.2026.10.21.10.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 10:45:45 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: slava@dubeyko.com
Cc: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] hfsplus: preserve FinderInfo when listing extended attributes
Date: Wed, 21 Oct 2026 13:45:34 -0400
Message-ID: <20261021174534.482192-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit aef507847129 ("hfsplus: fix generic/062 xfstests failure") made
hfsplus_listxattr() return zero when the inode has no records in the
attributes B-tree.

However, osx.com.apple.FinderInfo is stored in the catalog record, and
hfsplus_listxattr() has already added it to the result at that point.
Setting the result to zero drops it. As of now, a file whose only
extended attribute is FinderInfo gets an empty list on a volume with
an attributes B-tree, which mkfs.hfsplus creates by default. getxattr()
still returns the value.

The issue can be reproduced with:

    truncate -s 64M hfs.img
    mkfs.hfsplus hfs.img
    mount -o loop hfs.img /mnt
    touch /mnt/file
    v=0x54455854$(printf %056d 0)
    setfattr -n osx.com.apple.FinderInfo -v $v /mnt/file
    getfattr -m - /mnt/file

Without this patch, getfattr prints nothing. With this patch, it lists
the FinderInfo entry.

This patch keeps the result of hfsplus_listxattr_finder_info() when no
attributes B-tree records are found, as is already done when the
volume has no attributes B-tree. A file without extended attributes
still gets an empty list.

Fixes: aef507847129 ("hfsplus: fix generic/062 xfstests failure")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
Tested in KVM with KASAN on a804c5742bff, without and with this patch:
- The commands above, and a C test of listxattr() sizes and buffer
  lengths: a file with only FinderInfo gives 0 without the patch and
  25 with it; a file without extended attributes gives 0 on both.
- generic/062: 10/10 passed on both kernels.
- Full fstests (805 generic tests): 186 passed, 11 failed and 608 not
  run on both kernels, with the same failing tests. fsck.hfsplus -fn
  reported no new errors.

With this patch, getfattr above prints "osx.com.apple.FinderInf". The
last character is lost by a separate bug in copy_name(), which Maurycy
Pawlowski-Wieronski's patch fixes:
https://lore.kernel.org/all/20260828-hfsplus-copy_name-fix-v1-1-75ed9f0f378c@maurycy.com/

 fs/hfsplus/xattr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 71364e093fa7..c74c81966f12 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -838,7 +838,6 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 	err = hfsplus_find_attr(inode->i_sb, inode->i_ino, NULL, &fd);
 	if (err) {
 		if (err == -ENOENT || err == -ENODATA) {
-			res = 0;
 			goto end_listxattr;
 		} else {
 			res = err;

base-commit: a804c5742bff224d4cb4d25dd383554d598be32b
-- 
2.53.0


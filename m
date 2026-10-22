Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792662069;
	b=HhVEWZkgxMIoQPdlTbtqg9XsNr67UIURIyoEwwbzDRXTacSdAXBHgVDhOWz4s++U5Q2R
	 bbgiBF79A+2Stj0TdOWxAoFeF5o9zZquITVvzR7YC16vBn+0wrvy5cwA+ykMNah3jVmth
	 QZX5AFhzML7tLuu4/ON2rEL3X68AK6ewJZB/0Yzipdl6/TZCXVl7vcKq+OVYDlI8tMIG0
	 ToQLBmQBvSR2GfBXyLNa3CVHuXEoBvfkwdNUC0rjDISGz4tN70DuzadTM9AzCCeJLMHNO
	 jk7zVEB1Uw47fI3/SqKjm0xqkXQKxnmxYXZWrDZlUU7lSOl6BXW4/URiFm7lsMB3K7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792662069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XIEdpK6uoY0VcAn4RMjuLM3ziGKUkenXplth+Lt8Y7A=;
	b=5fVuaqMBshmhuFtZCV9G0Rv5tWTKMoiqEniibdgw6BD/fExTZqTBnCFZmtyA5ChZxi1+
	 hI7Bp8QhJlda/u/voE8bmtPQv5h8MeHExA7oqEMyXhyfREU/Bl1mV0LsyfmKktmK2ghRQ
	 UxCXUZkPNCZbrzCF2Zl77wKo4tD06ovHobjG36/H3SKEkXKmRMuYU3gDhMm40FLSJ96/q
	 ZnGGZ9/uO28/Ue1O8YHzeuLuQP73Kwl8tbBweEL6QpAbxw6c4jwSFHjumfRrWbA5Z9nPI
	 oKCDnQoBtsdXukdBKuEjd5npXe52JYLii2mXJTWYSItyLBraL5T7D8sXHYg7BkjBYCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=kz3Vg9pv;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C9C606A33A
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 09:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0C9C606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=kz3Vg9pv
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-918f75a68f0so22439776d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 02:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1792662067; x=1793266867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XIEdpK6uoY0VcAn4RMjuLM3ziGKUkenXplth+Lt8Y7A=;
        b=kz3Vg9pvKqAJ2lSpLZ/iAeT6tIlkg/q/lJDA65XliRZtEb1BP2h5McqrqUuHNE0A+Q
         T9EOQwdqdK6yfwIGeUo6xoq2dQwQitTjYraLMBqq26QrO/IDS5sd4VHYo4z6/M1MoOyB
         ZKc2iW9QbX2tDjW8lwIRHk4+AqR/joJ9OOmVHtvbiihqQbvYOCmvsop/a4capa5jPt5f
         lMym/OyK57LJd+Wjf/8q1yUDG6hb62kEKbpIea7mKtrydASLGKyYE1ov/CCJsT2oDsi3
         wisSn5UqPg+vcp1ZStL7L4Ctr/iQVO3K4ePRJlvpeODN7rNvki9IB7eSvRLerO8/ayfR
         bGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792662067; x=1793266867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XIEdpK6uoY0VcAn4RMjuLM3ziGKUkenXplth+Lt8Y7A=;
        b=sMAD9J6qCvWDabLAChPh+IPUCDz0gYPDu76mXRVU8mJa9O9JrhosOTwA96t1732G0+
         uZh9hYle6IFxAhuAJwousnRoUP6PnoanZuNJNqlVU6YLl4uHet1zRZioUst29cWa1D15
         8GYf7YQotp0ug0TJQVpAPoT0W+hUR4PB7wz/ixhNDCIFcDqlZn3ujlMbX+iBX7MCVeMx
         f5kaEnD807QiUJuEWbGWq0kGPm7lBo0iQ9lZ5t63urElutPM3GyhlnqbCWR4xRojT8Nq
         DpreoMSs/+BQe08rGB32h+OXDynWLCJwrAFctuLiu1Ut2mBoV5NYVSNqA6BfTV2ucqmj
         boFg==
X-Forwarded-Encrypted: i=1; AKwUvBzxrO18L+tH9zXEE9FIGXX0cnBxlnJzAQOBFwBSDl5yAmTz0B1FPD/kG4juLNzwZGckRolNFp15AKlCOaOA@vger.kernel.org
X-Gm-Message-State: AFq9FYJNIUUMY7wbq0zufm8Tsx2VnFqfhAVdxxCtHj1//BZbYB8OB93s
	NSoKVQf6W0k+oRPsNRwZ/tcFu8BIVFYZAjD9MohgPr/VYn1pJa0AnuiAGOSlFgZmMw==
X-Gm-Gg: AYBFou0nHIrAyBHpRksHGW6w+6aR7FwyOYWt6uKBFZLQ7mAd7y2hef+JSx9N5t/n0so
	mt5rCoSU2T/eraBIktO9wI1OWjPg/92y91AvoeVmxvkrYYJjovYgIovpLg17Idrt+11Ab8xfrpK
	EUnrBqJLDLVR+KQGz9JfKUPQxQOjg8mbAPmmi9qZzIjNne+37z1qPvRv6T6THWwgxt51BTjutN3
	6PkjTLQgjCLCHgi+3B7PZ/9nKXy5dhzLNgVl3OXF5YpjwGx3Sp0Mo1vxrYv2nDBtK8nqewBEgwh
	7TmRovUAqG6V7tDM9QSS4njA1RdLeSDVUNlZoqCc9wbbfVd6jZckiQHntU3r6AFM/jDYCZ0E3AD
	OEJIJE2yWlEtJsOW8dr0wi1MX0EDQt0VOpZVt6G/C50ECqY1Rkzeojsfhm4An4lhYt/wPqRQdR4
	etAl2HHpXC7cNTpcJe52Yf1mvZx1+aE22mnup2+2Te9mKrDSAz5D5PgXEI3SkmQbWUkAH5/EpUL
	FJU0gycfLsGX7ix+JNTB6SRgx2Xg/ZhbdxIf19mew2qorzRIj/TBOqjJdvpwd4Txe0kBTrBW/qN
	wc4=
X-Received: by 2002:a05:6214:418a:b0:91b:5d39:e13f with SMTP id 6a1803df08f44-91c12f339e4mr79983386d6.52.1792662066786;
        Thu, 22 Oct 2026 02:41:06 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10c0f838sm46074876d6.32.2026.10.22.02.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:41:06 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: slava@dubeyko.com
Cc: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] hfsplus: preserve FinderInfo when listing extended attributes
Date: Thu, 22 Oct 2026 05:40:58 -0400
Message-ID: <20261022094058.1169039-1-hengyul@cs.unc.edu>
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
Changes in v2:
- Restructure the error check as suggested by Viacheslav Dubeyko. No
  functional change.
- v1: https://lore.kernel.org/r/20261021174534.482192-1-hengyul@cs.unc.edu

Tested in KVM with KASAN on a804c5742bff, without and with this patch:
- The commands above, and a C test of listxattr() sizes and buffer
  lengths: a file with only FinderInfo gives 0 without the patch and
  25 with it; a file without extended attributes gives 0 on both.
- generic/062: 10/10 passed on both kernels.
- Full fstests (805 generic tests, 608 not run on both kernels): 186
  passed and 11 failed without the patch, 187 and 10 with it. The only
  difference is generic/795, which fails at random on both kernels
  with fsck "Invalid volume file count" (1 of 11 runs without the
  patch, 2 of 11 with it). generic/089 and a small test that only
  creates files and unlinks them while open hit the same error on both
  kernels. This looks like a separate race: hfsplus_file_release()
  updates file_count without vh_mutex.

With this patch, getfattr above prints "osx.com.apple.FinderInf". The
last character is lost by a separate bug in copy_name(), which Maurycy
Pawlowski-Wieronski's patch fixes:
https://lore.kernel.org/all/20260828-hfsplus-copy_name-fix-v1-1-75ed9f0f378c@maurycy.com/

 fs/hfsplus/xattr.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 71364e093fa7..45571d6f3abd 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -837,13 +837,9 @@ ssize_t hfsplus_listxattr(struct dentry *dentry, char *buffer, size_t size)
 
 	err = hfsplus_find_attr(inode->i_sb, inode->i_ino, NULL, &fd);
 	if (err) {
-		if (err == -ENOENT || err == -ENODATA) {
-			res = 0;
-			goto end_listxattr;
-		} else {
+		if (err != -ENOENT && err != -ENODATA)
 			res = err;
-			goto end_listxattr;
-		}
+		goto end_listxattr;
 	}
 
 	for (;;) {

base-commit: a804c5742bff224d4cb4d25dd383554d598be32b
-- 
2.53.0


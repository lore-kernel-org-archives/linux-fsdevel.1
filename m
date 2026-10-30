Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334780;
	b=i1O69tP75n7Is8PIFDFeywIjLkSofAah4Swx1jiqCxAT4ALOEvOEJ3u/P0dNhXpDOP8c
	 Uqe48+p0O0qPYrjFRkVxtMCrBVw26Ui7/VHpqBMpQ0Qx7UG45BSmRNj1gYsVvMoKxzfJV
	 UFMSxrHSoLwe428xOKZo8mvOPe5fAG6l0rQ8Ygj5cKoCvpbX+hXLoWYTmWr9GB+kBSTuK
	 /qyw0dwvzTznSAhq8se848GPWskd4Bj16+ELH2gGlzYpxLbJThMJhKZQWRCi271MJh86w
	 bcSkmfmILttpEaGz/B4KeSuQ52G2U1NgmrkeOVy+bo72KaGCDu+JjI06ovDawXxQf8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334780;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=08cN2zjiidPHi6YZg4T3YGZ1WyZF/coSaDDzfAKnE0M=;
	b=DHgzO8C/HAFd4TyuKD6AdmZevKIf285E1WhcMuzOsHR7+ZRcUTcThpOm842DSKEuw+KI
	 tWlHgUHsIxWAm6189QVqC/au3zfouHUot1DxYG3pJMSwpnI4penCxJXHVDZJQGnrA4r4r
	 NTrY+Sb89Anj+0vfTZFCsPR9TYEp4B/jOE+AxyutrVz1S615TLLdtvvh39ec096fDUWtH
	 93eD4E8GXVsZnayHZirpc7DG9wPYb4bj+bFD6OqlHL4JE0bER2qAOq3V/+jPYvL+JtxsV
	 GZgOKHRUhuc7aPrEsr9VMOKdZKfH41L5k9bG80Vikl7Dz/vMioFFn04OlGXkR0U3BXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=JwLkZznZ;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3DE606A31E
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 04:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD3DE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=JwLkZznZ
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5365b48238dso2261351cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 21:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1793334778; x=1793939578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=08cN2zjiidPHi6YZg4T3YGZ1WyZF/coSaDDzfAKnE0M=;
        b=JwLkZznZNTP0IQTjsQ/sO8D36bcEPSSHP62VDPaa/tII8C1FIGC4m5nduW2ivEW8Mu
         nCmyHRx89mNXnFrKVQbwLWREjA83LZ4XrX21KJKCcAp7wVZzrhJXTXHXsQk5sdEFIbae
         9E9VijIGmjuRKfeByhfOIQCpwPw3O+OW0E1aBbtHaFik5/QZxtAS+CrMIaUlOL5bsNJu
         Dv6DHhH61VmDQ8aDJIkjC1kJm9f0FoR+0HwZCZ+1JSMBqhZdAAv+kVldgt+SjXWFbzU5
         4LvhLU7SuMaAypCr0tf5BAWmbjQazsTQpOnmJ5PS4JFZDhqTtNbl477mMzdd5awOcHH3
         JQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793334778; x=1793939578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=08cN2zjiidPHi6YZg4T3YGZ1WyZF/coSaDDzfAKnE0M=;
        b=2uAjD2blYqHPYyiioK/rUSonbmphugoHLN5rW692x+n5Xpfa9mxcjNVIlU5xySIxnh
         AIjrGzGK2yXtpEWRydOY+g7doeqfTxbl4t4X9/SQgDN7raxiAiucihVyca/o03JEqdKr
         T7AveW9leGT8v5mj+UmoGctLGNnWre+MTaJ+iu4lHYWJe6tQZgr0HqWrLF7DB+MtFH8X
         cJS2wPcsL64u3N+MAm/2kod1EtIFy0iuk33Lyfvr5M8U9Q/15M6bqT/F8Mdku7b9rwaT
         rYDZoVj6Hy5AN/7MnU/AdblgT3gXBLBAQ15I6wQn1X8svN3O/6fzmzjM/OXw0cJ2L6mi
         epaA==
X-Forwarded-Encrypted: i=1; AKwUvBz/u+mOq5c8XNWiUSdPh7a/iorplBL3w/YVtIE5o1hOSnc4VTiowewkeQtwHYrANI41jhSL2O642Jz9UWj8@vger.kernel.org
X-Gm-Message-State: AFq9FYLarDm9UbWRbYOGcurOm58/1OKCqvkuFNH6ERIE3dUX3unhYZHS
	Vjywvy+GLgVdjMnQHtnuM4ByVkvTgR1cGhH63okCoEiOyqbHFF3Q2sK8itNCy1gU2A==
X-Gm-Gg: AYBFou21LgypAR6flCVZG+nu42Ht61BlGCex1BZv9TyrTK8zJnf29ueXTczyuwBreGQ
	fr+SKLDOdaJWgX0E4QDQZoV26aBl+qA9YpXrZqiaCZirnrOzV/Lyh+lm2K6BVPTq7jy/64UyH4w
	SJRD/mT7CPvM2fjab24kFnuCjQ965PwBw4IxxKA3BYJNOSDCme1HhpGCSClxRHNqpqF8OJVtxje
	02CgohJ6JrECFAPpq+Mq0uT8MdRaJLQGl/nA561dAjacF6C3zh73RpGTEoCLfnp7AICYfdOFCGX
	u4akGhBNLCBRBdao+OOpkKubeiC3qNrp4J0HfpjtKIlOHfb6XjEnAcmFMCF55ZhvswxgMvULUxM
	6LehHoz1JwjyvGmpEnODPNO7MR4HTUKeEC3IuADnYtyXtUcSj02baQ/FFVekGXPnUHl7YRyDqht
	gWo5TB4J/9O0vxGqbbmY4yp02ML/It/1wSyyftnEibHt8wDdIROhUTVrMusUY6jSQM5SvodGhY6
	y5f3V83OeMVLqWryCKCPqHM8fUM0ek3qOaBxlbzX2qWJcHk4OG6175aAln0c8xlahAzca94vPWU
	W78K7C9kERSZjSSCINxeknoCqSsbyhhv6pJR3z0qJRsuAKLeaRij
X-Received: by 2002:a05:622a:a1a:b0:535:25db:17ae with SMTP id d75a77b69052e-542b397a4demr17105461cf.11.1793334778444;
        Thu, 29 Oct 2026 21:32:58 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7f25fc2sm5218726d6.10.2026.10.29.21.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:32:58 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: slava@dubeyko.com
Cc: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] hfsplus: fall back to buffered I/O for direct writes past phys_size
Date: Fri, 30 Oct 2026 00:32:52 -0400
Message-ID: <20261030043252.4163173-1-hengyul@cs.unc.edu>
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

hfsplus_direct_IO() passes direct writes to blockdev_direct_IO(), which
does not go through hfsplus_write_begin(). phys_size only grows by the
block size when hfsplus_get_block() allocates a new block. It starts at
i_size when the inode is read, which does not have to be block aligned,
so after a direct write past the end of the file phys_size is smaller
than i_size.

However, at the last close, hfsplus_file_truncate() sees i_size larger
than phys_size and calls hfsplus_write_begin() at i_size, which zeroes
the file from phys_size up to i_size. As of now, part of the data that
a direct write has just written past the old end of the file is lost,
and fsck reports no error. Commit 5f63ac80aef2 ("hfsplus: fix issue of
direct writes beyond end-of-file") avoids this only for writes that
start past the end of the file.

The issue can be reproduced with:

    truncate -s 32M hfsplus.img
    mkfs.hfsplus hfsplus.img
    mount -o loop hfsplus.img /mnt
    printf 'A%.0s' $(seq 100) > /mnt/f
    umount /mnt
    mount -o loop hfsplus.img /mnt
    xfs_io -d -c 'pwrite -S 0x42 0 1024' /mnt/f
    umount /mnt
    mount -o loop hfsplus.img /mnt
    od -An -tx1 -j 100 -N 924 /mnt/f

Bytes 100 to 1023 read back as zeros instead of 0x42.

This patch will make the other direct writes that end past phys_size
fall back to a buffered write, as fat_direct_IO() and affs_direct_IO()
do.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
Slava, you mentioned that you are rebuilding the HFS+ direct I/O path
[1]. This patch fixes the current code, also for stable, and may
conflict with that work.

Writes that start past EOF still expand the file first, as in
5f63ac80aef2. Only the other writes that end past phys_size fall back.

Tested in KVM with KASAN: the reproducer above, and all 805 fstests on
HFS+: 10 failures without the patch, 7 with it (generic/521, 617 and
760 now pass), no new failures.

[1] https://lore.kernel.org/linux-fsdevel/161fab786f919adb384fbf22dc19f3289bf5f24d.camel@dubeyko.com/

 fs/hfsplus/inode.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index aed0866499b2..70c13dcdcd8e 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -169,6 +169,15 @@ static ssize_t hfsplus_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		end_page = end_off >> PAGE_SHIFT;
 
 		invalidate_inode_pages2_range(mapping, start_page, end_page);
+	} else if (iov_iter_rw(iter) == WRITE &&
+		   end > HFSPLUS_I(inode)->phys_size) {
+		/*
+		 * blockdev_direct_IO() does not go through ->write_begin(),
+		 * so it neither zeroes the file from phys_size up to the
+		 * write nor keeps phys_size in step with i_size. Return 0,
+		 * so that the write falls back to a buffered write.
+		 */
+		return 0;
 	}
 
 	ret = blockdev_direct_IO(iocb, inode, iter, hfsplus_get_block);

base-commit: a804c5742bff224d4cb4d25dd383554d598be32b
-- 
2.53.0


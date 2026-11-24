Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795560818;
	b=38uoQxFF/FQ6wGwVYLJ+E6BVnozNkVDmR5n3aN711l2t5uQpp7x762oilyqhRikubBez
	 VlebKbTX6sa3SA0YkdcG7RZpxEQeKB2CUX1w8OdJAROKaU/VMkz2q/nKuX7AFbbGIkDuj
	 UbExsW2JJ1apFxMPIzxsO/RcMy50znFuLbATEeUN6iK0U5dDH6HbBv+xTamkVj24aH923
	 8x5PpovKiWFmmU84QFdgb5ubIFJA3+mNeMvrwzjbSl9467mW+tEe8AzfoNbGTnqiLuG6Q
	 6zAKtBdZ2iRBvmXklRWmCVl/lDkvq8iXGveayhJBRrWlVitRiLgthUXMG2ohkJvlhzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795560818;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3OrUyU6UsgiNKGxOBn9zbInzN2tr0FdnmY+sZ0issxU=;
	b=aKOyaR17aG/G8VjrHceQFqb90SjE6JU0OwJxZu1xIh+c3ctfehi0Y9iWy69L/zf/uIkv
	 qzRrp2uUjtdW4NawDoDsU2WRbaCiQr+0CAie0rWqQRKicGydkFXwEfPEEY/ZPMBSHcjVT
	 HyFv6fDRAjMvIn3diwx+WYxy060HIjB1Vm/gbFxvTtISS0m7EeHgVzlCNag69hdBNwL5Z
	 1U0a94+Ku3rN11xhWrI0mP42EM9TWg9leKNydzYEKcI+LKLhSo75P65GD0SMGOB9P9Jbd
	 11Oc7bYJ+9NIAmQm1SofA5U/GykoE3wt2y26OWwX5UJ50r/1so9dlNeX6uRdI3qaU5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="e7/zbqfC";
	arc=none smtp.remote-ip=74.125.224.41
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80793606A329
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 22:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80793606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=e7/zbqfC
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-67db6d4054eso5702828d50.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 14:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1795560817; x=1796165617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3OrUyU6UsgiNKGxOBn9zbInzN2tr0FdnmY+sZ0issxU=;
        b=e7/zbqfC0GJXjw3w7n/Q8sV0rAyjf8KhSdlV8QJJLzAQrVtmO9MDckF+kco3JF9jJc
         IiQKfnF2n9bFi/1bX9pLLdNAJdLaZ7qHbB05vRMSgoxJ1KEYVmDwYpzkR0ljTTGteebx
         UXsoarX0WpCPvNCHuAxYiR+2U+OrOmlQb18OGG5JKMjWNuTPgdrcrVVUHMHEN1PRkEqB
         daQUzCSqIPncRLRtO9hMZxkqTh/wH7SGmGuOzj3NI7opbl0k+IDaJLwbfLb0FN3H6sLb
         G1wnCZNsAEJiWSTmJPwIDuZCWeB6Z44I38S7fj3sPmK8neEYyuyXVzCEl/QKKZ20XD7t
         dXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795560817; x=1796165617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3OrUyU6UsgiNKGxOBn9zbInzN2tr0FdnmY+sZ0issxU=;
        b=gopqQZtg0YEu0ZtRycppufI2xsnURCWdE/jwqLWIFCOI/t56o+XCcRV5RabfOsCgPD
         B6zQ7qyE/3ozE+FuC9lstykdBfTmen6jFE9UVsbAG8S7o0+FWxIuVMiRfVglKSLTf8fb
         fONcsps55fc1OAPINuZ9udeohlScFOzMMI33qnWu4mf1ofMB+XJJAy0GFPcFqTGgx26v
         GH58syLvsU9TY1kou9X0y5PNgCQgASG84EDvNoN2aG31/Bw91hHhjgsOihmD0dyrczOb
         FtmkK1c6Ox8DGqvP0cjUBOJLX5XG8xemBQm3KOhn6YjI9NYFJJuzyV8N8M8WNNv1a8Kp
         GGvQ==
X-Gm-Message-State: APuU4Z/QRKnC+fs1NEfGTj+sVUJCl9wIteUnVEE7q461X9luUco0hmpW
	W2k7DOvKDNTstw1iGezQ1FFVxkyMoKHELZh4GmwpBd5SnqLojaHX9xgisSCI5f/+NGjaTwplClB
	CFAEGJng=
X-Gm-Gg: AZFdTZf17me3140XuHa+IdjQ0+X4uOdOteZKRmxSfsERUQgHLyW7LRNkSGhYw8FHRaP
	Bwq3ydKt8+m2hlJod27LYd0+cLOUuH5p8f8JxXK124KTgLobuNvZ30qqs3GdGdHcg3NuRXxS5e8
	oMcGJEwJ0IGx6R48+0yV5SlJ2ZQL1SHoOCEfAlqP15sNHQ6GTpEKYGOmN2pg/WZ2HKB/XiaIiOn
	Vxg2Ljz6GDKPHpR1Kd2asdQDb6qUxjYEDY4dW3wiRKYnu+T84CUmjAwl6IyQyNv3bk2PM2sC5KS
	kIbRWiWPVhf8KxebF4OUqunxKgxYoL9KamARa+m3kY/2OtM2trQPjbm6YUQRfOm52khtyfJujzT
	IXdesDuB6yzW64T5boLSQX2fKGd5vXOfmFh8zTaol6jDoow2/2gWjK09iS3rkJItVeXDz9J2hqX
	8YMbg0M/gYHsXcPEZglEZ8HGmJ4rFzZw7UhzGtVqqVUHKyZ0C0TOlA3dm5jvBHSK7LD5piBaNOK
	OTsP31UmML+z67pCMpuaC/qKEeN1boHCFfgTwUHu9aHa+JKXvnJI+uhzACAh1qRZ0/TOe8LqQmT
	LIB/kuHuVgxQUfhcb9l16QISczKzKtr51OJHVICoMcnyRBxC1wGiqIi8zE6TYP2UrFj+S12va6q
	Nu2Ss0t8L/ezaXLXb39znA6C3+nXgYJEeFDUQkeGfafRGw7o0GrfrJPvWP+xm4ls3EO76L1Km5B
	G58ip6N6jjS5G6VIL4
X-Received: by 2002:a05:690e:4009:b0:67d:a096:d8b7 with SMTP id 956f58d0204a3-67df42ba074mr7634561d50.3.1795560817597;
        Tue, 24 Nov 2026 14:53:37 -0800 (PST)
Received: from system76-laptop.attlocal.net ([2600:1700:6476:1430:c4f2:e852:cd48:35ad])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df33b7502sm7706219d50.20.2026.11.24.14.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 14:53:37 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 1/3] hfs: fix timestamp wrapped issue
Date: Tue, 24 Nov 2026 14:53:28 -0800
Message-ID: <20261124225330.3879708-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124225330.3879708-1-slava@dubeyko.com>
References: <20261124225330.3879708-1-slava@dubeyko.com>
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

The main reason of the issue is the logic:

cpu_to_be32(lower_32_bits(ut) + HFS_UTC_OFFSET)

At first, we take the lower 32 bits of the value and, then,
we add the time offset. However, if we have negative value
(timestamp before January 1, 1970), then we make completely
wrong calculation. The reverse conversion has the same issue
because it treats any on-disk timestamp under HFS_UTC_OFFSET
(January 1, 1970) as a time between 2040 and 2106. Moreover,
any timestamp after February 2106 is silently wrapped.

This patch corrects the logic of __hfs_m_to_utime() and
__hfs_u_to_mtime(). Now, the on-disk timestamp is interpreted
as unsigned number of seconds since January 1, 1904. As a result,
the supported time range is from January 1, 1904 till
February 6, 2040. HFS keeps timestamps in local time. So,
the range is shifted by the local time zone offset.
__hfs_u_to_mtime() clamps the value into the supported range
instead of wrapping it.

The hfs_fill_super() logic defines sb->s_time_min,
sb->s_time_max, and sb->s_time_gran. It means that VFS clamps
the timestamps that are out of the supported range.

This is the HFS port of the HFS+ patch
"hfsplus: fix timestamp wrapped issue".

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfs/hfs_fs.h | 16 ++++++++++++++--
 fs/hfs/super.c  |  4 ++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index 2d56f8b1a5fa..0d710a45c61d 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -261,9 +261,18 @@ extern int hfs_mac2asc(struct super_block *sb,
 /* super.c */
 extern void hfs_mark_mdb_dirty(struct super_block *sb);
 
+/*
+ * time helpers: convert between 1904-base and 1970-base timestamps
+ *
+ * HFS keeps timestamps as unsigned 32-bit number of seconds since
+ * January 1, 1904 in local time. The on-disk timestamps cover the range
+ * from HFS_MIN_TIMESTAMP_SECS (Jan. 1, 1904) till HFS_MAX_TIMESTAMP_SECS
+ * (Feb. 6, 2040) shifted by the local time zone offset. The timestamps
+ * out of this range are clamped.
+ */
 static inline time64_t __hfs_m_to_utime(__be32 mt)
 {
-	time64_t ut = (u32)(be32_to_cpu(mt) - HFS_UTC_OFFSET);
+	time64_t ut = (time64_t)be32_to_cpu(mt) - HFS_UTC_OFFSET;
 
 	return ut + sys_tz.tz_minuteswest * 60;
 }
@@ -271,8 +280,11 @@ static inline time64_t __hfs_m_to_utime(__be32 mt)
 static inline __be32 __hfs_u_to_mtime(time64_t ut)
 {
 	ut -= sys_tz.tz_minuteswest * 60;
+	ut = clamp_t(time64_t, ut,
+		     HFS_MIN_TIMESTAMP_SECS, HFS_MAX_TIMESTAMP_SECS);
+	ut += HFS_UTC_OFFSET;
 
-	return cpu_to_be32(lower_32_bits(ut) + HFS_UTC_OFFSET);
+	return cpu_to_be32(lower_32_bits(ut));
 }
 #define HFS_I(inode)	(container_of(inode, struct hfs_inode_info, vfs_inode))
 #define HFS_SB(sb)	((struct hfs_sb_info *)(sb)->s_fs_info)
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index c0c3541e3d34..a63b92709984 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -345,6 +345,10 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_op = &hfs_super_operations;
 	sb->s_xattr = hfs_xattr_handlers;
 	sb->s_flags |= SB_NOATIME | SB_NODIRATIME;
+	sb->s_time_gran = NSEC_PER_SEC;
+	/* on-disk timestamps are in local time */
+	sb->s_time_min = HFS_MIN_TIMESTAMP_SECS + sys_tz.tz_minuteswest * 60;
+	sb->s_time_max = HFS_MAX_TIMESTAMP_SECS + sys_tz.tz_minuteswest * 60;
 	mutex_init(&sbi->mdb_lock);
 	mutex_init(&sbi->bitmap_lock);
 
-- 
2.53.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795131682;
	b=ERukgVE18RkRuJReNX6lZWJPiJ9jsa409swhLuNKu7tAjW8wxrzTNeQylf2F/EfIdXyI
	 Ib/hZ8M1Ey+dXvzfHRsfrwtQuaAzWZFtbXINGsY+xjzBRrTU9BSJ0vLeNqCSx4PfQJdWt
	 0SDmGt8XbL6ypBhpehvl0P7KZHWB9tn1U3s6sZWCTcp5C8bvz0/NH6hZc04ThxZwwVUVK
	 sL+vpar3UH8aM3irNWhamfOmJhZucFDX7Q8IP4eS5bNQA129VnxXBAoofLLFUF9mZl89n
	 nexNO7DnSF5gjpHKL4pcxlFXsmapdJWovPZ8hRVljt9wNMOTt5XJ2UHCWWLDtntPvXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795131682;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nKWdvn5g3LWqbr6kSTOS4+Q+mYE0fgsqV+kyH0HAgJc=;
	b=UgWou/mqOu7JwKuC/xpNL8Zu7uknv5sgY0X8kjLbUK5SEg12nUvOYZynx2qBn1IJMGS+
	 cV8j0/mN6hMTmWDNymX6lUuQjjc9WyK9GcMBvukXnpqQItmzQeNoOqjfgtdt7gU/RWdnA
	 cmu2EDlIhk5+NSWyMTNKPjbl8vW7gHzxhZo37Fv7meyaHUeHqbUB7/5CZGIS9yenEz8pp
	 phzXXYiGA0skEUH45H/TpLz9KpCX3CMC3ZvqCVFSlQUfCZ6QriRcpxfgwXbR5SaSEbFSK
	 amPPwH/rKXoeiT92Bp8dXqYbvEPQTSsBw33q2oIDKy8lBnjSyaI3+FiPWml9Jao11RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=uavAA8Gu;
	arc=none smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A12960A2639
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 23:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A12960A2639
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=uavAA8Gu
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-67db8985419so520440d50.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 15:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1795131681; x=1795736481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nKWdvn5g3LWqbr6kSTOS4+Q+mYE0fgsqV+kyH0HAgJc=;
        b=uavAA8Guf8WpnuTNpWimlPENJzUf8jbi7z9vm+4+bM3r6bbHArdER6HHyjbhAroXL9
         tX1WDOkGFYXp/Z8PZbeNdlWudF/fgIs6dmff5+n8b55qWrsGD0lXa5aNLl1svV+NQSik
         BInwZLE8LD5tLiSiqOjLoRe73LDHVO8WtEP2iZ5IEuzF0pnoIcjBi7nBgmlgFW1uvgEL
         dNeqagXulZh2q8aM4G6lvtAj50AfM4xSaQD2ti4kX3T23AiGMymqbTuPwp+G1acY/ZcK
         rBP2PmLWd8jaYjY/2GLCYVawno+kEBBao6Uesp3u3pcN9WPYQtrAfALrEojDy6Vu/DB0
         suoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795131681; x=1795736481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nKWdvn5g3LWqbr6kSTOS4+Q+mYE0fgsqV+kyH0HAgJc=;
        b=PWjF9DJs/rICEiBs0FLkuZoYgcFED+r8JuzIhxux76CySj5jXYOsBWrfcFePcw3fzv
         8eMKK6YNDKt2L3dOGadmGBrJUjBMg5RM3Hs9L/cFxAnzwdR46VMMXobq1MqDJM12/hdN
         KszH3O7aT5PPbNH1L9Vp7ZdGlElcpM0Vn53n6pyyV5sNjNfsKHw2FUVV6W1OV9FiobkA
         lMHj0qA7fDKIOb+GYllHDvSvOoVmYOgBOe/GcttHUjFQF7AQqgWdT0EpMYJk6UgGZDPL
         tOQbPFfXpFZON9wMU1Og2M4z1jArAtANF1ZHVT5JgyG9amly9RQ3/VoRrlIZ8u23NoLN
         rSBQ==
X-Gm-Message-State: APuU4Z8xE0q7Reu0dwgooUsbDfWthwNdbB8QYo1jLzAvOQR4aQMm44xB
	WrhZHge4ns9W91lQdEItCfN3SmFaY//TVwoAz1JALJ+aQxxdt9cTeTV4UTgDzXR2OATBiKRMzXk
	J6nr3xWM=
X-Gm-Gg: AZFdTZdaE2mFpeFgLeDSHeFViwDydMENHligtGiXbhh8RI6KEl+9g2NSWPT0nqtoKzI
	VZ4SfKa9xsW8SQPeiCfh0EF32XN6SUSbep0WlH6m/8imIOhE58mZHFDJVnE9MO2UrRYDb+gzvuL
	mYxCKxyYlFNmaDlOUO7sFf6GoQOnI8Sj/EP7d2CACajnl6cmteEN+xeJI7pMoyJIEOHuEexXFf/
	rw1K5S1yuWWq4agr3vIuC55Gv5sS/+AkUgvySiKcnYSVIGnpqWXPJj8fKJoa3i8VZt4mAY/FqTL
	9kCDJWfnlhfRSxqhOroG1rBgnUV4T6dMazou1MQW1nBdkegM9oCA/ZQ6n23O6Ibzcv94ggX4a9n
	j8T0RTMUM3KTKYuw3dyXMWztV3ShTlaE7Im9iFu8VpQQxYeVf2mpQF/5VHHDXa3HdUxFXQI7kyb
	2it1Im083DlyiQOfcj49L1iYsNHgkfeCbXlSzOQQSJ+QlYAezCvZh+rs7xQ1AZhrXvBjeZ6O94+
	HznGY5YW5FbbkM1Cq9vdPdkYp68vnBPNAH1bQ946BcOIiXhGizDSpQnxyOHJz83MSYDc/AekQnk
	OglCJ9+sNkcqdQre3+ZL4k84zpqZhiiD/DHCkINR73hB2qCh2UJU2q01X3P5pM77E5jBa6rQkqL
	AmAHKTVw0TgQDOCrLQ+OJrg3Kj9OJQx5N6hO54b3il0XWWpM5pSlmCkShwBpa/7nLI8c3b4I=
X-Received: by 2002:a05:690e:419c:b0:679:f97f:fdf6 with SMTP id 956f58d0204a3-67df448c769mr466727d50.66.1795131681346;
        Thu, 19 Nov 2026 15:41:21 -0800 (PST)
Received: from system76-laptop.attlocal.net ([2600:1700:6476:1430:1932:ad09:1827:11fb])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df338e8fesm796893d50.16.2026.11.19.15.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 15:41:20 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/5] hfsplus: reject an allocation bitmap that does not cover the volume
Date: Thu, 19 Nov 2026 15:41:11 -0800
Message-ID: <20261119234112.720963-5-slava@dubeyko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119234112.720963-1-slava@dubeyko.com>
References: <20261119234112.720963-1-slava@dubeyko.com>
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

The allocation file is a bitmap with one bit per allocation block, so
it has to be at least DIV_ROUND_UP(total_blocks, 8) bytes long. This is
not checked at mount. hfsplus_block_allocate() and hfsplus_block_free()
look up any block below total_blocks in the bitmap, so with a shorter
allocation file they read and modify bitmap bits beyond its end, which
are never written back.

The only guard is in hfsplus_file_extend(), which fails with -ENOSPC
("extend alloc file!") once the blocks in use approach the bitmap size,
and hfsplus_block_free() has none. On a 64M volume created with
"mkfs.hfsplus -b 4096" whose allocation file size in the volume header
was changed from 4096 to 1024 bytes (fsck.hfsplus reports the volume as
OK), writing two 24M files fails with -ENOSPC at half of the volume,
and after unmount fsck.hfsplus reports:

  Volume bitmap needs minor repair for under-allocation

Fail the mount if the allocation file is too small for the volume.

Tested on a KASAN and lockdep kernel: the volume above is rejected at
mount with "allocation file size 1024 is too small for 16384 blocks",
the same volume with an allocation file of 2048 bytes (the minimum) or
4096 bytes mounts.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/hfsplus/super.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index d23594d12064..6e4068e53b4f 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -777,6 +777,19 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 	sbi->alloc_file.inode = inode;
 
+	/*
+	 * The allocation bitmap has one bit per allocation block. The
+	 * bitmap code looks up any block below total_blocks in it, so it
+	 * must cover all of them.
+	 */
+	if (inode->i_size < DIV_ROUND_UP((u64)sbi->total_blocks,
+					 BITS_PER_BYTE)) {
+		pr_err("allocation file size %lld is too small for %u blocks\n",
+		       inode->i_size, sbi->total_blocks);
+		err = -EIO;
+		goto out_put_alloc_file;
+	}
+
 	err = hfsplus_ext_load_alloc_file(sb);
 	if (err)
 		goto out_put_alloc_file;
-- 
2.53.0


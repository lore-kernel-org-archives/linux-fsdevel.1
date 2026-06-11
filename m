Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67862737F8
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 21:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781212878; cv=none; b=ERDAaznyrBpuqWD2PFyzTRzFrxsA/Ed+lvXDr/vqEbzoZBTStfmWiloP7kWm8doIfDLkMZa4ff2joTXy/Dzm0i9F5o0O+2Uzm6wHoTmRzhhUd9f/ITBfBoypV9eBv/KuKM9YnqUSKVyp1/ciIkZts+s4MVBZTzKGJiUvD+NKgTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781212878; c=relaxed/simple;
	bh=gz8XXCvKDIUvwALZy3EPayeAQ0OgphiwA++tk+FDTuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K0HNCZWWky22i8mYmm6FosGyjNn9xtEHGh9oxOcZFBKnyO2+sb9NKdInhqI3HQJnGpu+fqLxXVJww/HxIu4ANnB53QvseTz2OXgn7UlSwafpUhYMl/fuTI3SFyLo2h8tDPWA1gutFRoUUdSQnairw7j29V9HzBqhl/G5ewX/oUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=L+MxZmCY; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="L+MxZmCY"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5175b6c4e19so2211511cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 14:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1781212876; x=1781817676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G9gu0vVO+upgROS7/Iq8V7N+x8+Xf5/itiHQvLUydmI=;
        b=L+MxZmCY/6A2WvmS0Msem7/23zhTU5D6xyYFWirum4xSS+ciNFkioAm6ySqBOKvYel
         clZXy3OpxBkxh8KR32I2MS1ngm7mbZFU6vaLn2z94hvU9KSk5vArrqoIZb519kufcykK
         u0znP7JSOusSw7OEdbWlR6r0Qrl2T3CWwU38c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781212876; x=1781817676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9gu0vVO+upgROS7/Iq8V7N+x8+Xf5/itiHQvLUydmI=;
        b=mM9laSLplhOSCKDCMQR5bKIE8Q7kbUhPjNwj770x/hFkDBbkNdPY58D+uz2wwkY0zg
         aycTvZw37+/1tNCNjmm3J8Lyueb8UEMHshJKDbbzKk67/xr2ZqC4mVFdeT+oE4+8qioI
         cvwPDakmtyhd56NQ9/8rx/Vu9FMnV1rSINVDqNIpIWNtV3slqoP36BNhgNP37xAWteqM
         XIRz0mHj0ODf4US+tWg13oQJ5zMvAzBYpEVaaI2yqxOHYpscir8j6B+nVWJNlSkwMYcW
         ds/NaI9Cz+vooEFfCkKRKkzAZuvKwOE6qz9ExN/3GMOXA8ILJnyUZ28OlzsOjY7ZaDXM
         /HeQ==
X-Gm-Message-State: AOJu0YwRbFWE/ArS+2/0/D+IurAfyxv2mvQGfeRdw7mRWrKZpjzYRmeJ
	wxIEwPMob1WFAT9TOIuwyyvw0UDUdc/eTeFy4XUYkKiE8cJWxk69mRjNBLSh2cnEHx/1gJ2hgSU
	75B21Goo=
X-Gm-Gg: Acq92OEze5lvULnWKt70yXFL8sZtTb33g/WEZxjlE8FB6ArbarTcbM4Hr3XWAj5ywv3
	gZQv+Skia415cuKxdgSWUTKGBhgWEsvzjvlANy/LC+/OxQGi3Ya1GQxpJsW8/ec+20IbVb1fCXk
	kSP/4zAS/9uNhNf9u0/d4wXCf0n7mk1dnjD0KcgoikBkzaUewayq7+nePPYECs+jcPKWtb6QX10
	RQEFwlnnB7MmDx80W4cEsOnirXGFfmxgJuRbfEwn8EnhIaZ65IlJoSbkjxrMEu5fsIS6v95IoEo
	sdKbubrEC/Dy+7lxxkulOCnzD/EIfwkf2MqV6hU6DccfrM+I7DURIzdtoANkjBuWB93zFuHrzgT
	XeK/eTOeI9V+gRwUJhWg7dbTXu26v7hzVz1aQQpcT2qQgucwQyGUsjZd04NrUv/a5zCcQoTJqJ1
	RhTdqo1C4AgSGyH0+bd2PQ/DyrXAskbQ4iqnoxedZf3h1h3dwqBTzehNJIaVjYKycR8oL2YG6eN
	PVOK4xgsQZ4wts7X6bZAOAy88nYg+3UxWw=
X-Received: by 2002:a05:622a:4a0a:b0:50d:6b06:a453 with SMTP id d75a77b69052e-517ede809c0mr72010571cf.18.1781212875850;
        Thu, 11 Jun 2026 14:21:15 -0700 (PDT)
Received: from com-75606.node.ndb.openai.org ([209.249.37.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d30105fd75sm4844076d6.2.2026.06.11.14.21.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jun 2026 14:21:15 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: linux-fsdevel@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH] affs: validate blocks before freeing them
Date: Thu, 11 Jun 2026 14:21:10 -0700
Message-ID: <20260611212110.4042-1-kylebot@openai.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

affs_free_block() accepts block numbers from on-disk file block tables
when truncating or unlinking files. The function currently rejects only
block numbers greater than s_partition_size before subtracting
s_reserved and using the result to index the in-memory bitmap descriptor
array.

That check still accepts reserved blocks and the one-past-end block at
s_partition_size. A crafted image can therefore make the subtraction
underflow or make the computed bitmap index equal to s_bmap_count,
leading to an out-of-bounds access on s_bitmap before the bitmap block is
read and updated.

Use the existing AFFS block validity helper so freeing uses the same
range as block reads and writes: s_reserved <= block < s_partition_size.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.5
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 fs/affs/bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/affs/bitmap.c b/fs/affs/bitmap.c
--- a/fs/affs/bitmap.c
+++ b/fs/affs/bitmap.c
@@ -46,7 +46,7 @@ affs_free_block(struct super_block *sb, u32 block)
 
 	pr_debug("%s(%u)\n", __func__, block);
 
-	if (block > sbi->s_partition_size)
+	if (!affs_validblock(sb, block))
 		goto err_range;
 
 	blk     = block - sbi->s_reserved;
-- 
2.50.0


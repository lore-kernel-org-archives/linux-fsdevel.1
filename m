Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601245;
	b=3qqmlEfDISZadAYj3SZx55llJZitUfpDkeIV9r22fN44UqCRM7V2zatnMtlPKS2mCIkD
	 TBS9nhcq2v3Wql8BvUgxYV1icO20GMMSFp2LWKqDIr0s4toxhnsk+rozpkUO18RGrU91P
	 /qh7m6h5stUrGCAnMk5cGW9uZfANYl9UN8Xmul+DJQN2WoQ5sHszKW9uXVJfQ1bY0k6oy
	 bMfMqrVRazQ1vVB9iDDtAFhrIVMMwZqSFKlDE1hGGl16JHOxoE8d+SZyKMjK4rF17dXlX
	 k+E2BwK3r+Gb9hA+gDvsrI/82S5blTA9Sb58CO6jzo0YuXxrSuZn5/n8gK6ZMw3h1xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601245;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=LMah0FJH7eM9uIAHBN801ImbAdcq93Rgy9kg6cK8pwU=;
	b=lMh80pqrBlCogTz002seE1E0SV+XoQA3FiooSn+itPZQngapocAzyrTgJZ6XEYKwdV8H
	 6FWEC81zJ2XRBNCedUL+VCJuErAtiV9szDdNEVDx0bJBPruawAauAR3I1G9K4KsVM3OE6
	 CnPb6/dSmguAYTcFMhDJKXTPvk2P8TDj5m7Qv8aq0vcQwLY1/7sjRBMS/kkjiAFpcSPWk
	 iyLMn+FQu2diJFF4eT2pqJ6o433qK5stA4rIYbwFAyqLNyiyP4acErbjVK9b1aoeJL2SN
	 uRz1GXFTwvrQbXZmWwZg/Dl9FaPMI6nBJMkBWeu8UjJBDrsT5L6AoToCj8Xb16RFqYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=D56VqIN2;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69914606A32A
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 16:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69914606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=D56VqIN2
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91b813ac020so13074626d6.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 09:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792601244; x=1793206044; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LMah0FJH7eM9uIAHBN801ImbAdcq93Rgy9kg6cK8pwU=;
        b=D56VqIN2mD3dv4GAByYwDvYCkhg2Ua4EGxHO85+aYP1hfXIYxIhHw53SXC6T9m2g+J
         swXuJA4YEH9V3m6ucnRzfA/sr88oFzfqkrkargrGlse7zMfF/QAH2T4BUrINl4bQUR2b
         pXThtglZHpSl16oCcy/fZQ9rcTfnUH3bFDKL4Kg7ZZigWCad7PhHlYMJVH7dVz6hSQA+
         avzdMUlF7AcjDdZd3pNjj/mecQipDeMtGaGB+WWnDDUdJbSWm7Fb/zIqAyvdert7bxY5
         FtzCqvivAC5m/E9tfGNq+DAGJdjDxM0ClWtJXtLC7HWWkpWVBn58qEWMdB5shwger84r
         jMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792601244; x=1793206044;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LMah0FJH7eM9uIAHBN801ImbAdcq93Rgy9kg6cK8pwU=;
        b=VNZYHay4xTtYXCIRYGt1micLZnFoCMC/Vi37NR06BUhIIwJV5ltATAyXSAynvg0Bwi
         wczZKzgqJV6VRnY3NB0JuLFVMRYggGZGO8m9+UE7p+12xYtGGHLysAQAXqiAV6TQrr0g
         t77GtW9AbH350LgGtKw4G5S5xPgKo8Xuf9ZeJNsXvqYJWQYveft8ccCvXiMg5LARGW0P
         /w2ByU5x+KdbaIcjambc7y+AKMpQf2UZWGrXU9bUQg0A4VgC1TuEWt2MDlrJaSo0D07G
         W/rE9lA8TYe5jjWMFRa0OJdM4N/aaHJsUSlDbEMOVTU3lwUKEZ33axdZBHHKa6NruosF
         T8cw==
X-Gm-Message-State: AFq9FYJMkxbq8XN9kZi8rI1eCTOGGYpik3gaiKpp5fo6bFly14/826sJ
	FgELfGi69yCT/6O9VWLL81KTkhmrpVqWkV+I3K3jvfEDAHU8teV0qJPHFoy78xtpbIs=
X-Gm-Gg: AYBFou2MJHy35027OP1IPPg+BGc0DJv94WtNL4/G9WIjQ0cyWy6WmfMAeB+NMvz+l9q
	cz/wavpat5JQhAocIKkECxVZFlXxCjoIOOpiI67C96jOcPmzxWppboJH4ck3McsX2o40azq9jQs
	JpyXMijuW/C9LXkLxtFq+d9/2pAR9mP+6pNJhdp0Hks6QhRIOmmj8/p6M3EU6bTWFBYMXCNXbq5
	d92dmP9nwa7wodRR8JKKEAmYqSf3dgciHrun2HkSsVvxsBxPkw8gOzy0oaW4/KbaEl6CR5NpZku
	/o//ronuYRtbGziMQAqh3NimZlS7TQeWB3hb9oWNvb2Bxu6O2Jh+C4YJq/StuJm+g3vJfoxJfYX
	c2FtKGMqe78IzGdpIvPD0t7Bf05MZSdjcbJYUHKk1tCexaM66clJ7sO+iwC+pZtI0zkCtgc3LCy
	ls8tXEKPsmejeNvRXdeHBJybd4HWg+QueVqkH17G8LD7ksZfvijmFJrsPmMyfwFrBXkxz2BEb19
	eimhAnHLHPkT+KvL9TtYw/fbhXaAz5Gyz0COzg1WzWbGdiVdi1liiamjhevE3jyDWDjttKV
X-Received: by 2002:a05:6214:e8f:b0:91b:80ea:60b with SMTP id 6a1803df08f44-91c12f30e02mr48846996d6.49.1792601244310;
        Wed, 21 Oct 2026 09:47:24 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.249])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10b70c50sm28791566d6.13.2026.10.21.09.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:47:23 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 21 Oct 2026 16:46:58 +0000
Subject: [PATCH 2/5] fs: make ustat() and quotactl() killable in lookup
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-b4-super-lock-unborn-v1-2-0265eddb6dee@toxicpanda.com>
References: <20261021-b4-super-lock-unborn-v1-0-0265eddb6dee@toxicpanda.com>
In-Reply-To: <20261021-b4-super-lock-unborn-v1-0-0265eddb6dee@toxicpanda.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792601235; l=1274;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=4pFxSN9rbQq0Lvp2SPmeFxAijaUR2vWg898aIvDsd6E=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCZ2mRaLXvd3XKOHjogTCovvQETfsQ7z2gp/mL7meIJRwklcPnq5QP6da92HUCWzLX0DsyCp/W7
 f4OKq94GSUQA=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

user_get_super() looks up the superblock for a device number on behalf of
ustat(2) and quotactl(2).  If that superblock is still being mounted it
waits for SB_BORN, and then for s_umount, in super_lock().  With a mount
which is stuck on its device neither system call ever returns, and neither
can be killed.

Both fail if there is no superblock for the device, which is what
user_get_super() returning NULL means to them.  Use super_lock_killable()
and return NULL when the task is killed.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/super.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index 7164c92fe70e..40f92ffa39c1 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1172,9 +1172,15 @@ struct super_block *user_get_super(dev_t dev, bool excl)
 
 	for (sb_dev = super_dev_first(dev); sb_dev; sb_dev = super_dev_next(sb_dev)) {
 		struct super_block *sb = sb_dev->sd_sb;
+		int ret;
 
-		if (!super_lock(sb, excl))
+		ret = super_lock_killable(sb, excl);
+		if (ret == -ENOENT)
 			continue;
+		if (ret) {
+			super_dev_put(sb_dev);
+			return NULL;
+		}
 
 		/* The pinned entry holds a passive reference, take our own. */
 		refcount_inc(&sb->s_passive);

-- 
2.55.0


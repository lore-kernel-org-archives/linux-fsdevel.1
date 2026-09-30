Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060FF2BEFEE
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 10:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764278; cv=none; b=OPZdDIl/20hfF6mWeLhK9FJoTMTQYjGCvzN+3Ika934Dtu606XcC2WMPU4GJlQNcVEt5hTyWFYrxXwA8lEH073G+KSHhp8pMKfkmbC7LoJ6dRACgVF29WCc4HTFLKXBmHCqDrwxIDh9oP4DQWMdaiogPSDnbNtQ+ybqXtZ0aUZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764278; c=relaxed/simple;
	bh=Fu+jSdaLQDE+olJSS3vucMCL+NeHBJSFwuuQjt2eqkw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=glnLD3p81B8eqVhQ1V1HEF2y8mNsR4QBrLZOzToTHmHxp3Dqh3vkMz1+FwsagcfBdECV/MlKsWxLK+67iu9WZkf3mpVDNFbreH75Myx+YFmED9OUylWd1nYbiWAPMlWzeDa0JG+JYSNES8D7h2UsLWQZqko1bVsE/F2SUfjxJes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emv1ol1x; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emv1ol1x"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5ba34653aefso1353785e87.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 03:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790764275; x=1791369075; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:content-language:cc:to
         :subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bO+Sh6iBCBWZKHcrTvlNeLFX2oL2DPi6PGfh6wnC4qY=;
        b=emv1ol1xlzSeNJv1roQjS5NcoO1Yzbz/J3x1eSvN5UO2T4TrBEociSBPTdsnbFDAXd
         sAZVZ272niQr2QxM6+EdbjGDoxCwS08ErmfWtK2mcoV9zKBZR3cdePrEOtkQYtDAhzf1
         H5p1WC52M/BlGhwLMwJrUYBur1TuZ0lcAX659a97o52HvQ1ZkXVTq7mZFRHnMHuUihtR
         SLBWEnlB8IOQ3XMHiq+pD4cbNmBEJsSRg0ZsuwFsu7eV4+P19YlqtpOvAAEYlWHeEAua
         8DXSG6wOdIAuS2tBzCGXdtljSxVp9sXVM4/jOgKR1dQ8sYNidChz2WBNsngAMv3qP7I6
         uqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790764275; x=1791369075;
        h=content-transfer-encoding:content-type:content-language:cc:to
         :subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bO+Sh6iBCBWZKHcrTvlNeLFX2oL2DPi6PGfh6wnC4qY=;
        b=1CVvDl1lHYaXRfGo+luRS713ZfXtB9+vCLZg1K9DmHErWWHl1/AWfYjBGdLZ6AK6CR
         vJzLbp3JzuNegjjm8YUQg8LtPob4JknkE9no/LnxASJCki34mUGGTgdxF+HB8krsusN9
         VVI+Zbo7zHkHvL/PkvF94v9xtOaQNxj0pw5N32RiqPdY/3F6vtUcZXmEfeWwI7swq+6r
         TcG93KQ7FYxNN6LKeDIcgfQJuoyB+uW/O3YYzfKT5Q2QhCwOl1MJYbsMAStw93VFLEAU
         g7EDkeb/ZUMMG+Rv7eRmtlSzHkeCPS2vCBqT5JuHAuJmQ7FnD1yXXPsMXbcnjxigLhze
         btkQ==
X-Forwarded-Encrypted: i=1; AKwUvBxeZVo2TK9PINffj+8C3GWKGkkTHRmh3qpJJvQar/ueSe4D3/Rz5ugIbU5UlMOOsO0lQ95R9sMuGpFnlORg@vger.kernel.org
X-Gm-Message-State: AFq9FYKOtuVUaVZ/7jFEcNqXyVFjDftPn4RWPklkYu8cU0LTnqPF6T9R
	dS0dtaXuA7pmqH59thFmjsN1f7iSo3DpBzMEz4n4zEeZCy7+XK3v3c7C/vME6d2UQTiBQA==
X-Gm-Gg: AYBFou1eu0Ywww5EbKeaFegHYn/mseH4xuclEIwT7X4gSb0FWJ59O5GbrvYPTfoVoTN
	nTGsufHhl96kaxl9W6V9Lq9TySc0Xgv1N1MqR2ZFU3HmRKVzFKxgh/KG9fY5hVOM7EHp8FRVNIi
	U7p5+LL9DAVk369CK8OJgvl6u9Gv7KNL1kvvz+ja+g8OIgLC9Th0ENYresm+1y3Zp3BLJT8ElXk
	Ub/zZL/WMsKqN9MCJowW6SbFgGD4QbxjuyAX7QS3e0deXLtC/eoyEkKTZjs7Nq6hT4xFwMpG01F
	7wsF+4eqbvEvftpcvLvoTiJiW7eNBc75YHmERppZiEmIZm4LImpoEdfSi3MeDRJsG4C9rutxnUq
	bGC7UWS2f+XSyJ91dOp/RF+cCk05zyj0Ps8IX/WO+Mfh0Rx8x1BXlISHI4lktu4qH8CqCq5TT3N
	/BiDNhgQ11c7os9BXUr/ONNm3O72tKjOC6s5OPOpPpKhhZScT8BRszZuHcVOs/i2SLyhq1C6jpf
	RVZnYk/Veg=
X-Received: by 2002:a05:6512:6681:10b0:5ba:3ae4:7e25 with SMTP id 2adb3069b0e04-5ba405ea45dmr330489e87.15.1790764274689;
        Wed, 30 Sep 2026 03:31:14 -0700 (PDT)
Received: from [192.168.0.120] ([31.130.119.235])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ba3fc03f67sm258061e87.79.2026.09.30.03.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2026 03:31:14 -0700 (PDT)
Message-ID: <46cb6054-6c05-4869-b4b3-d45eba082253@gmail.com>
Date: Wed, 30 Sep 2026 13:31:10 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Artem Martynenko <amartynenko140@gmail.com>
Subject: [PATCH 6.18.y] hfsplus: avoid double unload_nls() on mount failure
To: stable@vger.kernel.org
Cc: slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
 linux-fsdevel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

From: Shardul Bankar <shardulsb08@gmail.com>

commit ebebb04baefdace1e0dc17f7779e5549063ca592 upstream.

The recent commit "hfsplus: ensure sb->s_fs_info is always cleaned up"
[1] introduced a custom ->kill_sb() handler (hfsplus_kill_super) that
cleans up the s_fs_info structure (including the NLS table) on
superblock destruction.

However, the error handling path in hfsplus_fill_super() still calls
unload_nls() before returning an error. Since the VFS layer calls
->kill_sb() when fill_super fails, this results in unload_nls() being
called twice for the same sbi->nls pointer: once in hfsplus_fill_super()
and again in hfsplus_kill_super() (via delayed_free).

Remove the explicit unload_nls() call from the error path in
hfsplus_fill_super() to rely solely on the cleanup in ->kill_sb().

[1] https://lore.kernel.org/r/20251201222843.82310-3-mehdi.benhadjkhelifa@gmail.com/

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/r/20260203043806.GF3183987@ZenIV/
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
Link: https://lore.kernel.org/r/20260204170440.1337261-1-shardul.b@mpiricsoftware.com
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Artem Martynenko <amartynenko140@gmail.com>
---
Tested on 6.18.54 in QEMU: "modprobe nls_utf8; mount -t hfsplus" on a
blank image fails as expected. Without the patch nls_utf8 refcnt goes
to -1 afterwards, with the patch it stays at 0.
Discussion: https://lore.kernel.org/linux-fsdevel/9AD67E49-86E9-4508-BBC0-26919C72FB6A@gmail.com

 fs/hfsplus/super.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index d031c77fb..0d619945d 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -652,7 +652,6 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 	kfree(sbi->s_vhdr_buf);
 	kfree(sbi->s_backup_vhdr_buf);
 out_unload_nls:
-	unload_nls(sbi->nls);
 	unload_nls(nls);
 	return err;
 }
-- 
2.55.0

Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC1D43F089
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 15:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786979900; cv=none; b=lKTmq4j8gdTaxpLmx7p/w83LQsCyjdYeki1/vubWRy5+jXAcsQp4rPKlr2FU/M000iuNkUm2o7qAd14jXmvUuj2MJnEmo0FKRieeMxPS6N6fg4z+WNk465UZtBqTIPfTjTeEsYMwTO0NorazRPGTueXbT7M5uQJurv5wJjHAL+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786979900; c=relaxed/simple;
	bh=tCP9D0a5eyidqrerPu4jRVafCsdG/TkOdRzCzcE1AIU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ShBG2QtkhdcvuCXimrFy6RkR+uKhHyohUUwx6Jt0uEjx5I39OniTScUAq82DfOcSzeHyTVm3pOe2yLYLkRynntz2ZiKOvdXM3f63GYDtpBZcTVdTLDCwWP5Fe0N7mq2jwUSHC1SvhqBEdNP68/BkWXVlZ4HI+cavgN+WpwaRgls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUQmUbmB; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUQmUbmB"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cace91f112so40517785ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 08:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786979898; x=1787584698; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KOjFRvjhVU8cFjkZuXZNJ83v2W6JcBfwkSkd8Ja0b2Q=;
        b=WUQmUbmBeqEq/m6Uev0lt+hTrDrYyGvUdSANEXw41rqZGbMnlrS4vIjTUgyOMbW1jG
         bCiR3Rfm6MyVCHlihc5DhNaFpG34UYsDWfirr1qvgVIZFkeTaQGtQtygQilAVDsYijPq
         1cjKA0ZayHUN1xlzWWw9Ri/AvhibeTvb9rgMNrH2sLmOVMjA7MSBiYSStrgB8B9YIwg+
         AxEhflYq3Soljx4aWnd8jBZZk3vznEZDVi7DrSXThadjpKesGP9JqqtUst7Gu8t/BGQn
         AfLCJXBuTzTkqq7z0JbSSLFS5BM2g3jIRlynAQdzEeSh++9E3+aBtDlgv3Sxq6mG+syb
         XJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786979898; x=1787584698;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KOjFRvjhVU8cFjkZuXZNJ83v2W6JcBfwkSkd8Ja0b2Q=;
        b=EcgopFgMeo2n9LoQhO/MqYuxRKAKHJzShC9c9YLkLbiAQ06/bgR1c6+8e6dQUY7oNO
         6+pZOK4516Jc2XVYpmh1Avgl7DQzkAM7R0URdUWyJCC7VFQA6EqSgyBd6L+fMSMFuc7T
         dXPq3iGKc0AAZdh82qQ6QDIriPvVwDAfc9bxFngyyrQtW+2x5ji2u/pT8Zyr+CGlQ1DX
         MsUPNDMYflqG8anHBOkbuGcs54dxY7KhvQaX2GH6voF0gGEIKSRb7ndJquXejQis7v72
         ERQ9h7Ajq+M75yxbEmhiNksZS0OE//nKFgIbdg1TPVYU8b/CmJZnRrJCgzXHs+cHFf/J
         ip6g==
X-Gm-Message-State: AOJu0YwunDwFzJMgJCOqwJ0p+Yv9gGO5k44RD/Sv0+NW1soRX3II+I5k
	9gtBQtF8+ZW2TV0k1w/8ToKNLxpRKnBzC2J5+7h3LF2f0KJGkzlgATqa
X-Gm-Gg: AR+sD108YR2ZR6+HvmOK2hfCSCDA7Po8K5t+FZt5Q0QpTqG63oswsgfbDsu5neh51GZ
	7qOs0cpl3pwahK17rPQorhaTI5+4vNjYNw5RB5NOOAh4GqiJZjtU0r0U0Uc4QmYipVkDqhFORCr
	v5vBwSByL8Rrpb+RUcU1IDtgUAo9HVX2ADb335IZVN+UaMPtZPXJacPKNOSAw86CF7Tq1xPzkZe
	S2gIrYFw0k8cT1IVpfpof9FlcYe1K4m8Jb/PlU2p2tArNYDDZ0u+zOQKLoC85n1S6sKAMXf5sNa
	WIriwtn2IafxDjbx/juwzcT/Pv6fzguUd9x02zeGsYhho4xnm+1ve6gvPdXetgGLAIU5KX7JOEl
	mS0Amq3dJcoWcHWQAsvgvIpNMBJNvVNDBBx4KGaNo9OXVWtt94K3CFSF9uVq2gGD+Fc6WovBM7+
	symC5F3sI/AOOdg3gMNBkQDy3KxdGdSE9VUskQ8Hl3ywMjzI28BANxTVmR6g/cLPlkjVU2tw9iC
	u81RnbjiotnDJkDmU6g+/6Weh02npyc+o0QKPtAgSH9/rUy8Qc0OrmBYJF0NFGr
X-Received: by 2002:a05:6a21:3293:b0:3c3:7a0a:18a6 with SMTP id adf61e73a8af0-3cc71fa8631mr23752235637.18.1786979898025;
        Mon, 17 Aug 2026 08:18:18 -0700 (PDT)
Received: from [10.0.1.166] (75-172-9-230.tukw.qwest.net. [75.172.9.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc13c03320esm927521a12.25.2026.08.17.08.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 08:18:17 -0700 (PDT)
Message-ID: <6a01e914-db1f-476b-a371-170e3b179bea@gmail.com>
Date: Mon, 17 Aug 2026 08:18:15 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
From: Dennis Tighe <dennis.tighe@gmail.com>
Subject: [PATCH] ntfs: fix off-by-one page overflow in ntfs_decompress()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

The per-token range check in ntfs_decompress() uses

     if (cb >= cb_sb_end || dp_addr > dp_sb_end)
         break;

so dp_addr == dp_sb_end falls through to the symbol copy
`*dp_addr++ = *cb++`, writing one byte past the destination page. Since
NTFS_SB_SIZE == PAGE_SIZE the destination is a single page, so the byte
lands in the adjacent page, and *dest_ofs is left one past the sub-block
end (the later `*dest_ofs &= ~PAGE_MASK` then yields 1, not 0, so the page
is never finalized and later sub-blocks keep writing further past it).  A
corrupted compressed $DATA attribute then produces a bounded run of
out-of-bounds writes when the file is read.

The fix is to break as soon as dp_addr reaches dp_sb_end; a full
sub-block still completes, as its final copy advances dp_addr to exactly
dp_sb_end.

Fixes: 1e9ea7e04472 ("Revert \"fs: Remove NTFS classic\"")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dennis Tighe <dennis.tighe@gmail.com>
---
Reproducer is available on request if needed for validation. I was able to
craft an imagine that would exercise this scenario leading to KASAN UAF
errors on read-only mounts.

  fs/ntfs/compress.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
index 76bd806b41e..dc5ad951dc6 100644
--- a/fs/ntfs/compress.c
+++ b/fs/ntfs/compress.c
@@ -352,7 +352,7 @@ static int ntfs_decompress(struct page 
*dest_pages[], int completed_pages[],
          u8 *dp_back_addr;

          /* Check if we are done / still in range. */
-        if (cb >= cb_sb_end || dp_addr > dp_sb_end)
+        if (cb >= cb_sb_end || dp_addr >= dp_sb_end)
              break;

          /* Determine token type and parse appropriately.*/
-- 
2.47.3



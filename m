Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4382360EFB
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 03:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780631701; cv=none; b=ODt1dqnTbFI76/BdB6YscYdcjRXt459kimOx6Mi72Y58Bwk3M1iE+xpQc0dJAEeP0uU6V7Sdw6jD7VDk2VOwlUxyZhLO1SYme9go/Y2/HbHwHRDXILlKBrBXOjgHjHi3TXOXndqc3zXlMn6qEdp7mhxUunaNApCAgt6GC+Gf594=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780631701; c=relaxed/simple;
	bh=nM1BoT8PA92VKS01nonDSyd1jayFpvUtB1Z3IP5clv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XQ4TdLaI0s2bHucT2qs+x2KoeT5O7o/I9WDTeXkJjC+H/mZqkyiZnRmY7T2ZgqWO7/lb4SQCPDEMx3dZCA5GjjxzCtN7XzTqJx33kvKbuWKVaeCOkM1vfgFccppgXhWurfjyLSHaGS0IkHADmvOVOYF2xGTDVIR+uHYh2k/eiGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pedtR+mu; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pedtR+mu"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7e3b2a435ecso14258357b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 20:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780631698; x=1781236498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vgCSFytiH503jBumxd+MnT5KFyiCQKUlxBkeTHeZkWI=;
        b=pedtR+muu0qMSr4UBbFOgSkAyIJPnCz/BfftoVHqCp+op/f5zguxoLdqGO0RT/NyNs
         zFxks7uqRyvv6SD5sqeWD8vS79MfWY+Hbsot7XJDnjnU0TyeuP7TNONKuijXmk9tdaDR
         q+musxHw82Hmv0xOzlOB+6vNcoCaXyyEb1T+t3C3g/pNOkZ5fmAc/OO2A2TuOv5Aj9Ic
         wiLc17WXm0VDYJOL07F4GxyKXIxqlo82Pdzx2LKxi5iMdnbqgB+MCh6R4HtF4oFad9GS
         J/cua2l4+/WCbKHScGUyvmLqQO40SCV0hydj/6H6WPCVzbGsLO/XwNRl6O8nm4eAaPrt
         /H5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780631698; x=1781236498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgCSFytiH503jBumxd+MnT5KFyiCQKUlxBkeTHeZkWI=;
        b=jwG8P5I0vsQ2S2UqFVU1YwB9FAgl8KnHMUSvxEsvT2WDCczLetnIIcCSWWkXbQZ430
         bjZ8qX4GVluB54fza4TZczq6rO4R8cSy54vcQ0Iz4J/Hmqj5xkEZCykDg/tCE9ncea1/
         tJC/s/InZImhwNutIwM07qzjGMUG47J6TstK84olvxYWbgCCjKTcPTNZ6vnZ0PfNGiZ9
         ib+EOl4fjejedTXvv9JaREojobJVc32ltwZkEQeR2dFd8i1iBlb1a55COYyoLbI/TxcA
         vGwE82q/6KBsEqihuySP7/W3AUej487SaEbTnz0Htd14GZPrYmOnFfjlqCOs41Dx0nJC
         AtKA==
X-Gm-Message-State: AOJu0Yyizb4f3xqvcU+xDNY3696sErV18de4oGKq95kRInO8OI47FpAE
	e0JgV73oU+lYRes9DgSb/baB5x96TgnsphOnR21sGoKbaP+/IsD0L/Te
X-Gm-Gg: Acq92OFYJLISqlccUw/CkkXjS4d5c6ITRxEOCT5jZnjFstG0KbEQHHY2AaPCQTvYxhy
	92qwLTTtMpYYnrWMsstW6q2cvVLdVrDMckTYbJIq2FagZJz0V0NwaHISnkZZDMvU6YOtLQTpwkJ
	dGH1QiEZtEx7xzaajwAAECWxm6LlzN8AlhQzjvOLp9Fixv/800wBKDq+xDnCg7w73jFBcpDqBqa
	82PZC++0xTu29HCBEDe51k+kN5keNskW1LSwqXrLdCG35hKKgoDGFh5ILLbGlRRg8Fv4y2+ncZT
	UWxJbi2Yj/sozEnb87gt3Ecrr1sobx8bNXIF2C/10AidJg8p7IBZ1iOYvw4YEbw97Ku2bhWdFgM
	11Ass5bxH5tEqi8MqonVtD6RVGbyoy+CJGydHX0ddFrdmX752v4U5qWsyDWlhbbgevBegNnXbt7
	58igAHAYlzfObf1hSD/oCiITXBSq6CsGfMR8cIXOmIz3SFxgTfM/9wCFBB85gHoW+PcbX8TPRVp
	5c=
X-Received: by 2002:a05:690c:e3ca:b0:7e2:47b0:1d5a with SMTP id 00721157ae682-7ed0a9d6de9mr18328967b3.12.1780631697790;
        Thu, 04 Jun 2026 20:54:57 -0700 (PDT)
Received: from i-use-arch-btw (c-67-187-47-172.hsd1.ga.comcast.net. [67.187.47.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea23a99b72sm44468237b3.38.2026.06.04.20.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 20:54:57 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Maxwell Doose <m32285159@gmail.com>,
	Fabian Frederick <fabf@skynet.be>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] fs: efs: Remove unneeded debug prints
Date: Thu,  4 Jun 2026 22:52:51 -0500
Message-ID: <20260605035251.89305-2-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The current code uses debug prints conditionally compiled with #ifdef
DEBUG. However, that code, when compiled, causes compiler errors due to
incompatible formatters and undefined variables, notably:

fs/efs/file.c: In function ‘efs_get_block’:
fs/efs/file.c:26:35: error: ‘block’ undeclared (first use in this
function); did you mean ‘iblock’?
  26 |                         __func__, block, inode->i_blocks, inode->i_size);
     |                                   ^~~~~

and:

fs/efs/file.c: In function ‘efs_bmap’:
./include/linux/kern_levels.h:5:25: error: format ‘%ld’ expects
argument of type ‘long int’, but argument 4 has type ‘blkcnt_t’ {aka
‘long long unsigned int’} [-Werror=format=]
   5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
     |                         ^~~~~~

which also extends to the other formatters. As this part of the code has
been dead for just about 14 years now, it has not been modernized to
stay compatible with the most recent gcc compilers. Fix these issues by
removing the debug prints.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Fixes: f403d1dbac6d ("fs/efs: add pr_fmt / use __func__")
Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 v2:
 - Change commit to remove debug prints instead of updating them to
   pr_debug() per Andrew's suggestion.
 - Change commit message to include compiler errors noted by gcc per
   Andrew's suggestion.

 fs/efs/file.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/fs/efs/file.c b/fs/efs/file.c
index 9e641da6fab2..9153dfe79bbc 100644
--- a/fs/efs/file.c
+++ b/fs/efs/file.c
@@ -18,16 +18,9 @@ int efs_get_block(struct inode *inode, sector_t iblock,
 
 	if (create)
 		return error;
-	if (iblock >= inode->i_blocks) {
-#ifdef DEBUG
-		/*
-		 * i have no idea why this happens as often as it does
-		 */
-		pr_warn("%s(): block %d >= %ld (filesize %ld)\n",
-			__func__, block, inode->i_blocks, inode->i_size);
-#endif
+	if (iblock >= inode->i_blocks)
 		return 0;
-	}
+
 	phys = efs_map_block(inode, iblock);
 	if (phys)
 		map_bh(bh_result, inode->i_sb, phys);
@@ -42,16 +35,8 @@ int efs_bmap(struct inode *inode, efs_block_t block) {
 	}
 
 	/* are we about to read past the end of a file ? */
-	if (!(block < inode->i_blocks)) {
-#ifdef DEBUG
-		/*
-		 * i have no idea why this happens as often as it does
-		 */
-		pr_warn("%s(): block %d >= %ld (filesize %ld)\n",
-			__func__, block, inode->i_blocks, inode->i_size);
-#endif
+	if (!(block < inode->i_blocks))
 		return 0;
-	}
 
 	return efs_map_block(inode, block);
 }
-- 
2.54.0


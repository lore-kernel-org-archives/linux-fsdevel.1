Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2E842E40E
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 07:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790235567; cv=none; b=Io52OqVSvomHIdt/vGks5RIlkxkMOjknBt9rvilhE1RsCJNEHVlBT9yWz3Nhpm03hyPkjqdOe7S8ddFAij7J6/tcgUjJOZPAIEL+gk5C6PZiwqf6Lvloyx8VkT2+ZwRPWX8fUYQIVAp6j6qU5n/J3frp/jLyxRdFkyv3lE0JdPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790235567; c=relaxed/simple;
	bh=PjIKux1hcNvgxfpiHRvfSPqe0WlSzXEpKyqS/KZzy5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f7DEfNUXBOW2bPY1yWDyMPFRgmOuDdgGf8JkH4sZVE8OhGcjG0nonTKN5oQGGjOpw5S21IZMR40fKggt7fUlC38QfKo0G8VsM7ze+9osSvAnkNdHLO/qcekAb8Tnp67kB1jri6TXuArJ25xTBoi6LlNJDc6zEjS4SNH1gjxf4t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GG5w3nd8; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GG5w3nd8"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8692a856865so790016b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 00:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790235563; x=1790840363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TYOjaZsmA/UC/cCkN5UkTpeL0qbdNP9RpD8AiUnhENI=;
        b=GG5w3nd8eVJrszCocCjdL7iCie2GQLtXDwqz64kvch7WrNVhmNiWd63D6zIuRT6k0M
         Gzv9eAJdj0SSuS7PdsIdWuqbTXGinE/oTHeKuETh+io6+iEloN25c3BZJCx4MHpI7w5i
         +GYuHiAxR7LCYP1Ur+kfnI07H/vEscv3Wzgz+D9XJAHHSjMDSALt0igJUmNIh7o/tPYh
         YynMKa/7OcGtp9+OwsXCkYn73lYYK/KUlTb8BBMY/U7uDtt5xSP0grfJiM6b87H/Xs8r
         OofUgaS4lX7mNdkBmBdpiz/lMJfz9gOXjBYsES/G9qJmQ+dpfy4bSjBtDJ7/SbSNptTi
         FxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790235563; x=1790840363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TYOjaZsmA/UC/cCkN5UkTpeL0qbdNP9RpD8AiUnhENI=;
        b=EHmAYPCGUXy+J6AwYAFudkOZian8VJSkdx1Bz8vTwso5I2RmdCNxsR/ejx57DNOB79
         HDxT70jAVr/8oM2eV74Y7XC1IT1omGtv8xbIDS+dP/xJbkeEKDihGldExXWqb4Ae+wD5
         Ex2nkuBUwLYTCJpk/XFV5rVVCsaTPTKxnLp67Th95KDPO5Toxin8tdH4mykp0eSye+BP
         UVJCapJpKmsd93fA2h6kjiO/XaH+tkKFc+8LneXAtCo5lQ/KGCxLnD0AgADIcHzbU027
         aJPjqqaWOO+7UDZPSX8rbKVZXn5Kpu/hbrFfGUq3c0YNCafEFCAURPcY3uM4xp+F7qti
         oy3w==
X-Gm-Message-State: AFuF++kOb6P4Wi8d781nWLPI8mNRd7/s43lvP9VmFLkegbiMgS5t5/eG
	HwbStiqevpm58xImE0qsZTLGvCoW0SSqBi1ogaGPwes5XSz6dxTv0JQWsRG+iIkX
X-Gm-Gg: AYBFou0zxaznLaCWzmte6x7ZQrrL1FFi7ZW3rfKjMFrYp7W5o+i/WXjZ4N/cjmio/7n
	DGzNhJQTSm6jagQ1edEZlNxMlVFDaPq9PVFDT0fBub8BCtbFdoaAOPQdJbJlQE+9zJRB867yGMJ
	eyv6xilA8+CgOpdHQwis19E3cM2LVc8uTcw7cnUp2ki04RkepG1M4P3ag5dTdNlicJXeI1gpM0q
	2LOD7v1K1RIPnVcYJ99mnLlXhgUfTvWj8M9T/mztuXmzm7nrWxHy+/PZhm/r78g5Y7q7YrB5/gP
	MwLigvyRX9OmdxYfybayO1iu/5swNd8vO7X1D995JBWjZ5NynCfvDAMrIcvOzEa6ZnUVwq8U+YW
	6mm+MSR8vRHYJCtBcbPOZGqNStRM9ZgNQBEv7yiltu5UNtgCAlRTtNvlLjb4NM7YM7zB76UwEiQ
	6rhGHTqWXMXF2VISFTT27/wZiN/yxOSaCL3ScUR6z8nmi8rh9lqBZHvDMuCw6nCNV4lrkSmQxbL
	ahaNA1DJs8WgEaioGX6PNT24ceJvys0uh1VxHPpYaaf47e/gGCOe2JVmy+mA/VCWkvsMXedGGSK
	F+Q8DkLbtQ==
X-Received: by 2002:a05:6a00:3d4c:b0:86b:b06a:d3ad with SMTP id d2e1a72fcca58-87e99568559mr1319879b3a.23.1790235563022;
        Thu, 24 Sep 2026 00:39:23 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1dad44c6sm2393739b3a.42.2026.09.24.00.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 00:39:22 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: al@alarsen.net
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	matthias.goergens@gmail.com,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v3 3/6] qnx6: avoid double brelse() on error path in qnx6_fill_super()
Date: Thu, 24 Sep 2026 07:39:16 +0000
Message-ID: <20260924073920.2782917-4-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260921042511.1473629-4-benquike@gmail.com>
References: <20260921042511.1473629-1-benquike@gmail.com> <20260921042511.1473629-4-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In qnx6_fill_super(), sb_buf is assigned the return value of
sb_bread(sb, 1). If parsing the primary superblock fails, execution
branches to out_sbl2, which calls brelse(sbi->sb_buf) and then falls
through to out_sbl1, which calls brelse(sb_buf) a second time on the same
buffer head pointer, causing a double free / refcount underflow.

Fix the error-handling cleanup sequence in qnx6_fill_super() to avoid
calling brelse(sb_buf) twice.

Fixes: 5d026c724220 ("fs: initial qnx6fs addition")
Cc: stable@vger.kernel.org
Tested-by: Matthias Goergens <matthias.goergens@gmail.com>
Reviewed-by: Matthias Goergens <matthias.goergens@gmail.com>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v3:
- Add Tested-by and Reviewed-by tags from Matthias Goergens.
- Update Fixes: tag SHA to 5d026c724220 ("fs: initial qnx6fs addition").

Changes in v2:
- Split out as patch 3/6 as requested by maintainers.

 fs/qnx6/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 444458ce3e77..70438cf5efdf 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -348,7 +348,7 @@ static int qnx6_fill_super(struct super_block *s, void *data, int silent)
 out_sbl2:
 	brelse(sbi->sb_buf);
 	sbi->sb_buf = NULL;
-out_sbl1:
+out_sbl1:
 	brelse(sb_buf);
 	return -EINVAL;
 }
-- 
2.55.0.1082.g2b9226bbc0-goog

Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C921E2E091B
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 01:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776131605; cv=none; b=AZ1DuxugJdmTRF8SN+ZVqdZ30QB/UWaLTaSqrZH4+mpIInlo1Ob1xayXeQsAiBP0r4mkoSa6ezwyooCSs4NJqsZaM5cTjNbY4TglFmBVfAJSvtS3H6PCnKiuM9vKR/dp7DnXILbmo2QSHbYfP1HFQ74QYBMrTz/ZuxLlM1J1PD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776131605; c=relaxed/simple;
	bh=73PTIOzEApyKbESlUFkgG/fKbUVItu55gtgkI7CqDUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vpn8PogvAUpKGaMJALCrM7gwVFBWyBdAWZU3S0Zhb/gBLCbUGGIdBNHSP/aJnVOHqDyCJ0K2c4deRZ8VhCmuTv+Vg8hYiJ5hcnomr7cXlm+0AdBghjILHJU71Cd6db7s2XhZBjopi4AZDEFqhZiYtywDLx60Pgu++w5db8Ou8OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fznxDZ3f; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fznxDZ3f"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3591cc98871so2396003a91.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 18:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776131603; x=1776736403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M/FyreqTm+YT6hCujD3FTmSWTkYhr7dO9Go7aHpZvck=;
        b=fznxDZ3fXt0aqNNyEZvcJEqIBU0ylc6rw1QiAlrmwy1+DzrwubvQ+tsP/RmbZg25tI
         YDfZlNu3ltJujEkanisEREAtWII885HuVtce6JWgKm0TqxEeYRaUnyHEJFdBjwxttYrw
         cb5wStfec7ElgnBGawuynnej8lcOHFfO54c4LypX7kEOtPgoSx3EVZmjz1/aJWa3ujoe
         CN98HEwrc7l5crl+PAi83YK8HjYrWIy3CZh9miiJ/uV+bVtPDdNObsOLWtpq+wOZ0fl4
         EhbMmnNqThc7Kmf/4ZNHMJVfJkiqKXne/Se/3EuzDD5S+DJ+cZ13VZ4lFUrVpgiCMecZ
         D59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776131603; x=1776736403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/FyreqTm+YT6hCujD3FTmSWTkYhr7dO9Go7aHpZvck=;
        b=gKBxjax1c2m0SDLaX949Cizf8FofeZY7zP7D8RNu0Cgy0JzO0vi4VPz8QBVRO+G5We
         E4EaSr0HA7iQJPjS9nRHuXeW4xU9MgRmK0b5JfC3jKx4yEEijp3Aw1QbBJAWSqQ4HsjK
         kcv7Ysb4YJGpaKAGzqTQ3q4LQtp0SoAJQ6EVIwcRnfaUBp+o+jnLOSIwIpan5qA1FrSR
         CJH8yv666lJa9AR2v112Zd2w8x/KxesV1RsIItgEXGHTI8ikp+si0H18zAyPUPN3dGWh
         BxBeSS+BwchhAYW9lP1FRe5+nPU/bjUWph5HxSWSuuWXzPJhphiOzSprMTNvxaPYdxrC
         hNTA==
X-Forwarded-Encrypted: i=1; AFNElJ/BloG/JeLP4WJiCfOfYG0zJJ0eDxnOyOCSxkWZ8AdBYOT9NHylFREsGJkjWBTcHSHznzzUcKboFnc+12/Q@vger.kernel.org
X-Gm-Message-State: AOJu0YyBXKsXSzHl7sXqOcYxOeovyTnOr6L6/OV6Z9DBbpysTQ7LZPGN
	JT9gBKDN0sqSKDBuf4DFAfxR8HP5jU3A4beDJKbk5iSaJcIQbUUMGcuk
X-Gm-Gg: AeBDieuurH0BTy4P3i0JuKIu89xGPwTWWqopzXa7c265lNxGGySqV1WyTostd+ybsJl
	d+bYjld98S4lFOot0BfoAYb4624HQZm2Z6VLl8YMXUp4eqGPbi7ttMqOaBt18T++3rzugTHja04
	BBiDZxOR4j5Ok2OUbByPC+S72nJn59h1y3YwBqM7kc9R0cnNNb4Jy+z9bvZnx30YEaUT3jCL70w
	4Zw8FEedDHdiY2RZa+omZ/UAb6eO0NGOT8gXLRr9G4NXjmrlMn+VK3c6MRWWVGazRl06Px28XDB
	6c1rLnJXqh/46qEdzp7JXMMgco4mSkRMNavViaHcLnwZOznww1yYnOsX9OTH7vXkkSwuYVzre62
	FfbQNaWOx/J31iLQg76ILctEHetNKnDKIIlgMkY5NsRgX+PhUE+Yb0lScApL/sCQfalTLvyPdLh
	6rsXT1cowgZ3LpZpfAKF/OSm++uLdaYMgKmdB1FC3ugENwxlEY9304JLiX6sLoXyGC954eBWKV5
	obIWAWShWag1xD4KFlzVdSwJXoq
X-Received: by 2002:a17:90a:38c1:b0:35f:b5df:448 with SMTP id 98e67ed59e1d1-35fb5df0c31mr3797552a91.24.1776131603052;
        Mon, 13 Apr 2026 18:53:23 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:445c:f4a3:a803:e3c6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fc6e8ca0fsm332332a91.14.2026.04.13.18.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 18:53:22 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
Subject: [PATCH] hfsplus: fix ignored error return in hfsplus_delete_cat
Date: Tue, 14 Apr 2026 07:23:15 +0530
Message-ID: <20260414015315.64954-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfsplus_delete_cat() calls hfsplus_delete_all_attrs() to remove all
extended attributes associated with a catalog entry, but silently
discards its return value.

When the xattr deletion fails on a corrupt filesystem image (as
triggered by syzbot), hfsplus_delete_cat() incorrectly returns 0
(success) to its callers, allowing execution to continue with the
filesystem in an inconsistent state and eventually triggering a
general protection fault in hfsplus_cat_write_inode().

Fix this by capturing the return value of hfsplus_delete_all_attrs()
and propagating genuine errors back to the caller. -ENOENT is
excluded since it signals normal loop termination (no more xattrs
left to delete) and is not an error condition.

Fixes: 324ef39a8a4f ("hfsplus: add support of manipulation by attributes file")
Reported-by: syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c0ba772a362e70937dfb
Tested-by: syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/hfsplus/catalog.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
index 02c1eee4a4b8..adbaeabc06ab 100644
--- a/fs/hfsplus/catalog.c
+++ b/fs/hfsplus/catalog.c
@@ -421,8 +421,15 @@ int hfsplus_delete_cat(u32 cnid, struct inode *dir, const struct qstr *str)
 	hfsplus_mark_inode_dirty(dir, HFSPLUS_I_CAT_DIRTY);
 
 	if (type == HFSPLUS_FILE || type == HFSPLUS_FOLDER) {
-		if (HFSPLUS_SB(sb)->attr_tree)
-			hfsplus_delete_all_attrs(dir, cnid);
+		if (HFSPLUS_SB(sb)->attr_tree) {
+			int attr_err = hfsplus_delete_all_attrs(dir, cnid);
+
+			if (attr_err && attr_err != -ENOENT) {
+				pr_err("hfsplus: failed to delete xattrs for cnid %u: %d\n",
+				       cnid, attr_err);
+				err = attr_err;
+			}
+		}
 	}
 
 out:
-- 
2.43.0


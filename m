Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793219627;
	b=jbfDSNseINvYNIvDK840eFS+7fyI2AnsM0038zfCOr6ufDw2MVug1yKn4qvvWDVkgTq9
	 RAdGepKOhm7XGBuajplqey4Q/YBoQ44NlRAeX86JxXSkptYFK6p3mycyOS9ewIpkygoQG
	 DoUO16dNj0tJWHywPDRpD1jtWf1rn7qsyT6sv2ljE/Y8cQl4nBqE7WKUl2HLP4cYx+dP6
	 MfoBVG7rGYjGl97nZJQ9MK5pFCTW7zbQsIR0w+07xTtymI/gXiXQd5CDs9km//a26Dab3
	 BWlSNWKdD/RP8OX3UlBpKqGf8ej6rIJN2Qo0ynhQyymhbph7Qy0+dur/q1OCq6yyYIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793219627;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Lb/W93mWkP3TBmUhejtZ18o//62t4qTaZxB1+dKBVHs=;
	b=ASnIN8YZg92w4e3app3pO6whbTzAgTqvYkrJ5yKWNcFS3l76/yq6XOi16XB3h9anKrxB
	 PYIL4WywOZ98flmXeEwu5pQsYZUri9NeCjKjDuxRbZtOx6b/hfK6Cp5SGbdo5gWObk+x2
	 J8ETbmng538nQod0nDHMrlm5heA62lfxyAa2Ai0Jsd4wghB9GkSjUZM00ggq0PiyDgBAp
	 tt0JGfopbBKCrDN3JUZfMft4U0ZMZi2mBFHgi9rUcFVpufUj6a1AcDCNjV1zG5McjlPYI
	 iu1OtW8DldoOeFOqYJggxYsYQWxPGt70u2WBL49jRI1WkNl2I4m35HvidycE2raCalw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="VIAHYoX/";
	arc=none smtp.remote-ip=74.125.229.5
Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5DB606A31E
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 20:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC5DB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VIAHYoX/
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-3535a54c09bso1071720eec.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 13:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793219626; x=1793824426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lb/W93mWkP3TBmUhejtZ18o//62t4qTaZxB1+dKBVHs=;
        b=VIAHYoX/gWbWjx34bja30pDruefzNGvjIYWXpOMoYXWW1mUOtOZlhkvEbPwNePYFUn
         QfUIJQixpcDi+reeukzBUdBkhjA55ttY+/3fETjJdUOW42FIxNYzDebmi7iCh2VWl/ln
         ze5aI4gcNybe7B7pq1gtOGt2W27Tt+dYcpcb9tWCgdnIFk8QRtvL6+ROASGzsvO5gLbH
         JZLIbEqVx5aY8Ke7U/Va1aHI+iEx3VlpkWO6TdszAMuDSf/kKvcWRuc2aejFyJYHcI38
         VhZ6b5Te9kYxtYtCfqqZWVZNG3QlQFpKwz3bQ2SeBxyRwFd7ltstAnke9Y+vHzAmf5A6
         OQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793219626; x=1793824426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lb/W93mWkP3TBmUhejtZ18o//62t4qTaZxB1+dKBVHs=;
        b=DcGlhlWZkTSRoTp027WiO414MFhwjpOWpHB04x6FybeAaTAThh9DfTWI9UZbguCiD3
         uQW3I4E57TH4DtJ/sSzKno93UnsOCExwXET9jdrYjUFuVCyGX8CW8t+9lXKWRvmx02Tv
         Y0VGdx6+l3V/GvN5AEXKeEyk2YfIk/KWfOPa+xZgE6TZzhEawW6J3l6QSL8X5HNYLnLq
         1il9Bq8VcB9LS9RR8YtutSYH3Ab5sjW0YPYadRjGqTlhj4EnCIC5R3lJZbSWnQtf12qe
         /TLN54FUKCLPCJ6HJh31Ue/THdMlwCjuIRo++9PZCq4nVwoyHG1x4eZAHkAMQf6NE2AA
         XBTA==
X-Forwarded-Encrypted: i=1; AKwUvBzsOAJqSZgUHaZRHls9iUWuomGOk1CjyqN+C1oeOOaexlkBSuAToNFvbu32EyrWnlx+7p7hPdulMa3U0+Pr@vger.kernel.org
X-Gm-Message-State: AFq9FYLc291oJAindSfVnN2aF7hTdPZYzNlUdmmFyD7lLF03Pe4qQwpY
	0a1CobE324kz4r6Er7l4EnwLRCzHw7xptl/s9pVa+5CpulMs7LQqPrHa
X-Gm-Gg: AYBFou2hRAxS5jSdSUblzrnwUl9IdcpsGc/jAIYIaWdrERyZa2HRy31YIo2KVi109Rq
	T3NtW74tbtHmBAQbmwI4jnXLZHkTRAK9VMB10/U/8SApHvzpiQ17zS/1q711FyoN2IdW5I3Lcf9
	TsVPjuEMGEuhcmY+njPFuAC3zgJkFBeocVRdw7UGFnS/E4fn2QAfU8rxBIrwOSIlhh4BAUPsRkm
	fo5Y3CLIKF88WOXURqQkDKo8iUEpbjjanGjEPW3u8HxksdS5SHmbRL5DV5gRz508f0irhUHQxIz
	nGee8BumM9qbycQV428YWhlMHEJTpwTAeRamZN6l6B6VjJ8TlTe2Kib7EG+B9KeBym4DEvgx8bq
	C2a7kZ2ubw7fjNC4GtyAaekvNJdxKIWqHaZwqEupJR3pCMZJj7nKVOK6Tpcmos7obAoUE5pyd/t
	CYgAEjzgA4GpkS2emK3ZqLqr96wg8CTgoIN/rRrxZJcvK+EdksxhabrPRTHJUa7yir5YECUZKMI
	ukBDZ878sWhJw1vDLiz5WWcEiJayGLwZPHRaWO+Zj6f3Twk+I8U4E9N1zpyWv04+UFx3flUhfl+
	CUDm1puS9yAXW8PHfzzrvv8K5eklwNXQmb1Vjr6ZXLZBFzvD6+gzTAjkkRu85UPqWg+zTan1nIR
	lAA==
X-Received: by 2002:a05:701b:281c:b0:16e:c820:b20d with SMTP id a92af1059eb24-1a6c87bcdabmr3617245c88.5.1793219625684;
        Wed, 28 Oct 2026 13:33:45 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75e5c6d4fsm14699522c88.14.2026.10.28.13.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 13:33:45 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: linkinjeon@kernel.org
Cc: sj1557.seo@samsung.com,
	yuezhang.mo@sony.com,
	exfat@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH] exfat: fix parent link count when replacing a sibling directory
Date: Wed, 28 Oct 2026 20:33:24 +0000
Message-ID: <20261028203324.6073-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

exfat_rename() adjusts parent link counts only when a directory moves
between different parents. Replacing an existing empty directory in the
same parent also removes one subdirectory, but leaves the parent's
link count unchanged. For example, renaming one of two sibling
directories over the other leaves the parent with four links instead
of three.

Also adjust the parent count when a target inode exists in the directory
rename case. Keep same-parent renames without replacement and the
existing cross-parent accounting unchanged.

Fixes: 5f2aa075070c ("exfat: add inode operations")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/exfat/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 68ddb9c5504f..24110e7fde47 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -1309,7 +1309,7 @@ static int exfat_rename(const struct mnt_idmap *idmap,
 	else
 		mark_inode_dirty(old_inode);
 
-	if (S_ISDIR(old_inode->i_mode) && old_dir != new_dir) {
+	if (S_ISDIR(old_inode->i_mode) && (old_dir != new_dir || new_inode)) {
 		drop_nlink(old_dir);
 		if (!new_inode)
 			inc_nlink(new_dir);
-- 
2.43.0


Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5BF2DFF04
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2026 18:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776538029; cv=none; b=VuiKGzCgGYj2wUqBUeWADi/xFcnGEvPTmRFcgyt83pwHq03lrl/gVZPyKhJ0CVJ/vHgJvz/RkKseAr7GILEXjeUI3OIcBRGSwShgrdrjOcTwH6uFn5E0cGCQuW2hEpklpRjK8+DGN6uFH7D2raWxS7wzG+sqLu04qys1EyheXAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776538029; c=relaxed/simple;
	bh=n61YgUSqgmdumnauMCTUcadlCI9wVoMAdmwGnHiYtk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=flJs4Ltv5FSC8ALeCHmT3168lHseyvpCAMi3dnEY16m0sMlgAu2aoQBa7Mc9RdE9ZBmWRriv20YRbCGTgbmObEFage8O9Ne+sMYergC4hQ1+cYfbY/u4z+D11sQ2MIatEBfouiOoeGBCE2EOoxQ0JnymJ5KfFbYvsXQcCzrY1p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxJI216U; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxJI216U"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8a05c18d3e2so14691766d6.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2026 11:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776538027; x=1777142827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FHvIgY9XKVqtizYUxvd+z2ersRg7u63uDYeKn9sb1y0=;
        b=JxJI216UnTvOhRn20alxOppoZ3NSutXCto+H3BLFZM7X02lRaFtAGg53O5lOx/LapL
         Cq/oRpX6kCQnEH8gnTZJ8tZ1Egj5P49s0XggMpwvsfBgZGoXoVQ/CorVtF1eN1Qqav05
         u6ma0tSsnthcOldRT2XtiNyoJ9vNw5DwXK13JJSxFwCh8JO7zX/W1sfZrHMxo5hyLMZN
         4UE0jwWlbWdt6RHV6GXpKgfabtWwkg5WNytVdbsYOPkhNelidHdc59DkGlvfGWWHtu4d
         5oyb8Lh5tK/DkEM5Oq+d0uOM0VlKBnf7sJwXvPqobiFLIBs+cB5F21mbJH7Idko8hGqh
         8iDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776538027; x=1777142827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHvIgY9XKVqtizYUxvd+z2ersRg7u63uDYeKn9sb1y0=;
        b=YpF1HNPE2y8PsioG4lprYqZubN15vsadT/KrSOfTQO2tQZG26xv25NOVIPfgriSIG6
         CKbHuachffpao0nDI2vZltsk40DSGY+o21aBA6hFDb3d/Y1G0ytNc6b/rRaRak6YaACX
         P0aThs0qhXvz9i6zQqizmmeVw/0sNIA5xtGP24MYy9ltTHEwgPBcpx99L+yZgXqVl/9s
         5/OdMCPo0zTvKVsfgo5Zj/7QR6H2o4eoJX7fIAyIjZGFEcXz5ncaClMzoy5qcNHy+6wm
         ybuzR0qeCLn9fJdLc02zR3r/YDqxDCNNVjCrUiRHvGtaMF2/kiDRcvPWQk/Grjk0QvYe
         szEA==
X-Gm-Message-State: AOJu0YwnUm5dFerhl5TStjHN83W9cQ/95JWvM3AvtPVCBG0QhX7d5JX0
	m5ixFJXXapnSuLRCGDrb2YXpEi/jGagz4wAmrJh2+C5KEwde3RdUB4e5ZH5JeNDg
X-Gm-Gg: AeBDietWpPLGlCRcp7RMN1YWC+B2wogmLIPX0wyBl2HBWUfCoJzTryjSO5yvXP0oRnn
	E8kBo+z4znnzBDSr1CddWsFdy31PZ/MX86I/8NSeUgX9cHv+cxlYdnYUYQpMUVd7zmdcb1XwBPK
	3qxmoTpC6r6ksGlphsbidnqzzSo+bgGApfmIa73bGq4x3uYjXqCKv8/I6pMMg4QEy9yYmfOmbW0
	sIB8d/I7VW8TYzDsIRJB+P8H3GYKT3NOh6/YxlbtfR150qQfCBzkRbOb3Mvlom7JpRv5kdhgNF5
	Dx3mP0LAk1+j62zHlcGcvZtZXYhItQhgooPaDcXJO4QcZC43PWXXtMHdURXJvqfSzj8faR3JKH6
	Cix6GhHMKBqXNI/QrSgVll2JPFm2dqnWTKy5JbgoL9yZv6xHJ00RTNnL80c6qLh0PiPC5iRFk93
	Bzc51nlZQITaaQy08eG8dfbOCAzvC6Fx+i0Ol7M7cW
X-Received: by 2002:a05:6214:ace:b0:8ac:a266:ce34 with SMTP id 6a1803df08f44-8b028325095mr103626526d6.3.1776538027405;
        Sat, 18 Apr 2026 11:47:07 -0700 (PDT)
Received: from cosmos.lan ([47.230.224.41])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02aea5ebcsm39402366d6.44.2026.04.18.11.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 11:47:07 -0700 (PDT)
From: tahsina13 <tahsinahmed217@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tahsina13 <tahsinahmed217@gmail.com>
Subject: [PATCH] dcache: fix typos in comments in dcache.h
Date: Sat, 18 Apr 2026 14:47:04 -0400
Message-ID: <20260418184704.8040-1-tahsinahmed217@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 include/linux/dcache.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index c5bd5a74baba..72b57a15769c 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -172,7 +172,7 @@ struct dentry_operations {
  * Locking rules for dentry_operations callbacks are to be found in
  * Documentation/filesystems/locking.rst. Keep it updated!
  *
- * FUrther descriptions are found in Documentation/filesystems/vfs.rst.
+ * Further descriptions are found in Documentation/filesystems/vfs.rst.
  * Keep it updated too!
  */
 
@@ -233,7 +233,7 @@ enum dentry_flags {
 extern seqlock_t rename_lock;
 
 /*
- * These are the low-level FS interfaces to the dcache..
+ * These are the low-level FS interfaces to the dcache.
  */
 extern void d_instantiate(struct dentry *, struct inode *);
 extern void d_instantiate_new(struct dentry *, struct inode *);
-- 
2.43.0


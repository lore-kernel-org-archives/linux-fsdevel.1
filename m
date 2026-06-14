Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A708D2472B6
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 23:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781481057; cv=none; b=NGyiFbQHdOeME9T7ej60DpMsHVEvANLc8z8WlEGywCBSQsGpLBDkKW0rUjAKlvnXqdaJp0FC8G/JrU11/5TMyHS2/VR144IizaNCIGiUJ0egsH2nvbgDF3qFsbdbizGoN4ZkxDHMX7JXWXAeMSuohi+Xi8EeTgG/dWBR8/jn0hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781481057; c=relaxed/simple;
	bh=RsuzjeVK5wMRQEobDXrt72MpfCjV1N3XuwLifxRp0PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WdxQkVjI0DHLpWVVRloLyjGbYZXv69h60iLHsFjYwr6/38BCw6tTfstW7ifIkjx7m1xaiKbPHBvnjcuLG5FHExJowNe45vrllKjJcvSVRsH0aXdZaJGNSeVnRbqx40x2m2mCUMwuedIUMtwTmuWKkBAlBGiv/JApgde75uEWZyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atMK4kLO; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atMK4kLO"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bf2e8ccca1so16932745ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 16:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781481056; x=1782085856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvXgPLhOiWZMaDJ+rY1MoB7jtQwbeV+7PhRopqnn4qE=;
        b=atMK4kLOl+IIfk3Kr9jD2UaGMrjFy5HBRgIMZHubeSy2e9yY9xGp5tbIFX3mOAkIqa
         cMQTJ0SgJhFXSdIDnkpj4GMnF1LiEv6tJtVMoBQBNJxj4UqDBnUwIcnNysfYKxrRtr4y
         GtrHXObyLYRYu+xF2RRR3CJJ6SGuW5Bm3XahHec2+DMVfw5WCKa11aC2mNh/6O4bOxOZ
         qORQjhuA73serBkVVrQzv7CaebRroCCLqPEjtWckbuI68jxbDQMLmsgZCK8Vmgw4371g
         m/qiM4yN6a9ub/mHMNoMX3Xhn87JycFFjBgOuXRtvcH1wHUK/sZCAZp27BK6sr4vuPeR
         DfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781481056; x=1782085856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JvXgPLhOiWZMaDJ+rY1MoB7jtQwbeV+7PhRopqnn4qE=;
        b=BhjA5uYhi8q2bAlZORe3RMLMkLeN5fGHZWf79vtIrCA37h5QFNO8gHa9sO9V/4Dhom
         Nvd+QzVf/NHM35NAvveWxcFPuMTe+8INww8vGULBvLWdsvYXg3vTnjHcjgxJq5XZFnV1
         J7UVRZWbMIuvFaoiTSXnNjTHYAvcPAqLmxrpL+5ZlVkjyi5SnbXPc92YT0YDxYRIC0xa
         vZHZKU2ML0m5e+wwQchJCAt+mP6Qxgj4dwp1ScDN1QlG+RZWH6gVVOuD0+uwluINzm4K
         rW5gkTbS53CAMixpfgzYj3H4bgDQSs5adG5sd1pbNcP62tGgcuHfaTNvhPIiaId2y3XC
         m3Rg==
X-Forwarded-Encrypted: i=1; AFNElJ/WZvl4E2H8nlxluv+7T1gCc4dFLww9o0esWc7svmSLpGRL7H+en6AYu2lfTLsNRGvzYG5voV6IHJOAMosF@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2xISi1ANKDzRSp0Cqf5Vv/LfAeVYXjmcNSxMvxH1XXrInjLz1
	GrqifH6G6Nzi2FSFTT7v463QKuYAIESQyxRGc//N/gC7a/4MhJZB+W8aTrGIUg==
X-Gm-Gg: Acq92OH4MWweabuxsYnPdca0Y6tV+HJy5S7airnWpb6QSko4EOVqElR5gWb8jA9Betm
	Tp77Gq4igVike06oH/LeaFbfhTjpCtZbClB1O9pMQV/UzW7ZQn1ffJ+WX37ghJ99ZXBQxoZVFKT
	StmeoGmEEMbtRna7EAQeCtHtnS9cmPzzH3EnI/m00OG6s7bM9r+puFiFP11Sfhhkn9x9tFSbN+P
	eRjHFx3CG/X2IT76OZe1cyjeJBd7Gy8NT6CNForOC+6gFtZp6m7N6RlJsze0Wk22TZea0Kmj2fg
	aCahQrR3kRN/dgh+CxUZhi79Y/bB6J6+C1pKkPtA/SgRtsYqpJV3f66ZpvLmWJpnxWvml8OygDG
	0Wjv/mppDgSVr/eMbap/mViMsmrdHI5Jvf02P6EtyRutWjU0DOS6j2D/7uLCIdclDJOM7Oqx1xY
	faBMJHh48Pj9Ec4nu6VKXkJrZJFZw+mg==
X-Received: by 2002:a17:902:e80c:b0:2c2:62ee:5a0d with SMTP id d9443c01a7336-2c410509b5cmr137466615ad.14.1781481055927;
        Sun, 14 Jun 2026 16:50:55 -0700 (PDT)
Received: from hyunchul-PC02.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac72asm86651425ad.38.2026.06.14.16.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 16:50:55 -0700 (PDT)
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] ntfs: fix incorrect size of symbolic link
Date: Mon, 15 Jun 2026 08:49:52 +0900
Message-ID: <20260615-topic-symlink-v2-1-648a769d01f8@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615-topic-symlink-v2-0-648a769d01f8@gmail.com>
References: <20260615-topic-symlink-v2-0-648a769d01f8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=606; i=hyc.lee@gmail.com;
 h=from:subject:message-id; bh=RsuzjeVK5wMRQEobDXrt72MpfCjV1N3XuwLifxRp0PM=;
 b=owEBbQKS/ZANAwAKATTyMPr3jkjTAcsmYgBqLz3PrNVLWS1tozhSGrXEKyRP7BfNAto+z9Yb0
 lcJAOQhH6uJAjMEAAEKAB0WIQTVhSnMU3bjbW4eb2I08jD6945I0wUCai89zwAKCRA08jD6945I
 0zIRD/486PbmZkOXPN1/Y0q32YFJQKsyIe8DFRBAidcGOpplpE7hT6pTemEK13MgJcTGZnYwvRB
 A4NG4kak9swbPcJwRWD4+6aFK8P4kivEk5P/mNKbvm10gsWA+UTmMeRo/NOk5Z2iNBWlMTYIiwd
 eeSGyVW9Kre/zd/ZzE82yVEdNB4/RxMbngufEXiQ/QaslHvX/rb8XfdqNAnQuraZcYYPZA6V4pN
 thqCJXt3LH+87R3t4InaNxd6Dx3q7hVSkA2tZUi2FM9mVqeHR6MtMe3QUj+DIsSBUL1HvBoc0lL
 Tp9EI6gXxU0U0ZUQzrpgqILUMCfF/1KKfejG8/mg4TsON9NYVyOQSL6vnen+QYQxMAzMN30FBzL
 HZzxMH+MoX0KQoHAjtWKYnD0r8H5FhXkUBpnfprd0mBcJ9lAD1/4SvEx96nmTppGIyVaUHtgzN/
 /hbcTbFO0qzE4KxdxAopcIaScyHp7lEVmX9m3Dy0Nk2Q+yehq6u0RhvEAkUtmHuR4Eeai7E0iPU
 OOtiNkusjDASOcwuxN0wBuTug71OJ9W0nzfsii2G1Z0CyyT6+CzISbwXPVSg5LTmZbOuuVr12zv
 9m+pIyH3H0VY9tLw5UqzqZPPZuAk13r69tdT1G0+mIcOjHxDzWGpsAFPL4u1y3AIiy8jl7jmDft hyVov2RLmUfujPg==
X-Developer-Key: i=hyc.lee@gmail.com; a=openpgp; fpr=D58529CC5376E36D6E1E6F6234F230FAF78E48D3
Content-Transfer-Encoding: 8bit

This patch fixes the issue where a symbolic link size is displayed as 0.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 2f2634baa285..efb34a5e94d9 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -1199,6 +1199,9 @@ static int ntfs_read_locked_inode(struct inode *vi)
 	else
 		vi->i_blocks = ni->allocated_size >> 9;
 
+	if (S_ISLNK(vi->i_mode) && ni->target)
+		vi->i_size = strlen(ni->target);
+
 	ntfs_debug("Done.");
 	return 0;
 unm_err_out:

-- 
2.43.0


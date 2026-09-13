Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A753D2DCF4C
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789311002; cv=none; b=nmZXAc70e7Twb5plSXDSaTI289BR44rD7YUiHfR2V56j0PK3miVRqb7kuf/NWD0/yNk5Bhzgz1AfbETP6Nuais6qG5Rh/lfq4Q+qye/IAl86FJTN06dwCqFa44Dv5I367Nh6e9Cfos6FmkmgxLV1PiMgQA6e9qPBIuxiRpY2BuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789311002; c=relaxed/simple;
	bh=6HyMqfMFokSBSd/H8EjZ1pGgrmb3gmjQfy+uT6NpeHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RaBkxce6iqFLImUY3yADYGQ8a07P939ipzuGtBJqGPrkI1iUZc+TrWHzyPVef+xtOsqpMhUW0CvX6H9LDSeZzHbr9lG5pc0yPymiz89RbY2t8mN+Ez5c3BD+g3CCsWLdXoRElwpwbndG+8dLVzx0gckdGPJYWmfvoeozTG6NKOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQ+GEZuo; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQ+GEZuo"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso10562835e9.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 07:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789310996; x=1789915796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lbZdzHZQeGskIxjajRcW6RuRmFa63C0BNSbgSO/ZyFE=;
        b=PQ+GEZuoV6QQXoBLvpY3WhXEj3FKURHLeXmUo0LbyEd55raaviJoBT8spI8CJ+Utkv
         aTuxkjwfCK10a1zK915+pWqa2pAUMsFTL2R/G9oGTPvRuRkmevHGuLLarN/rvfxlNcEj
         i3gji+kdOXdvJSrCY53/rnGPL+yvL/auyDtNr2E+2Rv2riJlaSTbR2j3rWrbxgwYZPKA
         bCADzzp1kDCFstJBAOtbklv4ilwPcfGmHvOBcO4OVAlr/Cv4UY8GAYr+9WCh/mwK65ov
         MVYHpK8GKMNh/P46Xy9EDnzIwIb+/ayj506nGoVwjg1QaDxaGwH7wH6gU1vldb2a3ed6
         hC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789310996; x=1789915796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lbZdzHZQeGskIxjajRcW6RuRmFa63C0BNSbgSO/ZyFE=;
        b=bRsqaAOyDxG4zrfg+gx6NIknomfmauzRPGx5OunrIwsd67zXrQzGdUQs+vmxOkzfSx
         Tbu+ZtnpzH6eGeFRZdIvrBA+RugqeenjJUfugu5NN4K1DTWgJp6YyfZQZMJCmPx4R5B6
         TUINmOvcFv1gmOIyvsqulepiuA4I4qRwPO1SX8HUgmYA0qd+XyFbYx+pb528dLcaQ5x3
         bRLzkJ+DAU3r/OU10QYouOJ1r6DNRr8bp+NLR2EVi4ljaiFWg+Aue0ySmEeyg6PeJROz
         aC1Pfi1AqNrtCdQ+mB+7DwPXnq0wJcBxTb5iUDubhEwud+xxp14QlH2X2fhvmAQtSSJS
         Aepg==
X-Forwarded-Encrypted: i=1; AKwUvBwjJe8an2yG3kkOiPZzUVsX87OhsE0lOHaGusfHSE6sa83HCpnO/4mEN6l84XJR9jg9T0r3PFtKVmJ7/XF0@vger.kernel.org
X-Gm-Message-State: AFuF++kQAKsYVjNV9OSXR4x2l/4y+X57FoOtz0vXQm2P7PDkqaNBF4QK
	k/kBrIcGJhCirY08C1oZNZ3VSxowyk59IDRoMyeTLTlIfGSL/W2Y8Vro
X-Gm-Gg: AYBFou3g6h+dcHHJ6eP897F9b7+ur4Mk+c6lN+OaMcE3GLVciI1IkqC/tVVic/e80RT
	G68vJZJZ4eiAQEyxjJ9Sls2ICgXU/B0My0+x/rJK74Xm5xH9GFWVLmyMb5wQAxbH2avxbyQoLOQ
	OaI+b+QNDpif9nX5STpN3fuNRhedfrxVYoutGCh/g4FNa6WA4n86Eqdj+/2Ii4sifOOEeI23QGd
	jgj86VNHKNEvDBiziax/7naZId38Bc8OXvw/AVsJ3p8zDdS1t4chF10AkTQUG9TvjarhZb2B029
	zPc9u7LzuHtwvDi7unU7mFljPt6YSd2IJhj22YLafW3NgydU8ji9yGghb7PVgxH88FEhDOgwdHz
	I3DTeCEPEcVlO7OPMyN9AGr1ygEYLf/TkCVTJiEex9BmZcID+A7iX19qLo19tKu6o9doZTxu0ma
	JI/svPRtzxaenN1dLn43N1sgWycgxEKCZthC6FzrY6hxK4wuWaaFP4/tczUEADYILatK9NF10pO
	HdQ29fPsFMU3uJzI1dglP2lmpK3EG2dSvwdgJMyBwvh1gqlFutIEg==
X-Received: by 2002:a05:600c:3594:b0:49c:fa21:1c89 with SMTP id 5b1f17b1804b1-49e6cc14055mr86517875e9.30.1789310995731;
        Sun, 13 Sep 2026 07:49:55 -0700 (PDT)
Received: from f.. (cst-prg-84-1.cust.vodafone.cz. [46.135.84.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6420de77sm109534235e9.3.2026.09.13.07.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 07:49:55 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 04/10] fs: use path_clone() and path_move() in vfs_open*
Date: Sun, 13 Sep 2026 16:49:11 +0200
Message-ID: <20260913144918.1606123-5-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260913144918.1606123-1-mjguzik@gmail.com>
References: <20260913144918.1606123-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional changes.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/open.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index a84b55301719..e11d1342ff74 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1102,8 +1102,7 @@ int vfs_open(const struct path *path, struct file *file)
 {
 	int ret;
 
-	file->__f_path = *path;
-	path_get(&file->f_path);
+	path_clone(path, &file->__f_path);
 	ret = do_dentry_open(file, NULL);
 	if (!ret) {
 		/*
@@ -1125,9 +1124,7 @@ int vfs_open_consume(struct path *path, struct file *file)
 {
 	int ret;
 
-	file->__f_path = *path;
-	path->mnt = NULL;
-	path->dentry = NULL;
+	path_move(path, &file->__f_path);
 	ret = do_dentry_open(file, NULL);
 	if (!ret) {
 		fsnotify_open(file);
-- 
2.53.0


Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CB0184
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789311007; cv=none; b=exd2ZQ9woHIjL9Mb56crN0y0qkR3YIZwKTKAu5cL2wxY6DzHYfwFJNvCMzlgviKWeEJQk9teUU7kVLOYGPztUL6fjbXiQXu+TlTr+k7rgw2VsC7yq179x361NmlsCVByaeS9lqU7JmVLm5raWhEqsBp2KgwwaRqM7O20xYSwaoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789311007; c=relaxed/simple;
	bh=hcHBjfQv2vt4O6bNCDsSTnuv3uAc9pY+xex1NeHkj3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+xFBfWO/ogMbtCg49UAOxE8DauMx8u9K6vdOych+Z0SVxTj1NqOQSv9ntK3MBGXCl2MLhlhH4dOQSa6Qe1/qZWMW3nuUDYqFZxPm6hn1wAAw0DKoGyGHG92vx85y8g3piSHK26b0MAnUCEkL88Qb7+Fpr9x8fx9o2Zd+vAVmuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8/P96AF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8/P96AF"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49e6e69d528so10973665e9.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 07:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789311004; x=1789915804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W133JhUAHBaW2yCEgAwNUk4+ZgihaBOC1mOOkFbU1Iw=;
        b=k8/P96AFDiK1s9ycYJwuGroDreTey0n+6MQeDu58gbYAEj5y0MfzqYwb36XT18fk9D
         vRf33uUnika5lEDOKjZ+EeeLK47SixwLN1VbvqhIJe2wz8hxr3kBzM0QbmBNEP+Zb+d0
         jptZCqI8cJYjRSoeVa8foqjZcX8+H/OVr4XBlvmVmRju2U9abGt+gKpM/1LfyP+uyiJI
         t1kesrDZpHKWHThS2ZlttvYvmCuhsXlxAPYJQdzsas8PkAvaus0yF5O0wn6c+i0zsf5t
         yWH8nfFNEfQUaYZpJJJirySv/non9laJn6uoxoaf6wjta3kTrtt5zcRNwnZdeXK8NC1W
         XGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789311004; x=1789915804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W133JhUAHBaW2yCEgAwNUk4+ZgihaBOC1mOOkFbU1Iw=;
        b=afq9P/oGYKdDzE8eHKxtWpLSA9cWwUG4w7AT3rXpqYL70ABhV4uck4mgc2QilqSvOp
         ZQwTVkOM59GqCN6qroDT176i46/t2gvSMzAhfph6CEyN6LTk80c1NqmuGhqeBv8IljFq
         Ep2IYljtin0VvIccCDrzqoRPyBlAxE4g8PxVyzrC3XsDQdAgaSPyctB4D2ww8TXgW3sE
         Zxly2kTU1GBoBwjlB17UZquFDnuJ5bVehqtlhce7E8SaycjLso4N5hbaxrZLol0cUm8Z
         era9lMxj58V+2CR5y0DIFktUhtu5UnRvzMqQOSRm444nagVtXZ6IWJLZ8W0sTwQfQHEl
         6KZg==
X-Forwarded-Encrypted: i=1; AKwUvBzH7i63qnO8NZlokL9zMnTRgCjNyEtOqFzsXADQVbN8YGhq7zI8qWOdJDv9BEULJp1HJZ1uHFIo6rwRxn5n@vger.kernel.org
X-Gm-Message-State: AFuF++kugK1EVlABzncOtfhptzlpfB+EN4PEkbhqrKr2WslMzD4ddB5B
	B06yLTxEnFco5G8aIXDe1csidtAb8ufXMxQQuU9NLKKaPsTXWkcACqOa
X-Gm-Gg: AYBFou3qBS/y/ZKQZ4Pb6BlayaXmqeVLVqT3TQBCOPW6tGS6R8mlbWJA6R7I05bUo3y
	L704dboNgQ9aDWlFHOz3tOLVgt6yhhZiXYpdozLjP0EQk6ux3v8dysPJWeIgx5cGoTbUF1F3169
	Hyb4Jh6GoJ+qxatLzZKSld7nZG077yNb+KJN5HxekXUkTIC2bDFhnlMkDsvtY7k2cFufb+pRjVf
	x3MmuqEQuaufSJzP4J/MBg9vpdC5P11OiB8S90sijYmi/dbeQfYp0U09oppSn7Wdp6p+PZ6Tgwo
	vbxwAKP9IA5eP0etNQ307EQPXBj4kHp1i1D2r38Jv5vCj3YZ6yQLNoRBBTRzEbLsVEuPNXoLLDb
	O+AkoHz5CUnOc6U7EiiAtCPeXMndpymI8ra1upA3V9vgl/JaLBGjF0lhN+dNlfBja88U8A239iq
	irL3l6QVyOnWuQvotjYROht3P4GogV3YNGL6cNrJEgrspDECfK/oMWjW8vtMWuKpbVPWokLcOzm
	C+PaTXSSasrdSDng9hJ+OrCEAW2gOO+BjWkL5bgzbA=
X-Received: by 2002:a05:600d:6501:20b0:495:48d7:f178 with SMTP id 5b1f17b1804b1-49e61988e73mr99621045e9.11.1789311004217;
        Sun, 13 Sep 2026 07:50:04 -0700 (PDT)
Received: from f.. (cst-prg-84-1.cust.vodafone.cz. [46.135.84.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6420de77sm109534235e9.3.2026.09.13.07.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 07:50:03 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 09/10] proc: use path_clone()
Date: Sun, 13 Sep 2026 16:49:16 +0200
Message-ID: <20260913144918.1606123-10-mjguzik@gmail.com>
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
 fs/proc/base.c | 3 +--
 fs/proc/fd.c   | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 01d8bfe1c410..6b055352eabd 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1766,8 +1766,7 @@ static int proc_exe_link(struct dentry *dentry, struct path *exe_path,
 
 	exe_file = get_task_exe_file(task);
 	if (exe_file) {
-		*exe_path = exe_file->f_path;
-		path_get(&exe_file->f_path);
+		path_clone(&exe_file->f_path, exe_path);
 		fput(exe_file);
 		return 0;
 	} else
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 0f9a1556f2a3..9ab9bfd6e48d 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -180,8 +180,7 @@ static int proc_fd_link(struct dentry *dentry, struct path *path,
 
 	fd_file = fget_task(task, fd);
 	if (fd_file) {
-		*path = fd_file->f_path;
-		path_get(&fd_file->f_path);
+		path_clone(&fd_file->f_path, path);
 		ret = 0;
 		fput(fd_file);
 	}
-- 
2.53.0


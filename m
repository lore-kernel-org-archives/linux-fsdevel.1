Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482F83148C5
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 09:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777974733; cv=none; b=Cds0hhxGLtxcxzKagnuyweZhUE6Gml+qmXBx59XH6+3ZS/lqvVeBVrOkGOGm1lC0q464bdXz80hb9aefjvgMGyNAoastk+WuP8xsl2BjgSw9GJm9f/YFjNGLEfdFGAzAMZfcXmKWMFV0CE6uoZzpCvbhRC1+dPMn3GLChPegtC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777974733; c=relaxed/simple;
	bh=C50xHnLVbEOK7GneCLj+4ihK+Y3olQywB6A6iuQURfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ttrLDCb6WCO/gPc8CCSzgWuswrPJ+/ElKi1sRixFydnu8kbFagAHNoBN/Mh8d7mxUN5107od2MDBgfWqHmWX0CW1Its3uY2YEMeJL95DZM15GVA9MghZD/ASaroEQqLiO1Kap6krqjJMnTs23wU2iL6yAezGgJ7H51/1rNRAjzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5M8cRIY; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5M8cRIY"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-835c98b659eso1358333b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2026 02:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777974731; x=1778579531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gkwo6P8gTQNfH4qEff3exRmXn3jFDhuKToYPFVQ+fSY=;
        b=E5M8cRIYB5EJgB2ElL8MPi5KXc2vbg/iWSxShbusnjLs8fazyyeYpyYFplcsjlZ/s9
         pEMg27Fy+iylmqGUbhK6QBKgDZ9QR5JaRDEvvSHFaVJe3QXDoPj5wL5CRBAbvBF4TmGn
         I9GSe0LbhvOG/wpgOWKZCIyW7Ngb/1Os3nLb8tvTHfw8mktRQTFKN+C/fJeRpP7WedEK
         vfh53dx+brc+eJiOe8oXY9UJlbYvQiAIBNgfmCLHDOG6ilJOH2bO1ViUDgt3l2NCHFU3
         5/TLBVLlys5JRwlmR9+JAcb+oueUgAQfO55Ch8FCc0+A3V9zyVv9EOssCuz5LmMVzNsk
         i31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777974732; x=1778579532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkwo6P8gTQNfH4qEff3exRmXn3jFDhuKToYPFVQ+fSY=;
        b=qjVXoclqosIJiQ7pCcSErBi+H8gkein542KiflbndC0ZMzMqjs/B1lMuQUSYQke88p
         NpLMzAyv6q3s0tjoJSfn2ZsvS6b0hPj2VzyJRDvxq4413eRABHfwnDxPlz/Lb4o2HbBh
         VgnaiRxgAuJytVbb2EAcIJUC9WRtV4Cs63baTGRSy4w+0gvlXZWT3UJYwi1ZnRFAERKB
         RkiAx8zfYi1hxMm6F+YvY8RSpBMZGtZQVsQxzXvblYj9Wk+az27pHAIN04+hFM5H8OCy
         0QkIk/FAe4FYYUdJbfPXmibmY3FnDhsPkrVEU6gXy9QoBhNwIVr+bV9RWeq1mjD9kK0j
         JRmw==
X-Forwarded-Encrypted: i=1; AFNElJ+OpWgWUq5RJs2wvy5ocwHqrhe1+x2QvCt+0Xncj0Q8LlYKKdq2jkcZwBdQsBduTFWFb1i9FIQAfL9m52y8@vger.kernel.org
X-Gm-Message-State: AOJu0YzCxUuQNbskLhkAm/hAvR0sKNJd3y+E3OuJMMXpVWJu3i0nQVeR
	JPYRAOGhWdp+9SzmOOTFP2R/8yk/EqGsLUuuMchpHLPuA/AIPNJ2laPfeQ6Uk8zmAPA=
X-Gm-Gg: AeBDiesOoDlzReaQQmKJP6IZhh8/0C5ehGl8jBEs2AHjTG3sIfP3Cb558j+CVR1zYIF
	X7v7PEeWzHMr5d0CoCoeK7XNVApfIjVCKlutfWaI1fFYR8JhnK8szkzq7JpnZO15QERX9yhjx4A
	xNhaXN+MldiEiX3TVaj1sn0GLwo0rE4ZQfpGbSwyuAZ8rVj5p5l2Ag8NLJxjOX5qYRaoKC2xfXl
	47027CefGGdkt4NX7Af7rReBwstJgDgKyT+EstGqaGScf4aYsNh/4H+iNGbSaKO6OA9UBZeKz9x
	0obGP9hA9/jrz2I0xGASUzKcHAAJcU2huQ2uiflAYiI8nKstMnZEjYTPwUOTpOkcoF3XMpDyVVf
	NHgJuqbccF54oCsr2OsSofiTc0MJAnUZdU8YrD2kAkk+AyEQfeDIR88F0KTcmUeGeEUGPB9EYsh
	GfOz97UI4TIi8YL69mL9PqoJ+6lbNRijP1tJ78Jc3T
X-Received: by 2002:a05:6a00:14ca:b0:82f:721f:10ea with SMTP id d2e1a72fcca58-8352d1bf331mr13683369b3a.18.1777974731611;
        Tue, 05 May 2026 02:52:11 -0700 (PDT)
Received: from vini ([2401:4900:8fc8:907b:6dbd:bd6e:9d0b:e8cf])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965d38ab5sm2125855b3a.26.2026.05.05.02.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 02:52:11 -0700 (PDT)
From: Vineet Agarwal <agarwal.vineet2006@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vineet Agarwal <agarwal.vineet2006@gmail.com>,
	syzbot <syzbot@syzkaller.appspotmail.com>
Subject: [PATCH] fs/namespace: fix NULL pointer dereference in do_lock_mount()
Date: Tue,  5 May 2026 15:21:31 +0530
Message-ID: <20260505095156.178351-1-agarwal.vineet2006@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzkaller reported a NULL pointer dereference in do_lock_mount()
when calling inode_lock() on a dentry without an associated inode.

where_to_mount() may return a negative dentry (without an inode)
due to concurrent unlink or mount changes. The current code does
not validate this before calling inode_lock(), leading to a crash.

Fix this by checking dentry and dentry->d_inode before acquiring
the inode lock.

Reported-by: syzbot <syzbot@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/
Signed-off-by: Vineet Agarwal <agarwal.vineet2006@gmail.com>
---
 fs/namespace.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index fe919abd2f01..b1dccdf06836 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2760,6 +2760,17 @@ static void do_lock_mount(const struct path *path,
 			}
 		}
 
+		if (unlikely(!dentry || !dentry->d_inode)) {
+			err = -ENOENT;
+			if (&m->mnt != path->mnt) {
+				if (dentry)
+					dput(dentry);
+				mntput(&m->mnt);
+			}
+			res->parent = ERR_PTR(err);
+			return;
+		}
+
 		inode_lock(dentry->d_inode);
 		namespace_lock();
 
-- 
2.54.0


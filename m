Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCCA331EDF
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 08:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782376587; cv=none; b=JsH79TdvmJKIaJ+FygcRJpIy6grsZhQ1mRPxAXc32ZxuulsvCd/q7ibSD/M0UEpHL9ujKvdnGV9T2eszA+S9Fe6rVA7a0u/cfwRTSCtY3HgjHLUjTJQi1Jbveopk0BTlYVSagIK6+H4+iyLnrrfX9doMa1JoEVBtbixF3du5UH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782376587; c=relaxed/simple;
	bh=qZiu7fS8kCZwF8htRjH//VRi7MyCn+kxzvosWiYjiV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eN1qMyXAfoL1gqHCw/i8Eo/fPHN1gFGiO+V8tvt6I3UAbagbYqjf5MgZ0IUNozCGZOLVPS8jJPMaOpESpovxB9wqnBiSi5fDeuR+T2fSZysDCcVTOTgoialmO3Nlileg7GbhUTUzeI+1KhyuBlI3+wzI5q4KWp/3vujhBBEHZnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JkDvh/3U; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkDvh/3U"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4924e6fda5dso9703275e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 01:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782376584; x=1782981384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhjLk1CMHsJsOzOKQ1JbfvjErAaIXQv49sV6IFA3w98=;
        b=JkDvh/3UEJ/KKFD95OenoyJPpGWz0C30rNVG/xSx51ViDMBLykodCQP6LLextigjSb
         Y+jWkxDP+JbxE9m5wvysc5XRaMS04mdOgooXX+hmgcEA2mMzG1aGFJdXTf3wL8y5GG6y
         eeMUmObFy2ZxgNbr5ubK4MO+xgsTjL4fnnI/4wHvB+6nKCs+Xj7uWsF2rQyYvauxXFTd
         0103O0ryVXNJWWS10mzD3Ly7L5QqOadPrC8aLIwBBIDyNfRYmOdSi7j7Ffb9igpVBFYs
         kJhL7N1TAZSYiZRFKmz9r1cT++Bz7Rg2MVdnnbDt8fH8n+MIfC5SjvyzhyrVoa7PidLt
         icEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782376584; x=1782981384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VhjLk1CMHsJsOzOKQ1JbfvjErAaIXQv49sV6IFA3w98=;
        b=dOA9ONsVRlVR1AUvcMezhBnH54U5BgG4aUU8Mi8dyPmMqE/AQ7dwGt+HEdeOZ7anrc
         tXPKYgCjKZUBdf/rKtTeaNK923V1cmfCTp1PnqniPx7Q0vGo3hr9uiX4Tra71IAJJx6C
         Y8nZGSYCmNEANdvaHjIa04amOllCxuv/sbQlh6wi+qQhkZ1IOTITIiY2tYV1Oq/TElBY
         qXqV9+WuZlw3rCiaj9mzdiJ23HL4Pwe68xVtoGlBueVJDM7+MCZdN0b9Ee9cCER8/UxE
         V0PILb/O+8qX4PBGQv3/xORUVfK9FhbXL8cSf3VsTdwDMF5OsQ7cyxRy5agDfBvqJjs8
         xs/g==
X-Gm-Message-State: AOJu0Yw2gCVLmlomhvcJD7oVtDS6UTq/otkvqUXapmzxJG/d1PDdF27f
	T3pIzP6e7zKqtCIQxTNxyb8uNKsvuvBjRhb/MkT+uLM1OJG+YL1EnGqRyc07dUh5USw=
X-Gm-Gg: AfdE7cm77JWW+ri4V4ZuZsh6yBxhPxUplELylp3KM4YWvSDp2YdWvcR5XL4BOkzSMmA
	Een7rI8zkxFbjUHb4LO1k5pq9poJv0UUIEzTfgKynOlGO+agwU+rNK5IhFwnYYLk9EfHLllVP4d
	VczsNv7VNYAv6vbWgC8sZ5jz8YQjswEMDFo/JFJzFBdlYhHJNWEB5kXm/c4F/khtUKcAfKQNYK8
	O1CdLiEM9bIlVIi16VwGt7y4KNYUJZr0bdwtcZayhMy+I4hT1z/Ju67pfHvbaQHqOaUaHmC0upJ
	nqdtkysVpqMzAUgdH2/h7o9eekxJ0QO40khub8ePtjuo2Cy+i35AQp+EHK4OFz6gqyh6kd+EnBJ
	TOgG45X8eT99+pGrgT+X+cfei/HgBoTPv4pNJ6skIBXduJ0EjzpsVK8G63+gKGbOtgSxI9YnQfZ
	W1FRf/d1XL
X-Received: by 2002:a05:600c:c4aa:b0:490:b189:212d with SMTP id 5b1f17b1804b1-492668a83dbmr17827635e9.33.1782376584308;
        Thu, 25 Jun 2026 01:36:24 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-46c2279b85csm13362284f8f.28.2026.06.25.01.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 01:36:23 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-api@vger.kernel.org,
	netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andy Lutomirski <luto@amacapital.net>,
	Collin Funk <collin.funk1@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	Stefan Metzmacher <metze@samba.org>,
	The 8472 <kernel@infinite-source.de>,
	Willy Tarreau <w@1wt.eu>,
	Joanne Koong <joannelkoong@gmail.com>,
	Val Packett <val@packett.cool>,
	Andrei Vagin <avagin@gmail.com>,
	patches@lists.linux.dev
Subject: [PATCH v2 4/7] pipe: move wait_for_space to fs/pipe.c and rename it
Date: Thu, 25 Jun 2026 08:34:06 +0000
Message-ID: <20260625083409.3769242-5-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625083409.3769242-1-safinaskar@gmail.com>
References: <20260625083409.3769242-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is needed, because I plan to use it in fs/read_write.c.

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 fs/pipe.c                 | 17 +++++++++++++++++
 fs/splice.c               | 19 +------------------
 include/linux/pipe_fs_i.h |  2 ++
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 9841648c9..c0ccf21b9 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1451,6 +1451,23 @@ long pipe_fcntl(struct file *file, unsigned int cmd, unsigned int arg)
 	return ret;
 }
 
+int pipe_wait_for_space(struct pipe_inode_info *pipe, bool non_block)
+{
+	for (;;) {
+		if (unlikely(!pipe->readers)) {
+			send_sig(SIGPIPE, current, 0);
+			return -EPIPE;
+		}
+		if (!pipe_is_full(pipe))
+			return 0;
+		if (non_block)
+			return -EAGAIN;
+		if (signal_pending(current))
+			return -ERESTARTSYS;
+		pipe_wait_writable(pipe);
+	}
+}
+
 static const struct super_operations pipefs_ops = {
 	.destroy_inode = free_inode_nonrcu,
 	.statfs = simple_statfs,
diff --git a/fs/splice.c b/fs/splice.c
index 707db2c2c..d12243d19 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1239,23 +1239,6 @@ ssize_t splice_file_range(struct file *in, loff_t *ppos, struct file *out,
 }
 EXPORT_SYMBOL(splice_file_range);
 
-static int wait_for_space(struct pipe_inode_info *pipe, bool non_block)
-{
-	for (;;) {
-		if (unlikely(!pipe->readers)) {
-			send_sig(SIGPIPE, current, 0);
-			return -EPIPE;
-		}
-		if (!pipe_is_full(pipe))
-			return 0;
-		if (non_block)
-			return -EAGAIN;
-		if (signal_pending(current))
-			return -ERESTARTSYS;
-		pipe_wait_writable(pipe);
-	}
-}
-
 static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
 			       struct pipe_inode_info *opipe,
 			       size_t len, unsigned int flags);
@@ -1268,7 +1251,7 @@ ssize_t splice_file_to_pipe(struct file *in,
 	ssize_t ret;
 
 	pipe_lock(opipe);
-	ret = wait_for_space(opipe, flags & SPLICE_F_NONBLOCK);
+	ret = pipe_wait_for_space(opipe, flags & SPLICE_F_NONBLOCK);
 	if (!ret)
 		ret = do_splice_read(in, offset, opipe, len, flags);
 	pipe_unlock(opipe);
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index a1eeed800..be653625d 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -335,4 +335,6 @@ struct pipe_inode_info *get_pipe_info(struct file *file, bool for_splice);
 int create_pipe_files(struct file **, int);
 unsigned int round_pipe_size(unsigned int size);
 
+int pipe_wait_for_space(struct pipe_inode_info *pipe, bool non_block);
+
 #endif
-- 
2.47.3


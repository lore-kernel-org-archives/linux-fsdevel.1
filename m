Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50C337D11A
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 08:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782376516; cv=none; b=ex+WdjpM0REOytT2z+YclYe53Y0PjjwDkKNrPgFBWAbkt3R++nC6MjDauZecUlyu5J+ZbfOpeIroZPj12DoC7DEd0J1Rron4jD/XgawzstZymb9kR4UYmAy3iUhqp7pnHaYk7r6G+5vRijiE+csj9jwESGNr9w+YBzauQdLzLTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782376516; c=relaxed/simple;
	bh=QtIkhOcb4XuSPNMSHsQTam2xRok/IOw4SC1HUoDCl24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gljhm2Z+xYM+M56ZoQyoJcOmGqgc/eeDiepK14NKg3cnGOb2CFpOslG68xjHexOGRqqKBq+VXefzqt0+xC2kOtQb/whxpPLSu7eQcOTQ+KmFTSe6Qzr1+yKFskudBC6v++/iZ0OupFggwjViodK5Zi/aa33zmS7VvBnvF/vHc/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvVtfjAn; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvVtfjAn"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4629051c946so453366f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 01:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782376513; x=1782981313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2cQgCHbxQom2kVIv1Cvt6Y9CPEs8rn7euaXGTL0+j8=;
        b=IvVtfjAnKaBK/0oQMtnLDiuV4uWEGKXPXAe+AlxRHG6MnbRdOnwIUfAKJjX57utGZS
         RA93kED8fJa9O5rFjZ+0xpmGWVHSGJekcF4QjLRE+9tIfLia59YTnsl5uCFNeaniCHYM
         5ZzmM6WJ/eA/ZQgbCsLgjOKHc5QpvB8SEkaetLP6sDVxwCT9Xbf79YBfNv/qFqmFb1eR
         GqdtIomwz2L9o19YnNZzwc8yfe+1sOCd2S9kf+44M9mXX/WaaS9HEOsL1d9bD/AsSE7U
         LxGhViFq3CN1cDSLLxRgrgwei7VAOJ71DV4FvcjrUCQB/zwz2D3jyNKU/qsz7in7C5lc
         AwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782376513; x=1782981313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T2cQgCHbxQom2kVIv1Cvt6Y9CPEs8rn7euaXGTL0+j8=;
        b=pfPX7xwlaTUmobHjcYpENzfDAZgfz9XJEzUIy78/5Yafcq/NaG01aYLAUwS2355P97
         a71JuA3YRvYuhlYbYE2Rlvm4GSD0gGCgKbLoK6Ed/G3UezV+HIt64DZJxcKjWajR+ynU
         2lUGjMQN54JzBitGRCDGObg9YwT+CRdgAWZAD2pZLcR7xb3tDXzb/x7vtQVblvu5Ego6
         ngsRxKAxlGgd2fGJJjxjyshlRbdyl8zQSBDaKCD3JIo0FwMG0p/gwsgIP279Zr3ijD5T
         nGUFQ5vf2DC9dlSM0/XiF7+as0EwdESQSA1hnpHVLxMmpXHs27NxYxPW1b++A/gpWBCu
         b/DA==
X-Gm-Message-State: AOJu0YznuLQb5HUG8jXW37+LTMxpeg44TvTDZuzmy7DqOWXvalBE3ST7
	EW3e4VSfHabkRNr468LknEvilZdWK7T0ZcCoBFn6gllCvpRVi3kWigTtPoTdUP/K72c=
X-Gm-Gg: AfdE7cm65jU/jtlqoLBfZpEbMABVSHZ/lj+1Nmr4lcwJLQrzf/G1RfiuXhCTEdv7oc9
	QnSjvVnUydZyycc11hBzX5BEtvdHBlynyMEbmWFV3P7TlHfzV9UcNMHAjU3gOYCKaMnLSlUTvb2
	musWvBup9iaSI4Asvcr1/8qKqgaO+RyhNxswnoxeZrlKtrMVyVQA9XOh2IUz0mfWyd2EBbr2l9t
	vESASZjV46Ip+KPfhrnXABrhHDLXW477sAQDD4Ab2BYhasIozGAQOGr8om0zdjSmxz7quebWrOO
	BSr+EWaQgcpj+GthOy3K7ha/tm5Xb0aVEE/Jg3YC0KJiLV/IKpDFu5ZKEcmD8kFbmxisXCN6kfR
	sNS6D4BA9F68fToK0Vz5/igcyR8b15uLT7od5Vs4Qhz7hENwqVn8HN94X6X0RkmTSbPWqF4vZAd
	+BldjqHjfA
X-Received: by 2002:a05:6000:4603:b0:460:602f:85a6 with SMTP id ffacd0b85a97d-46da34965dbmr2376831f8f.0.1782376512951;
        Thu, 25 Jun 2026 01:35:12 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-46c9ed7491esm9926887f8f.37.2026.06.25.01.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 01:35:11 -0700 (PDT)
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
Subject: [PATCH v2 1/7] vmsplice: open-code do_writev and do_readv
Date: Thu, 25 Jun 2026 08:34:03 +0000
Message-ID: <20260625083409.3769242-2-safinaskar@gmail.com>
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

My previous vmsplice patch did the following mistake: I did
"CLASS(fd, f)(fd)", then did some checks on resulting "struct file",
then passed numeric (!) file descriptor to a function.

This is somewhat okay in this particular case, but I still think
this is code smell, so I fix this by open-coding do_writev and do_readv.

Also I insert a comment to warn other developers to keep
do_writev and do_readv in sync with vmsplice(2).

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 fs/read_write.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 1e5444f4d..e224e7cb8 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1070,6 +1070,7 @@ static ssize_t vfs_writev(struct file *file, const struct iovec __user *vec,
 static ssize_t do_readv(unsigned long fd, const struct iovec __user *vec,
 			unsigned long vlen, rwf_t flags)
 {
+	/* All future changes to this function should be kept in sync with vmsplice(2). */
 	CLASS(fd_pos, f)(fd);
 	ssize_t ret = -EBADF;
 
@@ -1093,6 +1094,7 @@ static ssize_t do_readv(unsigned long fd, const struct iovec __user *vec,
 static ssize_t do_writev(unsigned long fd, const struct iovec __user *vec,
 			 unsigned long vlen, rwf_t flags)
 {
+	/* All future changes to this function should be kept in sync with vmsplice(2). */
 	CLASS(fd_pos, f)(fd);
 	ssize_t ret = -EBADF;
 
@@ -1226,14 +1228,24 @@ SYSCALL_DEFINE4(vmsplice, unsigned long, fd, const struct iovec __user *, vec,
 	if (fd_empty(f))
 		return -EBADF;
 
-	/* We do do_writev/do_readv, so it is okay to pass "false" here */
+	/* We do vfs_writev/vfs_readv, so it is okay to pass "false" here */
 	if (!get_pipe_info(fd_file(f), /* for_splice = */ false))
 		return -EBADF;
 
-	if (fd_file(f)->f_mode & FMODE_WRITE)
-		return do_writev(fd, vec, vlen, (flags & SPLICE_F_NONBLOCK) ? RWF_NOWAIT : 0);
-	else
-		return do_readv(fd, vec, vlen, (flags & SPLICE_F_NONBLOCK) ? RWF_NOWAIT : 0);
+	if (fd_file(f)->f_mode & FMODE_WRITE) {
+		ssize_t ret = vfs_writev(fd_file(f), vec, vlen, NULL, (flags & SPLICE_F_NONBLOCK) ? RWF_NOWAIT : 0);
+		if (ret > 0)
+			add_wchar(current, ret);
+		inc_syscw(current);
+		return ret;
+	} else {
+		ssize_t ret = vfs_readv(fd_file(f), vec, vlen, NULL, (flags & SPLICE_F_NONBLOCK) ? RWF_NOWAIT : 0);
+
+		if (ret > 0)
+			add_rchar(current, ret);
+		inc_syscr(current);
+		return ret;
+	}
 }
 
 /*
-- 
2.47.3


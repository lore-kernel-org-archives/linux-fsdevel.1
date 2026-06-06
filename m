Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03116301472
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 06:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780726288; cv=none; b=H1I7xydIoN8l2yz7qAJxH1YuZA4SXdS7CmUZnmjccvUxVCwVSp8Ls/no7M5MlJIcQO+bESjjkaxSx8coeP9riV6mhStgVy2JNNzNJR/EFNKAe4dEPp4c2DrP2NPgoihCSRR3D1QAqyltWfuOjd1is5DSMmLis8C1Sxs5NfSew2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780726288; c=relaxed/simple;
	bh=QtIkhOcb4XuSPNMSHsQTam2xRok/IOw4SC1HUoDCl24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzL/nc6l2i6uKh89bkcnFSXoXsUPJ3Obw69MqV0VsLiLeA8Zw2vAxSYO+p0Vk6bytthUvD/3AOExI/KFfZdh3zmY3cvaCBWUj19LWqq/PfQvKrC2neUV5YYSN66DULm30XUZVUPWzo5Ew0H0fwzJU11kBeW4JN6BiK0HlgH8B34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLy12Jix; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLy12Jix"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490c1915793so12793155e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 23:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780726285; x=1781331085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2cQgCHbxQom2kVIv1Cvt6Y9CPEs8rn7euaXGTL0+j8=;
        b=KLy12Jixz2tIbG+Bqx2kFQDR1LkeBX0JuY4LIwcqjeHo/va6TrWxNBoa91zM34FCyk
         mObgIC48xiVoCBi1ZPIGlgQOHQyn9emWUrVDOWqYaBFvhEZXDTOeeUhpLL6+rJIwshLr
         aKffAjaazH/1LOg2AqAoqWohc3YFEKEv/DxJevSlqg9zFJ078PjbTzLwj+enA8sbMdV9
         jpud3TmpWZmn+ufBFbxMUfcGTKX1l+POePF59aR2eaSzdSYgy7WHLLc+/yaRg8ft43ID
         nKTwCh5PVm9JUyDWNm8XB6Ha2WzeIkTh3i356Tr5YC4NvrM4K/q+hVxk9XvOEFi6IqtH
         L2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780726285; x=1781331085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T2cQgCHbxQom2kVIv1Cvt6Y9CPEs8rn7euaXGTL0+j8=;
        b=gGcd9DWG5ApjjD8ZPqlIKhTMocIJWjSaMpDlBuORoR8ok2Dl53o0+M+NaIUCq188RR
         EL/hqrtZWzXzZH/ZKEzQ97gafq3nBRhew9boCGPjan0QMEDwC7hQsDcLgRk2Xv89JISr
         sCmCSYDLVZ+p6NXZ9s0rQa3awx3FPPkmn50WtrbQAiGToyxsggtY/6zrb9J9h7qfMhY/
         XKzIipkvGB8RE8DWCJMkxXNKFWh4xd5b80lW+NPBc0qEw9VEf76NaQDd/z2hgmhgjcqx
         8u8/sG+umtpBY7V5Wrta0git95nSDnNE8DEEqNTq8pniO9r8NFfWZeVPn7xWbdzNVxrx
         lGWw==
X-Gm-Message-State: AOJu0YxGoQpXxAfSRhZaJjE4h6BwBYnX2S+nU1SclKecFw0kux4F5Qi4
	EZ09VWziADiZao/LyJBWAfQ5Gq8hsQGHcZ53T2eALsfsMSZm6k3+ZkO9xXyzQQ==
X-Gm-Gg: Acq92OEGDmFF0JlgngeSlk2i3tbU2REn1Wk3KidfXcjv2D/o+xd+PfD2hTvRIkkd4Wi
	Q/rNzNyrWdOOxYyQ9cTdBzq2IQ0ry2oU3HdG5ipLAo0bsuMYumzgjZaqdHkGYVZ3+W3oYgS0Sbr
	axY1PEj88mIM8bIBKfSZ1rPpJbfWCg0JPD/YTXOX/HWTUCHklcdcvJ44k4mUAa5HMAQ79tmXOuc
	khpfA/to+b5MHBC8IX1vEejygy8IkXxL5wcver8iB2dvj6BTnSTBrZF8hwmqrWI8aiEEBQ/W6qx
	9x1LP0MfVmHnkXQ0TDHBy4fufU5MG4TbJ3sKt+ivwcOpKkq6gBIWDn1ot6xbR12tpxy5dzR2bO0
	FewWfOtF+ZpyzOL2SF+vedfUogR50yWPW2k+tEz27uSAmrJ3A2+3bW0Ylt0nSVEZ2a/HBOuoIZ+
	LejrLooHnxlg4WQdrzA9EdLPKK5fmuKibXDu0b7BzV
X-Received: by 2002:a05:600c:a117:b0:490:c2a3:3302 with SMTP id 5b1f17b1804b1-490c2a3336dmr71973635e9.35.1780726285175;
        Fri, 05 Jun 2026 23:11:25 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490bc39e024sm273433555e9.4.2026.06.05.23.11.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 23:11:24 -0700 (PDT)
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
	ltp@lists.linux.it,
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
	Steven Rostedt <rostedt@goodmis.org>,
	The 8472 <kernel@infinite-source.de>,
	Willy Tarreau <w@1wt.eu>,
	Joanne Koong <joannelkoong@gmail.com>,
	patches@lists.linux.dev
Subject: [PATCH 1/5] vmsplice: open-code do_writev and do_readv
Date: Sat,  6 Jun 2026 06:10:27 +0000
Message-ID: <20260606061031.3744880-2-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260606061031.3744880-1-safinaskar@gmail.com>
References: <20260606061031.3744880-1-safinaskar@gmail.com>
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


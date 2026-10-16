Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9944FDA69
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 17:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792171046; cv=none; b=BdPLC29fIx4xnduHqeMq260fnBFvIngt2MzYztrtu2rmRYXSyzg3B3rDwD3XMHYGnvvTFwTbSk9LpKSEERasGFSYAV9Xme/esexQzgaMGdFhM4QKgi9C3GxRNuEXnI3U7ykLWELRh/Ezcjn4gtrfYMdm29Uh2zEOvrUkxUcJLcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792171046; c=relaxed/simple;
	bh=PDeQKDGVqwZ4U/KLEclMbrbOGz/7Qym/qxwL0GKnZu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JVhsjctfglJzW/M/C5+A+/LG8znYabwQVR2bwoJzE06a6pdoZc59JDMF9Nm9FlAQeMY9xxYaWCHmPgjXPyDUTfSE+YKSwFPtjuzPvfj4HP2rNbFINasHRb4d+pL5VtQRGbMHCQ+LXhdgax0ywnm0L0EgPz2j835QO+lpL4udOHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6br5TzY; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6br5TzY"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso121407a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 10:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792171044; x=1792775844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5Gmw5gaxDOzBmPpJ0CCQs51QbryjVy3dY9vuKu88q2A=;
        b=G6br5TzYBZLXXOl1zZZw05WwsGCi/UvNYa2h1RWUOvUVC/QjbO1HvZvBF3Hw4FlN6d
         NZ3vZh421tJa/5//thzU6qeQtT5xOP2sAmOptJ9W3U41mo9ThzcKVtohbpF6CVJ2UY+p
         t9VeDRHPQE/KrppKwFpo/1hc03o0RK3RLp8OGiNJ8fMcydD1zFAZoV0KNBJc086NT6yr
         bf9DyNpMHvLdmM+XzsV+C+5OzFySPrgN1awEeEQ6mvFMjXMbg1KvoY6+LBDP+eXV0QXv
         tK9pDfdFyw9BD4QBOhsLRoXgfhFEogHtCgB2WJSeCzSHvXBZ/FceLocqmrgxScX2DGhj
         /BVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792171044; x=1792775844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Gmw5gaxDOzBmPpJ0CCQs51QbryjVy3dY9vuKu88q2A=;
        b=zEeAJEOFMWPYnZKQz0RUhR+aM+f2LE2RGQVYvfmow+3028y4VowKsJHDdjUYL3yQZJ
         tGZprFaTkL+Kvfy602zDkXQm5JI5O2bfGo72sBrXnuz4qJK0ycpLOeoyyFuvZ5X26/ph
         CPhACO4exABiaIvslDSl83KiCBM72HliVHRDjOZLgyCd43vtC5/k6N4qQuWfim5VXZK8
         dBzFLjZQOB67txLXOqmddPQJCEr/IUdFScjdzNWj0EmbrduiWwinZrNJ0be3/osSoNdZ
         Se/zrPXDXI1LlGIHmXpDEvBvUdiHhPEV/gg0MoLW/cIkv7RhUd08Xb6VdYthbegrmCx7
         a7Ug==
X-Forwarded-Encrypted: i=1; AKwUvBwtUbMRdnxzQBffLCkBiDSCfmwqOEjQCn/nkVjLLUXFJsdczB3FGNoQ1PeOMgR5Z/HvAEdldbxNnbZQNRTu@vger.kernel.org
X-Gm-Message-State: AFq9FYIo6rQF4w6PDJ3JoVMvGfVzGdUl8YtPNQXBVzx1lmFq67Aj/6Ov
	+nEhnCGNmdo4kjzzcPdpcq1ZRYtHshZCGdPixYyfQ/0NByjOo4M6n7pkuN4Pjp+w
X-Gm-Gg: AYBFou3hnQGhOCS5iKl6CsPfBWQm9Gw1xZBf4/zI+j6U2UL0UAfkL3CXKG9o4nghXPI
	kSCot8agGN6Y6mYNUVuWjQaxG8UOasoOVSJ9YeP2+zDzO2Bk4b4WwB9W5OmIU7pRxpbYqIqY0Cw
	xkQOzkVV7Va6V6Z/ZXSAlf9bLirQyY8umO3E4oVP/5uRlugWQe8f1+XwN8dRw3b+pERvTmjncCE
	O9Y72BjX8Qz7D4+9fVUzX33KH0jH2cXAR1JPPC1JH3sbwWtmoDcJVY9vFBhaYzZcSDfzEiSB4Bc
	Rz1aUc4ZIZMTW3mu4/xp3K3NlNItA466ZkV7lc4M+IjpgdB4n0qfJyCLrlMGp0ajCpEK/EjVlTn
	NIWEln9tUAbdPml6jJfSPn2lkt2522xOM2K93spVZu9ZcQJlfoJWgPLRy0aCjbNgOnU9VUfM99k
	avz2tI8hTkUp9hpJdaO6K4OFeXbsgEFfdjPObJgDAbb2bMvRkQm5aEzf8EbWsL+a3swI58R9Lk
X-Received: by 2002:a17:902:ea12:b0:2e5:78b1:33fc with SMTP id d9443c01a7336-2e9a705023emr5958185ad.53.1792171044290;
        Fri, 16 Oct 2026 10:17:24 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac5:d45a:16dc::247:b8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e5d51b5sm13396075ad.8.2026.10.16.10.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 10:17:23 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	willy@infradead.org,
	hughd@google.com,
	baolin.wang@linux.alibaba.com,
	akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	syzbot+399510418a0b0cf1fc29@syzkaller.appspotmail.com
Subject: [PATCH] fs: annotate lockless file position updates in sendfile
Date: Sat, 17 Oct 2026 00:17:18 +0700
Message-ID: <20261016171718.243099-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sendfile(2) does not take f_pos_lock, so with a NULL offset it reads
and writes file->f_pos of both files locklessly. Two tasks sharing a
file, or one running lseek(2), race on it. The splice read paths
likewise update in->f_ra.prev_pos, a readahead hint, without
serialization. KCSAN reports all of these:

  BUG: KCSAN: data-race in do_sendfile / do_sendfile
  BUG: KCSAN: data-race in do_sendfile / generic_file_llseek_size
  BUG: KCSAN: data-race in shmem_file_splice_read / shmem_file_splice_read

The races are benign. The worst outcome of concurrent sendfile() on a
shared file position is an unpredictable offset, which is already the
case for any caller that shares an fd without synchronizing. prev_pos
only steers readahead.

Mark the accesses with data_race(). Locking f_pos in sendfile would
change behavior for no gain.

Reported-by: syzbot+399510418a0b0cf1fc29@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=399510418a0b0cf1fc29
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
Reproduced in QEMU with the syzbot C repro on a KCSAN build of
cfec639c844f: 42 and 43 reports over two boots, covering all three
pairs above. With this patch there are none for those pairs over four
boots. The remaining reports are lseek/lseek between the repro's own
threads (a different pair) and an unrelated ps2 race.

I used data_race() rather than taking f_pos_lock, which would change
sendfile behavior. Happy to respin if you prefer locking.

No Fixes tag: the race predates the history I can bisect.
 fs/read_write.c | 11 +++++++----
 mm/filemap.c    |  3 ++-
 mm/shmem.c      |  3 ++-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index e8c14e2760b2..ca2916472e7d 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1319,7 +1319,8 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 	if (!(fd_file(in)->f_mode & FMODE_READ))
 		return -EBADF;
 	if (!ppos) {
-		pos = fd_file(in)->f_pos;
+		/* f_pos is not locked here; racing updates are benign */
+		pos = data_race(fd_file(in)->f_pos);
 	} else {
 		pos = *ppos;
 		if (!(fd_file(in)->f_mode & FMODE_PREAD))
@@ -1341,7 +1342,8 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 		return -EBADF;
 	in_inode = file_inode(fd_file(in));
 	out_inode = file_inode(fd_file(out));
-	out_pos = fd_file(out)->f_pos;
+	/* see above */
+	out_pos = data_race(fd_file(out)->f_pos);
 
 	if (!max)
 		max = min(in_inode->i_sb->s_maxbytes, out_inode->i_sb->s_maxbytes);
@@ -1382,11 +1384,12 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 		add_wchar(current, retval);
 		fsnotify_access(fd_file(in));
 		fsnotify_modify(fd_file(out));
-		fd_file(out)->f_pos = out_pos;
+		/* see above */
+		data_race(fd_file(out)->f_pos = out_pos);
 		if (ppos)
 			*ppos = pos;
 		else
-			fd_file(in)->f_pos = pos;
+			data_race(fd_file(in)->f_pos = pos); /* see above */
 	}
 
 	inc_syscr(current);
diff --git a/mm/filemap.c b/mm/filemap.c
index 00fd89cf6f55..d5a4a5ead4e2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3146,7 +3146,8 @@ ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
 			len -= n;
 			total_spliced += n;
 			*ppos += n;
-			in->f_ra.prev_pos = *ppos;
+			/* readahead hint, racy updates are benign */
+			data_race(in->f_ra.prev_pos = *ppos);
 			if (pipe_is_full(pipe))
 				goto out;
 		}
diff --git a/mm/shmem.c b/mm/shmem.c
index 897fa2b61346..56fa2bc520ed 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3586,7 +3586,8 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
 		len -= n;
 		total_spliced += n;
 		*ppos += n;
-		in->f_ra.prev_pos = *ppos;
+		/* readahead hint, racy updates are benign */
+		data_race(in->f_ra.prev_pos = *ppos);
 		if (pipe_is_full(pipe))
 			break;
 
-- 
2.43.0


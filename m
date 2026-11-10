Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320714;
	b=HBOOStaY3VNoUkRp0MrhNww5rJvOlkrA3XI6BPQ3golSptkUzViSqlnevr9O+J3ZY4J1
	 HGJqy5o6d41b5CvyJg1GetuNY3MQriC3+jm9QVZEQLPQ0RzfH94baLsgAXo/acTumsbhA
	 OAosmxFfoHQXFaYAYg/Rgf+IkfCo72uvMrvBoyAH1eMDH/G+Cz2M3mFKL5s4c+XYMHRnM
	 XksEtBTu3X4YbEH+f6QjSXnCxKl2Gl1iZtUSIFKyy3I1Fsei/5IJIQnVT1xb9AHN/ZJUg
	 MOgVHuSAYqmzf3CPqzIdWsXGRpyQxjV2DN0Ux8YB0jrVykY4DjNs1b7kjmeOuaRhHrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320714;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=inwjjj3ubMG5WJ+XtAtEKVOvNIrYIBG+8zpVgeYTF4U=;
	b=FCT9xEcGmuXtqm67DK0CzjN2Soz8YENI0MO7BAAXXPHYHMbPoFD417nameoxd3y7aafP
	 cZQW3ES7tlbt8ktu+kwsK15EwrpBE4H+85XmNpmqd+qLI96ucjtuBd9TSovDnqx/jvE8n
	 0M0aKQVBSuc5xt00HxCNCaqiaKcck+PBcKp6MhcI4zbXuMb+Freo7wULjaMvfcqi/1lxt
	 QaVrPDdWOpJAQg1+AhcWulPjt2pb4lk/r9nmfDQwzp7ek8lBf0Zaemr/M+S6E3T4iRw0D
	 rckkzpqQwk3BoXF922Cz7blCNvJhoKMUBweZiVBOzJ6vxQUdHz85jvLJ/o3ditKZrqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b="bdXQVm/1";
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10E960727E2
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 14:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A10E960727E2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=bdXQVm/1
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-53512cd2f85so22003431cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2026 06:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1794320713; x=1794925513; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=inwjjj3ubMG5WJ+XtAtEKVOvNIrYIBG+8zpVgeYTF4U=;
        b=bdXQVm/1r6LGPidnUqsMUnLvzkg0TZvss5wFLBMtnHHus2yskdSUmmCgrPZxIqEXUi
         l7cMiFIxgZ5SZPhi4q8SeUmX88oUnt2ucjiPQbjoG0SpaVZIfmwdwuYsdFjPkIogtTVU
         40/F+EF2ULPkXhDKZDeXJBeE3kDIlcd7+d/SVd+Wv5en/U+agfFOe6DWYFe2V3plVRCm
         +kkXnE7ma4xhdZqPzVXCBdrK6MAv298WyXw0vwfFaHmOkiApOlJ4+8rBCMizTOMR0ZIH
         kakMGYUknM/Pn1pYYJL68gOoDQmI1EMW00hp4xCNVvr4fmtUKIAP4M799zJxy2ppixaN
         TKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794320713; x=1794925513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=inwjjj3ubMG5WJ+XtAtEKVOvNIrYIBG+8zpVgeYTF4U=;
        b=WFo+y/p+WCNtj7gkUJAlufxPNxrMVJRxV/trPm00rvtnK5OFDorRgt964TcRmPrUOz
         Jy1ggs7AXVbCBWY98Ph1B5KTFGpH1rff/wV0wPMMuXpZ1bWZ+NNmHVNC9bR0lx66ZQ3o
         HyS0GB7R5GE2a9kuBj/zhs7P32PyT2V72UkZavKwTqTFkgE+tGM5acjG89U2Jdhb8342
         gkcDGia/vyMVEozqXoZebZQU257yi3mZhSwvBKS9OqDskAf81vosi/fDcrqe/9ufARmt
         6vN+Mi3JdoDnwuJ+SpWTM42Z58tAo/Xxo3NOuoLxZWPPzOPrxfKS6TY4BP5n4b10V2+f
         c9aw==
X-Forwarded-Encrypted: i=1; AL+hErHQnUb1OuBhX9EYmGsXetEkYaeJbhc7kbEkh7ftTloDx+oDOvBE2sM8Gow10a0xADt+yoF8vyE2st5IEjGx@vger.kernel.org
X-Gm-Message-State: APuU4Z8r5PkBR2Na4ZowbYGocxalfzSHTWG89t21HAdTLfX8CIU02s+x
	kgdYKVNwtKSEY5huZkyprFylahQLdz/+ts+m+PLx2f/jNGpIHc9li2oi6u6ujSEFfKc=
X-Gm-Gg: AYBFou3lbW49/b7opanKpkYVA8Eh+tVNIvW0j6aKgHRZM8fPRduWVnGIssKH7VXta72
	xRLZ770fZMiy2nM5z8Uqpjy5akwA+upYJfroDQGhFHa4PBA0wmt5Ooo0hQ3uFbVvuLTbA6fzFZJ
	3yhePOFl0qa1qJNHX/7/7sjLWjhHvSjJPtONAkGgq+t+eAzyZxF06G1tXyEIpQDT9qgXyDV49nd
	ACqPNfbmUYnSajVJF4/DVmqo15iZCcrAGUbhx24GZplWQXKAaGpVNZQhSw/wkTA4TjKiKmYLrvr
	WjKBq1O1YnVhcVr7ut4A7eVeIzcvRXwDHmDkZ91OftgzM8kTpnbUAs0Pur6hsv1Lh/W6cCtqIpY
	E+FhA8NHt2/tOBdqEX/9Wlc1M/1YlmODd1yWetV9kUDWGc56oPYpMy3NBFrIB+38w4ZFQr8Ie3l
	CCrL4CdkatBAqTOMStd5hTgc38NufyuVDk70FRbNs7kL5bbFGOH+u9KQR8J/vHlVGHpjubaf2HX
	padDcuZ7HnfXfl0ywaPsLWu18cjMYLBr1BgiBEs7tPGMpLlcB7zKB0TcgLtW24C1I8YD3Y6dihf
	3+lLFFB5GLgVB0y3xZ79rhjdp1w/Em3KwIP0xKObf9wvag==
X-Received: by 2002:a05:620a:319e:b0:93f:633b:ee1f with SMTP id af79cd13be357-9479f2b50c8mr464025185a.28.1794320712437;
        Tue, 10 Nov 2026 06:25:12 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e73a8fasm232894785a.7.2026.11.10.06.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:25:11 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 10 Nov 2026 14:24:56 +0000
Subject: [PATCH v6 8/9] ovl: report failed upper writeback in syncfs()
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-b4-ovl-containerized-sync-v6-8-43d1be16a4d6@toxicpanda.com>
References: <20261110-b4-ovl-containerized-sync-v6-0-43d1be16a4d6@toxicpanda.com>
In-Reply-To: <20261110-b4-ovl-containerized-sync-v6-0-43d1be16a4d6@toxicpanda.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>, 
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1794320698; l=2851;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=I6Rii/Ix6PL0KI389Zplr9G5UjzXx6xnHabJY549AWo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKFeT3tU6qZCjIbQWxxAIqAF9LlAoQ/+NDW8wxYmNIajIuI+qGNUY5QkWBu95totv9VAUARwy06
 dPDgzo8WK0ws=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

If somebody else writes the pages of an upper inode, like the flusher of
the upper filesystem, and that fails, syncfs() on the overlay returns 0,
unless the mount is volatile or has fsync=off.  mapping_set_error() records
the error in the mapping and in s_wb_err of the upper filesystem, and
syncfs() looks at s_wb_err of the overlay.  That is not new.

With fsync=relaxed the error also comes back at the wrong time.  AS_EIO
stays set in the upper mapping, and the next syncfs() that has to wait for
the file finds it in filemap_write_and_wait(), after a write that may have
succeeded.

An overlay inode stays dirty while its upper inode has pages that are dirty
or under writeback, so overlayfs still tracks the inode when the writeback
fails.  Check AS_EIO and AS_ENOSPC of the upper mapping before the overlay
inode becomes clean and record the error in s_wb_err of the overlay.

A cursor for wb_err of the mapping would not do.  Checking it marks the
error as seen, and an fsync() after a reopen would not get it any more.

This is best effort:

 - Whoever checks the flags first gets the error, for example an fsync(),
   a truncate or direct I/O.
 - The flags belong to the upper inode.  An error from before the overlay
   inode was dirtied is reported as well.
 - The flags are not ordered against the page cache tags.
 - btrfs records the error after it has ended writeback.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/overlayfs/super.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index f38c6dd2ae47..a0fb85405f68 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -368,7 +368,7 @@ static enum ovl_write_mode ovl_write_mode(struct inode *inode,
 static int ovl_write_inode(struct inode *inode, struct writeback_control *wbc)
 {
 	struct inode *upper = ovl_inode_upper(inode);
-	int ret = 0;
+	int ret = 0, err;
 
 	if (!upper)
 		return 0;
@@ -386,8 +386,22 @@ static int ovl_write_inode(struct inode *inode, struct writeback_control *wbc)
 	else
 		ovl_flush_lazytime(inode->i_sb, upper);
 
-	if (ovl_upper_unfinished(upper))
+	if (ovl_upper_unfinished(upper)) {
 		ovl_mark_inode_dirty(inode);
+		return ret;
+	}
+
+	/*
+	 * The overlay inode becomes clean, and syncfs() will not look at
+	 * @upper.  If somebody else has written its pages and that has failed,
+	 * find out now.  filemap_write_and_wait() clears the same flags, so the
+	 * error is reported once.  fsync() goes by wb_err of the mapping, which
+	 * is left alone.  An error that the write above has returned is already
+	 * recorded.
+	 */
+	err = filemap_check_errors(upper->i_mapping);
+	if (err && !ret)
+		errseq_set(&inode->i_sb->s_wb_err, err);
 
 	return ret;
 }

-- 
2.55.0


Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2701A42E401
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 05:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790056139; cv=none; b=MN2KmwcjDfA2w3ZPSKMVq8rcNpl5WwzhbfbXOM4KUDyT9P1GafbKfoFUhsHChJkzfwbxwkNJxtOtePDhhbtQYYbbMFXZY7lIO6Kb2p+5w4Lg6pSoG4NAGHYNcgE1SEyrEhBP4z7aCbZvQkrKcMpPXYloVLFTGciKJgI1thFbris=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790056139; c=relaxed/simple;
	bh=GnebkRYN2Yq3glKz9FYmVBvCKtzjN4BYOu13gMAeubI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HFBCsGKeMRZpY55Wd6hLDDYXRHaqkb+FbW07Fl+heGpxNwYpgbU0Ed7PAipbV14PtlB0iwucYDLYZW3rLaC0lG/U9TNFpIuZNnk8eTCxXab+gz4N6Qr/9anyquiZkb5uzuPxjOCoOx7HK0uibi2zqOzQ7GIqWwJfLHqCkcFWlZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnP6EGQ2; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnP6EGQ2"
Received: by mail-pz2-f41.google.com with SMTP id 41be03b00d2f7-cc4c3304833so2646839a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 22:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790056137; x=1790660937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3yMlMFl92yRdWmVLrvdNriN9ZvlaK00DMIcQJuB/tCU=;
        b=WnP6EGQ2NIwrVZCC6nIVuP8tAxmopRWIdbfGWtL9dBuUQL5vanNhZvdWroRNliUqwO
         r3WGXY3p87BlUKqOKQCSHz/YgG+/ytdjies9gy5LDcxACxDMvbMJEOQWJaT57Ko25M5Y
         GgZ40KJZA7A248lUuJTknnM1OXhORoTLzy7wib3hbXNPjzJ/OXp+259f4U6rOoPM9QzS
         jLx21sASuoZIlCr8Hc8PZZv5Hd9bm5CSNdbbs0b2cQzA2GN/a9po7p+8Xf07MlI6sN3N
         f4nXySKnjCQaE2zqFMx1K07Rg4MxbSpblh0NVijcu/JXuLoX7ij9uCDhJnOjEwiB6wqq
         pptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790056137; x=1790660937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3yMlMFl92yRdWmVLrvdNriN9ZvlaK00DMIcQJuB/tCU=;
        b=O06yavX1Ihrg35D7rjtbyzKrpoNpLkkgp713oEBLiFA/MGNwAAohR9o0hy1l2/sSdB
         hOuPH3TmfW6X32RA2+UtVB7MXV/k6Wy0Cc1JTQAWpBWABumo6bG2zya2ATXq2InHL4sP
         1Y/AT7smW1ZZorBc2DzPxglJBH/CtF7gE/B/W8gBoSJ8YJSdeSFcEXAoDsrRx1wbQBXq
         FwJKppaekwcHhoy61Aq0lt15p/0844P286AXMEKSgs60a9B5Rw/tmQUdn623olfdrVgf
         T/QConbj5D358L9N23aT5LT4Gu02+FuhGbcdqhDmMAE93V2nz0wGEL+oZCktxkSI4rsf
         Pklg==
X-Forwarded-Encrypted: i=1; AKwUvBzpf4L9I7vqPsWnSDhJlGHLJEX2V17BgsHk6eI2aJNzCfdD8TFLNkTKyhtasBrjon2JYa5S+1GQypZJj5as@vger.kernel.org
X-Gm-Message-State: AFuF++m+ceCZpmUeqNvYcvc8P4TQmSBxFpcRzRUsPb3HC9OOy9jUTLTS
	zyt5AWKSInYQm5JpIEWKLsxsoff38XI9FA0dX46QE0BZyzsYJ3QGQ3tfPDZmaw4W
X-Gm-Gg: AYBFou1U0+kHyIj3xUmDoipU11iLiqfMbfobhDjBnwIzFr/rlu5ABUYQSeUtOY0Bpyk
	QS/VqpsXLpSVshEGuFOJ2488kInXge9LTA/fT9mA0ik1qQTKMmDb28h3i7qOQgmpCmhQjeTkNtu
	O6DaT7EbMNbEqTjzaEtN19doMBIdkEGYZWUcj9IJbREbCWSMtEkZhEj99WLB2jySITMJBAuZymi
	X5m2W1BewtVMsthOWZ1jZL58jyPeOS3ZBps7fHxDXBtYtFECGrvOBnwV0MiR1FExSMwsISPTw6f
	usSG1TXkgHjdEqjgughbt6wiFTnijonJDjPPRUoP3WXoIz4cYr8CYO6WpQaa8a/8gnea6+FrQdi
	BompSbmLrrIgsUglC6gNQ9wS563ykUaL/i2V8MJOHQzcgspmGhUyuZKjMekmLDCKad61hazmVyc
	GUuFnHax9VJ52HhjnWSzomyfV6pVyenmykx9P+doF/8pELfxAxgFE5H+7Zjs6ij21mU9b+tGqTw
	8uXD7zls1owlLVS03u64K8LHTkzn9WdyglU7lRj3Eb8rtCl3B7bHXfjkxZ0MM5OnwRTaBwWdpZv
	4kYI99gZve8B5Gaa6o1bYZMFCtqirJhbDChGeTqvQwSFA+G77GUhp4us+UP0zPZ1V/ocnB2+rQ=
	=
X-Received: by 2002:a17:90b:1fc3:b0:39e:6a81:5a96 with SMTP id 98e67ed59e1d1-3a073295901mr55758a91.42.1790056136975;
        Mon, 21 Sep 2026 22:48:56 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06e5a5eb4sm1372783a91.14.2026.09.21.22.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 22:48:56 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	Yichong Chen <chenyichong@uniontech.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] isofs: advance to the next block when a record ends at the block end
Date: Tue, 22 Sep 2026 13:48:53 +0800
Message-ID: <20260922054853.469681-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit b2eb2e288604 ("isofs: Drop support of directory entries
straddling blocks") some ISO 9660 images list incomplete directories:
find returns fewer entries than before, and some of the names readdir
does return cannot be looked up.  The log fills with

  iso9660: Corrupted directory entry in block 0 of inode 55232

and on some images the walk reads a byte past the end of a buffer:

  BUG: KASAN: use-after-free in isofs_readdir+0x93b/0xc40

Affected are images with a directory record ending exactly at the end of
a logical block, which ECMA-119 allows and current tools produce.  On
the Debian 13.7.0 amd64 DVD-1, which has three, find returns 9163
entries instead of 9461:

  https://cdimage.debian.org/debian-cd/13.7.0/amd64/iso-dvd/debian-13.7.0-amd64-DVD-1.iso

The KASAN report is from a shareware CD with one in its root directory:

  https://archive.org/download/simtel-1-0295/SIMTEL1_0295.ISO

A local one, which lists 46 of its 65 files:

  mkdir tree
  for i in $(seq -f '%04g' 1 65); do echo hi > tree/FILE$i.TXT; done
  xorrisofs -iso-level 1 -o boundary.iso tree/

genisoimage pads the tail of a block instead of filling it exactly, so
its images have no such records.

That commit removed the reassembly of records crossing a block boundary.
Its condition was "offset >= bufsize", so it also handled a record
ending exactly at the end (offset == bufsize): drop the buffer,
increment the block, reset the offset.  Nothing does that now, so
do_isofs_readdir() and isofs_find_entry() read the next record's length
byte from bh->b_data + bufsize, one past the buffer.  Depending on that
byte the walk either treats the rest of the block as padding and skips
the next block of entries, or fails the record as corrupt and stops.

Straddling records stay rejected: isofs_dir_record_valid() fails them
because their length exceeds the remaining space, which is what that
commit relied on.  One ending exactly at the end fits in its block and
is accepted, so it is the advance, not the reassembly, that has to come
back.

Do it at the top of the loop: do_isofs_readdir() reaches the next
iteration from the multi-extent branch, "." and "..", the
hidden/associated skip (showassoc is off by default, so no mount option
is needed) and the fall-through, and all of them need covering.  The
record was validated to end within the block, so offset never exceeds
bufsize.

Fixes: b2eb2e288604 ("isofs: Drop support of directory entries straddling blocks")
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
Not tagged for stable: b2eb2e288604 is in 7.3-rc1..rc3 and has not
appeared in a released kernel.

Validated under qemu with KASAN and UBSAN against the images above,
using a kernel built from the commit before b2eb2e288604 as the
reference for correct behaviour.

do_isofs_readdir(), isofs_find_entry() and isofs_read_level3_size() all
open-code this same block-end transition.  Happy to follow up with a
helper that shares it, kept out of here to keep the regression fix
minimal.

 fs/isofs/dir.c   | 12 ++++++++++++
 fs/isofs/namei.c | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
index c7ca7603e97a..00a609c901dd 100644
--- a/fs/isofs/dir.c
+++ b/fs/isofs/dir.c
@@ -104,6 +104,18 @@ static int do_isofs_readdir(struct inode *inode, struct file *file,
 	while (ctx->pos < inode->i_size) {
 		int de_len;
 
+		/*
+		 * The previous record was validated to end within its
+		 * block; if it ended exactly at the end, the next record
+		 * starts at the beginning of the next block.
+		 */
+		if (offset == bufsize) {
+			brelse(bh);
+			bh = NULL;
+			block++;
+			offset = 0;
+		}
+
 		if (!bh) {
 			bh = isofs_bread(inode, block);
 			if (!bh)
diff --git a/fs/isofs/namei.c b/fs/isofs/namei.c
index 010682f5901a..5f5ed36d12e3 100644
--- a/fs/isofs/namei.c
+++ b/fs/isofs/namei.c
@@ -68,6 +68,18 @@ isofs_find_entry(struct inode *dir, struct dentry *dentry,
 		int de_len, match, i, dlen;
 		char *dpnt;
 
+		/*
+		 * The previous record was validated to end within its
+		 * block; if it ended exactly at the end, the next record
+		 * starts at the beginning of the next block.
+		 */
+		if (offset == bufsize) {
+			brelse(bh);
+			bh = NULL;
+			block++;
+			offset = 0;
+		}
+
 		if (!bh) {
 			bh = isofs_bread(dir, block);
 			if (!bh)
-- 
2.55.0


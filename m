Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795131681;
	b=pR9Q1wnJH+iBt1orzSoJYA6tf37vIOEMu4IPDUXVodRpAu/v8ErJ6Um2Vij4ozf0oOAc
	 Q7rQdELbogJQrmHXts7lCHryW/iAqsFpNMQEMhOdYi+QeQRXzXB6AvXWYoL+AN///Y/Y3
	 BW1BzvYlVuxAuFL+6hf8mqrPDqL4AKbGwdRm9W2Mc1vGdoEs/euuO2AnzWPJKYR6Xf5an
	 dCAis8k+cd1gR8Ms0GdB+d3nkrEV6DsESeRN659LnbfLSmI5JUWHz9Fwlv66h6DTmBKgt
	 bhfBDJuDHNTh20Sqj3rkFtZ8MYYpJ4OJSn7d8vv7DkYi78p32EjCdzSJmI0p0MjM4qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795131681;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dGAIBXcxAo4ug92wkzcGwRrGYDjRYNfW8cF+/h8C8jE=;
	b=eGnQA67FCcASqxvPti2ksHQOMwUvNtJkN1lVb0yN39Qf9ztalzK8NQSPq8IJPxf0XtuM
	 QfuWaYU1QHLc/aiZsOmNU+t8UJ2RJMIAj8VCMto1msP52OSw2QdYo+6PFIvWWUp/4ip8s
	 zX/G8ah/V/5GE3+Z9ew9FAjGqvTVHUCGLlQCBLcq9nrTYr1xjGa+8rl1Q7QCXT18umrIW
	 CNXt+PQR4NXiXbqpw0B8mFkeDc7ayXiJYsY/Aa3zXEWKjJytA6JUb183o1cU27Rk/qRBe
	 oj+Vm5NebfcIxXPDTdRvA/n0hw2VIse2vx0jeslNTg5CVYkgE+Fton4GPx+m+ZylCRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fApaNGWO;
	arc=none smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EED60A2621
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 23:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0EED60A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fApaNGWO
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-67dc7eb1442so520493d50.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 15:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1795131680; x=1795736480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dGAIBXcxAo4ug92wkzcGwRrGYDjRYNfW8cF+/h8C8jE=;
        b=fApaNGWOhpxJ2op+1hGNQU70pZs+MrfP2MuEJJhAw/f0HEWcXhVxhwmx3U9sRBSfv8
         J2JIgAsgWJDrx16CHNvF+mkfqaPJIZvnOstF8pSBz4WcPZ0rJPNElSstxdmyMD2XDEa2
         eX1rJfiNGca+aTnwcJFOQy9Ro+HZqJHFUwe/SqUeD3gppVfPLZK0Rl/jWnIkqH1R3um8
         puT902k8pifZ1H9H5EZPt2uF+mAFb3QqUgIDbVRjdlGxKITmRc2wtlO3NAcz0I9m0uW2
         WiwIDYc9UO17R3y6+v5nZO+TAsdEKYL6GNM39OjcHuj3PQJty61y44vTu+DdXRQlKBAy
         enlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795131680; x=1795736480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dGAIBXcxAo4ug92wkzcGwRrGYDjRYNfW8cF+/h8C8jE=;
        b=EDzcABuiIa8a2h+t+/AJucSMUlo6K+Z2EEoI5ysqCQYh0OA1X85A5fmkReFEvKnisM
         vfFjBXySGIVfUepQydo0FT4I6uFZJw6yF+uLP3c2Lw96+w+EUcupbH6HK1T4zSxyKvnO
         a8D7XB+8zBmcjKeD3BiaA4EaQOojLZwIEZEZWdpkKyOSJzi4OfE+XTd/jpsJUqJipN9x
         JrwfMTO1nG7ljnBEaNDbFXTpa5etUz5uPBMRL9bAvMuP0T+FKJPtTwQQnm1HQzWZw5/Q
         YbdCl7TfZ2FRYSApW+md1aDiRurZLZMbfoBbuvXi/3sJ7leZ2Z7QJ/HSitvgDp482S79
         3vng==
X-Gm-Message-State: APuU4Z9OgKTLNUOBzHK1/yiOufWIWynBZl1RHDR08JfMRSPI48jsvS0e
	H2ZeQtfIeD3eoWvHHGTwfLxc+SzpxF8AAEdOf6mrP7M2iCjBdsir1KWo83IZXbLFlro=
X-Gm-Gg: AZFdTZdMF0uIEPNRblIlmJWrZPaEBscG/jQBhcdKd57chZE3aHVXjnHkdpi0wA/SJmx
	CPCxtAmg97baTBCg/gf2D1BGftLFvFcy513FxIhAjWI5vZc7GksGhpok0Ex6DdCu7IC7/c5zL7+
	TLUNWJk1HORrS2/HjAKAfeBNDvCJTkrTBMPsHn5B4nP2ZuiEob2Jgb2B93grZaV9Ln5sMNq4Dqt
	0tCTtRBqKNtr5zXk6dmx0jiVGah7iuu1/8b0S1z25pHcG9/uGvmJilRho/wD2JEaC9YK1COGI6o
	5Js+ElDGfZjgEdHfxDrc1ubLVTyTj93orq0+ZYTCzjy5kcnKqjwvxwjT7pM+IDGYQ3G4791+DlM
	rZ2wT7r1d3N9A6MHr6R6yBvRJFj/y8zOf3DQaDn3JkVmMkyrqQBzsA3p13Vq8rdQI0LDZJ0TOMh
	q9n0aPdHEHT4DiOgTqdxEE5ZETq6gcygUomUU04iC3nvZzAHr7FoDzSn/7tR3wMj1NS8H/SZWAX
	PG/a5euyUTEGLobUXSbrt/s7GlybVxbeVLjowxph+pe+A3hahkt+NwIAZ8cbDcDpYFnxJer0jt5
	zMUUSAoXlsWM1la8gOQ+DPIGAMrP+nGB98LzSaCnYssx2OacXMEXJUzUdxg88gPjfeRZ30uOVCK
	JUaQJf0SpL7mSjtEbTbuG/cONFYv+6nRThXNxlvfOuVJgPnmw/yGPMprmHt2gTKCF0CigX/k=
X-Received: by 2002:a05:690e:1907:b0:66d:1877:121b with SMTP id 956f58d0204a3-67df43f32d1mr715869d50.32.1795131680127;
        Thu, 19 Nov 2026 15:41:20 -0800 (PST)
Received: from system76-laptop.attlocal.net ([2600:1700:6476:1430:1932:ad09:1827:11fb])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df338e8fesm796893d50.16.2026.11.19.15.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 15:41:19 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 3/5] hfsplus: give the special files their own extents_lock lockdep class
Date: Thu, 19 Nov 2026 15:41:10 -0800
Message-ID: <20261119234112.720963-4-slava@dubeyko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119234112.720963-1-slava@dubeyko.com>
References: <20261119234112.720963-1-slava@dubeyko.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writing a new extent record of a file can grow the extents B-tree. The
B-tree file is then extended with the file's extents_lock and the
B-tree's tree_lock held, and takes its own extents_lock:

  hfsplus_file_extend()                    file's extents_lock
    hfsplus_ext_read_extent()
      __hfsplus_ext_write_extent()         extents B-tree's tree_lock
        hfs_bmap_reserve()
          hfsplus_file_extend(ext_tree->inode)
                                           B-tree file's extents_lock

All inodes read by hfsplus_iget() share one lockdep class for
extents_lock, so lockdep sees the file's extents_lock -> tree_lock ->
extents_lock chain as a cycle:

  WARNING: possible circular locking dependency detected
  dd/1553 is trying to acquire lock:
  (&tree->tree_lock/1){+.+.}-{4:4}, at: hfsplus_find_init
  but task is already holding lock:
  (&HFSPLUS_I(inode)->extents_lock){+.+.}-{4:4}, at: hfsplus_file_extend

This is a false positive: the B-tree file's extents_lock always nests
inside the other file's, never the other way around. But lockdep turns
itself off after the first report, which hides any later real problem.

Give the extents_lock of each special file its own named lockdep class
when its inode is read from the volume header.

The report is reproduced on a valid volume created with "mkfs.hfsplus
-c e=1,d=1", whose extents B-tree has no free node, by interleaving
appends to two files that were created before a remount until a file
needs an extent record in the extents B-tree. The remount matters,
because hfsplus_new_inode() initializes extents_lock in a different
lockdep class than hfsplus_iget().

Tested on a KASAN and lockdep kernel: the report is gone and generic/001,
002, 013, 075 and 112 pass.

cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/hfsplus/super.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index e568a5508b5e..d23594d12064 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -50,30 +50,48 @@ static int hfsplus_system_read_fork(struct inode *inode,
 	return 0;
 }
 
+static struct lock_class_key hfsplus_ext_extents_lock_key;
+static struct lock_class_key hfsplus_cat_extents_lock_key;
+static struct lock_class_key hfsplus_alloc_extents_lock_key;
+static struct lock_class_key hfsplus_start_extents_lock_key;
+static struct lock_class_key hfsplus_attr_extents_lock_key;
+
 static int hfsplus_system_read_inode(struct inode *inode)
 {
 	struct hfsplus_vh *vhdr = HFSPLUS_SB(inode->i_sb)->s_vhdr;
+	struct lock_class_key *key;
+	const char *name;
 	int err;
 
 	switch (inode->i_ino) {
 	case HFSPLUS_EXT_CNID:
 		err = hfsplus_system_read_fork(inode, &vhdr->ext_file);
 		inode->i_mapping->a_ops = &hfsplus_btree_aops;
+		key = &hfsplus_ext_extents_lock_key;
+		name = "ext_file_extents_lock";
 		break;
 	case HFSPLUS_CAT_CNID:
 		err = hfsplus_system_read_fork(inode, &vhdr->cat_file);
 		inode->i_mapping->a_ops = &hfsplus_btree_aops;
+		key = &hfsplus_cat_extents_lock_key;
+		name = "cat_file_extents_lock";
 		break;
 	case HFSPLUS_ALLOC_CNID:
 		err = hfsplus_system_read_fork(inode, &vhdr->alloc_file);
 		inode->i_mapping->a_ops = &hfsplus_aops;
+		key = &hfsplus_alloc_extents_lock_key;
+		name = "alloc_file_extents_lock";
 		break;
 	case HFSPLUS_START_CNID:
 		err = hfsplus_system_read_fork(inode, &vhdr->start_file);
+		key = &hfsplus_start_extents_lock_key;
+		name = "start_file_extents_lock";
 		break;
 	case HFSPLUS_ATTR_CNID:
 		err = hfsplus_system_read_fork(inode, &vhdr->attr_file);
 		inode->i_mapping->a_ops = &hfsplus_btree_aops;
+		key = &hfsplus_attr_extents_lock_key;
+		name = "attr_file_extents_lock";
 		break;
 	default:
 		return -EIO;
@@ -82,6 +100,8 @@ static int hfsplus_system_read_inode(struct inode *inode)
 	if (err)
 		return err;
 
+	lockdep_set_class_and_name(&HFSPLUS_I(inode)->extents_lock, key, name);
+
 	/*
 	 * Assign a dummy file type, for may_open() requires that
 	 * an inode has a valid file type.
-- 
2.53.0


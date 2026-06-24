Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845B334676F
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782309273; cv=none; b=iVcD1rS/ErXuqtzNbVQwiKL696iDiifzT49PVw4oxg6+70EvmYbeBloZkGKJKJCAro1/CyTr8V7m0eJ6j6op76tYFokJpa0CYKDoMs5G3D01HwnY7Us3Ar0zaXFroKg8U9k64+/ZKuIi5HCqKsNcfh6Fc38POJnXI69//HskJOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782309273; c=relaxed/simple;
	bh=p/pBZevVP/odvJAIRericFaMfFAM4i77/ezyd61QUu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=efxHpco8zQNOthy2cnlvKIy7k/D/HoROh1aq/BmYWcM35eEQvNKGUfvhrHKEWPd10ktxmGf6XBUedExtumYtm7KHpiiqnBGil1IKbW8rCtXXGgfa7ilEbjj7gidD85BGENEi2cdIRLZDFGTv8hc02C/uSbCZcoN0pMHw+eHI2To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONISG7po; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONISG7po"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so10328805e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 06:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782309270; x=1782914070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eeULs+8ln9ybOUotKushEgNx1EhZFlLnKHvahbNr24g=;
        b=ONISG7pobSqchFGe2lXY2t1J65cnhkZnwDE9GZYUknRnI/YY3w/6vdw7+4fCM1C0MZ
         BlLwK2mmMjtSgZAmBnnRA0z732Mo74dvT9AIj6XBDyiCFiJbJMlcC1jVpAVQlKERbSAF
         e84eyz20wBgHcaawvlE0L7MT19MskBdR2EFRS4V9oqh8+SncSP7/vZF2GM2emWhNsrs2
         gGlc4clDgEeIZssJdqNUfiq/NSzSuAKeeyHRGd8cS7LKfi7abr5+67GHMZo0A/xR/Gu4
         akzgVPFUOV2ShQzxzaeS0ivGpSy9ue6cxie3pQhS26FwhNnuhA9q1u9iMue5oe2Qzp0P
         o9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782309270; x=1782914070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eeULs+8ln9ybOUotKushEgNx1EhZFlLnKHvahbNr24g=;
        b=rl1t/kNIE7LjOPLrZPRirHOuua6PS2W9rVkiWnQAIWml2a0J+cMn96GqIu8PcgR1Qi
         61D8iAK+CzmwmvHihfEz4U3MsaJDpeckqGX/UdrAUTwa/XG0PVsICThVlUoO20cglPDz
         rxO0Xy5XZBWkPDL1mqzFKGS/BS40MgpfFLNsW9LLjO7bjGnpiiCEsNnZXQlyrjGEI+gX
         Nw4er0rt9YgNcxFzSKho+zPfIEKjnX+/nq5dBX4gT2nhRLeZNp58lUQjL6tHlt0CJKeJ
         1EMvO7li0bvObUKtq8pHTdQ77Q3t8D8uYoHDpq1IrKwULHFCOUCAfmPGdtxrmx2rJtee
         Mh8A==
X-Forwarded-Encrypted: i=1; AFNElJ/YgbMpCdF71zgvkJDbLJOqRYkN2pW6E+RiRRt4pVtDIGPZBg+aQy90GsHhLWQhjCPEvIkIIiOOqVL0Kbdb@vger.kernel.org
X-Gm-Message-State: AOJu0YyVddYSSzXcBuiNKLcNme9utWaXvaYA6qtEUn0VDFujW0rb1sKR
	7arbEPTxYEwjhd3RkV8oB7vswUq1XseoM04acx+0oRA3EtankdEGN78f
X-Gm-Gg: AfdE7ck/whsz9F7S9AvbaJkwoXabqx9kwThiNT8hy/u7GF4ZhWSOIopc+btWmLNTqu8
	OHdthIu+K3hK1QUpl8GiIZZSp3KXcMmo8DlCMNnckpb8QW9MG9Ors6iAlFIpHe3tfGQKscjg4ac
	mnnARiJdopq+TRmgbsR3JGr5SmJz4wvCE17/lRngGiFaF2nTUszklOb8IywKt/yeyl9IfYgCorw
	LvYjiHE5npd+SHbdFxchepl3/731DXcHTahDZpdfRpMpiKK8VS2itQybd4HXRxmWR3E5j8sGVSV
	bKQb/DCjzhf0OTe1xCl/uOU8oyckYvuX8FhH41bCdZOQ5DUZDXsByb1/crXRwTyCtElsfjR5PJ3
	HKCUoUD6D1eS8mH8wYXU7jRVkIAVIpOpVv49g1553VNB+aW83bDYcV43EX3CPBxPdb9Xz+6Wg5B
	X1rWnE/DD0/nrFw0KSQUaPXH4m4iHKi4RAA9/lvhrqmqEUcyLIyS9jyROYIsh3fwHX2TE4QGEfU
	yUvF9Ow997XqLMkWkLMCrukLP26OUaCDVf1RLdxjH+CtASuMNI1ZlH86FgR9SG4lv3gJY41mBc=
X-Received: by 2002:a05:600c:4753:b0:490:c682:e37d with SMTP id 5b1f17b1804b1-4925b38cb26mr108482885e9.32.1782309269582;
        Wed, 24 Jun 2026 06:54:29 -0700 (PDT)
Received: from instance-20260604-012959.europe-west1-b.c.project-2c9d95d2-bf4e-4d5a-ac6.internal (250.69.76.34.bc.googleusercontent.com. [34.76.69.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd15535sm497130755e9.3.2026.06.24.06.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 06:54:29 -0700 (PDT)
From: David Maximiliano Hermitte <davemadmaxxx@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com,
	David Maximiliano Hermitte <davemadmaxxx@gmail.com>
Subject: Re: [PATCH v2] hfs: validate corrupt catalog and btree metadata before hfs_write_inode()
Date: Wed, 24 Jun 2026 13:54:12 +0000
Message-ID: <20260624135412.7208-1-davemadmaxxx@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Slava, Jori, all,

I am following up with a refined test patch for the same HFS syzbot reproducer.

This variant does not change hfs_write_inode(), hfs_test_inode(), or the BUG() site. It rejects corrupted catalog/B-tree metadata earlier:

- hfs_brec_read(): rejects invalid entry offset/length, caches node_size locally, and uses overflow-safe bounds arithmetic.
- hfs_read_inode(): rejects invalid file/directory CNIDs before writeback.

Local validation on commit 840ef6c78e6a:

- git diff --check: pass
- checkpatch.pl --strict: 0 errors, 0 warnings
- make -j2 fs/hfs/: pass
- bzImage built
- QEMU/TCG with the same public syzbot ReproC:
  - BEFORE: repro_started=true, kernel_bug_seen=true
  - AFTER: repro_started=true, repro_done=true, kernel_bug_seen=false, hfs_write_inode_seen=false, kasan_seen=false, oops_seen=false
  - verdict=REPRO_RAN_NO_BUG_SEEN

I have prepared this refined variant because the hfs_brec_read() bounds check now validates entryoffset before computing node_size - entryoffset, caches node_size locally, and rejects entryoffset >= node_size explicitly. I am including it inline because it avoids potential integer overflow in the bounds check while preserving the same QEMU validation result.

I am sending it as a test patch / direction check, not as a final maintainer-ready fix. The point is that validating corrupt catalog/B-tree metadata before hfs_write_inode() prevents this reproducer from reaching the BUG() endpoint.

I would appreciate your opinion on whether this placement/direction is closer to the expected HFS fix.

Best regards,
David

Patch follows:

diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
index d56e47bdc517..e48a7110e342 100644
--- a/fs/hfs/bfind.c
+++ b/fs/hfs/bfind.c
@@ -170,12 +170,20 @@ int hfs_brec_find(struct hfs_find_data *fd)
 int hfs_brec_read(struct hfs_find_data *fd, void *rec, u32 rec_len)
 {
 	int res;
+	u32 node_size;
 
 	res = hfs_brec_find(fd);
 	if (res)
 		return res;
+	node_size = fd->bnode->tree->node_size;
+	if (fd->entryoffset < 0 || fd->entrylength <= 0)
+		return -EFSCORRUPTED;
+	if (fd->entryoffset >= node_size)
+		return -EFSCORRUPTED;
+	if (fd->entrylength > node_size - fd->entryoffset)
+		return -EFSCORRUPTED;
 	if (fd->entrylength > rec_len)
-		return -EINVAL;
+		return -EFSCORRUPTED;
 	hfs_bnode_read(fd->bnode, rec, fd->entryoffset, fd->entrylength);
 	return 0;
 }
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index ac4a9055c5c0..7283b9541064 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -367,6 +367,9 @@ static int hfs_read_inode(struct inode *inode, void *data)
 	rec = idata->rec;
 	switch (rec->type) {
 	case HFS_CDR_FIL:
+		/* Reject corrupted user file CNIDs before writeback. */
+		if (be32_to_cpu(rec->file.FlNum) < HFS_FIRSTUSER_CNID)
+			return -EFSCORRUPTED;
 		if (!HFS_IS_RSRC(inode)) {
 			hfs_inode_read_fork(inode, rec->file.ExtRec, rec->file.LgLen,
 					    rec->file.PyLen, be16_to_cpu(rec->file.ClpSize));
@@ -390,6 +393,10 @@ static int hfs_read_inode(struct inode *inode, void *data)
 		inode->i_mapping->a_ops = &hfs_aops;
 		break;
 	case HFS_CDR_DIR:
+		/* Only the root directory may use a reserved CNID here. */
+		if (be32_to_cpu(rec->dir.DirID) < HFS_FIRSTUSER_CNID &&
+		    be32_to_cpu(rec->dir.DirID) != HFS_ROOT_CNID)
+			return -EFSCORRUPTED;
 		inode->i_ino = be32_to_cpu(rec->dir.DirID);
 		inode->i_size = be16_to_cpu(rec->dir.Val) + 2;
 		HFS_I(inode)->fs_blocks = 0;

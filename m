Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151B144683C;
	Tue, 21 Jul 2026 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628841; cv=none; b=EE6+Npffd2WGB/1DG+VOjmhZiv2O4yL50bTdgzo/n5M1G0m8tiwkrPwO1zpZZ/h3jSOYj2ldTIS2qX7wg9m9PdFBWdqVQtRNYVjeSPQTTjoJniWunPQla7MX/7X3eQuwe1omOGk+iY3OtCwOHndanw9rMjMdb56mjNWKeKYI+Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628841; c=relaxed/simple;
	bh=SsNKGwYujEhJZ8g0r0Z0nqzX7hHlNonkTNgCGesicvI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XsM1CsjBkiSK8zm82Y8azmoFlNtUx2bwwL40tjsujupXjfnw3x+zvpbDKo0faOKPjhfnZRZjmpbwizq6Jfj717mewGb1Mfz/BsSyNbPo+N3WFnO0FYjAkoFyEutE9jPF3/ij1NYuIl3jhV5hNV530HS+ybKkchXnsVc4RR36JGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=BGucHbmc; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="BGucHbmc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1784628816;
	bh=g6Gb0CVwPEtmxvQ2MqzhroleR9cGmQI7QxQfZd+3wZM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=BGucHbmc86eAmzS7SbLfb5z45il4OGUWs9Q6PE1aYYZiECzScSjEadcJ8BMtZ6m5t
	 /LjQqCUxg/0/C7+IUuo2yzXRVe0AWIqV9yiQgInINpk9AVnMqN+hHfcn7bQl3dIoHZ
	 935UWas2oZv/1HkQZc9ntDilKzsd3vHQ29tlvM8M=
X-QQ-mid: zesmtpsz2t1784628801t8cc34aa9
X-QQ-Originating-IP: 2GKiwigWXB2/gq8ZjV0K9hRH3VoGxuOAqgokWZV/nFA=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 21 Jul 2026 18:13:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13879891815030819408
EX-QQ-RecipientCnt: 4
From: Yichong Chen <chenyichong@uniontech.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yichong Chen <chenyichong@uniontech.com>
Subject: [PATCH] isofs: validate directory records in NFS get_parent
Date: Tue, 21 Jul 2026 18:13:18 +0800
Message-Id: <20260721101318.1453108-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: N4r4IakIsd1k7bVx/EMLWdrMQBjjuB873+Ee1WFxs3aznrqxKBS61pZB
	6zTsXMePfmMOMUiNCNhFqbYLzDX0jofPPfbz8hmJ+z2r8rsBmQ25BFljvWNkRWVOGLYf1F+
	SOjEb3JXN3HiUPIz3tA/jlmLFwSI6YVfpNwJhS8y2rLihen0Udh/dzhxDSzDgkXsjqouItY
	xw2kTRzTLnsXir7WoG7r8vWTeC87FTbhVjXlNh3+56Bc1A0+3ewHSH2q4UX0WQc7eof86g0
	7uO+nqsYDcGtW+ugOGzJW4jYr++Sn6jhLR+0N+MO0/h4smi0CV82kx9fo+H6jy10hSQpXAS
	ezVlx8kq5Gq4Y1V5r+Klm5rEUYtpYEy/ostXKR6wHG2PTv0ls/tC5MXUjtj9yqVrrk/AnDq
	zufv0TNTU5hth+itE1t7AguUgx2YqBvfKJ/5CmrtDYksme6ZNbDWaPf/TCn8F6+LyM4OeR0
	2ITaby/KzJifXH3zN2YzD0WTHyDjc39JHKE1n02ahhU3ZOuH1sDtPj1u6VVKxQhHXMMhqxU
	CgJ+ei7FPbmFVaa962kkvUUD/OaMcqXvpyFoH8CwaVMRWYvCinmEKFk7iwOezaST4ewRfrx
	ezn0jvvY2DAhxK7qa33v/IRydp4TIkTIVCgR+yV9WYbXSWFJCwkMyvdYsU0bbr0ZgcT6d3V
	OwnzFkKrB0dubxWvhiwOE75bQkQaseEjVPKQfLqYp6Cy4KfRzheKXQPgyY4tgACI9a4kkPP
	t/coaY/V3rmqJXd7AiGW4eHet2yrzsUDE1wh7ckMNqpa/i+wlaCi+/p1G/GODC9BJE85rHd
	Vr8y1H6I84Ojxm7WhaW236rFLFSgPjgmXNrKAHpi/DU3W+lFRFfiTO4WAdilIpE15NSEYGj
	uzmfbYlGhN7g4RohCF0pgD56AgNfZ43FRHuyzT3w4z+3kDXIgguIOTXegWXxj1S0En2Pg9q
	omem8yiiq6IdiNeMA0I6eL8nLAWTK3W2zO6bURXR09Rblz2TvIdOng+MQVhzdSMwQAj4RU3
	OHSdjGo2mEQW3I3jTi4btRtfOmTuA/VySBdB1q3g==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

isofs_export_get_parent() assumes valid "." and ".." entries.

A malformed image can provide an invalid length for the first entry.

Validate both records before using the first length as the ".." offset.

This keeps the NFS export get_parent path from accepting malformed records.

Signed-off-by: Yichong Chen <chenyichong@uniontech.com>
---
 fs/isofs/export.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/fs/isofs/export.c b/fs/isofs/export.c
index 78f80c1a5c54..bffec45bb274 100644
--- a/fs/isofs/export.c
+++ b/fs/isofs/export.c
@@ -16,6 +16,26 @@
 
 #include "isofs.h"
 
+static bool isofs_dir_record_valid(struct iso_directory_record *de,
+				   unsigned long offset,
+				   unsigned long bufsize)
+{
+	unsigned int len;
+	unsigned int name_len;
+	unsigned long min_len = offsetof(struct iso_directory_record, name);
+
+	if (offset > bufsize || bufsize - offset < min_len)
+		return false;
+
+	len = isonum_711(de->length);
+	name_len = isonum_711(de->name_len);
+	if (len < min_len || name_len > len - min_len)
+		return false;
+	if (len > bufsize - offset)
+		return false;
+	return true;
+}
+
 static struct dentry *
 isofs_export_iget(struct super_block *sb,
 		  unsigned long block,
@@ -83,13 +103,21 @@ static struct dentry *isofs_export_get_parent(struct dentry *child)
 
 	/* This is the "." entry. */
 	de = (struct iso_directory_record*)bh->b_data;
+	if (!isofs_dir_record_valid(de, 0, child_inode->i_sb->s_blocksize) ||
+	    isonum_711(de->name_len) != 1 || de->name[0] != 0) {
+		printk(KERN_ERR "isofs: Unable to find the \".\" directory for NFS.\n");
+		rv = ERR_PTR(-EACCES);
+		goto out;
+	}
 
 	/* The ".." entry is always the second entry. */
 	parent_offset = (unsigned long)isonum_711(de->length);
 	de = (struct iso_directory_record*)(bh->b_data + parent_offset);
 
 	/* Verify it is in fact the ".." entry. */
-	if ((isonum_711(de->name_len) != 1) || (de->name[0] != 1)) {
+	if (!isofs_dir_record_valid(de, parent_offset,
+				    child_inode->i_sb->s_blocksize) ||
+	    isonum_711(de->name_len) != 1 || de->name[0] != 1) {
 		printk(KERN_ERR "isofs: Unable to find the \"..\" "
 		       "directory for NFS.\n");
 		rv = ERR_PTR(-EACCES);
-- 
2.51.0


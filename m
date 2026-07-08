Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E4047CC8F
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 16:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783529494; cv=none; b=GLuBEqQeXxR+xZ7Z5y8CCoMt2wA/y94SutInW9VU8HeyzfdvBclqj00FCtmCCTGv+2hrGQ2gZD1wnNhjoUV6jfzkynMz5TDDRxPyuPL8duQddDl1FMkutoH00uFiXtsVBNYSLbsB1q2NET7y+VilJM88RN9A8CQANWnJQPr+lMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783529494; c=relaxed/simple;
	bh=zYlyiqjSUhiYkbJOTENTJH4trDyaeI9WWvqH84datqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GwTFC4jxjwPUJOX8+dVSls/NtQaAP+nZFrFiBXIx9xl9FizzKvqU29cdN0CL54uVJJqdmRhpL4f43x5TxZdZZaKxssEEOgV2nUmR4D2ZUP7vnwkjHXZb47qdTsGCWZnRTAXL4Kg0Ok/5CIYkiwFAM1cHzjZJF5kICN1eG73aMeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzopBEA0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzopBEA0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F191F00A3E;
	Wed,  8 Jul 2026 16:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783529486;
	bh=Fs1l97gUuJOUggeSkxVmc8x+hMstX7kazastR4ARfLg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YzopBEA0EfPFV1TOe/qTxWSUJsHLwCAw5enPv4DaKa5XMVcubkglVM+BetbdYXvbB
	 gsQOO3AbYmTTEDV/to7wM4ucgFyl4RE7HWO2szrVUmJ0RN2YhThf0SXJBHspQo/XRm
	 kdUTdPVywfVZhD+yyI4i1BXW64tONFt7rE1M6vcDkGdO+gHZ+VaQXStxeU/4FxLtvb
	 d8GNArbVfIM0j9lDPoKWaNcpQGoVOqSW1MsdYBWOZOQFMOmj9uCaaJCQTgU9zb/OOA
	 xobniEC2CA6fofNmM1ULfAGUsp61nz5yzUjHL0JF5wNssj+cA0dvBYILSuRj0jfyBS
	 31Rq+i140GnxQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 08 Jul 2026 18:51:18 +0200
Subject: [PATCH 3/3] binfmt_misc: annotate racy accesses to ->enabled
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-work-binfmt_misc-locking-v1-3-a009dd5b56db@kernel.org>
References: <20260708-work-binfmt_misc-locking-v1-0-a009dd5b56db@kernel.org>
In-Reply-To: <20260708-work-binfmt_misc-locking-v1-0-a009dd5b56db@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-mm@kvack.org, Farid Zakaria <farid.m.zakaria@gmail.com>, 
 jannh@google.com
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1989; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zYlyiqjSUhiYkbJOTENTJH4trDyaeI9WWvqH84datqU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT5NbB7XX3QsDv+n/zL0H1F/56aa7JUNs454Fh73kpqa
 cyuU3nLO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYSfJfhf6z8s0if/U1bv7tl
 RWz9XbBtxZwib/NyDb3YWbf4zFb9yWH4p+a2oPKZ4fuK/U7PJj763iKrtb9hkcfTjTNUGNPXW74
 W5QMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

->enabled has always been read and written locklessly: every exec
reads it in load_misc_binary() while bm_status_write() or a concurrent
remount via bm_fill_super() may flip it. That is fine as it is an
independent boolean toggle but the accesses should be marked
accordingly for KCSAN. Annotate them with READ_ONCE()/WRITE_ONCE().

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_misc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 9d1039dcd3f7..0f04709a0a39 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -215,7 +215,7 @@ static int load_misc_binary(struct linux_binprm *bprm)
 	struct binfmt_misc *misc;
 
 	misc = load_binfmt_misc();
-	if (!misc->enabled)
+	if (!READ_ONCE(misc->enabled))
 		return retval;
 
 	fmt = get_binfmt_handler(misc, bprm);
@@ -863,7 +863,7 @@ bm_status_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 	char *s;
 
 	misc = i_binfmt_misc(file_inode(file));
-	s = misc->enabled ? "enabled\n" : "disabled\n";
+	s = READ_ONCE(misc->enabled) ? "enabled\n" : "disabled\n";
 	return simple_read_from_buffer(buf, nbytes, ppos, s, strlen(s));
 }
 
@@ -880,11 +880,11 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
 	switch (res) {
 	case 1:
 		/* Disable all handlers. */
-		misc->enabled = false;
+		WRITE_ONCE(misc->enabled, false);
 		break;
 	case 2:
 		/* Enable all handlers. */
-		misc->enabled = true;
+		WRITE_ONCE(misc->enabled, true);
 		break;
 	case 3:
 		/* Delete all handlers. */
@@ -995,7 +995,7 @@ static int bm_fill_super(struct super_block *sb, struct fs_context *fc)
 	 * someone mounts binfmt_misc for the first time or again we simply
 	 * reset ->enabled to true.
 	 */
-	misc->enabled = true;
+	WRITE_ONCE(misc->enabled, true);
 
 	err = simple_fill_super(sb, BINFMTFS_MAGIC, bm_files);
 	if (!err)

-- 
2.53.0


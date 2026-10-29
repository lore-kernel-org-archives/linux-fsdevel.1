Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793294955;
	b=kcipR+61rfXb4KpW4yonSEWgZsVIT9VLJA6Mlkpcapk4ovxu/uicREzY60aLnHEgxTq6
	 0CHE2hl+gnlwtrte0rcfcGHiM1DUWDdLpsLA3dQxdCyZdECNBO4j64/ZxrH/sF3Oq6Arw
	 GPW/Ru4S2hrWRi+YN0KpA+R/FAHy7v3hqbMaWaqv8MI7StKmJ3xEK8KQSXZ3W7qtmcnGp
	 nHRQIsvPDJJoR5i/hu9H/6PnvIney72is5BWfyZqouqxzqlE93AejycNCgUdeQYhO168M
	 vDXAtNlfsR2++hJVUKBpSNWkh9xD43cTUxC1AvB+ohQmgi9H6OMZAohl1Nl+a/BUI/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793294955;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=C0VaRVr7bGvM/bx82T8SSyENADhnZMpp8XqYnngbiFM=;
	b=DOxRW5HLn/TTA9d7KDAgTIuNr04/4D175BwZnZ27Pnhg4SObYYZrajr4XcWLFIt4V0NR
	 n2IMwdHiiONaN7b0YoVkW/px3uOj18hOxEP9wVwRU5uhd3LAi3oyT/UT4VSyGShy1aPXL
	 8ynyijhHYlM6JMfL2vQ/hvGKxLH84gQtdTVIl8RmZksBTP/xViYRgym9x1Phn4gv0HHIm
	 O/2J5ql2YaSD1hn9e4zrzM0JLQOT3i86KMM7mSIotup4CqDcNpfjc8MK4SxwKegS171pf
	 Cv2qoUVSqkxWw/JFuYq7xAFOwFlZMT3Fprl8d10Y5I8mAo0F9O9MVLkUAH61GhHi0+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jSE8mr23;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33EB606A31C;
	Thu, 29 Oct 2026 17:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jSE8mr23
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793294954;
	b=c0KD6Ua6M4LM8MkkaCXKCXbfakLnFnzLmDS1BSiclwz9gzIZhqPEF3DMEgpuKzKWVYf4
	 HJY6oY0nD61NGeX/rF4HNqpcjA3aitdHZNOb6h/KKjQZmTyt8lfLrYK9WSmZuVTgimh0m
	 Q4aobfNz0uKduSQS7XVTnaECr4Z4TdpCMT8afwhp2LxwDkDCBTej1wT8uG7byOSSsGZfl
	 Gvia3KJNaEuSQqc9BgFveM7iqST/gLufruEQLUQCR0EM+CKWCMpIlSoU6CNHzcUAl7A8O
	 0DyPHnvd+g60O1tMRbmVBA0cYUW/g3INxUD42K3qcikvH2xI1yuGsLf0t0IEJZ5H/4g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793294954;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=C0VaRVr7bGvM/bx82T8SSyENADhnZMpp8XqYnngbiFM=;
	b=Ezu8Iaiy6eXE2dlvBiU1wtcyRckJWDcEu47MilEzrrwlKseHhwdITMFdyihlJJGwj5ZZ
	 Cbk4YQT6oTMLxGEYKFRbgRBWiU/KsiEqytiCNR/+AAgvaHIVxopszbif/KIyv1dQk0RxS
	 uwtyGACIRZuld81xFW43Z2qj20BG/Q+pO2WFtxSGNOyCV+GXMjHxaBq645I8xzZcExI2v
	 reMZug5xJOseuBuWdk2T9jBU2zhp9qJcy179R18vnncMMOUpKhaXXNetDM6AXsFzXBKL+
	 37IznAIumEDpJ3GUZ+3XyFLfT6Oxxk7ekwAVcrkDSMJDM6yoRwDIUyI3wkZ6Bn2FhZg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E07421F01816;
	Thu, 29 Oct 2026 17:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793294954;
	bh=C0VaRVr7bGvM/bx82T8SSyENADhnZMpp8XqYnngbiFM=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=jSE8mr23Zla8o9R8EzxSV7hNU7AhNpnIgcHUXjrEOkuqKzbCfFcOy1Qdul6JpoOAy
	 fK50iOh7pCagdMTmoPsgsrmH9BGADJyONrgYm+1kmB+J6gmH1uxcteJNbd4tgmZ7Sm
	 aPJ73OVzqjsplVsYt7JwgqI7nufpKZBMxJz8UEdJh09jFtX6UPAI+yrvsrh/pUnjlz
	 UdanJSaAPso8XQX3sR4ohT0fexBpNHKkqhfmwx6Ki2PbFNTF1K6bfpM0WFvbOZuA2H
	 1nyb5D945apeqVE0EonyEQTUOS6qoejn64wEBsJEYcM6zRqUZJOB2cB/CU5HNnoBcW
	 xA1WXaR1+LSVg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6CAC24591E;
	Thu, 29 Oct 2026 17:29:13 +0000 (UTC)
From: Bryanna Marihugh via B4 Relay <devnull+bryannamarihugh.manhattantech.edu@kernel.org>
Date: Thu, 29 Oct 2026 12:29:05 -0500
Subject: [PATCH RFC] fat: use write_inode_now() on flush to avoid racing
 the flusher
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
Message-Id: <20261029-fat-flush-isync-v1-1-69c02c258d0c@manhattantech.edu>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAyNL3bTEEt20nNLiDN3M4sq8ZN3EVAsji1QDQ4vUVAMloK6CotS0zAq
 widFKQW7OSrG1tQCHLP/2ZgAAAA==
X-Change-ID: 20261029-fat-flush-isync-ae828e018ee0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bryanna Marihugh <bryannamarihugh@manhattantech.edu>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793294953; l=3920;
 i=bryannamarihugh@manhattantech.edu; s=20261029;
 h=from:subject:message-id;
 bh=0RAv1HEugH48i+Dam1TLaXkZ+tl9I43PsY6T9wrT1v8=;
 b=rau0TUVnf2bOyxOi17O7tp/tmHxUESLTnAw5OlPs2m1LHOW3t/lLx5DnrRY7lIXJ13jgSVB/n
 S1IpmXd9FBqAFyI3Z8B4wyhKPwBsePsB6qSU1BTIZxZEK5ExsIAlkV1
X-Developer-Key: i=bryannamarihugh@manhattantech.edu; a=ed25519;
 pk=9KJhRQBfRNks2S9TlKp7eVVyWBMuygW2+Zzy+kMGOZw=
X-Endpoint-Received: by B4 Relay for
 bryannamarihugh@manhattantech.edu/20261029 with auth_id=1355
X-Original-From: Bryanna Marihugh <bryannamarihugh@manhattantech.edu>
Reply-To: bryannamarihugh@manhattantech.edu
Content-Transfer-Encoding: 7bit

From: Bryanna Marihugh <bryannamarihugh@manhattantech.edu>

On cheap USB 3.0 sticks, copying a large file to one formatted FAT
slows down badly when the background flusher runs at the same time.
This only impacts performance; it does not corrupt data.

udisks mounts FAT with the flush option, so closing a written file
calls fat_flush_inodes(), which starts writeback of the data with
filemap_fdatawrite(). That does not set I_SYNC, so the flusher starts
at the same time, which causes lots of small requests.

Cheap controllers handle small writes poorly and sometimes stall for
seconds. I have found this to be a problem on many cheap USB 3 drives.
Older USB2 hardware, better drives and ones that support UASP
don't show this behavior.

Use write_inode_now(inode, 1) instead. It goes through
writeback_single_inode(), which sets I_SYNC while it writes.
Close now also waits for the data and the directory entry to be written.

Benchmark copying a 3 GiB file to a USB 3 stick (PNY, 154b:00ed),
default writeback settings: 11.6-16.3 MB/s before, 17.6-18.0 MB/s after.

Signed-off-by: Bryanna Marihugh <bryannamarihugh@manhattantech.edu>
---
This is a performance fix for cheap USB 3 sticks on FAT mounted with
flush (the udisks default). It stops close and the flusher from writing
the same file at the same time.

Tested on v7.2.12 (stock and patched) and mainline c339f4010dea
(patched), bare metal, same stick. With the flusher kept busy
(dirty_background_bytes=256M, dirty_writeback_centisecs=100) cp goes
from 6.8-8.7 to 13.5-17.4 MB/s. With the patch one task writes the file
and 96-100% of data bios are 768 KiB or larger (4-16% before).

Only measured on one usb-storage stick. UAS drives I have used did not
show the slowdown, but I haven't traced them.

fsync() and sync_bdevs() can race the flusher the same way on other
filesystems. I kept this patch to FAT, but have numbers for exFAT, ext4
and btrfs if useful.

I am a sysadmin not a C dev haven't written it much since school and so
did use an LLM for help reading the writeback code, analysing the block
traces and drafting the patch and text and who to email. I typed,
reviewed and tested the change myself and feel confident that I
understand it and can answer questions.
---
 fs/fat/inode.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index d85c8fbdcca4..0643244223c5 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -1911,28 +1911,17 @@ EXPORT_SYMBOL_GPL(fat_fill_super);
 
 /*
  * helper function for fat_flush_inodes.  This writes both the inode
- * and the file data blocks, waiting for in flight data blocks before
- * the start of the call.  It does not wait for any io started
- * during the call
+ * and the file data blocks, waiting for in flight data blocks and
+ * ones it starts. write_inode_now() takes I_SYNC, so the flusher
+ * does not try to write at the same time.
  */
 static int writeback_inode(struct inode *inode)
 {
-
-	int ret;
-
-	/* if we used wait=1, sync_inode_metadata waits for the io for the
-	* inode to finish.  So wait=0 is sent down to sync_inode_metadata
-	* and filemap_fdatawrite is used for the data blocks
-	*/
-	ret = sync_inode_metadata(inode, 0);
-	if (!ret)
-		ret = filemap_fdatawrite(inode->i_mapping);
-	return ret;
+	return write_inode_now(inode, 1);
 }
 
 /*
- * write data and metadata corresponding to i1 and i2.  The io is
- * started but we do not wait for any of it to finish.
+ * write data and metadata corresponding to i1 and i2 and wait for them.
  *
  * filemap_flush is used for the block device, so if there is a dirty
  * page for a block already in flight, we will not wait and start the

---
base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
change-id: 20261029-fat-flush-isync-ae828e018ee0

Best regards,
-- 
Bryanna Marihugh <bryannamarihugh@manhattantech.edu>



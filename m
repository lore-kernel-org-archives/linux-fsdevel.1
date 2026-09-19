Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6B33164B7
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 20:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789849257; cv=none; b=gWRYzE3voN5hziAkXZiQJ6akAcnzJV2yiIdGHCq/blEDx4L/v2gQDSwMnr2Us2bxmmvn/h+ncwVXUvn7ZtRKhnHkWu4k3rKUeIsTwnxOgOGxWYOrfSkHF/sEF8WkOjf/VRa/IlNUsm7PHMvdAFJZW2pDc75GCuAGBKD7EY/a8R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789849257; c=relaxed/simple;
	bh=9tXgFRdGNbY568yh3mm8gcBNUYcrFVVuPwDtoorSm9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p3W0ii8jY444cVnmxNUSf/2EW0OKo1Tw34pYgRIoqAvIXJ6dpnpE4Hsd0T1YkzTKuXOlPFTvmPHK/5KVRhzZr0aslv/SvCWHc1nbROcgqnAoxc6BB9uuNEO7pZkmdgQMER5mJ8Zce0tz8KRoMYaVArVrm/dgAgD+o1yOtyokJik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpVjX1iA; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpVjX1iA"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4d04d740cso1119869a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 13:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789849256; x=1790454056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LpJqRoGvSP4j/JMvJGn7hs5Aen0UlxRTT14Hmtdeid4=;
        b=bpVjX1iA1TilQ/IdUW+eBOQRd3z+YhAKGfUPCUKhVc169eseE3z4XlrUDyVwzFR8mO
         eCD+RQ8jCSmuyN6It8q5YPNJ4ub+vzKvBsEmk/X52qyqLWdrpq4dQjGniKDK8AWgBTAC
         b+LqvdKVcNsHpVpiEmHzlNnAYpQAxoe56PFwBFOwlHwSWM9tiMiYLBr7OE+6SUU0mzwv
         AVyPNxn2/x0QsXRrWeT9ab/SCtmIagVL9Cvc/ErCIYm+gvAQsSta3dH+m3RVAALHBnMc
         66YyZ9ipVtJiYWF9YgIq0MPHwn1rqe8jpwn2ttFPgJ+Pqe30bbR2J99TFkztssH4Jpjv
         C7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789849256; x=1790454056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LpJqRoGvSP4j/JMvJGn7hs5Aen0UlxRTT14Hmtdeid4=;
        b=PXOZhxNs66D6ATVIIdsdErxoSgdu7sSsu+0aLnFIy65W5KxMjoPZ0FRCbq3aBHLStZ
         JcDpY10l37lzIGD/5bqarrugnFsOyHrV0cyJhHj5uYFCVSzWKo9pnhJqOEjQit4htxTd
         /HwVrhCYnlD9ZovM3DPAkxGRUMViABd67nPqp8VQUmTAe7qlxUfmYHClP/lij5/Et0pO
         bfzzPXWoWMra4J37nvrA+qKZ4Aiail3SLX2NR1yRYyjY7Uyhlh1zjZQaW9Hdu8YucwBt
         oJKRCPIxNcCpkUFwX/LMIJZb6rJ6i8bhJFK+5LbAGkM+MG+ZnGrg+4wWq/oekzUJnvMb
         Bz/A==
X-Forwarded-Encrypted: i=1; AKwUvBx/SH0uZUI+HbA+7DTnlr/uQ+OCRaP+AEO2F7bO5BjRGGwjdOkf1uLyzhTnBiboxk2tnIgyvM3vTgej/mzW@vger.kernel.org
X-Gm-Message-State: AFuF++mXhzV4vMuPBM+24JoUQSBFfSvUuExotcvwV0Fk21kVqpzYek2e
	UGiN/1Kih78+GaS50WkadOPC7NdR0n8u9KPZyn8GZcFVXihFxQTjfOTz
X-Gm-Gg: AYBFou0LGBslHZV76mh5BsWmbqt+EWc9vF/eqJvI03I1+AvYGIzt7uIzUEUKV98epy2
	rzhq/nzTHj7loixGLKEmkEaVzwzumv5IvzQbdMYnVUcl7nOubIlS86XsSdGt4LLhu7iPHlAAtyd
	Cf+Ai+6agaT4TaCXpGRuB7kesZDulEWnNwfXdcOdZao1Bgu1K7WAYH+SYzgB4xqQFPpDgZPwB4o
	W5udw8LYOQSLKZbAbEq4aNcAhyAVwreJZKiNrGLTogE2r85owg68or4PgDxcojJdWQVq/+6v+0i
	ErfeVN9+UqXWbjybaCDGwMmBIA3lvLY0g67opYC9jZwWPoGVAvxAE+XnZIs4p7ytO2cyvdJkt2H
	bxAWJ4rrKXstPz+9QQEkjIBhYFvjUw7V4ykPho/SoaGPnA2z6Jn4LKxrWzd4a12pQGdPE0rfXFZ
	bbXP6ZgsgL7DWDQQYU9Qqg4Y2Cg38AbJe2MrCbajSPNpgGVKldzHMqv6WkEK6Yf/Tb5uph/Inxx
	P6OPOlANliq42SMn9Jjawi1dbmDSi4mcxjSt5c3TZEtXaHRdM0v5TcIUYHGy349zXwRsNiyjX5V
	jmqqWr+LIQ==
X-Received: by 2002:a17:90b:586f:b0:39e:6a81:f34d with SMTP id 98e67ed59e1d1-39e6a81fcedmr5281928a91.39.1789849255516;
        Sat, 19 Sep 2026 13:20:55 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6cb400c3sm5950593a91.17.2026.09.19.13.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 13:20:54 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Bob Copeland <me@bobcopeland.com>
Cc: linux-karma-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] omfs: fix inverted check and use-after-brelse in omfs_dir_is_empty()
Date: Sat, 19 Sep 2026 20:20:53 +0000
Message-ID: <20260919202053.2435593-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

omfs_dir_is_empty() scans the directory's hash bucket table for an
occupied slot (~0 marks an empty bucket) and then returns:

        for (i = 0; i < nbuckets; i++, ptr++)
                if (*ptr != ~0)
                        break;

        brelse(bh);
        return *ptr != ~0;

That return statement has three bugs at once:

  1. The sense is backwards. Its only caller is omfs_remove():

         if (S_ISDIR(inode->i_mode) &&
             !omfs_dir_is_empty(inode))
                 return -ENOTEMPTY;

     When the directory is NOT empty the loop breaks on the first
     occupied bucket, so *ptr != ~0 is true, omfs_dir_is_empty() returns
     1 ("empty"), -ENOTEMPTY is skipped, and rmdir unlinks the directory
     while leaving its children allocated and unreachable.

  2. When the directory IS empty the loop runs to i == nbuckets, leaving
     ptr one u64 past the end of the bucket array - which for a standard
     block size is one u64 past the end of bh->b_data itself. Both the
     out-of-bounds read and the emptiness verdict then depend on whatever
     sits in memory after the buffer.

  3. Either way, ptr points into bh->b_data and is dereferenced after
     brelse(bh) has dropped the buffer reference.

With KASAN enabled, rmdir of an empty directory reports:

 ==================================================================
 BUG: KASAN: use-after-free in omfs_remove+0x265/0x270
 Read of size 8 at addr ffff88811a145000 by task init/1

 CPU: 1 UID: 0 PID: 1 Comm: init Tainted: G    B D  7.3.0-rc3 #1
 Call Trace:
  <TASK>
  dump_stack_lvl+0x70/0xa0
  print_report+0x153/0x4c6
  kasan_report+0xf1/0x120
  omfs_remove+0x265/0x270
  vfs_rmdir+0x2e6/0x810
  filename_rmdir+0x3bf/0x530
  __x64_sys_rmdir+0x4b/0x70
  do_syscall_64+0xda/0x4b0
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
  </TASK>
 ==================================================================

All the information needed is already in the loop counter: the directory
is empty iff the scan reached nbuckets without breaking. Return
`i == nbuckets`, which neither touches the buffer after brelse() nor
reads past the end of the array, and gives omfs_remove() the polarity it
expects.

Fixes: a3ab7155ea21 ("omfs: add directory routines")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Note that nbuckets itself is bounded: omfs_iget() sets inode->i_size to
sbi->s_sys_blocksize for OMFS_DIR inodes (not from the on-disk i_size),
and omfs_fill_super() rejects s_sys_blocksize < OMFS_DIR_START, so the
loop always stays within the single block read by omfs_bread().

Because bug (1) causes rmdir on a normal, non-corrupted filesystem to
delete a non-empty directory rather than return -ENOTEMPTY, this may be
worth a stable backport even though I originally hit it via a KASAN image
test. Left Cc: stable off for you to judge.

diff --git a/fs/omfs/dir.c b/fs/omfs/dir.c
--- a/fs/omfs/dir.c
+++ b/fs/omfs/dir.c
@@ -232,7 +232,7 @@
 			break;
 
 	brelse(bh);
-	return *ptr != ~0;
+	return i == nbuckets;
 }
 
 static int omfs_remove(struct inode *dir, struct dentry *dentry)
-- 
2.43.0

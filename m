Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B4225B091
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 08:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790411722; cv=none; b=glKz9t3vnJE2/AYc1ExWWRXdhBvlbCAqWofOkC0nX5TAgdxdyn2q8X1MqZIkmTGbJ4o7xpH0NiEtsfKLKdlaoW8+Am6ZqNS8UOBqezlOzHi/Ox78STnCqTu0teI4fxfPojKsg3lpsyUhnY+7O8th33g8Vl1k5AG34wuyRRmSr+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790411722; c=relaxed/simple;
	bh=gD2nzsQEzocl8bIn/g7qzCa0+g5MyaOadrenMGGgIGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxePtrV3uS+uyvtSxHM+pxvKNsAUiV4AnVeK7+zn0iw4T3knPk45tY5L6SNmhzDvaQ6y1wHRhNThCp9GYNajCVbay+i0rx13ZuSza0Pk1TOa4ZMM3NmhjZ44Upm687KapJ8KIwrBUBHUPWiBh9BSybUBP+SWiSpn3aMte0cnhQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hr8bm1Cu; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hr8bm1Cu"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccda24a3so947142a91.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 01:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790411721; x=1791016521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QeKCQ/Vusfa8g3872G9mv1JHH4KuNXooSO8a1iwRbXc=;
        b=hr8bm1CuueqeNYBTXg4iKRjQIt/4y44NvbjGK5gG2AUmtxt9WZdTbWFaT4D+/gIMXo
         /+jQjvrUruNk5MsRMOt9xGGIcfV4DNnUUayrm0ZZW4H0BMVT2M18jSOn0uHBtBCY7MHp
         ve/4dHRLnS6xHhIl8wOmIDi3z/WHCBYBUMRDKeeL+nUaioktdOZP7Q7NkNE6Nc8C6DbU
         Hwenr56pfasEdEUQv7ijaftW5FZhuEWC6/kosYRzhKp0I2og3K+qPvLyxarnuX5eTSfj
         R8LuFWL+6yMIoSriJbCKVL9IYazCXP//jxg7i+U/0sjxLcDblpKGt/jw2F0LmSqSXtzc
         b4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790411721; x=1791016521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QeKCQ/Vusfa8g3872G9mv1JHH4KuNXooSO8a1iwRbXc=;
        b=f0s5g/bKXwSS9sVolI2hA4BQptK6b2cUaAT3In4LdCyYY5lkW+FGRNnZ90u7VycxlK
         hktTafteyPUFPYS8XanUrM90BGiJwzAyhoxVBkkjyDiKCHtlmlXJ3qadbYET0d8bfjkM
         pBmtXqPQJiPl5XOvlQVn6U8jb7rerbQpy714QUCYq4d/wDoLXzVFBGU0tMZJqHlp2mga
         Vlo5yXK58HQlviA8Of1XZYEa+WbcxzZpfsryKqXEdqjQw/qnacG9pdOe77jJaGjvOGfh
         GZrsrz42awfQtqjux/sFt0K0GAs5qRCjdXUt6if5eDV7QdKr+6ev0IttbpiIKnF566WY
         cLCQ==
X-Forwarded-Encrypted: i=1; AKwUvBxgQzP5OwG8jNaHfY90GKrGZLVOlsLVZWZ/vmya9ePSnthHnfZdp3WaQ+VSolGH0sIdALxS5/mtl752KjGl@vger.kernel.org
X-Gm-Message-State: AFq9FYLePVeeK9FLvCELXct57ixQlIJdZ4s9LxRGn+HPwsPzRceRLLdI
	Z/q1KYPf/uBN5T7Wz/NDdibTzPqJLHgAHZJS4J5iq6qHkSt/wLc0lb7N9BOuhuqt7p9SBH93
X-Gm-Gg: AYBFou14iDjFMwMrY9KY3/6omuSubqDdaXxMKuQxfqElzKYuuwBjbrqiZEg7RzQUOBN
	6hYSTzL8zXwj7+ecg5oIihP28dmFYWjGR7nAYtv+pipiaUoX3A1t+dsbbU+ppGzs9Gga75KnEro
	pgVyvQmSwFJ+jM7LXMuFq/AKrKKHeNvKYZfqWEXk1uhXR8uZpCecrBiTfXmF3Gwe+k7HhTF9PL+
	6nxT43NvyAqUbr2hOJcGF4+7GGxQdr99IkrFFv1+vaD9dueJZTg0FJby/iE8xsqcf60Bu3ak6sk
	PhoSMMKZirImeU6GaH5GXUumOnRW2KbaqHqeThHS7DXdCQcDhp5JAA2PbjdmzOfxtNqpuYWXiUn
	EYum6pIgPaX6RkPfAFTepexAh8IzmREHA28djfCCrKjxD040S4iU4m1X6abh3MApL3BJ0pQct2B
	uRbH62ynisPlz0pOiE3bY/aXBnTzAGTqpzcjGfRAY2g6J7R7AVtQLFIGEagHdS2Qa2eECnPMKts
	2hKopj1v9Ykz+RvbuHxMOpecnCSQTQpisOiD32niyIvejs1DcO8KFvkWWwi73AYE2ASz0YS4O+y
	7TG6aPvfUGf5UBA4b9cKH+oMgKC05HA1YDD1ZJ8VwSxoBrQoEGkKv7zZibKhv6Blqbq3gw==
X-Received: by 2002:a17:90b:518c:b0:3a0:dbfd:1a1f with SMTP id 98e67ed59e1d1-3a0dbfd269bmr980053a91.25.1790411720661;
        Sat, 26 Sep 2026 01:35:20 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a09766210bsm14697952a91.8.2026.09.26.01.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 01:35:20 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Hui Peng <benquike@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] isofs: bound empty directory blocks in isofs_read_level3_size()
Date: Sat, 26 Sep 2026 16:35:17 +0800
Message-ID: <20260926083517.556576-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cmlro2xzle2aa7ebflvxhbcv74mea7p6qvxhin6egpdvyzyuxh@s45tpgxdal3n>
References: <20260919222553.3792320-1-benquike@gmail.com> <20260923175215.1577791-1-matthias.goergens@gmail.com> <w3rnunloyshklgq4ocr4jsullzhaey6u7odstfoyhd4usbfppo@m33jyem5jgrf> <20260924151356.3287733-1-matthias.goergens@gmail.com> <20260925043804.2091174-1-matthias.goergens@gmail.com> <cmlro2xzle2aa7ebflvxhbcv74mea7p6qvxhin6egpdvyzyuxh@s45tpgxdal3n>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

isofs_read_level3_size() walks the sections of a level-3 (multi-extent)
directory record and, on a zero length byte, moves on to the next
block with no limit.  A crafted image can put a long run of empty
blocks between two sections of a multi-extent file, and the walk reads
every one of them before it gives up, all the way to the end of the
device if it has to.

Real discs do have trailing empty directory blocks, written by tools
such as Easy CD Creator and Nero, but always at the end of the
directory, never between two sections of a multi-extent record, so
they do not exercise this path [1].

Jan Kara suggested treating an empty block like a section: count it
towards the existing 100-section limit rather than adding a separate
one [2].  Do that: both the section count and the empty-block count
are checked against their combined total, so neither one alone can
reach 100 while the other keeps growing.  Only a zero length byte at
the start of a block counts as an empty block; the same byte later in
a block still just ends that block's records, as it does today, and
is not counted.

Hui Peng's earlier patch for this function added its own, separate
limit on the number of empty blocks [3]; this uses the combined limit
Jan suggested instead.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>

[1] https://lore.kernel.org/all/20260925043804.2091174-1-matthias.goergens@gmail.com/
[2] https://lore.kernel.org/all/cmlro2xzle2aa7ebflvxhbcv74mea7p6qvxhin6egpdvyzyuxh@s45tpgxdal3n/
[3] https://lore.kernel.org/all/20260919222553.3792320-1-benquike@gmail.com/
---
Tested with fs/isofs built as a userspace program under ASan and UBSan,
and in a KASAN VM on Jan's for_next:

- The real discs from [1] (DM_BXL2, Comdex_05, ITSOFTCD_39, each with
  trailing empty directory blocks) and the level-3 images from the
  earlier patches list and read the same with and without this patch.
- A crafted multi-extent file with 150 empty blocks between two sections
  now stops with "More than 100 file sections/empty blocks ?!?" instead
  of reading all of them.
- A crafted file with 60 sections and 50 empty blocks interleaved (110
  in all) is rejected; without this patch it is accepted.

The image generators are at
https://github.com/matthiasgoergens/linux/tree/reproducer/2026-09-26-isofs-empty-blocks

 fs/isofs/inode.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 184350d2e6ad..e884618c0c53 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1175,6 +1175,7 @@ static int isofs_read_level3_size(struct inode *inode)
 	struct buffer_head *bh = NULL;
 	unsigned long block, offset, block_saved, offset_saved;
 	int i = 0;
+	int empty_blocks = 0;
 	int more_entries = 0;
 	struct iso_inode_info *ei = ISOFS_I(inode);
 
@@ -1202,9 +1203,14 @@ static int isofs_read_level3_size(struct inode *inode)
 
 		/*
 		 * If we are at the end of a block (or at its zero-padded
-		 * tail), move on to the next block.
+		 * tail), move on to the next block.  A zero length byte at
+		 * the start of a block means the whole block is empty;
+		 * count that towards the same limit as sections below, or a
+		 * chain of empty blocks could be walked without bound.
 		 */
 		if (offset >= bufsize || de->length[0] == 0) {
+			if (offset == 0 && ++empty_blocks + i > 100)
+				goto out_toomany;
 			brelse(bh);
 			bh = NULL;
 			++block;
@@ -1233,7 +1239,7 @@ static int isofs_read_level3_size(struct inode *inode)
 		more_entries = de->flags[-high_sierra] & 0x80;
 
 		i++;
-		if (i > 100)
+		if (i + empty_blocks > 100)
 			goto out_toomany;
 	} while (more_entries);
 out:
@@ -1245,7 +1251,7 @@ static int isofs_read_level3_size(struct inode *inode)
 	return -EIO;
 
 out_toomany:
-	printk(KERN_INFO "%s: More than 100 file sections ?!?, aborting...\n"
+	printk(KERN_INFO "%s: More than 100 file sections/empty blocks ?!?, aborting...\n"
 		"isofs_read_level3_size: inode=%llu\n",
 		__func__, inode->i_ino);
 	goto out;

base-commit: f622f21cddacf8a0ef3b0344382924dc52c72a72
-- 
2.55.0


Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0364E3976A1
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 10:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776680362; cv=none; b=Z2HHzZZYRJZ68LstGc3oEf8EUsHLbxwc4QDqG+OuIYdLHZNLswDB/6JlQ/gV5Dh1TRwNymb1vSiDD3G4pKSMQNU1aZgjxh0pYL2KuAT6lWLPC17PDZe3IOvxbYbl+cmZXARzkAKW8fA9JJE0iUp+5FPqN2yObZFG0BYrglcds+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776680362; c=relaxed/simple;
	bh=uB72ztNNSNFG0oCvDwY6IFaQpKhwo1oZ69iKOks75ps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jy55ooak0EB99jpLgUnqf+h/exLeokwTqFzJ39uwzIzwH1vSvo5If0qiWI5RnrEegcPowfYvrVRP6v3TmSzesBo/b+XZt0yPU+QYT/ZvwcWRAphMF78nWyzPOZZryoVmH9jm+GKox8aMjg2OCmDl/PEqp01Pdy9vNcCwTUaCt44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=I9O1KY+k; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="I9O1KY+k"
X-KPN-MessageId: 3af41678-3ca2-11f1-b185-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 3af41678-3ca2-11f1-b185-005056abad63;
	Mon, 20 Apr 2026 12:18:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=U1/E4oDPIfTo8O/8FO/2Z2rwqpCusEwuYG+K1GOPmqI=;
	b=I9O1KY+kD+I18lDf3HUwcZ5g1B4hpnQSplXdTW/loYFJe8l2TE6P6vNC6zWxc6X3YWuLF3OAH+JuF
	 CbfnsjjbhOgcZEMVl7tM+49MZwsAmZj1kuvEjAYeIeowrqL8mFBw145BljSBNtLLda+FFYWI2nDwzI
	 DNO6VTEW10ZM4FOUhE5PWjscniy/awO9qxEm3BbA4Pz/nrhnLePXW/XTV/P7k/Zu02P68qoPK4FcY2
	 /wjJP9DCrRPF4QBHBtZo/lzD5CdLRW5TVr22oOJuyxbOgwRkJwbb+Da9sALObbdyOFwvknVRtzMYGX
	 ae0WgNXj6HPOm9uvi5vlPxNmNeEhJ5w==
X-KPN-MID: 33|JNNZ2kpmCnGWgoCADazWLKtL0Z/UJCPkwheAm9a4pOKXj696xxtvns0IYngt7eo
 ja/qZ1y0hWeAfEFq1ncS1knnM2HXicu+jIW9TGWbImuI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|e5l8tZh43+29nou8BtEz7MbcEhdohz4uKEEl0xtU23Z8GeFYYI5FhgwZypCA/cR
 RXTShsPPGJmrTgM5/vQbI8A==
Received: from daedalus.home (unknown [178.227.109.30])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 38829507-3ca2-11f1-8011-005056ab7447;
	Mon, 20 Apr 2026 12:18:09 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: gregkh@linuxfoundation.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: cmirabil@redhat.com,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] vfs: remove always taken if-branch in find_next_fd()
Date: Mon, 20 Apr 2026 12:18:01 +0200
Message-ID: <20260420101801.806785-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

find_next_fd() finds the next free fd slot in the passed fdtable's
bitmap. It does so in two steps: first it checks whether the bitmap
has a free entry in the word containing start. If not, it looks at
second level bitmap that registers which words in the first level bitmap
are full and then looks at the first level bitmap at the first non-full
word.

In the current code the second level lookup is done by:

  bitbit = find_next_zero_bit(fdt->full_fds_bits, maxbit, bitbit) *
    BITS_PER_LONG;

where bitbit = start / BITS_PER_LONG. However, in the fast path (first
step) we already checked the word at bitbit, so we can skip that word bit
and start at bitbit+1. This also means that we can get rid of the branch

  if (bitbit > start)
    start = bitbit;

since if we set

  bitbit = find_next_zero_bit(fdt->full_fds_bits, maxbit, bitbit+1) *
    BITS_PER_LONG;

the reassigned bitbit can never be less than

  ((start/BITS_PER_LONG)+1) * BITS_PER_LONG > start

So the branch is always taken.

Obviously the reuse of the variable name bitbit (and the name itself) is
quite confusing, so change that as well.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/file.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 384c83ce768d..b7b78efcb0d1 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -544,24 +544,23 @@ struct files_struct init_files = {
 static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
 {
 	unsigned int maxfd = fdt->max_fds; /* always multiple of BITS_PER_LONG */
-	unsigned int maxbit = maxfd / BITS_PER_LONG;
-	unsigned int bitbit = start / BITS_PER_LONG;
+	unsigned int max_fds_words = maxfd / BITS_PER_LONG;
+	unsigned int fds_word_idx = start / BITS_PER_LONG;
 	unsigned int bit;
 
 	/*
 	 * Try to avoid looking at the second level bitmap
 	 */
-	bit = find_next_zero_bit(&fdt->open_fds[bitbit], BITS_PER_LONG,
+	bit = find_next_zero_bit(&fdt->open_fds[fds_word_idx], BITS_PER_LONG,
 				 start & (BITS_PER_LONG - 1));
 	if (bit < BITS_PER_LONG)
-		return bit + bitbit * BITS_PER_LONG;
+		return bit + (fds_word_idx * BITS_PER_LONG);
 
-	bitbit = find_next_zero_bit(fdt->full_fds_bits, maxbit, bitbit) * BITS_PER_LONG;
-	if (bitbit >= maxfd)
+	bit = BITS_PER_LONG *
+		find_next_zero_bit(fdt->full_fds_bits, max_fds_words, fds_word_idx + 1);
+	if (bit >= maxfd)
 		return maxfd;
-	if (bitbit > start)
-		start = bitbit;
-	return find_next_zero_bit(fdt->open_fds, maxfd, start);
+	return find_next_zero_bit(fdt->open_fds, maxfd, bit);
 }
 
 /*
-- 
2.53.0


Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3129A3B3888
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 08:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783326961; cv=none; b=hJMq6njCQJyQo1olzewPahD2zKNZiDHagJ0yMRmzFT22XGVk7tSd5tPlffCh6Jfg1aDOhqf2PN1PVpg08UsdYhz+gxWAKujto1R59zZhQSkcUwGxXcl872X++klmfPeI47c9YzoogUzvw3+3hW3RgQY1hYEovjBdRlPIQ9KkBN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783326961; c=relaxed/simple;
	bh=N/hXUKDFTtzj092Go8yLO/kZjznf4SO/lsSm3Dn0G9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UmFyYIwSiMzA25E78MduTz+061Vt3itk/3hozyLdRlU65eWirrxtXpTilTuSdJ2T9rTUmFnOEmIK1UvXv4M31vDS61sbEO5M2F6dF8aj01jUjGqpEW5kIZirgLqjvbNgUPu4cycoAjOW+irJMo97FBZ2CfZVz4hCpI9efM00mBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWSaUzaZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWSaUzaZ"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cca24023edso8580795ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 01:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783326946; x=1783931746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7p60FQdKaKNOxLAc40FMD98dlWIjxkI8C1nOoFeA1CU=;
        b=KWSaUzaZ5PCnUY5EXybOCyIBq7W2gCpjQygTPADXZaz4rw6C0k0dBCHGccn5LZcsZF
         XW6gdOMzs7x5suzQg8DGhUoL9xNKsKjpjT93YhrFKAYDjl57nmkaHqDJLA/kRc6hnNa0
         k/XqM7eQeLsmtNnMIe17wvlpAZDm+m8ugv3GTlA0hr0ZTlcN5HxNCahtynkq9IL7u6mv
         B4sCNaZZiPE90d26ESDoxdT/MzQP5Ynm+4H9hVJ7EsI4AtFBUBIECh5T1BUMrjbl4zvq
         KNNySBHM0bPBYU6GBiVY7Vf8DLIllavfLTDN0+BnvJrPafD34Q1Vy0oVayHDURAoFHey
         uPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783326946; x=1783931746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7p60FQdKaKNOxLAc40FMD98dlWIjxkI8C1nOoFeA1CU=;
        b=GT5ceuuLfS4SRYMXl1m9ttPOMQ55uQG0163H7K1Dbza54olRzZd4WOWy+jwYGLo6Y3
         ETvdkIlHD0fHAid7nfIis+4QQoymbVeMr8ik3FEUeUE3cLcE+Vb/okDFqfbwhjE3rpuJ
         HxBZITAGOlby3cfY1dImmmcmWpCqw+dwauv9HUAu6s7gOIhwWXZOzvA8Nyi2r5rQOLug
         vpu+HcihEizuIuMqK9TXkpQmXodLgwwpd6JhXO9fZFv+usjrL+lQiGCAIaxoY/oeiQop
         td74Svdc5To9UDW8uFRByz9QV6EuwHiQKdMZKXy0PL29yu2sDnKSM1sx/SfePgnSjLJn
         Ytlg==
X-Gm-Message-State: AOJu0YwLhY27N2cKtnpXhUuM3/4g51521HGqv1rO+6b1W8pCOBMJbBha
	Su5w2Pf+LBdzS9y3lVPquLGj7gw/qIDrCaFB4YU8se8xs+Wr75s9x5g9F4zrFQ==
X-Gm-Gg: AfdE7clVnRxcN8e+KoHtvSICywYEyIQeQg5yNETD4qTxn/zwWGVx+nsWhmROeNrkNne
	/QOWC28o7M9iSzFYAtok0LGdcRrB7zLFO/9S6USZwZz7XeBZn3Gwr7/bLs4NOB6NZwBO/4P5oxS
	9WXknTUbRXF2Js9XBsQnsPYxutdRzmxAtPGz8B/uN1YojCGpftRo1ZEeWDnOM3s+GDnyC44jkoD
	6V2RjX8zMOdFZ6NL9SxdlkHu261+IjRgDQAkDvXBxSz/SpywwWFLCqV2scrHxOzswzjt4DHLdQ9
	t7SJMMP4qqLdBNeMwgO4Y7IEkaj6tCI9HIl6kVHNlWl+HV1r6142kAVUF/LlrMrh25pX4GqNL3R
	Yzwm36ea74J9d4j3+WZ1tFK6PzzVMJotee9LmjRt7VMmM+NaMtxefvmfWf29N2I0=
X-Received: by 2002:a17:903:b10:b0:2ca:bad4:33a2 with SMTP id d9443c01a7336-2cbb9e38d70mr92253795ad.11.1783326946375;
        Mon, 06 Jul 2026 01:35:46 -0700 (PDT)
Received: from nineveh.sos.local ([131.191.24.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccb0e77725sm5109815ad.71.2026.07.06.01.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 01:35:45 -0700 (PDT)
From: Jeremy Bingham <jbingham@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	brauner@kernel.org,
	jkoolstra@xs4all.nl,
	jack@suse.cz,
	djwong@kernel.org,
	Jeremy Bingham <jbingham@gmail.com>
Subject: [RFC PATCH 0/1] minix: unify itree_v1, itree_v2, and itree_common
Date: Mon,  6 Jul 2026 01:35:35 -0700
Message-ID: <cover.1783324260.git.jbingham@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For as far back as the git history goes and then some, minix's itree
functions have been split across three files: itree_v1.c, itree_v2.c,
and itree_common.c. The first two of these files had defines, types, static
helper functions, and some wrapper functions tailored for version 1 and
versions 2 and 3 of the Minix file systems respectively. Each of these
files then included itree_common.c.

The reason for this odd arrangement is that there are some stark
differences between version 1 and versions 2 and 3 of the Minix fs.
Version 1 has doubly indirect blocks and 16 bit block pointers, while
versions 2 and 3 have trebly indirect blocks and 32 bit block pointers.
By having the separate itree_v1.c and itree_v2.c files that then
included itree_common.c, DIRECT, DEPTH, block_t, and Indirect could be
defined differently for the two broad types of Minix filesystems while
sharing the bulk of their code because the same code in itree_common.c
would be treated differently by the preprocessor and compiler depending
on which file included it. In other words, DEPTH could mean 3 or 4
depending on if it had been included from itree_v1.c or itree_v2.c.

This whole thing came up while some patches I submitted recently to move
minix over to use iomap were being reviewed. Having the two separate
code paths and includes made that task much more difficult, and a
reviewer commented at one part about how it was one way to avoid keeping
disk geometry information in the superblock info struct. Parts of this
code do not seem to have been modified for a very, very long time,
possibly since 1991, but that's no reason necessarily to keep it in place.

This patch unifies the two code paths previously used for itree
functions. Most of it runs the same no matter what version of the
filesystem is being used, but in the places where it doesn't version
checks, information stored in the superblock, dynamically allocating
formerly static arrays, careful pointer casting, and judicious use of
accessor functions for more type safety handle the different cases while
still keeping the code more contained and hopefully less confusing to
others.

As this is an RFC patch, there are many more comments explaning my
thought processes and what's going on than would usually be found in a
kernel patch submission. Depending on how this is received, I will clean
out excessive comments before submitting it for real.

This file unavoidably lands as one relatively large patch, but it ended
up not breaking down well into smaller chunks that would still build a
working kernel.

Jeremy Bingham (1):
  minix: unify the v1 and v2/v3 itree code paths

 fs/minix/Makefile       |   2 +-
 fs/minix/inode.c        |  35 +-
 fs/minix/itree.c        | 744 ++++++++++++++++++++++++++++++++++++++++
 fs/minix/itree_common.c | 374 --------------------
 fs/minix/itree_v1.c     |  67 ----
 fs/minix/itree_v2.c     |  75 ----
 fs/minix/minix.h        |  26 +-
 7 files changed, 774 insertions(+), 549 deletions(-)
 create mode 100644 fs/minix/itree.c
 delete mode 100644 fs/minix/itree_common.c
 delete mode 100644 fs/minix/itree_v1.c
 delete mode 100644 fs/minix/itree_v2.c

-- 
2.47.3


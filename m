Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270357;
	b=r5BR4RPrpmp7pF6cqe02cMwQ4aTv1DU0p4L/695wzv9CadG6pSx7YulF0gCPWYJGXWlZ
	 CnXG0nAzhTxYWOlSZMteRhbZ4kZIOmbfninAfqk17kWdRCytFqk+yXqbsf0wRd2EBRZp9
	 uWRoNIPnnyc/GfoTwlGzzO61rA18EE17pTDlYPfYbmwnNexowdP1DqX71/8CzZS55SxOO
	 QdriChHH2r1wJMWDmmtclZP2NhcsfESR1o+W0WiSqmkC1APTqdoL1ucHTd+M1KDqQ2nvu
	 AH21jJU14QXeDvrFP01o8pJ+3myxR6YcbKctTTmX+aPf/Qxi/QU7XMzDPHk94Svu45A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270357;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=JmwoDj3PG9XFrsBQzQoBbAJE6gd81sDGhucCNwLvdrc=;
	b=GzEmfcm4yxMuordr6RgvOv9BE3VTZkGsT9lGJbeRux8AF2/IMRA67HiPpl0ODL1zkM+7
	 DAZJ0J1etOm3DkqZmuj/Fa1tyoHmstjMUXsIZAclAXUJTOM7MaGtssE79m09/kiKn1RlG
	 e+gIjR6SKqHNptiHvaGgBkUA74pfyQ43+AUwWnMYbOFLqdIcSL7qPrW16sPe/MhW97ggR
	 +lZQPQNg90vg11i/IgcFCsrV7CutxClQe6rnuxw5shf8m7tVz1ffIOGt9mz5XS7LU+o+p
	 7xcM3CPUGdSMJsy0mILFexh9s2IGC83qItRMpud/LiivRVgci0ArNyQRsbKIzQE+w2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sYhw7Af5;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C15606A321
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 10:39:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28C15606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sYhw7Af5
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c3fd91337baso327154866b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 03:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793270355; x=1793875155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JmwoDj3PG9XFrsBQzQoBbAJE6gd81sDGhucCNwLvdrc=;
        b=sYhw7Af5tl2jxcMlDKlH/ulgZDSnyJq2/+3qJDDDKWLk3ngcxZY9RuHCQcZ9vPVWxH
         Daha8fqe8Il/FvYoFVRvBER+dp7uf+sgOps0B3KaL29LiYtrSdJoyv/zkIdbXycRjULy
         z4kR5Ko9mz6r+HhSg3ZZnciy7dFhLu6viFRJIqkFjdHCjAnae7QytGsh7W0OG0U3GKpg
         uebuUuT04pAYOUtkKI01Pd3j1bHI60EbEwdWW5O6IGddimZBxFeaQno4+/Vt8QJaJEQK
         JBDUx+2yD2fABfLgdUWUirW4P73smoALyJgMq2TLi7HKIII94dADbr37hnpZNd8U//K7
         gfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793270355; x=1793875155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JmwoDj3PG9XFrsBQzQoBbAJE6gd81sDGhucCNwLvdrc=;
        b=np3ZdZd3zCrQe7epaurGmdu1XrEWiKzCQWQIW2Y3Rf+GlUlfR1M08u8baNHRrSyJTK
         uhMOqbfa4JsHLKogp2b1N2JNHiFwpMFdgZhi/Zv6WiIGKsaeAJzt05U9AeiR47Ow1gAk
         OV9l+CHuDhoNZCgcjwiYgBoXWb2zfO4PkLAQyWrbOQYDTO5FRTr5T+rw4UKdLf5Nz/X5
         slSqzVOwj22MBO0H7B+RRq5biMTxUXAmlg1If+0p1MZ2HLTES/ih/BOBlRLqaqfXN589
         Xxzs+l6wU7LDSHwo/bNXdH5QxeAc0hNQSO2FKKAKWpy+zsrJGVU7pfS9jDqnXbenhX0f
         dvCg==
X-Gm-Message-State: AFq9FYK/q15NbsLSgaHQidUa4e7AKxWrqHavItpWYkecVj8PyXei/NdJ
	vXAWgCChn3giLKJdu/tIyTXAuF9bv84BTjVmR0OCY/7ipxlrK2gwUkeV
X-Gm-Gg: AYBFou2wL7T8niY0BTeXeerfkRe82sYrmfhEB7Ay6QNVLhMp/at3sCO8tJzr5ZBVbJA
	TTthp8KsZUEmPjutSciqFdB0BajbtZe2czDVrleXan6vkpMSoTkozDhworKgYQyoDFyzS83vhXE
	ZOqRrKFPrMInCZqUW/yUrmO3JqUnMhSyLks8vICdWjGSvenXnqDX9igktwREqW/732arsHmsQyj
	P7S05m4M4uhgndGZmzT6lHfiNMAFJe8Y5un9lDDxOeMaX1XS2PLasrQ3JQsQgypUw4X5DBCkRaK
	0AdAT+uP69pFFJ5fPY1nRKfAx4wTrPb6uvKLWo1Op0n2kOAaZLKAWrpU7PUZ3Ittmqw28CFcFzt
	3GUHX4KN6DbU6V5guVTb826/rKRGy5JJFV3QPe5Mm7l1nd6BkF1BA91i4/dRXonoWZId80SS+sZ
	Q5tCaMjP6Bo+B60FRt5y8L/ZbvOMR21QB/l2rztloVok7aLa2QC3ll2rjwJ4WP7qATjxiQ05dvz
	b+61rl5iHYGXNo9j2ZuXmwGqwb8oqGPuSJz2gcReJoV+4SsD8h+oqRwGHBkI+C7avHL9pJPCeag
	GdkTEU0tkUGsQKCTV7tQsxy9QZFIgMuIpSzjjQNqYFGO13vlj4wdq06+80a9/Y9l3wNXwrvVKVu
	4zmra/FKvJv96ZmwyORQOVhwjJtPfAcKr
X-Received: by 2002:a17:906:99c1:b0:c29:22cf:b0f5 with SMTP id a640c23a62f3a-c49bdf39ecbmr404107366b.33.1793270355081;
        Thu, 29 Oct 2026 03:39:15 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c49954c8ff1sm479288166b.78.2026.10.29.03.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:39:14 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev
Subject: [PATCH 00/16] Overlayfs fixes from Chris Mason (batch 1)
Date: Thu, 29 Oct 2026 11:39:04 +0100
Message-ID: <20261029103913.2785828-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Hi folks,

The following batch of patches is part of a collection of overlayfs bugs
reported by Chris Mason.

These bugs were found by Chris' AI code scanner (kres), but underwent
extensive manual auditing and filtering by both Chris and Josef.

I thank them both for handing me a reasonably sized pile of patches,
most of them important, correct and ready to merge.

The patches selected in this batch were either simple enough to merge
without questions or important enough for me to invest the extra time.

Patches that I changed include a note [amir: ...] with my changes above
my signature.

Notable changes from Chris' version:
- Include "fortify ovl_copy_xattr()" and "assertions in dir cache"
  patches already posted publicly for similar reported issues
- Use LOOKUP_EXCL in "do not copy up a dentry that was removed"
- Add vfs helper try_take_dentry_name_snapshot() instead of open
  coding it in overlayfs code
- Fix for empty security.capability from Josef adjusted and rebased
  onto "fortify ovl_copy_xattr()" refactoring

This pile applies cleanly and was tested on top of 7.3 and on top of
master of the moment.

Backports down to 6.1.y are either trivial or already prepared in
my local tree. I will make those available to the stable maintainers
after upstream merge.

PR will follow soon.

Thanks,
Amir.

Amir Goldstein (4):
  ovl: fortify ovl_copy_xattr() against underlying layer modifications
  ovl: add assertions in dir cache code
  vfs: add try_take_dentry_name_snapshot()
  ovl: skip copy up of empty security.capability

Chris Mason (12):
  ovl: do not copy up an xattr value that was never read
  ovl: set OVL_WHITEOUTS before publishing the upper dir
  ovl: check that the parents of volatile/dirty are dirs
  ovl: take a snapshot of the name for copy up
  ovl: do not take a name snapshot in RCU walk
  ovl: use the pinned upper dir in ovl_fix_origin()
  ovl: hold a reference on the parent in readdir
  ovl: do not copy up a dentry that was removed
  ovl: fix a torn path in ovl_get_redirect()
  ovl: read the nlink xattr of every indexed non-dir
  ovl: always encode the origin fh when index is enabled
  ovl: set the revalidate flags after d_instantiate()

 fs/dcache.c              |  29 +++++++++--
 fs/overlayfs/copy_up.c   | 110 ++++++++++++++++++++++++---------------
 fs/overlayfs/dir.c       |  22 +++++++-
 fs/overlayfs/inode.c     |  14 +++--
 fs/overlayfs/namei.c     |   8 +--
 fs/overlayfs/overlayfs.h |   8 ++-
 fs/overlayfs/readdir.c   |  61 ++++++++++++++++++----
 fs/overlayfs/super.c     |  21 ++++++--
 include/linux/dcache.h   |   1 +
 9 files changed, 203 insertions(+), 71 deletions(-)

-- 
2.55.0


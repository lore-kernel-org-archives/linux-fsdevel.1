Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A20C3ACA51
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 18:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200911; cv=none; b=lJAYvr5ipoD/G0sPamrHG6qhd+qzkZm+UlDbdg7VlaAFqsYwCSoC9U7xKDq0z/BH56bqiskDzsP924i3mf5Zik7p7p8zfH2sTQx7DvJSB5mHpHKQPgJFlwvAmwR/c3kfzv/r1d8aeTJElnVpFvQ1s7wDYfuIabeWsTHTK60tB/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200911; c=relaxed/simple;
	bh=YJFgl3FW9ptuz8HmUGhbUPk137u1ZPYL3WIVCtBVC48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EH5po8SuxR5S5SgUQzYuQQkIUjtrBsql0wlDAyGh9NmfL/ZbKswC5ecnfTHJQEoZLh0nNT290OGINFFEBjPo5048kbSHuVbbbJLgPGOx5Z2OoR5/cQWY2VZ/RfqGThcQHIRMSNfCK8mT05FKGU1cP9csCtkGM9hOJZkp9skyYPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwqLv0A9; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwqLv0A9"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45ef6565cfdso76538f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 11:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781200907; x=1781805707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zM95gdCTPVByK90i40t9RusSaC7GIwD3PMg0Thy0V5k=;
        b=FwqLv0A9H9SWXNKbfZ1xqypKD1IEPvAhcoEF6K+aOfO5mPxJCfY5eNUDRtGl96+VnD
         1pVhMJBTvK2LFZy0gG8FRxwsN4dyZAXj2WQgzkC/gu9PL0GSuElj6blRYzfN7iAwRxt4
         MKExqYG27NGsnmcbATrau63JqHM6y6D9kYbk2T4ljSFbSVj4RyCyUMyMAjf3tZoLcdwc
         yxkpg26VongrRCzU+oSazy1D6WngsncSQ3/7VCLaXty8NYToE0Vm8XrgoupBjRRjxKly
         uCiwLWf0TNRtaPTBnCo6SNwqD7oJ8FkPr1KDyRx9FrrnlCs3zddF1fOc+mJnfu0bfThH
         d3Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781200907; x=1781805707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zM95gdCTPVByK90i40t9RusSaC7GIwD3PMg0Thy0V5k=;
        b=YOZSoqmChxj2NpgMYEo+nkbeC1iwU8WWmvynccDbeNbcfg++yPEKiQ936cFIQQCv1x
         Sbiue8TJiqTza9u+JWjnmDe8BYheH339A+lR0SJ0/VWxY08YKPPk5r7AXNfWehTLQoBG
         KKLSD79NCU/GdlK5anV6U1RB7gy8rXNrvVPTGPYPOPiIje4xtiHopTy6HlqiUoRZlgIQ
         jhXxs1/PrKkz4KXD/6VOZDs5joE6mML+wbbTRI94RoZ8vNf2+SiBx85mNIg8jnUrrljI
         TD6E4pCkTBqWegqEZnD0VDCiwDFA5UhCXfuLuuNzAf98mE+qzJSheW+OrRp1/Z6p3lNX
         Fpvw==
X-Forwarded-Encrypted: i=1; AFNElJ+p/uiEj22Dhv4NRLpU4jcQ/I3kO9BfNlQNye/ktaVdBkF4VKLwaSiobxV9pTK8wBIkjlSlb8Hv/UUQ9HJE@vger.kernel.org
X-Gm-Message-State: AOJu0YyFp0YKCzvR3UrLGdZYuqhXrfLLlra56ShAn52N9KBjOOP6InSq
	6fIq5jqguoNclQXfXx6GOM0yiwKTciViGuxGbVOvro37H9MAlHLLqMSVEZAKANQT
X-Gm-Gg: Acq92OGyx1WHn80c/qxF7wNYITDz8isKI/TUp03YYsZCQ9IvR77DNQr7/YpVVTfhMAY
	P3TBCioP5nfytajOaIAgNZ9hEaLJw5rsXGRfvbZstjQLyYND9LLFZFb+ABcIXhTvfvFR2l7tQbE
	pJ6CeOzgRrM0hwo4kFoqaT+CRU92nPYqFTB51OH+mN7NS4Kppjp6HZmea+YpDsRZro89fKtSklg
	W+tL2oJX89sb2LEUVqv2YollXyqMv34jZfDKaN0gDXyVV5DV440YXHlk7SAhogwBGtUdsODQKz6
	XalpkUkCK1joM3RYi82fr5WVZ2PsGtRY/gBiWR/TC800mBb68vzjaSjObWyix45SrP1qcdOl5mw
	+tlSWkQb3n0YFjgSawbT7b8xhXIY3rSjT8w41tiQL3QVud/Jmj9pKkbuifxstWNd7XGSrVV08tH
	SkU6TRDNLJ3/bGAWEEb2wOzqKwQL3DfJN8M0ICgNqaQcZ/pXXztA9HL32+O3EhC3uN6rklmBgJ1
	DVUtt431aWBZ2JnUiCz2fLmP94X1cTaG6Zzx0CrFEc8LOPpDLw4Vgu8dABZhu8FgaTglbsDJMmd
	Z9NTpfKa9Q==
X-Received: by 2002:adf:e008:0:10b0:460:e00:121d with SMTP id ffacd0b85a97d-4606758b140mr4570744f8f.14.1781200907285;
        Thu, 11 Jun 2026 11:01:47 -0700 (PDT)
Received: from instance-20260604-012959.europe-west1-b.c.project-2c9d95d2-bf4e-4d5a-ac6.internal (250.69.76.34.bc.googleusercontent.com. [34.76.69.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606c0c9022sm679159f8f.10.2026.06.11.11.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 11:01:46 -0700 (PDT)
From: David Maximiliano Hermitte <davemadmaxxx@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>
Cc: djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com,
	David Maximiliano Hermitte <davemadmaxxx@gmail.com>
Subject: Re: [PATCH v2] hfs: return -EFSCORRUPTED instead of BUG() in hfs_write_inode()
Date: Thu, 11 Jun 2026 17:57:53 +0000
Message-ID: <20260611175753.1410325-1-davemadmaxxx@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Slava, Jori, all,

I wanted to share one additional diagnostic result from our side.

We are not HFS maintainers, and I do not want to present this as a final patch proposal. We used a small change only as a route-checking experiment, to verify whether the crash ending in hfs_write_inode() / BUG() can be prevented by rejecting corrupt metadata earlier.

The experimental change was in fs/hfs/btree.c, after reading the HFS B-tree header:

	if (tree->root >= tree->node_count)
		goto fail_folio;
	if (tree->leaf_head >= tree->node_count)
		goto fail_folio;
	if (tree->leaf_tail >= tree->node_count)
		goto fail_folio;
	if (tree->leaf_count && (!tree->leaf_head || !tree->leaf_tail))
		goto fail_folio;
	if (tree->depth > tree->node_count)
		goto fail_folio;

We specifically did not modify:

	fs/hfs/inode.c
	hfs_write_inode()
	BUG()

With the same syzbot-style reproducer and the same QEMU setup, we observed:

BEFORE / unpatched:
	boot_linux_seen=true
	root_mounted_seen=true
	repro_started=true
	VQBIT_HFS_INODE_BUG_SITE_3 line=474 hit
	kernel_bug_seen=true
	verdict=BEFORE_BUG_REPRODUCED

AFTER / diagnostic btree validation:
	boot_linux_seen=true
	root_mounted_seen=true
	repro_started=true
	kernel_bug_seen=false
	hfs_write_inode_seen=false
	kasan_seen=false
	oops_seen=false
	verdict=REPRO_RAN_NO_KERNEL_BUG_SEEN

So our current interpretation is:

	The BUG in hfs_write_inode() appears to be the crash sink.
	The corrupt state seems to be accepted earlier.
	Rejecting inconsistent HFS B-tree header fields before traversal prevents the reproducer from reaching hfs_write_inode::BUG().

Again, this is not intended as a polished HFS fix. It is only evidence from a diagnostic route check. I would appreciate your opinion on whether this direction makes sense, and whether the proper fix should live around HFS B-tree / catalog metadata validation rather than changing the final BUG() in hfs_write_inode().

Best regards,
David

Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB50318FDBE
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 11:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777550284; cv=none; b=g8EzwqLs2hTyFJ/TYUs+ix7J2l5Aer4R48pniKJHhbN9hZlB8+pX0u3fGOGKeHPx32usQC/JSTRlE9zD1z1vQ31xl679QUgFLHOCJXj8vT4TeMIynuZGdmEBk3GyH+lecR4NYV9EPC8yMVDYIsRlCL6FpUYwnEZO+MJ4lmL9KSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777550284; c=relaxed/simple;
	bh=MthpMT33XCv+n5gHHo2fASuF1na0bjoxfCIjFK3Viow=;
	h=From:To:Cc:Subject:Date:Message-ID; b=kReG2d/6H9vjUBBHXABMATqSWyq6ZnEdghKwWTe5xsTfd2RdPP1Lt0GAFszCfqm+wNTylzNuFNNExdIEW4C1EKzQzz44dymdWyLva/TyGZD708HGi+YlijgWzIAqey8uoY43FkL6kH5V0hqNLeIRJpM5iDGHGjAdGOgaG0RsC2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEpD7Tc2; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEpD7Tc2"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35d90833cacso633778a91.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 04:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777550282; x=1778155082; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rueCD1ZsgcCsQQilyqi458mm+zVO0hUPiotgswNp7CE=;
        b=mEpD7Tc2E2UoZxxhVni9NE+CMVqY2VuZMrGIltWG9k27vIUxo0S8DNCvpglX4VgYU7
         loUOb7pxrLYX9P3NuAQcB4FQcSrSTFr2cfNmSd82rVKrebO5nL7cV6yWIFBI81XWKnoC
         RpFNmosJmeu1MBbTTKrVd47t+kYtvU47uFp0/r17wjoOgK2V4aV7rAfXhx/3WhXrE10J
         WkFeaJuw+G5h+PrhQAbONi3H6JYxH45hfBfbfEsA6Jd6LWu1Eo/qGbGJL1D/rDGHyn4g
         rdEJB6iMQwKgN/hik58N7rHHizK7Lq8OHJVXZqDUGsjhYJSCwqk6E05nf5cw/2dJ7cfB
         VsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777550282; x=1778155082;
        h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rueCD1ZsgcCsQQilyqi458mm+zVO0hUPiotgswNp7CE=;
        b=GerSXal+aSr8RviBpsacpw+Mga2U0gyLIgcL2z1JTRUQzUvHLZEzLQrgMjpiiDh4qT
         yDiD9zVapRNzhWkcDRcW3tccvxicGOMTkc3RGrKupTduuuGFVPfQUS5mwBf5OjbhthXH
         ucKkqtMnu43DpxIpPFdrIMrQmA5+Xga7AWMyVTgW9I0nAhhF8C9I0U3SCYD2p+gUvqOr
         h1nIhXflYOxW3Br3WisSAB4f/dpPz0SkUjwjv3JbNjNpIVrwtlhSqJrq5zXT6shFiofl
         BSOovo+2SaCyi057kfAXoPYrQpCtA8ab+ukXFrBciHm+1q8Z5xT8eVr4J8Fonq9VNVTF
         LVFA==
X-Gm-Message-State: AOJu0YzZc+wc754XZGKRGbtTztoCvOMdrnVwu7F5a+0VrBzlOqIFYpSK
	tRsNhU1uKZoqyeUhtTuAlnx1kIjKCUWIe3CRvLOEVr53Gs3yjpqCd0ZM
X-Gm-Gg: AeBDievwMOzjANyn4Kru6UjZ4sP/5pQ5k6/BLFffKXmIC1WBloy2OXrglqtaHagGzhu
	p4z0vxE649Q1aE1OQU0bgQsU52E7DEFSnEBiqPjO6Tu3duFZ9+cXHiH5suR5f+utwW4SRPAZQc0
	h23PXyP0d0VSeHrWKADPzm0i+JyR4kuRwRRDFBJz9Px/LyP4+522DEtuvpvPC22bqFEyWceMiwq
	CzWioGX5sxx9STG1sT7hSR6BL7SSotkmNxSDsFc9R1002DoZV3ZidBe/E6jsLN476DjdkvJhpGv
	ZQzn+HziGz12zEsKg/ERXHTJ9CbLeXtXF2EgfPQJX5chrxgYgVsMbqJrKQ00OPTfrZowQRNKCVe
	x7VbW7dNK3umgbnbMSGCaduld2vBj7DziRV6VMQDe9OsMLUbvCxOWOvbAJSuAvdfxvy6NA1YuzI
	bR7YmUKFie8EyG779opajIV4tuaPPiJIsP
X-Received: by 2002:a17:90b:17cc:b0:364:919c:b52f with SMTP id 98e67ed59e1d1-364c30ff32fmr2632823a91.24.1777550282152;
        Thu, 30 Apr 2026 04:58:02 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364bdf2aa41sm3638926a91.4.2026.04.30.04.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 04:58:01 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, lsf-pc <lsf-pc@lists.linux-foundation.org>, Gregory Price <gourry@gourry.net>, Bharata B Rao <bharata@amd.com>, Donet Tom <donettom@linux.ibm.com>, Matthew Wilcox <willy@infradead.org>, Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: [LSF/MM/BPF BoF Session] Numa-Aware Placement for Page Cache Pages
Date: Thu, 30 Apr 2026 17:03:37 +0530
Message-ID: <h5ossmwe.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>


Hi All,

Amir insisted for this :)
> IOW, bring the Hallway session into the room, so that other people
> can participate and we can use the hallway time for gossip and
> stuffing our faces.

So, since we might have few slots available in FS breakout sessions -
here is something that I was hoping to have a discussion with you all
in hallway. However, I thought maybe it will be a good idea to initiate
this thread here, to see what do you think about this.


Linux already supports memory tiers and there are ongoing discussions around
promotion of unmapped page cache pages, which lets kernel do the right thing
for userspace page cache pages on a tiered system.

v6.17 added support for per-node global reclaim via
/sys/devices/system/node/nodeX/reclaim, which lets users perform per-node
reclaim of page cache pages. We also already have interfaces that let userspace
define the lifetime of page cache pages, such as RWF_DONTCACHE and
FADV_DONTNEED. These are increasingly useful because locally-attached DRAM is
a costly resource and we don't want unwanted page cache pollution there.
Userspace, sometimes is in a better position than the kernel to know the
workload's access pattern and whether it makes sense to drop page cache pages
once the I/O is done.

So the question is:
Do we need a userspace interface for the placement policy of page cache pages on a per file basis?

Note that we do have per-task placement policies like set_mempolicy(), but those
are too coarse and don't help if userspace wants per-fd control. mmap+mbind()
doesn't reach unmapped page cache. shared_policy per-inode works for
shmem/guest_memfd but not for other filesystems (I think so, but I maybe
wrong).

So what I would like to discuss with others is:

1. Is there a need for an interface that allows userspace to do per-fd page
   placement and maybe per-fd page migration?
2. Are there applications that need such an interface or would they benefit
   from it?
3. Even if applications may not need this today, should kernel developers start
   thinking about it now, before users start abusing some not-well-defined
   existing interface. e.g. the story of echo 1 > /proc/sys/vm/drop_caches,
   which became a production workload tool despite never being intended as
   one?

Let me know if people think that this discussion qualifies for a BoF discussion at LSFMM?
Or do you think it's a bad idea altogether, if that is the case - Then
please help me understand, why so?
Before starting to jump on the implemention of any of this - I would
like to gather feedback on what do others think?

-ritesh

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956473;
	b=vJjFPEJp8iJnoMuBd3gnx6mKjqe2GMbRxiCzMwBlL/GP0hHE9PMroSOLWgY41hXBOJ0T
	 tm5YZLfvyaLczXC8FZPmhTmxdAHgwR4C1mcmX3t2zkl8uL8yQ8wBLQSa+B0+Bvun24R3W
	 HddjgPNGT3EFHuZZ7n73hUVO6ecB0As0egnnQioTuOY2b5Hr7skgeFKzP1eqvje9qQB7E
	 MH2FFQAANk5o/FLnRz22pyIrSYwgX6JcRkDfxDJrLwiRcktZNb+pmBCVRuiSzlFAIDLe7
	 Jjbxg0QEe26HhQL4SmS0D6b5PqvMVvTV53vlQdfT8bit1pWmxmLpN0R3HTDCRQgnw2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956473;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hYxjyPXBHKTCAiV1LvERXcwFBgtg5JptbqNlrk95z/U=;
	b=S09iqTkfn5nyGqm+rg5jU/E+8FyrUaNGUi0kk2Mh89EiTKIOZQT3vyIVdPxvyxYy5Ys6
	 gIkhVk/bTv3bJablvhFfbVMc6rrFoOveJFwzO47z+r6vJdtRfb4Y0e+zanoMDGFHJag5K
	 WBfKYr0kazhVx6Y1o8Ubeus7DIo190Xv9J5DKRTRU+PAfDnJtFxtBb05SKpJtiXiYM8db
	 qk82ll6ZF+DVuao45yzhtk1TIS4THWtZrS72Jx3UWwH89wrxl2mJBwLgtPhn26NSR2BuZ
	 41Z9x+m+k9+1tMnzRdBjXkwzG2YiDxoMFoCL51MLs/alfisJ739kc07I4SJ+iF1R+Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E45JGGGQ;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C31606A326
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 09:14:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91C31606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E45JGGGQ
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1a3c08d6928so772167c88.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 01:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793956472; x=1794561272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hYxjyPXBHKTCAiV1LvERXcwFBgtg5JptbqNlrk95z/U=;
        b=E45JGGGQajMGTNP6Ld2aXqAex1Bp0z4/3WfJCGIeCkCkqYeHAPT2KEYuSXJb46X4hI
         PmZd6KN/KAj0NEMVL8KIVPA0zERygqfCT78iLY9tStNCqitsvYQaV8CYP7HZZdZCxON7
         +otIoJAybK/LghkuW+Zi0Bzakghw/H6iAUJvWjXZ7ggEVqDChT8uBokKdGvfYby4qzmD
         +x4Cs18jlSZ8vdUgRTrJmOPSKpeiP604r0Yajm1HuETnnK/F7dRwciVbwyLTcdXqxmY5
         Y0sXGDMTgqbHl1j/1dxJAuiY2jGZC1vwu1kldqinG8F1J5lnASCCtRwZNw1b0B0EkjAs
         tkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793956472; x=1794561272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hYxjyPXBHKTCAiV1LvERXcwFBgtg5JptbqNlrk95z/U=;
        b=bqiSXoXJPDrGFd3jPMgl0Au+6Et8XkE2toyAhAV+z34fmW7E5jYUzvtmpz6tBKpUJ6
         hwEXX2CKK8SYX6F+vtmFfbMteFRZa5XJiMdcdXzhd2y6hVMJfTbbmKHb5tBZuAEBgxzX
         j9+jiGohEpbPTEPOGH6KFyxzvjPGwzHp8gnPGlrZklYkVf84ppwVCE0rtDPttSqiEHSz
         89q9+jINWRP0oJ4wArSnfv5CRHbE+XFdydXNK7TSOIewM35ysYGT6Cac6fuUPhs1aKiw
         6HQbdQtRUJVJ1J4x5MoNO8snToKunPg8KPoS57p3rj591xnY0OByDyTyzmaDsHFycPR2
         zPJQ==
X-Forwarded-Encrypted: i=1; AKwUvBx3OeSKkMvNT1MVDguESZu3wxvNQws9gusEvIgfXmIbtCY+Eg3ZdT64DdbJMZ1uRswPkn4uPhWmPOD39GKE@vger.kernel.org
X-Gm-Message-State: APuU4Z/c5Jjtns0ira49Q6QUXNw0MjvbXBLXpS8yIEpZ+ykxkWlgl5th
	CwVIF2FoF3cXRdtdHpGb2YJ/PqcoGEwtHkiuED4W67ViAW1wCf5qyenv
X-Gm-Gg: AYBFou0Ppld4XXs9uYx14y/mtK7kLM7GfYnP/OExzv2RfSm/Xn9vEtNH4O1QxvR9IZu
	2H1kn5dG9cxdYE2uErceNRy4frggy1FSNTf8pfCcqotITYHw5kBsJt9vJXYNZrvdFEv8q+sViT0
	3HcX3AH4YQyOjPnerSDIk9t/5E8sun26xbBkApHjlv5PcBWJuCPvl/wdqpxCS66iFl5PgJqB8Pc
	zHoihP/kEk+Bo8n/mG0rvVqHymUNQZYPhDCz/BRcSVImbOVvnBUr/dAn+4UtNK4aTgVEHzVdnTS
	nipk7solh7kWCnNIpdp5L1knpJnY+lAE69ew05Gvsg2577769lv+XvHANl+pUC8W/wCvz/1eelz
	lpI9fJCkZePgHlVGgFdakwnF40tbJQUtHB+NBa+gt5qIHCp9KEfzn5x98iB1Vw1QNG+q7TaY5xx
	zUr3BOu6nyBfb4TEbB7D+BLEQTOWSzaC/yCpXOWQZxHvBOrSJKQBJc/HalwHbO7QIuCW52euYvh
	iL4f+amJVG2YRpurJFPhSrwDRgQEx7ee5uf8evebq2Llv03EirZG8xYqqxsivHQ76sbIGgFHv7D
	WPInvZBfRC0TPwpUYJPeoyzuBCpkEGhvq8vh8/qcEyeucKpZvEUY4N4WDFuw6q7B1Q==
X-Received: by 2002:a05:7022:1102:b0:14d:c7ae:85df with SMTP id a92af1059eb24-1b25d31ef97mr2084289c88.12.1793956471465;
        Fri, 06 Nov 2026 01:14:31 -0800 (PST)
Received: from anon-laptop ([103.187.196.159])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e485ce2sm4200968c88.7.2026.11.06.01.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 01:14:30 -0800 (PST)
From: Wahid Khan <wahidzk0091@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: ntfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wahid Khan <wahidzk0091@gmail.com>
Subject: [PATCH 0/3] ntfs: three fixes for crafted images, found by fuzzing
Date: Fri,  6 Nov 2026 14:44:17 +0530
Message-ID: <20261106091420.2461683-1-wahidzk0091@gmail.com>
X-Mailer: git-send-email 2.56.0
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

I fuzz the new fs/ntfs driver with mutated images: an image from mkntfs
populated with ntfs-3g (directories, streams, sparse files, long names), a
few bytes changed, then mount, walk the tree and write, under KASAN.
Three problems from that are still present in ntfs-next (e62b384ca).
Each patch has its own trace and the reproduction steps.

1. ntfs: do not read an index block outside $INDEX_ALLOCATION
   A directory without a usable $INDEX_ALLOCATION hangs on its first
   lookup. The task waits for an mft record lock that it already holds.
   It needs one changed byte in a crafted image.

2. ntfs: open the index allocation before reading or writing an index block
   NULL pointer dereference in ntfs_ib_write() on link() when the lookup
   ended in the index root. This is not the path fixed by 9365c4a1357e.
   It needs one changed byte in a crafted image.

3. ntfs: open a named $DATA stream by name when making room in a record
   WARN_ON() in ntfs_attr_make_non_resident(). This one does not need a
   damaged volume: a file with an alternate data stream and a full mft
   record is enough.

All three need an image to be mounted, so a crafted image, not a remote
attacker. I can send the images (about 380 KB each, compressed) if they
are useful.


Wahid Khan (3):
  ntfs: do not read an index block outside $INDEX_ALLOCATION
  ntfs: open the index allocation before reading or writing an index
    block
  ntfs: open a named $DATA stream by name when making room in a record

 fs/ntfs/attrib.c |  2 +-
 fs/ntfs/dir.c    | 14 ++++++++++++++
 fs/ntfs/index.c  | 17 +++++++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

-- 
2.53.0


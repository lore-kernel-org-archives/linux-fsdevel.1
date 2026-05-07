Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737BE3FD14A
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168939; cv=none; b=cNG1Q06fmnIE7yCo5l5poLPBD+XXggJgGAt1iSStIq7tTEpWwPq86tOnOIge7nen5kG/meWwFstgZTfZaIEkYmANwnNRiwxRozOk2myYPa5CDPz9MSvvAtK6G2Upk8iX4fKcIhhz65aztHIevaJqh8vSz6PafS2WbeljKDKOf/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168939; c=relaxed/simple;
	bh=qkNoeGkk1EDvbqr2YYvb3ZfhLuvKkUA3Dp1BcLHOb58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WBqRtOyYL8uoFmw1ryQj63xGFR2LYFYJxqdB4n6Y8CrTGSHXmsF71oKJ+AnKR1FGydPfPYQ90QC1w9D9vdxjTc9huR5qeHh3YCq8frdDpjENXwEI0ddTpwxLJQiFFsNL13ff02z6AUKnbGplioYZ1BHsBO+Mysl2EVl2v6jamDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qhGJkbhg; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhGJkbhg"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a9633ef0d6so539965ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2026 08:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778168938; x=1778773738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eKm6d3Tcv+zN5MgNnW1QNHFyC06/mNbb0XfWewjzA7k=;
        b=qhGJkbhg+NPu4JCwV8ENh5FWLh3qTGrdbnjpoDhIRxxcip1qqT2SNnJJvUrqwBFGEI
         XQEWeKsfk/0hEhj0+HkGLZRzqr1VzhTBy3GcYVm4ku1xSndtrkxHkYGXIxY4Af9wdffc
         RsZF88qFeia+D78rxJiyt2CnTNg9bjGqw9d/pwiAvks6Z33iIqFsH4E+Rfx3kg31IIv3
         nIPOWUsD97JXpoywo+A+1JXHEN0Ll/fKMdl4J8ct9PEbSg2NOKTsB49WH/lfg+WLzOvr
         RzvxZp1Qq6t1kzwK2ILCKagJhjJfZlx7XNz37Uqb4OiKjcZeci3ZD4WAElkB25wjo4XM
         ewzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778168938; x=1778773738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKm6d3Tcv+zN5MgNnW1QNHFyC06/mNbb0XfWewjzA7k=;
        b=Y5hh372egezhjKTu3g968SecbQ9Jvm+WT0sL7UMOdDcNXWD3xNApShqmJt9eFuWJk6
         1HUE9S8mus57BMShPNYGD549nSE68lCb4edv9Fy5po8DnqNyu+oLvs9lMpGWDEHmzzj/
         yf1ZrZX+feTPFUM7mYdPv929XlrV80f1bsErGAivTXZ722Q5n/SHcMeL9Y7SzpnP3Sfz
         02ImZKWzSt2xCtAtenUdVN3zAzeeMByNxVZTxnuQQ/B4W6eSyPBLcDV6cAevqZVTwFDr
         tWIBvWOlPJNnd0js9Vl+skk8rwahP5ZGH1C8uvuS7dO8KTj/HSq52AToeQaSxlexpQ8F
         LCXw==
X-Gm-Message-State: AOJu0Yz9ILP2IS+HwCevk5J/lB4jH9/Mdw8b/+uIpx1t4ibycsey2s1d
	I9ucJ+47bzXDQUb00qA7UpE3Qr7uomt/YrMMWq8lOK2BhMyO6EQLW7T0
X-Gm-Gg: AeBDiesacfS9adOS6mzIeGUmEYzSShT5ECYTcK4Oaol8QPOHEz+MxuoQHZ1dXhFd13M
	dWOt6rMz2Cxcieu8vLuEG3uTgkKrBJdKjm8oy4voMqAR/VxmCp/XdW4wfamqnu5xhRclkOKv189
	o9mYNCXI+FHeDGwM5vE3N7WlIkHvOJjLfTcHibS087s6AiMI4dCs65zmzPhPPVSo0pjkXUu2BqZ
	cke0Csa8RSGtibHE0haPYQeBgUn3CEnwAJoAqmzFEzwYaKmvI1PsSd6yKbXjXec8wCrcC8DwOoR
	xVmtc6fuOTTYGJ5yP17+OwXvDJmQJpAyYTEz/Vc9hdDjuY47LqwUb8SS0rCuElKY908Uq3b0KEI
	l3mVNRKpiNePHCQRJcBFA7/Aus4c1ooK8jA2nYoigzsaoGvZwh3ecPAzpuQuHUVeaVcnmeFhRXK
	5h/x6/YIS3C+N6neRfJMw2L4HfSLA=
X-Received: by 2002:a17:902:d2c1:b0:2ba:7662:804f with SMTP id d9443c01a7336-2ba7afccbccmr43919385ad.2.1778168937668;
        Thu, 07 May 2026 08:48:57 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bae7857d8esm934685ad.55.2026.05.07.08.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:48:57 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH] ntfs: avoid leaking uninitialised bytes in new security descriptors
Date: Fri,  8 May 2026 00:48:52 +0900
Message-ID: <20260507154852.1721710-1-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_sd_add_everyone() builds the on-disk security descriptor for a
newly created file by kmalloc()'ing a buffer and then partially
filling it in:

	sd = kmalloc(sd_len, GFP_NOFS);
	...
	sd->revision = 1;
	sd->control = SE_DACL_PRESENT | SE_SELF_RELATIVE;
	...

The buffer is then handed to ntfs_attr_add() and persisted as the
SECURITY_DESCRIPTOR attribute of the new MFT record.  The descriptor
covers a relative security descriptor header, two SIDs (owner and
group), an ACL header, and a single ACE, but several fields inside
those structures are never written before the buffer is committed
to disk:

  - struct security_descriptor_relative
        @alignment		(1 byte)
        @sacl			(4 bytes; SE_SACL_PRESENT is not set
                                 but the offset still reaches disk)

  - struct ntfs_sid (3 instances: owner, group, ACE.sid)
        identifier_authority.value[0..4] (5 bytes per SID, 15 total
                                          - only value[5] is set)

  - struct ntfs_acl
        @alignment1		(1 byte)
        @alignment2		(2 bytes)

That is 23 bytes of uninitialised slab memory persisted to disk for
every new file or directory the legacy ntfs driver creates.  The
"+ 4" trailing accounting in sd_len holds ace->sid.sub_authority[0],
which the existing code does explicitly write to zero, so it is
not part of the leak.

Anything later able to read the SECURITY_DESCRIPTOR attribute - the
same NTFS volume mounted on Windows or by another NTFS reader, an
offline forensics tool, an unprivileged user that ends up with read
access to the volume - can recover those bytes.  The leak persists
for the lifetime of the file on disk, not just the lifetime of the
kernel that wrote it.

Switch the allocation to kzalloc() so every byte the on-disk
descriptor covers is zero before the explicit initialisations run.
While there, replace the bare "return -1" allocation-failure path
with a proper -ENOMEM so the error reaches userspace as a meaningful
errno instead of an unrelated -EPERM.

Found by inspection while auditing fs/ntfs new-inode paths.

Fixes: af0db57d4293 ("ntfs: update inode operations")
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index dc786270afe5..aad928ebb7bd 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -355,9 +355,9 @@ static int ntfs_sd_add_everyone(struct ntfs_inode *ni)
 	sd_len = sizeof(struct security_descriptor_relative) + 2 *
 		(sizeof(struct ntfs_sid) + 8) + sizeof(struct ntfs_acl) +
 		sizeof(struct ntfs_ace) + 4;
-	sd = kmalloc(sd_len, GFP_NOFS);
+	sd = kzalloc(sd_len, GFP_NOFS);
 	if (!sd)
-		return -1;
+		return -ENOMEM;
 
 	sd->revision = 1;
 	sd->control = SE_DACL_PRESENT | SE_SELF_RELATIVE;
-- 
2.43.0


Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07F035E1C8
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 11:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779016237; cv=none; b=UVTylYKvhtp7xQL+MWYNRCVIJlq/hmLtVsNmflMXOf3naw/XJpu7plgzKxgEg/HqWnWIFxBNB/e2DdHEun9RhLqMsX94+vJiSGKc1Nff/YUXIeP6XlFQEufTLuBr4VtjIkAPRmko5KQ099NRmlzo1V3c06qgBhTiG6hI5CHDwjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779016237; c=relaxed/simple;
	bh=n+C1rVyGdlKurjuMZfviPdnXsf7j/DTvcv2LKJqNXf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDnQvZAJ00CX/bxgJLM77oz4V+6UpnhjkhxVRJ80z2qu4BuNfl5xny/tnH9LXltnaLrwnhfYku57iWEcMXWayLwpBD9a7kSJxWeNOVv7agww/qVrAmfjlttAYzOJoqzGheBaFuVWwL2qJ960Szm8fEkm0a5tjWzJUl55DhM67YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnWj+u7w; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnWj+u7w"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50e97863425so17573991cf.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 04:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779016235; x=1779621035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7Mwcd+TqqhYeRK2C3/0bLC/BLmg36DmKBF7VQkSkpQ=;
        b=OnWj+u7wfnaYSZ6yp4g4M3kIcj4bk1nw8Am5rvgeKf8WGnwwkXgrYwBoOI5vGouJJ1
         yP4GL3LA3V5kVcuNeSMQEXWNxjiktuLSBTC6mqwZZBGGOv7jl39qZLWGi3M/nqMtHL3Q
         bAUBn3WU86MwUOzDsK7ICV6pid1RA+nTffLmLZu44SK5o+LuhkfSTWADezD2MJ99bTpn
         A6l2fMygsHg6Ntu+L7usfXkJ+oD3e/ORooW569eVid+yz0mq/gqwk+Qvkn0Y1+o75HSW
         3L0pUB7geVR/36woy6pVOcB9w9qzjslexM8/naCIfQuS0zpFwf5x06SH9aUZY/vmDRXi
         ijaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779016235; x=1779621035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N7Mwcd+TqqhYeRK2C3/0bLC/BLmg36DmKBF7VQkSkpQ=;
        b=NZKU5q5m6Kxy93h6Eb1ovuBYaS1riQLUDqrtgGsmV2ZD2iVeKryTZ4xwY6h/4ixs8t
         J3QJYzeq3w39KBUOsgozEblVYRw0BpcVFYPqI2myIKwYoZ6R9reAY49Ztmk4M22dI217
         9+Ylx/7rw5UR69OwrdvlJeMGF++Qbjc3OrcqL0dSlLCBzRJVu7ITZeBq3j4WKGdhAFYa
         1zlpBEv2eT6Aysf0KSAhnsNR9QSL+q1EJGpCtQi8F/2KwsKCts/3pRv6MAJbcMXNdtf7
         wbaPc7VBHOI4L3ygh48X9j21Oa4l++VTxV3r0XfC/aOisp+HUzeiRnwpl2pIP2FNkyrK
         p2NQ==
X-Forwarded-Encrypted: i=1; AFNElJ+hRdWz9AYD7FTZ7P62IQdwN9IIt7nwwuIKv4yvNMNC4KJKi20Cz0kOZ8nHDNUgGpW0xINb64tMtixxMs1b@vger.kernel.org
X-Gm-Message-State: AOJu0YzumTPwZy3ZengU9bwKNQqWIPlZyUl/49kdLi3IwFhzZdGaEVxj
	ALq7wck/PIn9EGqVEQbTtF+58F55z07Ae0rvipLOoeDiAaYQsfY9O5qm
X-Gm-Gg: Acq92OE9L0ULChbFhum1IrOqfqjNueo4xBZqxk843yxVehg+0UhNM6IbQgyLagrdSxR
	2R7jEbTu3KXiENNIoA4/l9xSeahOo9Tex9MkcmQa7VKNPyMcOOaIYVwBhvoIweGJY0CiXjXP6LF
	apZKJmR6UBidqCmSpLC5OpEkKHrxv6jLmwSFDnfEGhwJyy81DZBTvDTlEF1/He8Boto8u9f73GX
	TC7nj9PGkzPJEsMTfehqcFLr7p9wDEF6H2DYbwcKe6Ut07dLkob7+nbNpHhGIk152uzUN+uiY2R
	ZtfxfBgY8amN8qB5+Y3JaSLEB8QkQwuO3JKXaw5WxSxu8OCg8rAmRjtFdUZrtAeGpnNTE1avfpm
	dhGyhKciVQNMLnmwbtBPAQ6UNf5UTRdCIGn7PasZmLc166U12r0jPkySmnTUYYmEkfcOvu1U7lX
	tnjzWolMGrCxUsEmGY/UII3ql706WxSA5Ux06XtvflUa9kH5hFBcan+9yUY6cOe1g9Cw6NuQv85
	t87aw7DWRNxNjgj0MxILSoxfuXaGCJzeFsDIazWN0I=
X-Received: by 2002:a05:622a:6201:b0:50f:ade2:2d3 with SMTP id d75a77b69052e-5165a1ec441mr152988931cf.42.1779016234888;
        Sun, 17 May 2026 04:10:34 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456df09csm100306651cf.13.2026.05.17.04.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 04:10:34 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>
Cc: ZhengYuan Huang <gality369@gmail.com>,
	ocfs2-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ocfs2: reject dinodes whose i_rdev disagrees with the file type
Date: Sun, 17 May 2026 07:10:13 -0400
Message-ID: <20260517111015.3187935-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260517111015.3187935-1-michael.bommarito@gmail.com>
References: <20260517111015.3187935-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

id1.dev1.i_rdev is the device-number arm of the ocfs2_dinode id1
union and is only meaningful for character and block device
inodes.  For any other user-visible file type the on-disk value
must be zero.

ocfs2_populate_inode() currently runs

    inode->i_rdev = huge_decode_dev(le64_to_cpu(fe->id1.dev1.i_rdev));

unconditionally, before the S_IFMT switch decides whether the
inode is a special file.  As a result, an i_rdev value present on
a non-device inode is silently published into the in-core inode.
A subsequent forced re-read or in-core mode mutation (cluster
peer with raw write access to the shared LUN, on-disk corruption,
or a separately forged dinode) can then expose the attacker-
controlled device number to init_special_inode() without ever
showing an unusual i_mode at validation time.

System inodes (OCFS2_SYSTEM_FL) legitimately use the bitmap1 and
journal1 arms of the same union: allocator inodes encode i_used
/ i_total in the bitmap1 arm and the journal encodes ij_flags /
ij_recovery_generation in the journal1 arm.  Those byte
sequences are not an i_rdev and a non-zero pattern there is the
on-disk norm, not an integrity violation.  Restrict the cross-
check to non-system inodes; that is the full surface where
i_rdev semantics apply and is also the full surface an
unprivileged consumer of the volume can see.

Following the i_mode canonicalisation in patch 1, S_ISCHR /
S_ISBLK covers the whole device-inode space; this check operates
correctly on its own, but the canonicalised i_mode makes the
predicate exhaustive.

Fixes: b657c95c1108 ("ocfs2: Wrap inode block reads in a dedicated function.")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
 fs/ocfs2/inode.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index fb592bf3e5f31..305e22cc9b1d9 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1533,6 +1533,44 @@ int ocfs2_validate_inode_block(struct super_block *sb,
 		}
 	}
 
+	/*
+	 * id1.dev1.i_rdev is the device-number arm of the id1 union and
+	 * is only meaningful for character and block device inodes.  For
+	 * any other regular user-visible file type the on-disk value
+	 * must be zero.  ocfs2_populate_inode() currently runs
+	 *
+	 *     inode->i_rdev = huge_decode_dev(le64_to_cpu(fe->id1.dev1.i_rdev));
+	 *
+	 * unconditionally, before the S_IFMT switch decides whether the
+	 * inode is a special file.  As a result, an i_rdev value present
+	 * on a non-device inode is silently published into the in-core
+	 * inode; a subsequent forced re-read or in-core mode mutation
+	 * (cluster peer with raw write access to the shared LUN,
+	 * on-disk corruption, or a separately forged dinode) can then
+	 * expose the attacker-controlled device number to
+	 * init_special_inode() without ever showing an unusual i_mode
+	 * at validation time.
+	 *
+	 * System inodes (OCFS2_SYSTEM_FL) legitimately use the bitmap1
+	 * and journal1 arms of the same union (allocator i_used /
+	 * i_total counters and the journal ij_flags /
+	 * ij_recovery_generation pair); those bytes are not an i_rdev
+	 * and must not be checked here.  Restrict the cross-check to
+	 * non-system inodes, which is the full attacker-controllable
+	 * surface.
+	 */
+	if (!(le32_to_cpu(di->i_flags) & OCFS2_SYSTEM_FL) &&
+	    !S_ISCHR(le16_to_cpu(di->i_mode)) &&
+	    !S_ISBLK(le16_to_cpu(di->i_mode)) &&
+	    di->id1.dev1.i_rdev != 0) {
+		rc = ocfs2_error(sb,
+				 "Invalid dinode #%llu: non-device mode 0%o with i_rdev %llu\n",
+				 (unsigned long long)bh->b_blocknr,
+				 le16_to_cpu(di->i_mode),
+				 (unsigned long long)le64_to_cpu(di->id1.dev1.i_rdev));
+		goto bail;
+	}
+
 	if (le16_to_cpu(di->i_dyn_features) & OCFS2_INLINE_DATA_FL) {
 		struct ocfs2_inline_data *data = &di->id2.i_data;
 
-- 
2.53.0


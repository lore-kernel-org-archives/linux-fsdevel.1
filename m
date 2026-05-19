Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C56248A2CE
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 11:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188669; cv=none; b=GAqMJMmuhX8qm/f10IKqOLh4vXT3gVSXiLhHjSwUprV/G4pa03bLICwwGfUM//30A3JKnj4dtUa5RDcWMZB5+hIro/5gejbXgsHEQp9yCW7F/1dcoJqdLxnwrm6QutIj+eue/Z/k9qdNue33OI2Cy4pLKOxV0J5klcTQCOSr+rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188669; c=relaxed/simple;
	bh=FA07lT6C4tTEVDxKP6sBgKRYzFaomS+7kWG4YIRtUto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4GqgQYURCr4jHioxLPspsf7pt4cHBB45ve3LCpJaf2/jDgREXE1fIDDbXga0IkaP0ptjI4PjlpJy9N8tH8ozqZpo3RdjEoMQ/C3T0lw7MlBM4uDkbD3u1HWOpSufSq/e0YvXG/CMOfp0tLJVuKGbiw2p+ICqbHjJVrix5AC/YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqKQ+dCT; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqKQ+dCT"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7bdec52f48dso26622707b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 04:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779188666; x=1779793466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuiWRQBqdRLNOxJ2VaNl5btGp2aiulYiXmdelCaoF30=;
        b=EqKQ+dCTBmNawz3z4SNN2PCQdPqfGOKoY4u3jlk9tk9yyloS9Hg7V4Fdoq46lOgU1g
         BbQXAZrdhp3bgnLqzYO1kOUNUNz5ks/lexZ4j6Be2QLer0JXWnZs3AF1IsE9yXlmchyp
         IVSCpmY8japnhq8lQpqJ/QJryl8/p0F2af3+8aPnA0vCSBaff3PBp8O2PFvwbUUWuCf1
         byC2sPBomdbQvV1JUdU0/Unb0yPzOZlBys0UOvvYTVXG8wcqUoI8EQVds6DRvq4ONaJ0
         5+t+lVUcE39RusMUF5fyG6giQ7uUWSVhpAAS7c/yPqU+t3iL/K3edERyK0gYgUP4mtup
         7phw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779188666; x=1779793466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PuiWRQBqdRLNOxJ2VaNl5btGp2aiulYiXmdelCaoF30=;
        b=Inqw2BogebcUozI5UzFdkHWV7k6932YNj2Zq3hR8GHd53iCvwHQ8RWJGMowqFyEMYk
         NfGPpkBDBU8zqG6mT5D0oaj0tFw4YcTE1rIo8nad1vEK7qKuOLxejTNNTY3qfm1PFtTF
         xdYDvGsk3Xi2AThkylglwyNM61m0l92oYc7I8gfx0Ml8KKjKoGiJcWIWMfIxcxc/Og01
         Ks8P5LxBRnSsunQiz5SqNtJVs/NnqRaTngcaS9Ej1AgBTewSXj89Y9OcxsvTazjXvF4z
         ou+mdLEaFact+3p4JcNN3Dm6Hyuq0YleCEe/FuW8XFQtjuKyQpcqtlT7P2lYJIOExXZ2
         jIcQ==
X-Forwarded-Encrypted: i=1; AFNElJ8aehz+N0KDN6Cinc1nRrk7GDHtyIAvH2UPuO7jUHcdJ12c81ZId598kv9+kk+zf68XMvnmjrplcex3+pod@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3c6gEdtPXKkTqsEo8ik4TIjcKZKSv3/nePk0duPKuRVJTy+Mp
	wy6yIvPqTYmgMNhz9HSqA5tatoNzOavydHFV8AHldgGlibocDCMl5rqv
X-Gm-Gg: Acq92OGwLrH0wOTXF8Zql8H68Fx9RX0SVFIJ6OuBpUVEJZUNzWIpzT0HBF4ExsW+TkQ
	GHX7Aqf7kgxlRxYaIFzR3ObvySzh6wOSrnoTBG2zspoy2gReYC3gi9evf24rqr2sRQDbbS5QdwC
	rTWsQ7gkUlz2YYoq4MOIbv7AtEYydHCktzvnbVTSI9nat98s2SMR07tb5W8PQfCzRTeN60VHACQ
	rbGYhTFrJqInw5N8AvKug3NeleUlCPSdtGh5Gke3+RlwMt+Yl6AkafN7JLuiTHO63eS1NiKp3pQ
	8sOWaxf7n/LcX1ajvetc1kQyxa+QequQQzuyERfsrxAcvGedC5btc+A2eH/boxUf8rCCVefiBNi
	HMDHQdPt8J8Fs7e+9Fwmia31VPvOKFNDDzdbtXMzXPfTAkaVeOoBGYKNmTtjqVSMc86vuQ1UO6R
	WbW5jgpJayLylZRlQ2joMxLlzEFdi1aHYNq1RvBtgx5EL65KudWEVYTIt+3gjea4rF6enBqFPez
	K5ALwI/PaQruw1C+UtH
X-Received: by 2002:a05:690c:e1cc:20b0:7c7:df46:3e2b with SMTP id 00721157ae682-7c7e7e1c3c2mr143911227b3.16.1779188666185;
        Tue, 19 May 2026 04:04:26 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9bc0ccf7sm35206827b3.25.2026.05.19.04.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 04:04:25 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>
Cc: ZhengYuan Huang <gality369@gmail.com>,
	ocfs2-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] ocfs2: reject dinodes whose i_rdev disagrees with the file type
Date: Tue, 19 May 2026 07:04:03 -0400
Message-ID: <20260519110404.1803902-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519110404.1803902-1-michael.bommarito@gmail.com>
References: <20260519110404.1803902-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

id1.dev1.i_rdev is the device-number arm of the ocfs2_dinode id1 union.
It is only meaningful for character and block device inodes. For any
other user-visible file type the on-disk value must be zero.

ocfs2_populate_inode() currently copies id1.dev1.i_rdev into
inode->i_rdev before the S_IFMT switch decides whether the inode is a
special file. A non-device inode with a non-zero i_rdev can therefore
publish stale or attacker-controlled device state into the in-core inode.

System inodes legitimately use other arms of the same union, so keep
the cross-check restricted to non-system inodes. Factor that predicate
into a helper and use it in both the normal validator and online
filecheck path; filecheck reports the malformed dinode through
OCFS2_FILECHECK_ERR_INVALIDINO instead of ocfs2_error().

Fixes: b657c95c1108 ("ocfs2: Wrap inode block reads in a dedicated function.")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
 fs/ocfs2/inode.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index e149ccbdc03ce..992980ea98046 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -72,6 +72,16 @@ static bool ocfs2_valid_inode_mode(umode_t mode)
 	return fs_umode_to_ftype(mode) != FT_UNKNOWN;
 }
 
+static bool ocfs2_dinode_has_unexpected_rdev(struct ocfs2_dinode *di)
+{
+	umode_t mode = le16_to_cpu(di->i_mode);
+
+	if (le32_to_cpu(di->i_flags) & OCFS2_SYSTEM_FL)
+		return false;
+
+	return !S_ISCHR(mode) && !S_ISBLK(mode) && di->id1.dev1.i_rdev != 0;
+}
+
 void ocfs2_set_inode_flags(struct inode *inode)
 {
 	unsigned int flags = OCFS2_I(inode)->ip_attr;
@@ -1518,6 +1528,41 @@ int ocfs2_validate_inode_block(struct super_block *sb,
 		goto bail;
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
+	if (ocfs2_dinode_has_unexpected_rdev(di)) {
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
 
@@ -1657,6 +1702,16 @@ static int ocfs2_filecheck_validate_inode_block(struct super_block *sb,
 		     (unsigned long long)bh->b_blocknr,
 		     le16_to_cpu(di->i_mode));
 		rc = -OCFS2_FILECHECK_ERR_INVALIDINO;
+		goto bail;
+	}
+
+	if (ocfs2_dinode_has_unexpected_rdev(di)) {
+		mlog(ML_ERROR,
+		     "Filecheck: invalid dinode #%llu: non-device mode 0%o with i_rdev %llu\n",
+		     (unsigned long long)bh->b_blocknr,
+		     le16_to_cpu(di->i_mode),
+		     (unsigned long long)le64_to_cpu(di->id1.dev1.i_rdev));
+		rc = -OCFS2_FILECHECK_ERR_INVALIDINO;
 	}
 
 bail:
-- 
2.53.0

Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02713BBFC2
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 08:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954682; cv=none; b=aRr0ti15ZV3O+UZO9bbq5gBI+h0WMzuPOGwD77gRIR0amLRn2crNdL8AySjpa45bY6apJp+Tujro/PpHNALd+bQttcfpVWlbH2TdHW4b4VyVAppG/oc3Vjv+DHi+boYMddLN4En2d+cmyrCMuzltU8zdB0jiZonXLPABM4giBcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954682; c=relaxed/simple;
	bh=lwXAQeijo31yQP352IYmI6t5ooOevLP8dvey8N0IrDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ry8xZf1PJWikEipV2S/FXbV7qoHrLikHDRRnQMEjYIgj0UhnexY2iv+tV5lIfC8UpDeGZcAa1xm7w8KLeWIklRbvvKme59VSwvkR9jc83Ral/DfV9aaoS8tJr3ZVUInusgIJPDcrCFCGn6PUx0jnZgtsH9Lk/KL4Hqy4ECfNpgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n+gfHkEF; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+gfHkEF"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b01910b499so2837507e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 01:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786954679; x=1787559479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kr4krNOjyqQplmnPBqykD0MinGwk5XrmWVr9/hkIl1o=;
        b=n+gfHkEFfQR9c8YibKPLJZrUqey2eELGWD+3yx27x1GAIaz3j68H+XCEnyDaj5np2d
         WN0RZwlXYi2/zFoogSffHNNgbXqnGVOn5h/JrO1Ze9a/3LmTxDhrJ/Ysw5ZBYeIKztjO
         14YSCAwdk+CzJZ1M6NS40cRCdc8vonTmHh33P2X872FjdbBrfC55knvT3z10XIByjAMX
         jDlOWTVxTL4B9gsfTyLmsy4omFsdTgBEpmDgtVZyFToXpfH8QXVnpOQc5bUdkmdhEL07
         uALfGqEcxS/4tHYWA+EzAnU1YypM3K5bysQLwckm/j5i2y8Q/rMBrCq4Q59Fu+usHP6j
         1yBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786954679; x=1787559479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kr4krNOjyqQplmnPBqykD0MinGwk5XrmWVr9/hkIl1o=;
        b=Z/DX/w/+bo0w2vo6T1Y24vfw2eXaHyqJLEJUV/z4YDiBefDP/rlpOeVwDOy78EGkl+
         H+QHEMijWSDyNGvZmWB3xa8pA1NNeCTpfnqNwFF+jyjRjB+4VpZ8TIs8mDSDxBXrxrXv
         Pz4s8YFqHrOnu3p6SYxEm9wzheIrRSV/wVslHvXD20qcrs/STRsn7z6zOjlwY1MaXqy0
         2lCWl7qMVncN8IHOTJc93vPhumuIMaa8PzwDReu3FamOEYZr6gklToH59qnQ2cFpnX0F
         A6QqHgZshU29Htj7xMk4ZHj/27tyOlArRVpjftNVoUzttyCTeyhO2vcVQS/AdOf850gO
         PzBg==
X-Forwarded-Encrypted: i=1; AHgh+RotptX1kXRKMNqyvy3uYq4Z/tKjEZUQIIdORHI/AiPsLQKMyiAVeM1xM1BAX2FD7XzCSd0b+nYneT/+xjnE@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp5ABoybZ01BJvQx/LA4MRK0FfBlo3uYr3D3Ey+/TrVCduzQ+X
	nJN/bSad9A08/iX7uO0n0+PgivFzVEe/z+EpK4fBys3duiDDNvdoHRfn
X-Gm-Gg: AR+sD11F+K3iCKB2wzp0XYVTei0OuEVSXGkhAFR5MmhR1/lOqW89HzJP7bmQ9OLkFKy
	PU8t8XIaFZDBXgcH4J8ejOJMvfVi4tR+WIcD1P86hG6JOctbnN5COet61Etqp1RN/mPLAJRf2f4
	fe4fvDiizGB1PNkz1nHTgRGBIeB9uqJ6W8VMr+Py/5Tj3/LobIF/8OjbMRJzKYmtMkORRoqeT3I
	chNXyFvVkq5SaOeEvlEs0hKVG3kVPeTAwk7uEbA59Yc/CqOEu/aDXHvzNQCyxvr3gZUG3pPH/c+
	KaO//yoLnIl/CNvrEtgkBwtcREaX3k/8fNZGmafJL1Od4gwXWf8no5T85msweXfulOdzJ639lFF
	/cuRtjyLmifVd3D7hrpZweIq5Y/n6OobU9XGszMAK3WTQEQA+UwH6cLJL4FIHq+KPFPlTULjhhV
	VeMRiS7CMy+TUI3+fWa52/wjzcDEHuboclGqlm0Xay+JVu
X-Received: by 2002:a05:6512:8384:b0:5ae:b7c7:5334 with SMTP id 2adb3069b0e04-5b453cd9ca7mr4540296e87.17.1786954678709;
        Mon, 17 Aug 2026 01:17:58 -0700 (PDT)
Received: from c.. ([213.165.253.80])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b46cfa12c1sm199089e87.24.2026.08.17.01.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 01:17:58 -0700 (PDT)
From: Narek Jilavyan <njilav@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mjguzik@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Narek Jilavyan <njilav@gmail.com>
Subject: [PATCH] fs: do not cache a symlink length that disagrees with the string
Date: Mon, 17 Aug 2026 08:17:56 +0000
Message-ID: <20260817081756.4176757-1-njilav@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

inode_set_cached_link() stores a caller-supplied length in i_linklen and
sets IOP_CACHED_LINK. vfs_readlink() then uses that length directly:

	if (inode->i_opflags & IOP_CACHED_LINK)
		return readlink_copy(buffer, buflen, inode->i_link,
				     inode->i_linklen);

and readlink_copy() clamps only against the user buffer, not against
the string, so a length larger than the symlink body becomes a
copy_to_user() of adjacent kernel memory - reachable by any process
calling readlink() on such a symlink.

The only thing standing behind the invariant is

	VFS_WARN_ON_INODE(strlen(link) != linklen, inode);

which expands to BUILD_BUG_ON_INVALID() unless CONFIG_DEBUG_VFS is set.
On a production kernel it type-checks the expression and evaluates
nothing, so the value is stored unvalidated.

All four in-tree callers are correct today, and notably the two whose
length comes from on-disk metadata (fs/ext4/inode.c, fs/erofs/inode.c)
both re-derive it and reject the inode rather than relying on this
helper.  The API should not require that of the next caller.

Validate unconditionally and fail safe: if the length disagrees, warn
and leave IOP_CACHED_LINK clear.  i_linklen has exactly one reader in
the tree and it is gated on that flag, and vfs_readlink() falls back to
i_link with a strlen() of its own, so the inode degrades to the
behaviour that predates the cached length instead of disclosing memory.

The check runs once per symlink inode setup, not once per readlink(),
which is what the cache was for.

Fixes: ea3821990719 ("vfs: support caching symlink lengths in inodes")
Signed-off-by: Narek Jilavyan <njilav@gmail.com>
---
 include/linux/fs.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 50ce731a2..e1d8f2614 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -946,9 +946,19 @@ static inline void inode_state_replace(struct inode *inode,
 
 static inline void inode_set_cached_link(struct inode *inode, char *link, int linklen)
 {
-	VFS_WARN_ON_INODE(strlen(link) != linklen, inode);
 	VFS_WARN_ON_INODE(inode->i_opflags & IOP_CACHED_LINK, inode);
 	inode->i_link = link;
+
+	/*
+	 * i_linklen is used as a copy_to_user() length by vfs_readlink(), so it
+	 * must not be taken on trust. If it disagrees with the string, leave
+	 * IOP_CACHED_LINK clear: vfs_readlink() then falls back to i_link and
+	 * recomputes the length with strlen(), which is what it did before the
+	 * cached length was introduced.
+	 */
+	if (WARN_ON_ONCE(strlen(link) != linklen))
+		return;
+
 	inode->i_linklen = linklen;
 	inode->i_opflags |= IOP_CACHED_LINK;
 }
-- 
2.43.0


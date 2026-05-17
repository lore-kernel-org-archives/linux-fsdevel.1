Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0801C29D264
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779016236; cv=none; b=GNBnVQzdUlhcB3goUJPkDr7lNYFyA4acWfjqX3rG3X6JJH0bkCShIrm81IUi8IwSx7vxWdSJnJlZuJLhpW/FveWxZt3ex2jUBbC4RpD8ur7Jk5D7bAnphQFVWw0QviS1gk0vl/tdepSvRJM+ydHqJba2BTD7995LaSscyxSmYj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779016236; c=relaxed/simple;
	bh=KBKpFoApqVOYrZgt8hDeAf2QScaQBhG6btxplHe/0IM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcaK+yT8In1LoFqJgy/BM2N9Aa4+qW+wizeVUXox/n+JBsBGgBmBJlQlt5CpkI6a3n9/vYXlWB6a3YaoI6TKmlg1aSKYLrQZ1tA+5kpDFcseainOcZLw8Vo4EEbTjaZYZQsQt+WE1x2PlSBFsg+5Z4jxtqQRlxBHUX5zjRP1sJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkqqmM8n; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkqqmM8n"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-512f750d4b2so18796471cf.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 04:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779016234; x=1779621034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYwK9wCTOrjldULnc69mQhALgu/e64LYTBbU5tr14QM=;
        b=DkqqmM8nvzdU/R9mGP2zN7qEv0bMNd3p7DigMG30L24VS7g5WAYDIAO1Mr90Q8H0Tl
         Ei+gUFbtm/RjDN61ho5qTvkcRPGlVXAMsxigt/W3aUzI9UhI23Sk8F4z6RQoo3MPqD/Y
         Tv3b1mSbhpJZmgWn0gorpHXLitEFmMma4J2tt4PoJl9lyDiIhQpjvJ+EHw7aEnKO2eFt
         b0CPPVcPkRXViJAZmb236BMO+LYn1OwKcl9AU72ysmHqpgbOKmMGzr3Z7/qSxdBJrk1Z
         58ygmvl7WPFOty8ZG4exJbM2UogSgLpoVsln7Gxo/nA6mW3cKpQFen8hkoj+xo7cSt8M
         kLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779016234; x=1779621034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lYwK9wCTOrjldULnc69mQhALgu/e64LYTBbU5tr14QM=;
        b=O5neaQ4xjuJWanI61aj6z2A+MHXjOnklEmPEnD4dvQnyLa3t/02TYlt0lnzE1U9iMq
         3MfQO5VYd9hU0xOwxPwBHUURjjCOdYXxDUFRnqpNE8j5TjHz3A1mQ0b1BKtfsI1CuZqu
         sG8pRA9uXjYwuHOHdUdecC+VZHraJPtyX8dJU9RQZPD3RTGzK5ISx1kElHIWZ3GYwkZA
         yATa8xbMlTwe1bxDdBRv/h1gDijEqym18H4hq8Y70xI5VDuUhjr/4DBnX9WSagnF5GEC
         NdtfNCEDkwqqkiV0C3FaoJ5NzKveJ/ZI/FJzsECHOIAakz7VxmczU4F+y5xEaJCcpR4M
         gIoQ==
X-Forwarded-Encrypted: i=1; AFNElJ/kS9RYrhBt7mtELut2kfKy0xilzGOKjATPLnbD0A7wdfxs4CsuZ5cP6er0T+SpLv7o/Rzrp6GezIHTLjW4@vger.kernel.org
X-Gm-Message-State: AOJu0YxPIG5/X1Sy5GT6I+cuzNTg8K8pQH1A8Gpc6gkIs7Q94CzhOXXX
	Ar6rxuUzHRrH0cnZ7RL01B1j+JTsyY5vw+pUjvvEluQf6PQ4FQ8fqd88
X-Gm-Gg: Acq92OEdVXtp3hdPC5IOFSpBUaM0L9t7FSjFFMqBqouDR3WbQ8/Iv91JqY2WCHgcQaq
	ChjdCk2tiZ39xLfbrSZLy3Ay8ncr6SYIh56/2VcIAw4TUd2Yl0JAxvjCm6IFdQjoegd157/9iMN
	M5Vyh2zN8gDJ1ZTB+GK/zVPpnh5EWW/6t6ndZyWH6agguoyGKbuMm9lInFfUYztQjCtS2uYSbQ0
	ypPVykO8n87f+vbDI0NJfk4SlVI0HvkCrWWKz0AuiqyPFkvyb07ktklvv6a0VB2c+fyERiBwKZ+
	jiQdmtQZ8IkL5QeNHEZoFKPgz4qmgUPh5kIw1u81Bc15yi9jNXzdOctFveBT9L0rm8osFadyi1d
	s5vGgFyqPmivCugcLJx2V4rZKVKNh2G+ZuKbkw5sAXBhWiDm5EBS4JgvQxmPhw4w0pTwyEr2XER
	SQsnBc0b+EN7quEGUOwLrzrUuUncga/wFwbTblbEqLUndoftKWdCq90m15fB6E+bLjktBRwO7/D
	dbVFhKjVbbWGUGlDcMQQW3g7FPhaqsf4FbwbgFlJmU=
X-Received: by 2002:ac8:57ce:0:b0:50f:340f:ff37 with SMTP id d75a77b69052e-5165a0df14dmr151793751cf.22.1779016233726;
        Sun, 17 May 2026 04:10:33 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456df09csm100306651cf.13.2026.05.17.04.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 04:10:33 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Joseph Qi <joseph.qi@linux.alibaba.com>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>
Cc: ZhengYuan Huang <gality369@gmail.com>,
	ocfs2-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ocfs2: reject dinodes with non-canonical i_mode type or stray bits
Date: Sun, 17 May 2026 07:10:12 -0400
Message-ID: <20260517111015.3187935-2-michael.bommarito@gmail.com>
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

ocfs2_validate_inode_block() currently accepts any 16-bit i_mode
value as long as i_mode is non-zero.  ocfs2_populate_inode() then
copies that mode verbatim into inode->i_mode and dispatches on
i_mode & S_IFMT to the file/dir/symlink/special_file iops; any
unrecognised type falls through to ocfs2_special_file_iops and
init_special_inode(), which interprets id1.dev1.i_rdev as a
device number.

The result is that anything able to forge or corrupt an inode
block (a hostile cluster peer with raw write access to the
shared LUN, a privileged user mounting an attacker-supplied
image, on-disk corruption) can publish an in-core inode whose
type bits do not name a POSIX file type, or whose permission
bits carry bytes outside S_IFMT|07777.  Both shapes propagate
into VFS-visible state that downstream code paths assume is
well-formed.

Reject early in the validator:

  - mode bits outside S_IFMT|07777
  - S_IFMT values that are not one of S_IFREG, S_IFDIR, S_IFLNK,
    S_IFCHR, S_IFBLK, S_IFIFO, S_IFSOCK

mkfs.ocfs2 and the kernel only ever produce these seven types
plus the standard permission, setuid/setgid/sticky bits; an
on-disk i_mode outside this envelope is structurally malformed
regardless of how it got there.

Validated against the existing inline_data, refcount, and
chain-list checks: this hardening fires before any of them and
does not perturb their behaviour for well-formed inodes.

Fixes: b657c95c1108 ("ocfs2: Wrap inode block reads in a dedicated function.")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Assisted-by: Claude:claude-opus-4-7
---
 fs/ocfs2/inode.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index a510a0eb1adcc..fb592bf3e5f31 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1494,6 +1494,45 @@ int ocfs2_validate_inode_block(struct super_block *sb,
 		goto bail;
 	}
 
+	/*
+	 * Reject dinodes whose i_mode does not name one of the seven
+	 * canonical POSIX file types, or whose mode carries bits outside
+	 * S_IFMT | 07777.  ocfs2_populate_inode() copies i_mode verbatim
+	 * into inode->i_mode and then dispatches via switch (mode & S_IFMT)
+	 * to file/dir/symlink/special_file iops; an unrecognised type
+	 * falls into ocfs2_special_file_iops with init_special_inode(),
+	 * which interprets i_rdev.  Constrain the type byte here so the
+	 * dispatch only ever sees a value mkfs.ocfs2 / VFS can produce.
+	 */
+	{
+		u16 mode = le16_to_cpu(di->i_mode);
+
+		if (mode & ~(S_IFMT | 07777)) {
+			rc = ocfs2_error(sb,
+					 "Invalid dinode #%llu: mode 0%o has bits outside S_IFMT|07777\n",
+					 (unsigned long long)bh->b_blocknr,
+					 mode);
+			goto bail;
+		}
+
+		switch (mode & S_IFMT) {
+		case S_IFREG:
+		case S_IFDIR:
+		case S_IFLNK:
+		case S_IFCHR:
+		case S_IFBLK:
+		case S_IFIFO:
+		case S_IFSOCK:
+			break;
+		default:
+			rc = ocfs2_error(sb,
+					 "Invalid dinode #%llu: mode 0%o has unknown file type\n",
+					 (unsigned long long)bh->b_blocknr,
+					 mode);
+			goto bail;
+		}
+	}
+
 	if (le16_to_cpu(di->i_dyn_features) & OCFS2_INLINE_DATA_FL) {
 		struct ocfs2_inline_data *data = &di->id2.i_data;
 
-- 
2.53.0


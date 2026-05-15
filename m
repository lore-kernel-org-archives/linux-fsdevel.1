Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3B64BC00E
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 15:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859326; cv=none; b=oiwKUuTF/8tPVUumRdwMtCgnlvviCdcwM/UL2L1gp5od3V4hGVCAZRAoK6W157+vtYWzeqJU7wnshSBlzx3fm7aZbz0J2W7wC/kuJjw+dcheHBElovGYGPjl+fXw4rzHr+m9zXN7HI3vApixXPteGMlcSajGD9b2Fs7Q5I4cBZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859326; c=relaxed/simple;
	bh=41FLwQ9O70hFKk04ES4iZspQrQekruDM+bfF8zh4fmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ExZS65g7rCEAo7jnLXgtEtYF/SPXbLx4gUNLatJe5ngCQRc7rlT2QzeOXOufec5CGCzaO+cCK+YXT5agShDWztTzD9Kd1asI+zS5cGitnGuEPkKHKDvH2w4/lUxdSUJGwE/z/a2VX2YPAAlhTV4lzdQgmY421/xeRVVZNUjT+MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvGZEJ1Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvGZEJ1Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFDAC2BCF5;
	Fri, 15 May 2026 15:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778859325;
	bh=41FLwQ9O70hFKk04ES4iZspQrQekruDM+bfF8zh4fmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DvGZEJ1QuT5H+ZpnYGFrVTNr2hKDmjUq1zjP9/PZgUclyfg8ddkcU+HyydOi2zS1l
	 AYuStkBXsPepXGYi0bC+AqF6sWeO3QCOCX77qYbdDv6S4BXal/4SJJ4vcYnhv7A1p/
	 buaKssFMTIoq+k4NSKBfJEXPTPyurywZpF0inSOKew3mv0MdPG+Snq5yuFQoI3nkY5
	 nD+VeEPa95M2FHu4mBOS+5jvAWeb+o7y3S+3q3Jt9GcOOKPS5hhKwheOizqzpzKB2Y
	 kB6TppFHRGp/2EoOGZmUgPdeve9DykzOdksedS8boyvVXImpsLtmoD1XDjOwcxbQTz
	 x06Xd/WyrqA8A==
From: Chuck Lever <cel@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH 4/7] fs: Clarify FS_CASEFOLD_FL semantics in UAPI header
Date: Fri, 15 May 2026 11:35:12 -0400
Message-ID: <20260515153515.362266-5-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515153515.362266-1-cel@kernel.org>
References: <20260515153515.362266-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The existing one-liner "Folder is case insensitive" leaves the
impression that FS_CASEFOLD_FL is reserved for directories.
That impression is wrong: filesystems that derive
case-insensitivity from mount or volume state report the bit on
non-directory inodes via i_op->fileattr_get, so userspace
inspecting FS_IOC_GETFLAGS can see it on any inode type.

Replace the one-liner with a block comment that names directories
as the typical case, records that non-directory inodes may also
report the bit, and notes FS_XFLAG_CASEFOLD as the read-only
companion exposed through FS_IOC_FSGETXATTR.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260507-case-sensitivity-v14-0-e62cc8200435@oracle.com?part=3
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/uapi/linux/fs.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 2ea4c81df08f..bd87262f2e34 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -395,7 +395,16 @@ struct file_attr {
 #define FS_DAX_FL			0x02000000 /* Inode is DAX */
 #define FS_INLINE_DATA_FL		0x10000000 /* Reserved for ext4 */
 #define FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
-#define FS_CASEFOLD_FL			0x40000000 /* Folder is case insensitive */
+/*
+ * FS_CASEFOLD_FL indicates case-insensitive name lookup. The
+ * bit is most often reported on directories, where it controls
+ * lookups of entries within. Filesystems that derive
+ * case-insensitivity from mount or volume state may also report
+ * it on non-directory inodes; userspace must not assume the bit
+ * is directory-only. FS_XFLAG_CASEFOLD reports the same
+ * information read-only via FS_IOC_FSGETXATTR.
+ */
+#define FS_CASEFOLD_FL			0x40000000
 #define FS_RESERVED_FL			0x80000000 /* reserved for ext2 lib */
 
 #define FS_FL_USER_VISIBLE		0x0003DFFF /* User visible flags */
-- 
2.54.0


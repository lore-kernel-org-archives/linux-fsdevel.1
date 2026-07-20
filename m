Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0F233F5BD;
	Mon, 20 Jul 2026 11:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784546638; cv=none; b=Kp7hUV8oQwO7CiKfOF5g79GjXwokQPzCVsR0aEil+zoHEBw7zO0qCVw98gOWjXvGYFXsrhbd+AV29wRMHrCjnMiQisbZ4Ok8dTuhwQvfVAfCcqmeLfhb84aXTitsZ+DY7iwVHmORp+zqfoRLiMkVfsZs/M0VARIiDiLpkpTLsyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784546638; c=relaxed/simple;
	bh=oHo4+MnO95k7uf1gxrZNs4UCWp4rGZ2LkdXTaG/Id84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sOVWxfSHaV5TtQ6KPslSNcfKFw1pIShe4JB87IZmvvlx54+8mtuqG8C+4uGfF0cd2wRlt4dzzT2ejOuEsdgyVMjTk/v4RbOwm3Mz9l/c0dtrgmQfPx+yMXjNi5xsONZjPwfE1Xp1hupry8KKJXanHWZhdODfCcecYxDeZBMVd7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OShGn1AR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OShGn1AR"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 8AB4E20B7169; Mon, 20 Jul 2026 04:23:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8AB4E20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1784546625;
	bh=nEHorIJEC3fsfWXI0c4CtWnWsA2Z3L6OzxJh4w2Tl5U=;
	h=From:To:Cc:Subject:Date:From;
	b=OShGn1ARsC3NmicLevf8VMWXXcJy5I09zdayS0HUWJ2wjDhW2Wp+qRkaHafhQA4MG
	 tUoBDbH2cPjIkoDXTcC3dfHslU5hQxz+0WHE5OedLJQCA5dfXdaYQhKDtk0vdq/FSB
	 A7n0wQ70YKkmB/vhPQCvxriHMzKdu58ANk48h5FA=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Subject: [PATCH] mount: remove redundant panic() in mnt_init()
Date: Mon, 20 Jul 2026 07:23:31 -0400
Message-ID: <20260720112331.1096530-1-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since at least as far back as commit 0818bf27c05b ("resizable
namespace.c hashes"), we call alloc_large_system_hash() in
mnt_init() which already panics if the table is NULL.

Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
 fs/namespace.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index fe919abd2f01..43de01ce023e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -6248,9 +6248,6 @@ void __init mnt_init(void)
 				HASH_ZERO,
 				&mp_hash_shift, &mp_hash_mask, 0, 0);
 
-	if (!mount_hashtable || !mountpoint_hashtable)
-		panic("Failed to allocate mount hash table\n");
-
 	kernfs_init();
 
 	err = sysfs_init();
-- 
2.55.0


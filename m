Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5244248DB;
	Tue, 18 Aug 2026 08:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787041698; cv=none; b=TpWGjAdRFKG4iCNT/DVHphOeFs4spHL0qGETpeWI6d6+Jixo/TQ/T3+gGFDdsc06Fw/Lan4wN0jGcXXp6JLUIbRNmmZCuqMM21MzjXh6Nc4mL6comnjotISFLCq0/xf5nqX2VA9kRhwk/QyrE/s4hRCOaTlHGZvwLxw1U/Lr40s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787041698; c=relaxed/simple;
	bh=lYplAMG4LheSIIGiMcIK0yi/FZp3/9t9KECpC1B71S8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b+khilUsBgsN9eXdnplc63/XASx6G1VAgqRujCezh11vRBon7HG4gwPEzCgRSZTd2GD13kKBU/byXyPGCaiq54sbaL0nDHkuLHBy0lEdVrDqWhLCXfhZAhS25zWcwLlkk7vBcpcGZNv8djt6ddUudhf8ewzzMCHfSIkQQTtSNTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=beNrtr7X; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="beNrtr7X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=L1
	+zmo288p2BzZxswgqBpXmRniK4p1KNhwgk9h190q8=; b=beNrtr7XrNf3pWIvbR
	zkfTjkWgZZFU11pidZPo8HXHOGi4meOLvVzmruZxRyLCoIPC4hWIlFXxDS5HZdvp
	M45Z4BVkHQNmYCuf37spVTw/v6J3iMqQMAVfaDXvkxiQdnhucljuQCtYz5QbH0iZ
	8Y8O9q7eDeQWV2CC9dtriYZFI=
Received: from liubaolin-ThinkPad-E15-Gen-2 (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDnDxV+F4RqSbD3Ng--.4899S2;
	Tue, 18 Aug 2026 16:27:44 +0800 (CST)
From: Baolin Liu <liubaolin12138@163.com>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liubaolin12138@163.com,
	liubaolin12138@gmail.com,
	Baolin Liu <liubaolin@kylinos.cn>
Subject: [PATCH v1 v1] ntfs: do not update ctime when setxattr fails
Date: Tue, 18 Aug 2026 16:27:40 +0800
Message-ID: <20260818082740.498458-1-liubaolin12138@163.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDnDxV+F4RqSbD3Ng--.4899S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFyDJw4UWw4fWF1UJFyUGFg_yoW3Kwc_W3
	Wjyr4vkF4YqFn3Xan7GwnIkrsav3W09w1Ut34fKF4Syw1DtFs0yr1Dtrs5tFWkZFWUJay5
	ArykWa45tr9agjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRNYFCUUUUUU==
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6gChbGqEF4BuogAA3S

From: Baolin Liu <liubaolin@kylinos.cn>

ntfs_setxattr() updates ctime and marks the inode dirty even when
the operation fails. A failed setxattr(2) must not change file
metadata.

Update ctime only on success.

Fixes: fc053f05ca28 ("ntfs: add reparse and ea operations")
Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
---
 fs/ntfs/ea.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/ea.c b/fs/ntfs/ea.c
index 0cd192752b7c..47ff40aa8e0f 100644
--- a/fs/ntfs/ea.c
+++ b/fs/ntfs/ea.c
@@ -768,8 +768,10 @@ static int ntfs_setxattr(const struct xattr_handler *handler,
 	mutex_unlock(&ni->mrec_lock);
 
 out:
-	inode_set_ctime_current(inode);
-	mark_inode_dirty(inode);
+	if (!err) {
+		inode_set_ctime_current(inode);
+		mark_inode_dirty(inode);
+	}
 	return err;
 }
 
-- 
2.51.0


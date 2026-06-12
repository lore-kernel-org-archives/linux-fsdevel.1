Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADE638B7B0;
	Fri, 12 Jun 2026 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781278235; cv=none; b=sjZo5nJYj8YUpQm7RACASDS7/E5voepcsWOxrycU0frf8d7oPfcbdsJoPq/ofPtHQWf4yviPvypjlbXbN1srn35Y4jeX8WDvz18aAQtsjdftm5Yw28y2ZB2Zr7FV9uLgn6CEQ4NfK1tqiAlisC+l80osReNpU2wWS5VNb6Lxs94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781278235; c=relaxed/simple;
	bh=cVVAyTXsZJyiSC5hpQfsjij1dyemK+YG/UgrwEcyC9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Twf8Mmr5d8D6jys+mEdq0YRgTpjs+PxsawA7yTMphCUG86Wo+03br5sj1ZasLEkHq3Myx0Hel8NbrTjOuG6p1GTRRHLDnliucZrq61LkUCIe1++rzszfauo3HiR/4XjTZSiaocbAeJSnbR58L9lL0kn44PyQI8O0pPewE9RX29Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkP21ZBY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkP21ZBY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6BD1F00A3F;
	Fri, 12 Jun 2026 15:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781278233;
	bh=/Zhwwy0u9Y8ZgnqS3Nt6scpfw4vg3nu8ME6rn1XUGgM=;
	h=From:To:Cc:Subject:Date;
	b=IkP21ZBYjZkYu+RP1LddXB5XY/hQZ8DPSBl++eaAvsCsfDIDXszW5eCOIEZXQ3NcN
	 fNr2wuq+jbEkn9UdX87evfptf2MMXyOlsoJOKN1OfsfkhVP9MSGWCNcRROfQElW3e2
	 KPmiiO8rOaKTVgk4nRoi8GU5V+1zLnKUHAlThnpxeae5UssdyNEeTpIIIaZ6CNayL2
	 xTZ4sGZ1rE6dZcWhVrGLNnkVSQ9pur5SdMaK3xd/yUwoCqT/9HxI9vNBKRAveLVyR6
	 RYg5IFVc0z+bmbtkfSDG4YSDCIiy1A2M09L/pekoaAh2+K0dw5Kgr1Ig4NKgOdoL+0
	 poLP/NIS0vOVg==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Wei Yang <albinwyang@tencent.com>,
	Zijie Wang <wangzijie1@honor.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] proc: only bump parent nlink when registering directories
Date: Fri, 12 Jun 2026 15:30:31 +0000
Message-ID: <20260612153031.536525-1-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

proc_register() increments the parent directory's link count for every
entry it registers, while remove_proc_entry() and remove_proc_subtree()
decrement it only when the removed entry is a directory.  Regular files
thus inflate the parent's count while they exist, and leak one link
permanently on every create and remove cycle.

For example, /proc/bus/pci/00 with twenty-two device files and no
subdirectories reports nlink 24 instead of 2, and SR-IOV VF enable
and disable cycles, each creating and removing the VF config space
entries under /proc/bus/pci/<bus>, inflate the link count of that
directory without bound.

Before commit e06689bf5701 ("proc: change ->nlink under
proc_subdir_lock"), the increment lived in proc_mkdir_data() and
proc_create_mount_point(), and was therefore applied only to
directories.  Moving it into proc_register() to bring it under
proc_subdir_lock dropped the S_ISDIR check.

Thus, increment the parent link count only for directories, matching
the decrements in remove_proc_entry() and remove_proc_subtree().

Fixes: e06689bf5701 ("proc: change ->nlink under proc_subdir_lock")
Cc: stable@vger.kernel.org # v5.5+
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 fs/proc/generic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 8bb81e58c9d8..3ac825c79313 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -404,7 +404,8 @@ struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
 		write_unlock(&proc_subdir_lock);
 		goto out_free_inum;
 	}
-	dir->nlink++;
+	if (S_ISDIR(dp->mode))
+		dir->nlink++;
 	write_unlock(&proc_subdir_lock);
 
 	return dp;
-- 
2.54.0


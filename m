Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227D1433AD;
	Sat, 28 Mar 2026 07:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774681998; cv=none; b=jELuQARFKBEAfGVLg13vpYKamKJmbfkDBO/4+OEcyqQLnPhDRkFQe8KSEXZrI2rVotDtSiebz2Qs+pfSCUnUUsiiEzAFOyVRsvldnDbxYmeTPlD5kYyufmsd7F1urmWIE8vtCs71X3RPTJVT1XxJGHTmrYdDaoXbCmuL2F3qOv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774681998; c=relaxed/simple;
	bh=5gz+0bAXOB0IIOackQ6QLy9iLvj3x2JBaZVzggW+tVU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=AWPR5lirCc6FDYmAntHt2ZN8s8PWHKtixRwWUVYAERDM19xe9p3c+s5yWkJ0HmZ40RaA1r2M3dGtRbt9UAfFvscSL1t54wtSnxUK2dUjsxwo0Y71FkzXGOoWx7fTZvObV4kysgurrjPSCsz/Sn9Yz8Bk8jHfECbpPMkQd27phTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 62S7CIf8046831;
	Sat, 28 Mar 2026 16:12:18 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.2] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 62S7C7EC046769
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 28 Mar 2026 16:12:18 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <21e7ebfd-d35d-4682-b553-6996cc8c3a8e@I-love.SAKURA.ne.jp>
Date: Sat, 28 Mar 2026 16:12:07 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v5] hfs: update sanity check of the root record
To: Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Leo Stone <leocstone@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        George Anthony Vernon <contact@gvernon.com>,
        Yangtao Li <frank.li@vivo.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav204.rs.sakura.ne.jp

syzbot is reporting that BUG() in hfs_write_inode() fires upon unmount
operation when the inode number of the record retrieved as a result of
hfs_cat_find_brec(HFS_ROOT_CNID) is not HFS_ROOT_CNID, for the inode
number is assigned using 32bits integer retrieved from relevant offset of
the file system image.

Since commit b905bafdea21 ("hfs: Sanity check the root record") checks only
the record size and the record type, let's also check the inode number.

Since hfs_cat_find_brec() is called by only hfs_fill_super() with cnid ==
HFS_ROOT_CNID, we could move hfs_bnode_read() and related validations to
inside hfs_cat_find_brec(). But such change is a matter of preference
while this 3+ years old bug is effectively the top crasher for syzbot.
Let me immediately stop wasting syzbot's computation resource.

Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
George Anthony Vernon is trying to fix this bug without my patch
( https://lkml.kernel.org/r/20260311211309.27856-1-contact@gvernon.com ).
But it was proven that George's patch cannot fix this bug. Therefore,
I believe that we came to a conclusion that applying my patch is
the way to go. We can apply George's patch as a further improvement.
But unfortunately Viacheslav Dubeyko (the maintainer of HFS) is not
responding. Therefore, I'm sending this patch to more developers who
might accept this patch, instead of waiting for Viacheslav.

 fs/hfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index a4f2a2bfa6d3..2e52acf282b0 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -361,7 +361,7 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
 			goto bail_hfs_find;
 		}
 		hfs_bnode_read(fd.bnode, &rec, fd.entryoffset, fd.entrylength);
-		if (rec.type != HFS_CDR_DIR)
+		if (rec.type != HFS_CDR_DIR || rec.dir.DirID != cpu_to_be32(HFS_ROOT_CNID))
 			res = -EIO;
 	}
 	if (res)
-- 
2.53.0


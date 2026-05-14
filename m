Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FBC3A8722;
	Thu, 14 May 2026 07:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778744104; cv=none; b=MfEyLrZ8aB/O+Lz7pggamjyVngsFp74wB85yB+82JIP7n7VnQksxBONwgDnP6km2dCt2GXC2LY9hxlcojWdBUZ3snBilrtS+wYm0l8f5vBDbXBrayohaXGje9m+kyULiIlzk8zH38u1zV88lI6BwTFulnpBkeafqHpRthYO8qR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778744104; c=relaxed/simple;
	bh=VI8HIUFY4WhHGfTY8w6cUBxM7ulkIUmlLU6f1/DbOAQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QmFJ1MGwYLdxfwBMKKN32YcX+/5b2ok72hUibEeSmQk9w5iAn62dkdBr8Cp0Im36r81jBvZUlvZSzgvI5ofPcp+Q961/C7nCWpf8LjzonxUlyDia+yBrKBrxmixw8oZiSrd3Rfk8cUqQIxtCMnzSYFtwGj59QJRwGsDU+UEDJBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 64E7YZ4q042358;
	Thu, 14 May 2026 16:34:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.5] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 64E7YZou042355
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 14 May 2026 16:34:35 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <c80f3c36-4c66-4e51-ab3e-e83d37b60131@I-love.SAKURA.ne.jp>
Date: Thu, 14 May 2026 16:34:32 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v7] hfs: validate record ID against requested CNID in
 hfs_cat_find_brec()
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: George Vernon <contact@gvernon.com>,
        Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com,
        glaubitz@physik.fu-berlin.de, frank.li@vivo.com, slava@dubeyko.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20260311211309.27856-1-contact@gvernon.com>
 <93f202e6-81bc-4df7-b193-1a812094fa6f@I-love.SAKURA.ne.jp>
 <752d15863effadd7789431137a3feff825594cc3.camel@ibm.com>
 <b7318588-33b2-4dc6-9469-e11da855f8ad@I-love.SAKURA.ne.jp>
 <5a52755364c7ca1438e06caf8e923cea723a0498.camel@ibm.com>
 <b332e546-e93f-4b79-a11c-695058d61fb1@I-love.SAKURA.ne.jp>
 <4f6b37028269c7c4a40a58b57cd546a93dcbd7c2.camel@ibm.com>
 <abnzsVk9JNN3alKq@Bertha>
 <dbacbf1c48ac5aa24f37c58bff995d7b03268db4.camel@ibm.com>
 <absr9g7LaMEHfw47@Bertha>
 <f84ae595-a084-4ded-9f99-964752a69f7d@I-love.SAKURA.ne.jp>
 <070d92639460b672a174d6a11b1e7d0b099b18cb@gvernon.com>
 <9f66743b-70e0-4886-884e-5203f5c02ed8@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <9f66743b-70e0-4886-884e-5203f5c02ed8@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav405.rs.sakura.ne.jp

syzbot is reporting that BUG() in hfs_write_inode() fires upon unmount
operation when the inode number of the record retrieved as a result of
hfs_cat_find_brec(HFS_ROOT_CNID) is not HFS_ROOT_CNID, for
commit b905bafdea21 ("hfs: Sanity check the root record") checked
the record size and the record type but did not check the inode number.

Initially, Viacheslav Dubeyko was assuming that we can fix this problem
by adding validation to hfs_read_inode(), and George Anthony Vernon is
proposing a patch that adds validation to hfs_read_inode().

While I am not against adding validation to hfs_read_inode(), treating
an inode which is not the root inode as if the root inode is a logical
error which should be rejected regardless of whether we hit BUG() or not.
And we confirmed that we can't fix this logical error by adding validation
to hfs_read_inode().

Since hfs_brec_read() doesn't receive which type of struct (one of "struct
hfs_cat_file", "struct hfs_cat_dir" or "struct hfs_cat_thread") does the
caller of hfs_brec_read() want to read as function argument, currently
it is impossible for hfs_brec_read() to return 0 only when the retrieved
record is what the caller wants, despite the HFS's on-disk layout includes
type of struct within the retrieved record.

Therefore, validate the inode number within hfs_cat_find_brec(), for
it seems that Viacheslav Dubeyko does not want to touch hfs_fill_super().
Unfortunately, we cannot remove rec.type == HFS_CDR_DIR test from
hfs_fill_super() despite hfs_cat_find_brec() guarantees that it returns 0
only when the retrieved cnid is the requested one, for the retrieved cnid
by chance matches the requested cnid with HFS_CDR_FIL type when when the
caller wants HFS_CDR_DIR. Also, since hfs_cat_find_brec() does not return
which record type it found, hfs_fill_super() needs to call hfs_bnode_read()
again. Not optimal but inevitable if we don't want to touch
hfs_fill_super()...

Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
To: Viacheslav Dubeyko

Since hfs_cat_find_brec() is currently called from only hfs_fill_super() with
cnid == HFS_ROOT_CNID, we know that hfs_cat_find_brec() can assume that the caller wants
HFS_CDR_DIR. But since I didn't get response from you on the optimized version
at https://lore.kernel.org/all/9f66743b-70e0-4886-884e-5203f5c02ed8@I-love.SAKURA.ne.jp/ ,
I can't understand what you meant from the "Please, check the HFS's on-disk layout." response
at https://lore.kernel.org/all/c732a6e39e833b4b63499059cd388b753e1b2297.camel@redhat.com/ .
Do you want to add "which type of struct the caller wants" argument to hfs_brec_read()
so that we can validate record type and fd->entrylength inside hfs_brec_read() ?
Do you want to add "which type of struct the caller wants" argument to hfs_cat_find_brec()
so that we can eliminate the need to call hfs_bnode_read() from both functions?
Unless you have a plan to call hfs_cat_find_brec() from other locations, we should avoid
adding unused code path.

 fs/hfs/catalog.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/hfs/catalog.c b/fs/hfs/catalog.c
index 7f5339ee57c1..bac0218a736c 100644
--- a/fs/hfs/catalog.c
+++ b/fs/hfs/catalog.c
@@ -208,7 +208,20 @@ int hfs_cat_find_brec(struct super_block *sb, u32 cnid,
 		return -EIO;
 	}
 	memcpy(fd->search_key->cat.CName.name, rec.thread.CName.name, len);
-	return hfs_brec_find(fd);
+	res = hfs_brec_find(fd);
+	if (res)
+		return res;
+	if (rec.type == HFS_CDR_THD && fd->entrylength == sizeof(rec.dir)) {
+		hfs_bnode_read(fd->bnode, &rec.dir, fd->entryoffset, sizeof(rec.dir));
+		if (rec.type == HFS_CDR_DIR && cnid == be32_to_cpu(rec.dir.DirID))
+			return 0;
+	} else if (rec.type == HFS_CDR_FTH && fd->entrylength == sizeof(rec.file)) {
+		hfs_bnode_read(fd->bnode, &rec.file, fd->entryoffset, sizeof(rec.file));
+		if (rec.type == HFS_CDR_FIL && cnid == be32_to_cpu(rec.file.FlNum))
+			return 0;
+	}
+	pr_err("found corrupted record in catalog\n");
+	return -EIO;
 }
 
 static inline
-- 
2.54.0


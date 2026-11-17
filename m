Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.205
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794937142;
	b=gfgMYldFsg0bcElLFAz4QM7wszAfK6VFFAi8JoC9lt+P+B69n60AhjgfCiw4RS8lbwmv
	 blG19Yl+/F8AxpECQxig1M/V1pjMQt8wRqidNgQKILJxqruBTgN2Hhik0kTV7AAyHzLDm
	 A50MvrmiSo3wxTBDeIoYtuLpMuuI5HKLzEA0tD+oYDGOXxuy+f7KHl6+kbPIEXy68sx8j
	 nlJFshgVEpomOyCYXIJhrvrAM1X1FpNxFr/sU9Q5JoNOfJmgkDM39N7ZkntYtjuZD5MDs
	 mMx8KjjnMz+pCWCm8t6c/i0H9M2lM5PdTHE1/FilvMbz6jppZczKqE6POiqOzz19kUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937142;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=r4Gwx2fPtf078oRE/xnMSrJHc96t9lMNVuFVBI5quw8=;
	b=tKMvavkq5Tp7Eayv2XzcY+dfVUdEkmpcqqCMp2bvmUxY5Z7PeW2Pu0ZxQDPW77oZuT0M
	 ROyofS6axMf2pSd4MwgUbab2atpSTKhbtocd412za0IvUQvQHK88cWxze5i3qjaEuLXHl
	 Wq+DjuGKW7W65XcOI2gBQWwhk/ovMjVTO9YjPtxYZNx1+yfWMtOPPaJvPVYmjoDB/9x2J
	 Icxt079RAYeSopAJth7HBrbkhP9snufVeTIz5KVKXbKhMCsbMIN5I+b8D0cBO8diztYQw
	 GPwrxj3Ee+oa4NEcudgUHJP7cfgYs4/TdouxYNthaT2jaey05br9fekU0OEOMqVAxeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=poFOFwvQ;
	arc=none smtp.remote-ip=203.205.221.205
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1089606A31C;
	Tue, 17 Nov 2026 17:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1089606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=poFOFwvQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794937131; bh=r4Gwx2fPtf078oRE/xnMSrJHc96t9lMNVuFVBI5quw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=poFOFwvQH6CvHK6WNoPFcswXNMR32QRI4gmao4+JWmlawmGIbQfpnTYzjDz2NmEPR
	 UtTzgoxV+051xzpBeBy2GrWvjoEKYDu3YZnZYaTL6pnKncgKAhUThrJMRnCm/NAQRV
	 /DmwGJlcEpZLsU5QQjZutDPAzn3h97Sr1tRQt9RY=
Received: from [172.18.4.77] ([202.113.185.209])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 9B1B66A4; Wed, 18 Nov 2026 01:38:49 +0800
X-QQ-mid: xmsmtpt1794937129t478vdfid
Message-ID: <tencent_8D37DE888453A72965D4A60F43144E2AE206@qq.com>
X-QQ-XMAILINFO: OATpkVjS499uHhPXDSMy8nIfORQN18OSkXQgzu93+2Uv7nIgXk1JchmgZxjgw/
	 5aFxdOq/EYW8TLWLVL4JGrKNNTesuaEuVqXo2wbQjkMhN6VHs0dRCRA83gibjA5bwwkQ83KBhTgs
	 ul0F8t09AbHRo7waJgtq2itR+cJDCFmKWe/Nr4TrjeKo5VALb9guXajq1Nw9N6nD2BoxLEwBGZK5
	 Cfy2vRO96Z1DxKUIHETzp1mrySO0gcLmV7MnDre7MiZXb7SMFaptla8P4W+NSyVwEqaLUQhyP6Fq
	 FqkG3H0f4iNIadFzroh/35L9z7nlitDr3IH0xMIeB11Pl2i34lYOCvs6s/FOL6Ge3y3A1/D2ayM2
	 pO0kb9guCgMznnbFoRop+6eF01RsbWmq+otWHBAhW/i1o891tCldioVG0Lmx26OGlre/lxLSjeNR
	 xny057Ebf12unuDF2C5Ty7XnbZ8xx5Uq9JnXeqpKVFQMiboLbytXt3BGBf8S9B/fi3Ek5hsjljRT
	 1gn8BnTTE3sdf8r0sOvhwf31ggHY8kzjy8dfpx5E9tSyb+QN/4q3gLufAwLwkWQHWq3Bu9QKQ+ek
	 i0eb0nIMFEv3YqpBtKm+TLkv7MJYWCi2+7C+uY0kHgBuLGTUE9CFuLTOeDbB/CdHaNh7JvQ9BTuo
	 AdYM62/ENL8xfN3C5G6dAPSaO6nTgmLz/WCmBZ5w/h3SPxIFAV+4/PPUUvzM9Vv0pdUa8EpOjTrq
	 B67oP0LLh0aCiZg53CF+mKTFTFhIyZAlAtVz5w+k708bdvS1t3n0mjA6kjwjZfxcacZUzylHN8Sp
	 Wy+6xQ8ji12Aas7RcomvSFkvGu6LxF4+fJQgqePNY1Ba2wregY5wKds0wfk5FDJ2uvQEGJwXq8pd
	 PycCJfY53hCi6NvN59yyqjkaFMkiMImeIhU1XiltdTeqIuNkyrg1zbUg+ywqqbbhjeOdJC4hTDyW
	 g1UIxpy6YXB7GIX66OZtH5iaXfwZ/Bwez06oC3uVGoSWxmv6h8UfDjWGEyZDcyHl29bT/EPwb3+y
	 y5k8bSSrbkgxapOM4zNmE9jnyK6Pu1uFFd5HsDl4+nMBb08erR
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Guikun Yang <yangguikun19@qq.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] fs/qnx6: validate di_filelevels against the pointer width
Date: Wed, 18 Nov 2026 02:00:00 +0800
X-OQ-MSGID: <patch-qnx6-filelevels-v2-20261118@qq.com>
In-Reply-To: <20261117-anheben-kauen-botschaft-efbcb6e18d72@brauner>
References: <c4-qnx6-filelevels-ubsan-20261031@qq.com>
 <20261117-anheben-kauen-botschaft-efbcb6e18d72@brauner>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi Christian,

You were right -- the v1 diff was hand-written and did not apply. This
v2 was generated with git format-patch from a tree I actually built the
change in; both fs/qnx6/inode.c and fs/ufs/super.c compile cleanly and
the patch applies with `git apply --check`.

Changes from v1:
- real index lines, hunk headers and context from git diff
- Fixes:/Signed-off-by: placed in the commit message above the diff
- function signatures match the current tree (new mount API)



---
di_filelevels comes straight from the on-disk inode and is used as
the depth of the block tree walk in qnx6_get_block():

	bitdelta = ptrbits * depth;
	levelptr = no >> bitdelta;

With a crafted di_filelevels the multiplication overflows the int
and the shift becomes negative, which UBSAN flags as
shift-out-of-bounds.  The superblock path already limits
Inode.levels/Longfile.levels to QNX6_PTR_MAX_LEVELS, but that
constant is too generous when the block size is small: the product
ptrbits * levels can still exceed 31.

Compute maxlevels = min(QNX6_PTR_MAX_LEVELS, 31 / s_ptrbits) with
s_ptrbits initialized before the checks, and reject superblocks
whose levels exceed it.  Apply the same bound to per-inode
di_filelevels in qnx6_iget() and fail with -EIO.
---
 fs/qnx6/inode.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 6de49333a..558a2c2a3 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -298,6 +298,7 @@ static int qnx6_fill_super(struct super_block *s, struct fs_context *fc)
 	const char *errmsg;
 	struct qnx6_sb_info *qs;
 	int ret = -EINVAL;
+	int maxlevels;
 	u64 offset;
 	int bootblock_offset = QNX6_BOOTBLOCK_SIZE;
 	int silent = fc->sb_flags & SB_SILENT;
@@ -405,27 +406,31 @@ static int qnx6_fill_super(struct super_block *s, struct fs_context *fc)
 		brelse(bh1);
 		pr_info("superblock #2 active\n");
 	}
+	/* ease the later tree level calculations */
+	sbi = QNX6_SB(s);
+	sbi->s_ptrbits = ilog2(s->s_blocksize / 4);
+
+	/* limit levels so that ptrbits * levels stays below int width */
+	maxlevels = min_t(int, QNX6_PTR_MAX_LEVELS, 31 / sbi->s_ptrbits);
+
 mmi_success:
 	/* sanity check - limit maximum indirect pointer levels */
-	if (sb1->Inode.levels > QNX6_PTR_MAX_LEVELS) {
+	if (sb1->Inode.levels > maxlevels) {
 		pr_err("too many inode levels (max %i, sb %i)\n",
-		       QNX6_PTR_MAX_LEVELS, sb1->Inode.levels);
+		       maxlevels, sb1->Inode.levels);
 		goto out;
 	}
-	if (sb1->Longfile.levels > QNX6_PTR_MAX_LEVELS) {
+	if (sb1->Longfile.levels > maxlevels) {
 		pr_err("too many longfilename levels (max %i, sb %i)\n",
-		       QNX6_PTR_MAX_LEVELS, sb1->Longfile.levels);
+		       maxlevels, sb1->Longfile.levels);
 		goto out;
 	}
 	s->s_op = &qnx6_sops;
 	s->s_magic = QNX6_SUPER_MAGIC;
-	s->s_flags |= SB_RDONLY;        /* Yup, read-only yet */
+	s->s_flags |= SB_RDONLY;	/* Yup, read-only yet */
 	s->s_time_min = 0;
 	s->s_time_max = U32_MAX;
 
-	/* ease the later tree level calculations */
-	sbi = QNX6_SB(s);
-	sbi->s_ptrbits = ilog2(s->s_blocksize / 4);
 	sbi->inodes = qnx6_private_inode(s, &sb1->Inode);
 	if (!sbi->inodes)
 		goto out;
@@ -560,6 +565,13 @@ struct inode *qnx6_iget(struct super_block *sb, unsigned ino)
 	memcpy(&ei->di_block_ptr, &raw_inode->di_block_ptr,
 				sizeof(raw_inode->di_block_ptr));
 	ei->di_filelevels = raw_inode->di_filelevels;
+	if (ei->di_filelevels > 31 / sbi->s_ptrbits) {
+		pr_err("inode %u on dev %s: too many file levels (%u > %d)\n",
+		       ino, sb->s_id, ei->di_filelevels, 31 / sbi->s_ptrbits);
+		folio_release_kmap(folio, raw_inode);
+		iget_failed(inode);
+		return ERR_PTR(-EIO);
+	}
 
 	if (S_ISREG(inode->i_mode)) {
 		inode->i_fop = &generic_ro_fops;
-- 
2.53.0.windows.1


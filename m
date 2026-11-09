Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794188575;
	b=cDOrvTfn0umpY90Ll/mIiY69ebygNo1djCNzxWgtA2+44LCn66JelkDf79zEk9c+50sN
	 LPV4OuQMOIPQPiR3/1xQsHrFCHxgW17t95ve6qnmaxSmamOAy4YTmt35wSCuawnygvKpr
	 hINSECWZGp7dAE31JeSVoS2re98W20FWuVd01ENqdclpSVtHQFoTavVzM4/uprTUzEmuo
	 QfhYrNP5xpfEhfIt9K3aIjoawiIu+wUUpEYRTYPTlpXyaeVWadN/GRBAk+lFOF3eaKrnn
	 0xr7NHuU+f3UWRuHDMjL75ZG2a/0ffLORjQiX+LH8vczzZbEJ7mWF/wsA9BwE2VFSsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794188575;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=t0E833MpVG61FRxYwlYCLOnS/nHsLvc7hjk+1MaYUEc=;
	b=y9fDMVoClBZ6hLNN34miVZ4fq6QpQOeqmCCT2+GA2IdRPPyRGoi/R+5EzDmXoB3Xwxi1
	 pGIHwoTudYDAC67oTYDjVAqibpgrhXdIldKGrcmfrdw0VuI2bzuL/leweJXOQCK3tQH9V
	 GQS/2+ZmU9F7KomjttTsXmPb4+sWsZQeh275v/AhSOZzvBlyexrCwyZI2oDlWTvHObQgU
	 FVIq+7YnvFE5t0bekTjzNX8N4L1t4Vdvb3l47lTDGb+o3K1Su6HAC7WQh/UHUWJv03Jps
	 ZMbuQdNSu2BaCsc7dGzuBbp6MfUqDsHDlbv3qdLyI/xLdb0Q9lvfeRDL9yOp/ykM0GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=HSLp2GbT;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE0A606A31C;
	Mon,  9 Nov 2026 01:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAE0A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=HSLp2GbT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=HSLp2GbTZNWZnonXS8yOEyA7X6p24AiPwd4PaWbl4Uw1AImnRPFInK6/KaiUVMirnpef1VUN4HdqO
	 Zoq/Ui/2Zj3EEWLffVIazGQn9pRLrqinSXNl1ZJE1dbcMLd0hX+NJ/FLqY4ZLtEbOLB49q1yvK8QAH
	 nRBbDwsFthgT3jxY=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76af1250dddc-bf5f0;
	Mon, 09 Nov 2026 09:42:38 +0800 (CST)
X-RM-TRANSID:2ee76af1250dddc-bf5f0
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from [25.255.2.225] (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56af124cc24d-7bf5a;
	Mon, 09 Nov 2026 09:41:34 +0800 (CST)
X-RM-TRANSID:2ee56af124cc24d-7bf5a
From: xujiahao <xujiahao@cmss.chinamobile.com>
To: Jan Kara <jack@suse.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xujiahao <xujiahao@cmss.chinamobile.com>,
	syzbot+db6df8c0f578bc11e50e@syzkaller.appspotmail.com
Subject: [PATCH] udf: reject extents past EOF when extending a file
Date: Mon,  9 Nov 2026 09:39:52 +0800
Message-ID: <20261109013952.449019-1-xujiahao@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

udf_extend_file() warns when inode_bmap() reports the last extent as
longer than the block the file is being extended in:

	WARN_ON_ONCE(within_last_ext &&
		     elen > ((loff_t)offset + 1) << inode->i_blkbits);

A corrupted image can trigger this, as syzbot reports for
udf_setsize():

  WARNING: CPU: 1 PID: 6098 at fs/udf/inode.c:684 udf_extend_file fs/udf/inode.c:683 [inline]
  WARNING: CPU: 1 PID: 6098 at fs/udf/inode.c:684 udf_setsize+0xd5a/0x1010 fs/udf/inode.c:1300

The extent really is invalid, so there is nothing to warn about: report
it with udf_err() and fail the truncate with -EFSCORRUPTED instead of
tainting the kernel.

Reported-by: syzbot+db6df8c0f578bc11e50e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=db6df8c0f578bc11e50e
Fixes: 16d055656814 ("udf: Discard preallocation before extending file with a hole")
Signed-off-by: xujiahao <xujiahao@cmss.chinamobile.com>
---
 fs/udf/inode.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index bacf2a861..b68aee826 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -687,9 +687,14 @@ static int udf_extend_file(struct inode *inode, loff_t newsize)
 	if (err < 0)
 		goto out;
 	within_last_ext = (err == 1);
-	/* We don't expect extents past EOF... */
-	WARN_ON_ONCE(within_last_ext &&
-		     elen > ((loff_t)offset + 1) << inode->i_blkbits);
+	if (within_last_ext &&
+	    elen > ((loff_t)offset + 1) << inode->i_blkbits) {
+		udf_err(sb, "extent past EOF: length %u, expected at most %lld\n",
+			elen,
+			(long long)(((loff_t)offset + 1) << inode->i_blkbits));
+		err = -EFSCORRUPTED;
+		goto out;
+	}
 
 	if ((!epos.bh && epos.offset == udf_file_entry_alloc_offset(inode)) ||
 	    (epos.bh && epos.offset == sizeof(struct allocExtDesc))) {
-- 
2.43.0




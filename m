Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA283CF669;
	Wed, 15 Apr 2026 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776242718; cv=none; b=M7RDJ6W8hOlHLAMNa6/hQKOvnmSyUzWYPuU+/0D0lxBNBm2BmwmyuoedAndKklPk9AR+LQLu5oOs6Y0cxWpZWSuZwkNKSJKUmMQrIfmwf3T59U67qKnqKsR80bRuL2ncyoz8XyrCCuLh5ZqXOM7k8iN75CVhej6Bb2zUfc72TBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776242718; c=relaxed/simple;
	bh=lk+6jHw1rYhShaVR8oHzz1RyJ6hkNFMUZWxE0AYD2x0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=XhBbeiLrgTpKgDAXmhTApb2cXLobCZdQuLquiL/KNsJm7U11PjoBMd8SnK+/AnAlwqvb4lNNWSlCKYPIXNx62h76xmuA6dJsy49Kf2pGs2eoKS34DqOn7+DPq4y7bw0Si2vxL4OR8Gg7RYEjuG7OQ1f5v2hCBzQr7z0AEfphPUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=OpI/Zir2; arc=none smtp.client-ip=203.205.221.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="OpI/Zir2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1776242707; bh=Z1qcQjIyQcvNh2MsmZNjN3wdZl59kpHyhu8kDEDs5EY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OpI/Zir2rOTU5owwCigmevOjDYm3q2rDzCDsZIHdm8pASEDnAaTiil2VtP0OKRIzg
	 n+8nr/vZ17LYNE3C1n39csvZiNCxBlziXwbUyyDCosD1SlbNQD7XfeSz6YGHj1mSBv
	 RLeuhNLSd1blPdt+OgFfQYFHVNCjjF4SnT1umWTI=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id B44B521C; Wed, 15 Apr 2026 16:45:04 +0800
X-QQ-mid: xmsmtpt1776242704t83m5bic5
Message-ID: <tencent_42B2972A36284B9A7555774B66843D4F3609@qq.com>
X-QQ-XMAILINFO: NdJjTjI40ejMBrB3AzYxuTwgAV7Vyuen3ABBObOMI3q18hfpEOv2AtY2oMzw45
	 hQFP+Xqkibdgv6gXykpPPPn9BzGlJRh3idiRF4qaYabZCNZsrTcPGqjXkqDi6qbfRFue3FDnOEyk
	 g5RpvyH2snnwCIjiYaozDO3lbOybWnDOL4jyX7p7SyBA/9AGWNI06xwl8lM9qEcFMMiN2pwH4KDA
	 1hG4KBRwEkfHRE+X8G1Wlklr9IE0DvU2rXX24fkA2kvCtqy/k7YFZojK7sIjrg6zAIsmUNhhSC3u
	 CUpEDDExp5GAjX3o7QDOFICpZwn5Ld71D6DkZW8reJTR49JvfatoG2bWU5UDcWns2hO3uwBSd4YM
	 EHLsBl8sEy1UL/GsEyBxVkq8cIVC8U3GrHSR29XcTf/1uqtgUXcoHe7+nGH3spvV/dxHecgSkdtx
	 nmMj/rGtOX5VPHujdBCFx5NOQKCte5KxKZUuuUkO1QGhwQ4WJc9/OMJsh8C0cilcMsar7gbek4+r
	 MlzF7KhXvUx6FEjqfw9DmbrLZYn66p/xKmtGr5lycEvAITkiTuDG/+ZF+8ZfDVchY5YjiTdZlDgf
	 H8z3uFKKh3JxlJUGDYkidDAOo/rgcdTexsgjIoXjN0qxZLUfWeczlYgsmqI4zpx+puzBva3CVkpf
	 VlPT+kyOYGjSUrNQdwIpoVRn1rwA1xa/iQ5OiBuOZ7QsGUs1+j6zHRKUAxPyh9wUfGAfqR8oYuEU
	 eCXRUZCi//sSq3kyeU8xTwiYvPAnB+C+h1FpY2COhhblv+jkXQzqOJCPy/srjADMRMQIcWzFypj0
	 /JIJbFHyPU4BwSFW8ruyVaUUYPLC9W/uhQASMMCg1ssWHuSyUXSebY5ldZBOTs1bTB1LCM371fv5
	 9v+6Ytktd0Ox3ikOEy+4+topmkCBSfWham0k/Wa5pWbX72CdD6YRUBi3l0DO5L3KMRBpgRuwpZ29
	 nm78estif2K48h5VltmnlRq6wtA3QF+e7tBd9t8GgcOvIIzEczj5QwcAS1E7VG2T6yfX3WoX+tqJ
	 BtcVwAng==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+bc70a12e438dadba4fb4@syzkaller.appspotmail.com
Cc: frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	slava@dubeyko.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] hfsplus: set attributes inode dirty at correct position
Date: Wed, 15 Apr 2026 16:45:05 +0800
X-OQ-MSGID: <20260415084504.315596-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69decbcf.a00a0220.468cb.0069.GAE@google.com>
References: <69decbcf.a00a0220.468cb.0069.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported a null-ptr-deref in [1].
If the attributes file is not loaded during system mount, a trigger
occurs [1] when setxattr is executed in userspace.

Move the mark inode dirty operation to a point after the attr_tree has
been successfully acquired.

[1]
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
Call Trace:
 hfsplus_setxattr+0x124/0x340 fs/hfsplus/xattr.c:555
 hfsplus_trusted_setxattr+0x40/0x60 fs/hfsplus/xattr_trusted.c:30
 __vfs_setxattr+0x43c/0x480 fs/xattr.c:218
 __vfs_setxattr_noperm+0x12d/0x660 fs/xattr.c:252
 vfs_setxattr+0x163/0x360 fs/xattr.c:339
 do_setxattr fs/xattr.c:654 [inline]

Reported-by: syzbot+bc70a12e438dadba4fb4@syzkaller.appspotmail.com
Fixes: ee8422d00b7c ("hfsplus: fix potential Allocation File corruption after fsync")
Closes: https://syzkaller.appspot.com/bug?extid=bc70a12e438dadba4fb4
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/hfsplus/xattr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 452a1f9becb2..3e6f45b3259d 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -317,12 +317,14 @@ static int hfsplus_create_attributes_file(struct super_block *sb)
 		next_node++;
 	}
 
-	hfsplus_mark_inode_dirty(HFSPLUS_ATTR_TREE_I(sb), HFSPLUS_I_ATTR_DIRTY);
 	hfsplus_mark_inode_dirty(attr_file, HFSPLUS_I_ATTR_DIRTY);
 
 	sbi->attr_tree = hfs_btree_open(sb, HFSPLUS_ATTR_CNID);
 	if (!sbi->attr_tree)
 		pr_err("failed to load attributes file\n");
+	else
+		hfsplus_mark_inode_dirty(HFSPLUS_ATTR_TREE_I(sb),
+					 HFSPLUS_I_ATTR_DIRTY);
 
 failed_header_node_init:
 	kfree(buf);
-- 
2.43.0


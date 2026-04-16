Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA9C2F8BF0;
	Thu, 16 Apr 2026 03:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776310689; cv=none; b=I11uSLZqai+S9xZe2ZgUBw9nBaAW0UfQ7MyD2gYhs2j7BahtD20dqCpQsphioNXXmWn63CBlW1FS55vkx/ioVOs+Mj/6yw0JXch7qbUUzigDQ8um1RiBmH1udlyHWe+4nmVF1kHgwk6VSQaUNBDjZuXDAMbgHQs7ZMzIu31MfW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776310689; c=relaxed/simple;
	bh=8drU68S5e7kN6NcupLmyCchm9X2JiX3fnMF+qxbaVnw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Zfcw7TycuxUiVpLHdSEr0iOvRQfU8D7jltDKuTTR+263kchRvsPBfOqN/fdhePa+yJvuCF3gEjsAxTCEoCBDB7/j49bdAUXSfWxAQUlHfWJ5EyYHx80xCqP0jIk6TuG+VtGryjtixga7sX1ruB1MD2XNXirWixTqBesJPT0E04I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=i2U3HJR1; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="i2U3HJR1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1776310676; bh=JDTV4kgGdEpReWDkuOfM97Ibn8K5SexgtY9NeAKpzqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i2U3HJR11Fk1Rja9RsB1DhMxoPTy+v13wj20HIBu5L6Lt53BSDGqpWzzn2Ujxn7ev
	 z1d9pfUZsdI7i6d1gDQAdeLxQ6urtjhdgLk/aqrEbfeQMIw/LYd5xo0t0ve44oqoA5
	 +lc2cESpuiVzxUrsAAZGolWANxoT5Gv0nmZaXWuk=
Received: from lxu-ped-host.. ([111.198.231.89])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 974B5E4E; Thu, 16 Apr 2026 11:37:52 +0800
X-QQ-mid: xmsmtpt1776310672trcvnw9ir
Message-ID: <tencent_A8D47429765566CC3C8B378496D036664A09@qq.com>
X-QQ-XMAILINFO: OATpkVjS499uxmiJg0BUIFzAr/6nipTGNkCe50HsNx+ZMsgRaOxCG8PZWKfZlb
	 lwIAJ9T0clw4JLA5FyxNuJIOK/+PvJmbxS/VIw4BBd7c66nnsfEj4KStJSKfkW6coTjdhVnNaSWJ
	 VcsFpKI70YrzayKBXApxmvks3v2Sf1BWwOqVc0ck7IE6EmiOOKAzw6CuN4+e5W/XfzpEMOoWsAJI
	 C7kKr0VIGDStaLB/VMZXny9WPiY1epqFk34NqkPGRZROaybPk2Ybyw/L9OdArn+3BR9LJRTJG8DX
	 Ool+cjMeanuEhyPYSQrIxjgcbXElGQ2vmcNYaioq+7ildZpF1fbmXhtQKWbtQZFAYotQpno/5lU3
	 sOwIfC0r61ZX+IaUEQN7xXN1TmMJp0GvS7oOVIGsVf6fi4a21IPf+Jf+bC0JlCb5RGTbEoS8fBz0
	 BFyltpIi2Advs1ADiQDCNeL3xxxTFnYuhLrGwGGS+enaymBolmEaz0H8mcFQ8RduhrDLcsqpCgjU
	 oD5AdTSratoQ3R1ev0wEdnt3wS2XvxDYuux2c3oehLE1hlMRe8IDvuiYux6yLJnjIAU1wr1+P9y3
	 2lVBTc1nH51usRp7D25OyqcMP48awrWbMUPBfxkuaJ+NWfL/E/tkb7ipJZ50YCuX5B0x/PKyGot1
	 8UxO741FJZgg/kG60aRJX+MGCk2y+X0ytFGN68lYH0Sv8g3eD5q6xob0lhH5Ll6kA1bx4Htcjfso
	 Rd9YbrGA6nyyNKDYKPv0Rt/JVDFfw8bTdaSCSp7AAfmkLMxMNdHgi6QRFo7M+Wgp5dYgbf5ZayST
	 NFigX+YRfxnKuN7xHPGjfTkFsiq2qvJSkQedv0piPaXfHJ+kpnyr/Rv/piIFCM/R3hRdQLDQDjMG
	 sfdnfvGaVAPoEfxVHxMweIMozEwfKvHom7UHGBgN8aUcyHTSEWuVAwQ0n1P7ff5MIxv3H3fRiYgj
	 W/Ct2vJQKpQ/KDQvSfKOw/IFwChaZnYcSF5pECA8NoX4kyXasPR2mhiedWZXFrZ4TWq4Ez/JlI2s
	 lvEVolFwf6xlzKcUYWZwsa6RSyfQTWo2z3+4z3NQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Edward Adam Davis <eadavis@qq.com>
To: vdubeyko@redhat.com
Cc: eadavis@qq.com,
	frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	slava@dubeyko.com,
	syzbot+bc70a12e438dadba4fb4@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH v2] hfsplus: Remove the duplicate attr inode dirty marking action
Date: Thu, 16 Apr 2026 11:37:53 +0800
X-OQ-MSGID: <20260416033752.361039-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <4ca511af88f86e0b8bfb45ccc8e460ac773804e1.camel@redhat.com>
References: <4ca511af88f86e0b8bfb45ccc8e460ac773804e1.camel@redhat.com>
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

Remove the first mark attr inode dirty operation.

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
v1 -> v2: just remove first mark dirty

 fs/hfsplus/xattr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 452a1f9becb2..21a1c196c71f 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -317,7 +317,6 @@ static int hfsplus_create_attributes_file(struct super_block *sb)
 		next_node++;
 	}
 
-	hfsplus_mark_inode_dirty(HFSPLUS_ATTR_TREE_I(sb), HFSPLUS_I_ATTR_DIRTY);
 	hfsplus_mark_inode_dirty(attr_file, HFSPLUS_I_ATTR_DIRTY);
 
 	sbi->attr_tree = hfs_btree_open(sb, HFSPLUS_ATTR_CNID);
-- 
2.43.0


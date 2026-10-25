Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=189.12.192.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792965845;
	b=w7jmeANzqAcu3eID6uid2msE1ev9muaZDPpJQ3qhkE4RMefbiMSKR+B3FQSQyRmfEegn
	 qimmfkl1XbWjRFUnH+iKZlPd9lmqPILVJZY8eu0ES4MXPB1ooArP0cRZ8E2zaVvZreuyS
	 m3lW3K1EWa/0v2QoVR9C33RVqh4IVefZA+bCHat6n41tO8OIyVVkiVB8azftLE9cjxXee
	 UtEtV4WqYFEuS1XnsINmnlv9fYy+WtXPXNmyYf6yuACLWMyKuFst0JaVEFRBfTUo0WOMA
	 v51J+ETTGmBrmCmBHQq84juUV+Tg8PXyf6pseE9HSZ6jS3PUdBPG2w63/nhaOxKsl/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792965845;
	h=DMARC-Filter:X-Hostinger-Mail-Ref:DKIM-Signature:Feedback-ID:
	 X-Hostinger-Mail-Id:Received:DKIM-Signature:Received:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Date:X-CM-Envelope:X-CM-Analysis;
	bh=CrNDI/HhIZ8eZSkcLOFUV++vkyO6sNl/t3L4lyOaao4=;
	b=X/9qKqniCsN3sVUYm/9NbNRCu0sCI9HrqJ9LLvqChcarBsRUmRdGNb3j93tbjGztoQtl
	 BSp0+QMCRlSafPc8bTKY3UwYTNUqNrpCrNNLw5bAjM+1GOobYRx6s7wVrSKWKMTUU7E4R
	 u7w8AK42ZPrnwiY0dz9yvOmFA067MaXQhpJXhzR7Qsw7aU2pKuCyqXFuvu85mmlOOGJjH
	 caxYRw10kBQ8bfwGX1wOhyrTMpQJZ/H6KPF3CzfARg6IKQUzA5efhWpteE1xTnZKDWy17
	 kmfqqSr1r2yrmoLinks2WgORk94GWZo7UUlp0UHf3jO0v7XDB/3NbdRYnf0b5es0JMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=espilon.net;
	spf=pass smtp.mailfrom=espilon.net;
	dkim=pass header.d=relay.mail.hostinger.com header.i=@relay.mail.hostinger.com header.a=rsa-sha256 header.s=oak202607 header.b=NDg+Ng5J;
	dkim=pass header.d=espilon.net header.i=@espilon.net header.a=rsa-sha256 header.s=hostingermail1 header.b=dxIjdEow;
	arc=none smtp.remote-ip=189.12.192.4
Received: from oak8.relay.mail.hostinger.com (oak8.relay.mail.hostinger.com [189.12.192.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB4A606A32E
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Oct 2026 22:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CB4A606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=espilon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=espilon.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=relay.mail.hostinger.com header.i=@relay.mail.hostinger.com header.a=rsa-sha256 header.s=oak202607 header.b=NDg+Ng5J;
	dkim=pass (2048-bit key, unprotected) header.d=espilon.net header.i=@espilon.net header.a=rsa-sha256 header.s=hostingermail1 header.b=dxIjdEow
X-Hostinger-Mail-Ref: eyJfQF8iOiJcXF8vIiwicmVjaXBpZW50IjoibGludXgtZnNkZXZlbEB2Z2VyLmtlcm5lbC5vcmc
	iLCJ0ZW5hbnQiOiJldW4wdXM9ZXNwaWxvbi5uZXQiLCJ4X2N1c3RvbWVyIjoiZXVuMHVzQGVzcG
	lsb24ubmV0In0=
DKIM-Signature: v=1; a=rsa-sha256; d=relay.mail.hostinger.com; s=oak202607;
	c=relaxed/relaxed; bh=CrNDI/HhIZ8eZSkcLOFUV++vkyO6sNl/t3L4lyOaao4=;
	h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:
		content-type:date:date:feedback-id:feedback-id:from:from:in-reply-to:
		list-id:list-unsubscribe:list-unsubscribe-post:message-id:message-id:
		mime-version:mime-version:references:reply-to:subject:subject:to:to:
		x-hostinger-mail-id:x-hostinger-mail-id; t=1792965838;
	b=NDg+Ng5JKcX/Upp6WmC0HAozj3GXXPCJ1irisWyQrietuRXwO7btSFJr2ue25xxnKsNVjk9gl
	U6xFhFBFyhXBst45fjlCX/ERCtxc5qc06ByihNzWjXruQXvYwA69te1bsh/+aB2PZPPuVQbZyZm
	8xJpIVo9G8bRTTr5nggB8hLkk2IBzKhVw8rm5nHeqINZoT0sbt/gO0Vs2sPOcViWtZnYWq9IOE2
	uI4H5dNn/xp0zFS+J4ora/yrbNJwvbcbcNZ0JdgZnLwMgA3JsKTaocyFY6wUoyQV4V5DDs8JGU3
	M57j0g/s7N+tGjUr9iosUAyrX1bnFO0jjYsa7x9wZorw==;
Feedback-ID: oak202607:espilon.net:hmail
X-Hostinger-Mail-Id: fa675520d0bf11f19c93bc24111db075
Received: from fr-int-smtpout22.hostinger.io (::ffff:148.222.54.26)
  by fr-int-hmail-krelay4.hostinger.io (KumoMTA ::ffff:148.222.54.57) 
  with ESMTPS (TLSv1_3:TLS13_AES_256_GCM_SHA384)  id fa675520d0bf11f19c93bc24111db075 for <linux-fsdevel@vger.kernel.org>;
  Sun, 25 Oct 2026 22:03:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=espilon.net;
	s=hostingermail1; t=1792965837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CrNDI/HhIZ8eZSkcLOFUV++vkyO6sNl/t3L4lyOaao4=;
	b=dxIjdEowTZ1HzJjJMm5MiY1FLzil0o8dgrn60fthweT0wL+jCCH3mDPjbYpBVNHP8hzh6g
	xr/Qh+cl/rOuVVO0ktt1gdb3M03oRT87bikpVIfPGMv+DSijj4E59HTHeCd9ODWmMpjtXe
	jt28U7n/m/mDy4Npzi2xsiIsjzu+kxRXM5Fyb5eC/lW487Um14yteDVT1BKFS5WmiTHHVi
	GNlQRGMAUQkeMP511H9oFiWXb3x8ER+VPLfjbYFRJ85EyyilQtlKDQAMqELM2L5TVkU4jf
	/TbnNH9M8dvSLcPspFeBHUhqM4DbDmAK+5rkxenYo8gqyWqFtYsnEOb4xYC+yA==
Received: from [127.0.1.1] (unknown [IPv6:2001:861:5b02:4810:d535:8293:aee4:a9e])
	(Authenticated sender: eun0us@espilon.net)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4jCW4F5GGczyyn;
	Sun, 25 Oct 2026 22:03:57 +0000 (UTC)
From: Marouane El Moufid <eun0us@espilon.net>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fs/sysv: validate free-list counts from the superblock
Message-ID: <179296581973.931625.11883539052974567803@espilon.net>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Sun, 25 Oct 2026 22:03:57 +0000 (UTC)
X-CM-Envelope: MS4xfKJfFyJwkKSy0bzPvsDDfK2FTGcWurSuC3L597x1Lx5iwjjRV7/7nOoPf6U/8dyrEGmy3FnKosDJAUsX677jWZkOCCgThGVImaYB+aNR5adfebRKR6fF 4GytyD2etpujbQPjIrXKy2MNHtEqPFIvjI3pcfKgFYlmO1na6S+WBN0V4qkHBuBYSLG/pSe4op07OojgrGlAIVFnb+0xSjPVsHS9Yu485m36bX6s1khgySwa I/mmytzlenUMD10wGIV83oV6cvSQuEMryNeEXn85AFYzHQdYGngQ5cRmGHBxc13yTG4VRgo6PBU43q6NCcWlq//oIxiFWKnvj7UwLyidRsQ=
X-CM-Analysis: v=2.4 cv=CoDtcW4D c=1 sm=1 tr=0 ts=6ade7ccd a=NNrdi8j+18+XpAC5aQBFGw==:617 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=ICNSGLm3AAAA:8 a=jI8lft7n-wMM3qJCQBkA:9 a=CjuIK1q_8ugA:10 a=-W5iAdWQbIJCsXvgvhpT:22

sysv_new_inode() uses the on-disk free-inode count (s_ninode) as an index
into the free-inode cache (s_inode, SYSV_NICINOD entries) without bounding
it, and sysv_new_block() does the same with s_nfree and the free-block
cache (s_free, SYSV_NICFREE entries). A crafted superblock with an inflated
count causes an out-of-bounds read far past the cache array (KASAN),
reachable from a mounted crafted SysV image by creating a file.

The on-disk format requires s_ninode <= SYSV_NICINOD and s_nfree <=
SYSV_NICFREE; reject a superblock that violates this at mount time, which
protects both allocation paths.

Signed-off-by: Marouane El Moufid <eun0us@espilon.net>
---
 fs/sysv/super.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/sysv/super.c b/fs/sysv/super.c
--- a/fs/sysv/super.c
+++ b/fs/sysv/super.c
@@ -315,6 +315,14 @@
 	if (sbi->s_firstdatazone < sbi->s_firstinodezone)
 		return 0;

+	if (fs16_to_cpu(sbi, *sbi->s_sb_fic_count) > sbi->s_fic_size ||
+	    fs16_to_cpu(sbi, *sbi->s_bcache_count) > sbi->s_flc_size) {
+		if (!silent)
+			printk("SysV FS: corrupt free-list count in superblock on device %s\n",
+			       sb->s_id);
+		return 0;
+	}
+
 	sbi->s_ndatazones = sbi->s_nzones - sbi->s_firstdatazone;
 	sbi->s_inodes_per_block = bsize >> 6;
 	sbi->s_inodes_per_block_1 = (bsize >> 6)-1;

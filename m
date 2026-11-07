Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794079196;
	b=mUmYBgeG0OLtAHqWcHQNwl8GIzmck0oqB+iE8YGSfG90uu0yWU4PCOI1P4RMW105qtv0
	 hqpfO/9SQJ9BDrRPLXFOYs0OuYQ6WTTuQIMOiwqNcslhrkK92jOMrwVTeStveHrKlNHzK
	 DyneNPcq/3Uq/E0WdMFnDMqeIO84loAqxY3EgERAgbTALw7JwDiT43yWsfuGbIW5tmadw
	 AREYUBDoBWXlW3Sw0j8/akEMA2l9IJ3ywf2/9McruysTGhIj30Od+8jx7FAcyMvlzTMHl
	 Z2VDglCrXjKxV1pFkVNOyFLt/a4WarDxPdniNKhlwsWma+WJ75gw0tJRc/tTur0208A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794079196;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=8zerBigyv9mmzg2Gjo9e2dqqPP6k5FgIy3HAg56oVSI=;
	b=z0V5VB2fFx8AxAF9iI/e9lml8HdJHTZEq74DnTbwVqmAQFTk/gevmSGcc7vKK0c8Yqau
	 AV7hagRXwFd1xM/qn9GVsS+uzlRlNk3IEkHcZkw/uRxEf+yn+vHmngYSBgb/5VgIfdI2Z
	 uo9z1O+VpgZiSRrTKix0IpLvxLuCz0tR/8HiyOFLX10r2ww6ZVmRJlLZHDePaK2TgQpZ0
	 QX00ViQHrK/UMGi4vDlm4kXoVaLWBvM06gfgLWt+6CnyXK9LIjWziuys3N1NFhmI3BcjB
	 mbIZbJIqsPmgXp9mRk9NPP+awF2QrGcQvt0QocrNj+I1Al+ilhEiajnJIW3Ft4l6WBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=AURhGvnE;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29535606EE81
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Nov 2026 19:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29535606EE81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=AURhGvnE
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91ebc0351deso7627686d6.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Nov 2026 11:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1794079195; x=1794683995; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8zerBigyv9mmzg2Gjo9e2dqqPP6k5FgIy3HAg56oVSI=;
        b=AURhGvnE8sFETK7RokAwv3quzHjXhBE30qWbkAq+wP6miAD+x6MkOmA/0kHToZBUu8
         t966u6k40pDVh4nfY1dgbvniGj6ktX2zMmyu2cUHwy+bbzhwAEO634XFVTbTDnh8veJA
         svlbhvYRnZV0CqMUUrz1L0BfALKnz2pvzb0Cv9h4JtE2oaDpDoLKDJRbUAtyUNS7hekM
         Tbq4tXg6VgIqtZKQl/pMUDFIlOHaVLtPvIhqTY0dUN8g/VKImdT/uBYTVDN6gQ1lhRS5
         LLBW/z/ZWQUg2seVaav7scOozI29kdsSye4+Lsoipeh5eaEuADj1kZQ0ngn8+gYXxYDZ
         Jq8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794079195; x=1794683995;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8zerBigyv9mmzg2Gjo9e2dqqPP6k5FgIy3HAg56oVSI=;
        b=rFL+DzL71MH20+t/hWuQpB9GgXFzPpZUHEviNcYu+NiOSXVD2q1hUgzO0zN0gdxnn3
         PQSB+cqRiQd9n595uJksgKZBY5MSIFUvbW/rU/LwJmB6m81Obe05RDJBRBZRODGxmv+Z
         N+VeNTTfzkxJ7q2JhWuGJVje505+fKHw+CwkmfJP3Y7Ry6SxRMpmh2jz3gl9qEGry61O
         S1j+tC+sDqSj2qgaRPstKb8Yqvj+5ti/EGavAe7RaBvvdVPeZWvwQU4RJ8dsys2/p22P
         Dt7muC6n51q6MDcas/o5RftlFxQeyNJRCkn3nqDcxkb1T1SVAqolJwLBq/ZU1JYLtvd3
         4jAA==
X-Forwarded-Encrypted: i=1; AL+hErHaX8H2ooUkQ38p44s1lriVOelNPFiZbWyFc2/3H82lNwLj21vp8EPXljeUKdjc1Cgvny1Z2hkqmE5RlFYh@vger.kernel.org
X-Gm-Message-State: APuU4Z8uug4x5l9oL+qkfbrBTPiIkBWf2OXnFJLb4d+dT3DyX+hTXD/7
	5iQ7MPgk7mcMMe8Yna1OoA5C4iWtUQDlj9L4oqcobx0r6qcl7roEueFLADqVXodRKX0=
X-Gm-Gg: AYBFou355ekXVXFpZQJt0yyH2P5G02H2TPSxnWBfceXr/xw6OjAois2LHyrYxKSbohZ
	2/Fv3Mc/svphR1Rya1JJZ+43hunXgHYSQmERZgjUmR9MhsnVDnP2K69dg24eiyKn8RDpX8qwBJU
	gxdhX2WRTAVwowoS0WikbtYEGqMYu00rs7vjI60u8PMSNGA33N/YpA82diShVYx67cpMbQY1lD3
	I4D0HIph9u0XbeVV6KWqRVu4HffoN8A3Pvv1HblqRN1rYVcM4k57dm7h7B7lFZw9YhQlbcHdyHb
	CXEaL2RrgvY2tzfRJVEO01seMgsoKaJ1YlC3QaN0zq9y/sY8S3/OEGiR+gzVLrI476J4eoqQNlR
	TlPoM4TELN+2CY2Q174ZFwY/ML0Hh9gVLG5Of6hWEjunHNEObS6MtEBDVNK6Mfu1UTVSv+6vERi
	ejCtgqu2M24JIDigiuSBpztlciIEsL4wawviCJZcrn5PfUJ7JqpG+zPRlEgpe87SVZSoqRGKCKQ
	WtGouebDbuE2jgvfbvNm3jfvhbfqlUM0C5LdaRw+BVnnGouzwKba0Y6MFBtMkxrNrRmET0IkTpF
	QDpHnolf50jFc3hgldj6RZmjBokTgL4oJz6ICuQ/izhSkg==
X-Received: by 2002:a05:6214:3308:b0:91e:b100:1523 with SMTP id 6a1803df08f44-91eb1001f9emr68146156d6.57.1794079195112;
        Sat, 07 Nov 2026 11:19:55 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91eceb56c90sm702666d6.3.2026.11.07.11.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 11:19:54 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Sat, 07 Nov 2026 19:19:35 +0000
Subject: [PATCH v5 6/8] ovl: cache dirty overlayfs' inode
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261107-b4-ovl-containerized-sync-v5-6-d34b4ae57fdf@toxicpanda.com>
References: <20261107-b4-ovl-containerized-sync-v5-0-d34b4ae57fdf@toxicpanda.com>
In-Reply-To: <20261107-b4-ovl-containerized-sync-v5-0-d34b4ae57fdf@toxicpanda.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>, 
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1794079181; l=1773;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=4vtTge6/ThBXumR/B3MN7k2/gMZpZtKv00zfzARf7Uc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QE7kYqImzZByR9bEHLrMuC21KuaTdkAwi3r37N9KScAxvVGsqEgOJtwlmPwM2opRWHNScz0i8WU
 A7kMv3mM9zwU=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

From: Chengguang Xu <cgxu519@mykernel.net>

Now drop overlayfs' inode will sync dirty data,
so we change to only drop clean inode.

The purpose of doing this is to keep compatible
behavior with before because without this change
dropping overlayfs inode will not trigger syncing
of underlying dirty inode.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
[josef: also keep an inode that is under writeback, rebase]
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/overlayfs/super.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 41d0d37accda..ccfbaf9d8797 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -388,11 +388,27 @@ static int ovl_write_inode(struct inode *inode, struct writeback_control *wbc)
 	return ret;
 }
 
+/*
+ * In iput_final(), clean inode will drop directly and dirty inode will
+ * keep in the cache until write back to sync dirty data then add to lru
+ * list to wait reclaim.
+ *
+ * An inode under writeback has had its dirty flags cleared, and only I_SYNC
+ * pins it.  Such an inode is not clean.  ovl_write_inode() may be about to mark
+ * it dirty again, and marking an inode dirty that is being freed has no effect.
+ */
+static int ovl_drop_inode(struct inode *inode)
+{
+	if (!(inode_state_read(inode) & (I_DIRTY_ALL | I_SYNC)))
+		return 1;
+	return inode_generic_drop(inode);
+}
+
 static const struct super_operations ovl_super_operations = {
 	.alloc_inode	= ovl_alloc_inode,
 	.free_inode	= ovl_free_inode,
 	.destroy_inode	= ovl_destroy_inode,
-	.drop_inode	= inode_just_drop,
+	.drop_inode	= ovl_drop_inode,
 	.put_super	= ovl_put_super,
 	.write_inode	= ovl_write_inode,
 	.sync_fs	= ovl_sync_fs,

-- 
2.55.0


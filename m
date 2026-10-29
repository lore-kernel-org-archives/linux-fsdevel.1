Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793236181;
	b=UsUdL4W8bAaG4YcPXv3zJnm6OVGPHyHq2wOANGHQUZvwdpUF8nzFctOSjGH4jNy52uMN
	 mK5umxjWv0WNbuqgP1jsqG/bl7ldDPmvlnPnFWQ8VyDIrQXydsO1Ifcnq2+cPLf1kVrCa
	 l2vbd0CxkWmfHLK5dW1pz44slCwpuSilCq6Yi7Cf2FdVKO6qhojDmG/amOoPJ0u/J95Cq
	 nrbEnk4oeHV+JWwhkr4/rBG0mRkhC6qFNhB0U2Gz4n0OcJL//nHhGXVc+JBs42VNtHdjX
	 jnCRMEoOEg1WW65OI0ye3gHzxAdfWZs91n1O6ZkMHBJ6drGP/Pd59ae+0S0P0znGTqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793236181;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=VhnQvFMBWmQXRcs2LH7tdr4qlxDY+S3Z3dB60xAZW9Q=;
	b=2eMMPNQ16nH3j3KxmK2cY2JCsCPG8EyPhjM6/aUpb1RLU3Lf7a31otGA+iJ/IZab/gXz
	 BKZHyi2rdyQW1hm/tqpptjjvOXumxhHWF01NNpIUiA//uThdJyoCs0qVcDEI0u6ON4ygl
	 dZBwztZKr/YSqqZXHr2chgd4EtQh8aolTJ1tqaqNcav1tQXGWFDasXIAxn6UhZMEiFCgD
	 zvU2hLBga0xIdfObFIfQqAqK8CzzSvZFw40CjqolBPRVIO/BCRdTtjaAQeq3y5MzhGvvt
	 GHB+qecA0dw4zJhT3YWUB+fCep9kI7B85imsu8vHMqNbeRKLI8sLwmzTwr9maYl02PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=ckpJhZ+q;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003F260A262E
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 01:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 003F260A262E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=ckpJhZ+q
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93f3c616c84so131191985a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 18:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793236180; x=1793840980; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VhnQvFMBWmQXRcs2LH7tdr4qlxDY+S3Z3dB60xAZW9Q=;
        b=ckpJhZ+qONPQQbYzD2UTq54ct6Sw3y7LCcmluW5900B5L5voVi9KsB4AHmsZpYPI54
         LHTPeu/IrIGaeQ1R+XHGW6ivWBs8Zcjm4pH0N0Ng5kPCHweLOT6Wo/elwz8Xx5ecq/oZ
         Si/F3wosx9CC6orZ6F3rgJSEzeoUNRNBJuLkQjtd9Wf1cVbjj+TYv8dDlP+zA4Ksu5qy
         v7qajcjZXJ8NGdcsK8FRBPx1QN8qNUbdr5qRlsCEiFQShQIphJQIQM8iFQfBtE/U161B
         +34HwT2hSt+umXfcd19pwwn0jMkLHqOwKnW5BTMD+VFIV3S0/X2zUpeezujgTLclcKye
         g3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793236180; x=1793840980;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VhnQvFMBWmQXRcs2LH7tdr4qlxDY+S3Z3dB60xAZW9Q=;
        b=TCbvaSW92LvxmgtWzWHKzNrE6T5bOyEoVVY65tck7LZEbrtlsB+nNuHaYajlSDkwvV
         tvX/Cz3LF6ljMrUq+/CqtKe6oZOc+wqh2iIy0CEUte3kWCv7F5tUhZPEGOcvSxOMNpyo
         u2wjKtROo2Jh3uE7kSDhfdpn9sbQvUCdshZyu2OOCjNix9dovVLPS26gEyB+8u+3df9/
         tRxZNL5M250/uiUUIuQxHGMQkP9uuJZe0qoVTyvGt1N/ZJdQNCRLuo+b4JC8MfuSRunU
         zGMJ5jCOpBKDIOHlCMlvU0b/STiAP9N8f9gU/FluOBlFSzi9sKT7+xh/Rc7RjZBxz5UY
         TF0w==
X-Forwarded-Encrypted: i=1; AKwUvBzooFlwfbSckJQD9Exop/enZyFZOf0t6w/sFzeTii1gMmrr4K3TghcA2pqDXlTRZ8xkjpQG4x8amt3k8ZOd@vger.kernel.org
X-Gm-Message-State: AFq9FYL7lIMFHiyQYE/5so2wgUr3fqBh6PZ7N4QDAQyyhhvbafGz/uMO
	eUJwV7VXWkqE3HrF6KnvC2HG+2LWxLJRydIAAj26D4ZsyAZBsTVAXFw195Nx/9LK7ks=
X-Gm-Gg: AYBFou1OA1Z+VkWhntc6mSPj2rKGO7XVFaN4XpTqI6C7RB6zkBbdDZwGoZNp894prYh
	Z15BMxRHVxa+yp3uR5pmLB87J7SA4rfNKLZaVY5pTg8b4HgFOz29AUvwytCBBVAk97iUtuM46kp
	FeO7wLZh7K2lyDyEwqZABfT1B1p6alYzB4NWKjGr4zjzOdJZzytG96YrqJdXjj8vNcJpslOpcmm
	Qq0SbuxXsg+qRHB6QMTsn+b3QKjj2dnZQYJ6MS+XrtrJQ2B7KSI51T6lCXvGmCwI0P+AsmPfbXJ
	FSTvGQAefu8jJRFy5Cm/jDrCOzT94pq/lRjtyhx9QvpLSAV0LMXEtWqmCfpLFxKm5K6fY4RY9Op
	cmC0NhGIHTr+hVyJjVQx0stqLSNqwX+9pbi8EcGxzbXjOaSj8C+4zTzwaFeXLQFFC/UhTsQ2KSS
	ba8sfaqbyNiYOuDFu4kZx98lTdMGCc+PHu1MJZKNNbw/zOumjNhZh4iEA4RLu3SRXKV5/TESZqo
	QSdG2vJxEq4YnSF3K0gTa2Jh0+FtkA8Dt8mJlNrXjWI3IvS3KO5Y/z3Sr4wtzEgMPIEVGVwApOl
	cm+ZyMsa5AnyuERYsPGjW5FKy4PaBLG77xzX2dr4fZOsH18kaK7pmuBehBLiu9BHWFI=
X-Received: by 2002:a05:620a:2a04:b0:93e:6a4b:3ea6 with SMTP id af79cd13be357-94408a268famr627465885a.24.1793236179900;
        Wed, 28 Oct 2026 18:09:39 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0a94a5csm1403038885a.41.2026.10.28.18.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 18:09:39 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 29 Oct 2026 01:09:19 +0000
Subject: [PATCH v2 05/10] ovl: cache dirty overlayfs' inode
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
Message-Id: <20261029-b4-ovl-containerized-sync-v2-5-4e9f08e4a052@toxicpanda.com>
References: <20261029-b4-ovl-containerized-sync-v2-0-4e9f08e4a052@toxicpanda.com>
In-Reply-To: <20261029-b4-ovl-containerized-sync-v2-0-4e9f08e4a052@toxicpanda.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>, 
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793236166; l=1773;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=RBYClNWPOGPAjYFAlPxqB3P6LQQ7aE4KvOPd0H7s5Y8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QDEhXxDI+uaXyyjXjTHfF9WLGtv/7BLkXM7HaqSwKCJiz/3wVIQo8KKsXwdjocRmwTcWL6I9AoZ
 BOVS3S+YHtAI=
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
index 4e06b3c772fe..a68eb78a9061 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -392,11 +392,27 @@ static int ovl_write_inode(struct inode *inode, struct writeback_control *wbc)
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


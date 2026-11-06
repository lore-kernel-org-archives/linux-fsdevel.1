Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972229;
	b=rZwmKV0BUAzXAluSRLw0OF6THCgUNQQLH2rcG8y5hlqAwmc5b3zV2PS11PWudnmVKCQk
	 xjh5iPXYU0iiDintF0H/j8Z5X89+ovALUAQQo+75hV2AqHVHQRWN9J1fNsfCwiK8xl4BX
	 PaoBozOcIbYxijRNqzoUSXKhuWrh6tvp9SrsWSraKN2OPJVc9FWw97KtCQYnKgcr6JRpI
	 Z/PcF5SO+VkddEaX952yPnxvRBgv9tPpmFV7Zxw1yw6SVvfmmY/h5/t1HwKfBL0C0ursn
	 t+JCUheBSQn0zOWD57pgA9647gVglFJG2lUzI5jhHkUVJxJhpAoLQ7XYgyg+4IiFYXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972229;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=sLwuZPQ43zw7H/off7wRnGr3Z+fljgzkXkXA6hTWCoM=;
	b=yEAhimcQXkq5REVPWYExoVniShP13C6Q4XBc/xa0RmIoyg+8U9qXNB8bYEKi28pZhFpL
	 RHkb2MTUH73RcHmK5wDxOx3dWdfUKjIgtdooi0i0svaV7OJvL7Gj0IEutXaXZl8Xbmaja
	 fYyynhOb/vnHBLxDO22BlCgA9qRPie8BgxYAUnlLH77eROhEXTb5b2O+DBDfwlhWxv5oW
	 WD2zDqq/eF67eHE4UKbj2jPzPlRFG3f96dbgcG3b0aEd0YiGLrZ6n60MIzQq9JN4rXMT/
	 LMOu9O/xSgTG3GXn3w7kikPI4BOgVQrcGT/CLeISrCCf904rB5GB85EGsLWSbdMQ9pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=FzgA16EQ;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDEC606A33E
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 13:37:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEDEC606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=FzgA16EQ
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93efc0452b5so46715785a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 05:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793972227; x=1794577027; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sLwuZPQ43zw7H/off7wRnGr3Z+fljgzkXkXA6hTWCoM=;
        b=FzgA16EQjljGFzaLq9tfZpfjLHW8Djd/nikKxTUArTpix3O6tl8b7uddLWZEcfoTVC
         32NwydsoRsnJIefKxGUjaZab/q9zugce3DrJaY1iuaFhN4iEMJxpeqdqXvYQKvT+S+Dg
         WkTEc2Llp+DicO4SL/2gtaNEqfaLSiIIzutec8q9EA0cE6JP6Sd5A3XZQ+3JQN3Fr29t
         U8xGGMb+2iyf/nBs8VvEoFIROUd0LL0leEPuuvp2aHvHseOS/K5TVkvga93OQNKnjLmk
         i40SlH3/fp8octItc1mH6qZICiYOARuwsPcHARyttPeW9s029/8HymAhtTpC6cfA2aGe
         nFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793972227; x=1794577027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sLwuZPQ43zw7H/off7wRnGr3Z+fljgzkXkXA6hTWCoM=;
        b=V48ZTr0/LLAKFkZG/QC6Isnc52GdL62N1Y44L9j6KsFtkXMF7ghJbBfuvtvrhIpgZ4
         teP3w+9GQQoMBoiXIWErgPvZu/iviYweIHw8hzbmWMtHV2B0YIDWADbsnt/CshWX5bLv
         +tsWbWsPdTDierr2slAbpTvA8J8MBnoHCcz1GzwfPm3eReW+LYevelXzWLHQuwOxepfE
         jIjyOuDNucKmEhidLAxcbZAhtZwRM+tzp8hFnttRjoB56ynijOqpTi0VTPDhqbpNBoC2
         0sY3s57u0EfnUZH9y4JnKnhA0jfbdKx6Cezt/0OceluacNvSDNSV0Jr1jBab3ae5y/I1
         z2Uw==
X-Forwarded-Encrypted: i=1; AKwUvBwAOpCr49m7C5JaOHQPWv54G9yRF0aMHEwU7ax3sQMtZFWsO6qq1AwgJksqFMkgUYiZNgO9Pux1l81sVOej@vger.kernel.org
X-Gm-Message-State: APuU4Z8q1Ux/FpO4mPmP8ip1YdPnv6eUI86id8iYFi22U2tRa/aDhcMG
	XmfWi+8D/dqDfvznKyizLPLTyaTMHLt9qkRjrYZ5ZUpzJps+eA8iAR8W/QPAWSujc9Q=
X-Gm-Gg: AYBFou2dZ9sUYAAXYvGFMCf5Q6ViuzsAaZOzFJ20UkHYm+CQ7zuLx8cRapBgqmEiZE5
	jvVUEKWHjCdDtQfx3GlzgpV/IJwu9RnK5eHNKAsyBA3GvA0LgpkV9g6ACGZk2BAOXYjGjjdarGm
	eJPLw6u/yzUV0tU9yPOb1ZbPXPgT9N+PWw+/gDkK18Ecdog1tiT8JBuCq46u7Tdb37apKC+DgZa
	PrQWvNdFKZT5+ukFErLbJkxkCAY7XrB7epqe94AIA6l5hl3YSeEm0RBwrFOspAK/9WxgW5+3s1Z
	oP7mQzJUXN9Yb7WkpqjTftmjbxhqCA5vwkrBvPq2doM0jUWm/mU51io+PKH71n/+q1m8dyDHsqu
	6jih7py4a/Vsb27DUFKAYO2URwODW+InnseQuhkKHl8FilicgugwsWMx82DBI2YNV3M7kOUi6za
	0ZTDEaswt/1DJf5Z3GGFNnCnwaivJbIM6gYl7aIYGqfkLft7O15bzpxuLHrW/iY+xutuNR2bsN+
	3EL3hUAJnU/RmfqVasahcEI6Jic1BpjPMWVMXdOMqPnznFz957cLXA9EaLJ+D1HTuAzbDg3dhaH
	HnF6Rhcc7wHjsVc8GRMZ8aPIAQhpM/3T2x01FCvsvmi59g==
X-Received: by 2002:a05:620a:28c5:b0:93e:7ddb:5098 with SMTP id af79cd13be357-945f34af8b6mr355669585a.25.1793972227555;
        Fri, 06 Nov 2026 05:37:07 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945f5a95e82sm144243885a.12.2026.11.06.05.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 05:37:06 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 06 Nov 2026 13:36:48 +0000
Subject: [PATCH v4 6/8] ovl: cache dirty overlayfs' inode
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
Message-Id: <20261106-b4-ovl-containerized-sync-v4-6-6ddde0b7dd8a@toxicpanda.com>
References: <20261106-b4-ovl-containerized-sync-v4-0-6ddde0b7dd8a@toxicpanda.com>
In-Reply-To: <20261106-b4-ovl-containerized-sync-v4-0-6ddde0b7dd8a@toxicpanda.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>, 
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793972217; l=1773;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=8D/WsTmpQhuh8wOYjV18U8givpb6bYlz8XjxGqBtv7o=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QA9RmpaU30QmRGQWJMahS83ENZAdOVQF1bFKvrcIoJI82hjYmRv/lISjRXjFBS8IHeqXVpuFldu
 fYqirWgLzfQk=
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
index fe4ff5c6ce07..87773b73f228 100644
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


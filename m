Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963B137C0E9
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 22:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782167301; cv=none; b=H3ii4t70H7SPK05b8u8Weani3U6oTsFoPBfpxLAx7ZgNZurTbvEOjAocgkSPQJh/pjeGZKB4Pa4tr8STuTR2oS8ZBYI8YiRiiyN9sjVX1/3OOAoJDWpaXo5HmrCafmSTyON5+wITTo79Cvk2Aacq7RY1jDogo1Ln5lJ71DNOGLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782167301; c=relaxed/simple;
	bh=B+pNZf9Lnj2XWG8FCwn7MKZtRbeWhKNa/vU4AZvzREw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dNImUlqzVEeUh/pD/pNApsHn6nW9To17Tw3Y1bbOSkaK6RenT+2bF6PmA3i8BdFUUc489eYwlPQpRMdtvvm653FyXRjgXvX4nSLFuo5KDiR9i7Nn5TwwmtFQBaTfvPVxENFk53EvQgAMaXA5r6j0f7DvB5r2JgpvCVFCkKjWIVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J1ms8mGg; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J1ms8mGg"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0b35fa876so49383895ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 15:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782167299; x=1782772099; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qGElPt26WdpnNahM3WnJg4mnRJcDyCeFwMEl1h5w3R4=;
        b=J1ms8mGg7w8fz9sUDhtJ4xzM8rWoq/LFJAvWn3ScVrFDHuT3B8y42sy0c+jVPDV41S
         jnL5WKUwnOjt1kgBixJDiyAy5heqegv1rZVV+rev8CnGaMo7FvVyTxNYVA+08mgtqmSL
         7HbVDIT9YJWQRZgO7XhiOC1RWwC7dmvkWVt4QLKRW+NS6N4NnEc96wsTZFhshVXC2pPb
         o0/j3nDBtUlutDSky1zYI2tUFUFtL8f/IhIZ28tzHT8NvT946lQwrKhrlg579G+jrZ96
         iuSqPOX6Ne4Kw7phL1vA6k542HSajg7iwm2HSInGW8gnp+p1hKp/uh4E64fuszjYVwfk
         wpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782167299; x=1782772099;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qGElPt26WdpnNahM3WnJg4mnRJcDyCeFwMEl1h5w3R4=;
        b=WS5ZW1PU/QMMt+pNKl9LIGWNX5MpwXQQjDwsiP3UZBj9bveCwEm0ubuuDiUf8GqjN4
         jce5HsCyjD4TDXAM3nutpiCdyStOsKGyDf+7F78F2l61CA1omLq3XMZCfT91gJoNtXjB
         A6Kn111arYR6DfZ7XTGo4kM80dV02bPLllV5ZxDXzHDNBOWVt3XZ3qI6sJnnSa18rUNK
         OSwJHQTzYQ6e9yL5pXiJwYuu5wQi7ZR8dApaM7JJRXpETsJYZEItsX4Gb559/lfx7TJ0
         Z469hNjfCilGyHh7FBJwuPiD9ORaQ2EkAemuw3xjk3qIXSe2ZDTHwBp119RS8FHgcU9N
         dzrw==
X-Forwarded-Encrypted: i=1; AHgh+Ro1TP8IRDlCzocU/W18Y/W3B7epYpQzN2SD5kKc807L5CCWetKau11NG2ytJfdAFEFCA+2XEzuBrcjShWoI@vger.kernel.org
X-Gm-Message-State: AOJu0YwTnoJBc3cK0Llxo0GfalAkXYJEXaxIPc7bhU2DJERenY99HfqD
	g0zg9QASuH0WeFDFdQdlGV4xucmo64+FD8qCWGUfo/RcJ4QRvaGmrPQFieeX8rG40GBGUVaNEct
	NEg==
X-Received: from plrc9.prod.google.com ([2002:a17:902:aa49:b0:2b9:d494:f713])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2309:b0:2c6:a99a:52b5
 with SMTP id d9443c01a7336-2c718cb1273mr172105375ad.12.1782167298528; Mon, 22
 Jun 2026 15:28:18 -0700 (PDT)
Date: Mon, 22 Jun 2026 22:27:57 +0000
In-Reply-To: <20260622222757.2130402-1-tavip@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260622222757.2130402-1-tavip@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260622222757.2130402-3-tavip@google.com>
Subject: [PATCH net v3 2/2] vsock/virtio: restore msg_iter on transmission failure
From: Octavian Purdila <tavip@google.com>
To: netdev@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>, 
	kvm@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Jens Axboe <axboe@kernel.dk>, Octavian Purdila <tavip@google.com>, 
	syzbot+28e5f3d207b14bae122a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

When transmission fails in virtio_transport_send_pkt_info, the msg_iter
might have been partially advanced. If we don't restore it, the next
attempt to send data will use an incorrect iterator state, leading to
desync and warnings like "send_pkt() returns 0, but X expected".

Specifically, this can happen in the following scenario, triggered by
the syzkaller repro:

1. A write-only VMA (PROT_WRITE only) is partially populated by a
   prior TUN write that failed with -EIO but still faulted in some
   pages).
2. A vsock sendmmsg call with MSG_ZEROCOPY requests transmission of a
   buffer from this VMA.
3. The first packet (64KB) is sent successfully because the pages are
   populated.
4. The second packet allocation fails because GUP fast pins the first page
   but GUP slow fails on the next unpopulated page due to PROT_WRITE-only
   permissions.
5. The iterator is advanced by the partially successful GUP (68KB total
   advanced: 64KB from first packet + 4KB from second), but the send loop
   breaks and only reports 64KB sent. This creates a 4KB desync.
6. The next retry starts with a non-zero iov_offset, disabling zerocopy
   and falling back to copy mode.
7. In copy mode, the transmission succeeds for the next packets but
   exhausts the iterator early because of the desync.
8. The final retry sees an empty iterator but zerocopy is re-enabled
   (offset resets). It attempts to send the remaining bytes with zerocopy
   but pins 0 pages, creating an empty packet.
9. The transport sends the empty packet, triggering the warning because
   the returned bytes (header only) do not match the expected payload size.
10. The loop continues to spin, allocating ubuf_info each time, eventually
    exhausting sysctl_optmem_max and returning -ENOMEM to userspace.

Restore msg_iter to its original state before the packet allocation
and transmission attempt if they fail.

Fixes: e0718bd82e27 ("vsock: enable setting SO_ZEROCOPY")
Reported-by: syzbot+28e5f3d207b14bae122a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=28e5f3d207b14bae122a
Assisted-by: gemini:gemini-3.1-pro
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Octavian Purdila <tavip@google.com>
---
 net/vmw_vsock/virtio_transport_common.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 09475007165b3..35fd4094d771d 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -295,6 +295,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	u32 max_skb_len = VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
 	u32 src_cid, src_port, dst_cid, dst_port;
 	const struct virtio_transport *t_ops;
+	struct iov_iter_state msg_iter_state;
 	struct virtio_vsock_sock *vvs;
 	struct ubuf_info *uarg = NULL;
 	u32 pkt_len = info->pkt_len;
@@ -368,8 +369,17 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 		struct sk_buff *skb;
 		size_t skb_len;
 
+		/* Save iterator state in case allocation or transmission fails
+		 * so we can restore it and retry.
+		 */
+		if (info->msg)
+			iov_iter_save_state(&info->msg->msg_iter, &msg_iter_state);
+
 		skb_len = min(max_skb_len, rest_len);
 
+		/* Note: virtio_transport_alloc_skb() can advance info->msg->msg_iter
+		 * even if it fails (e.g. partial GUP success).
+		 */
 		skb = virtio_transport_alloc_skb(info, skb_len, can_zcopy,
 						 uarg,
 						 src_cid, src_port,
@@ -399,6 +409,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 			break;
 	} while (rest_len);
 
+	if (info->msg && ret < 0)
+		iov_iter_restore(&info->msg->msg_iter, &msg_iter_state);
+
 	virtio_transport_put_credit(vvs, rest_len);
 
 	/* msg_zerocopy_realloc() initializes the ubuf_info refcnt to 1.
-- 
2.55.0.rc0.799.gd6f94ed593-goog


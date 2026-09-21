Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094894A689F
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789998002; cv=none; b=q2eA+hF7gZ+CijWBcgQQolGUM6T2TaW/Se4CqE3gq0sBGcgNtRINamYVl9zpK+BkCV2gYQTcaK2nvAe3ttz4x9oTKybIQ3xMOYFufIperYUPPU7+2JfhPgcSuJs8OT3XLaRTy+tDP6zXzF6cuQDvB4mdVf++DsPI4HqXPpPkXrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789998002; c=relaxed/simple;
	bh=iU1u1X7cruHQchsBcaFSFlP5wT6XT+YL719bzSe6aAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E6bkKzl6iIrZsapoUag0BJzGxgKBtfEOpnm/xFp0zybrQe442NbiDlFHRaaIEFHYi2CwRcZepPeM12nDG2w70oEISBHrbUFP+UJyQcWuDGUyCoKE74IZMmsDeHmjoarAJjbCem7QZ4E1Xha0D9WWchLfVL0bRzZJStcYPqradrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elBFyK9R; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elBFyK9R"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd4ba9f68so41845825e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 06:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789997998; x=1790602798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0usqXOyq3o4rQ+AIVUUfsp1gP3m25NdfBnNXnNuf6eU=;
        b=elBFyK9RLFilzpG/TmAgpW9bxj8muxXlg99N53H3eV4np8s8VqfEDigO00OvlkGv7n
         Gmwp4C5/ob2Pro9ciGOeYH6ThlUqwkdH+stElgaGkZsza5457AQprteLFhFBtMI0NNRk
         AjwFF26AsXoiu/xAOtkESEfPzteWMQET5/oE/Mjkkrm+YL5fhMU5QBjId+7Sb2FcMAlj
         nUSk/v7Om4jnAvdy6dLPkgGs+LKIIX5PIFXd/irK4vABWAb68tvsCguy0Y0XBP38kdoR
         yj4nft0NVHK7jUM/UdVXstPVaL1fw88520VcxrM6MKV/PzME4POYRepXQ7MQFJacuUMj
         koMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789997998; x=1790602798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0usqXOyq3o4rQ+AIVUUfsp1gP3m25NdfBnNXnNuf6eU=;
        b=uKp9oK/ziqUwBp0ENKQ8HAPrss9/LDqo+jvyqYWNel3TMSF2gbidXgMWplJnFhxtfc
         b4sK1Z0k5ty4hrkk/gBGBsih76ZW9p8vk8tfePfl36hFJlQRHVYPOEFvw1vsgC2j2/FE
         ilQSEa3A3WQ0mIwkhdqfCSeixP/ZgJJ+KAl6ca4Zbj1dweHVVL0nd1cl4p9EDZILh9Bq
         jfozbTfaBJOzwj3UCTsK3Wp439y66xdMGhvCviTDZHt1EdKlbPOOenE5qBTce1PMeESV
         M8e9NJQ+IXW3am47Q2uiAhUNk6Xx77Dp1T6p1Du0F6VZXe/TvgNUE9qS5MP0xpSJlbuT
         1eXg==
X-Forwarded-Encrypted: i=1; AKwUvBxh+WL2PNYO9twuB4rQoEcx8uzeW4qtvmALlqf7/mlrBgj3TBSpilaKh5OBxBE5d00mWkgtXmfnM4MrBinG@vger.kernel.org
X-Gm-Message-State: AFuF++lcLQ+omK1PibSyERz5fBkotwvhzhitFVLwFXYzetypSbXYZM5W
	iw8jL/FW6i7WwOO/ECwi1pSLU37m2ODrVeB2y2WLFjA5H8e4jSdyYd8s
X-Gm-Gg: AYBFou32CsJ/a/cLwMoXg5xte/lDgu/eyq8Fc1gGUXxt1p+g3wOkS1nkPXL3HPyRILb
	QQD97kvxyp9KxFpdd9vrvdPE1JcQlC4zv0u5mhEnuH/mVrofN74PJ4VPs4G2YqMlK7sO5hixl3f
	G84Lrqt/01iuv3rmIJ3Ldfpa338WiDbLDFgwetsg1mDgbfMhL0xRWTPU0XrJhoMRDQcLuvU8vXU
	9OoCw1hAyinU8HLBPIbLzg0ERjpSAAxGWVKbYT+WdYKJOEOaIjzBaNL+WzlNkG99eyjrdXZ6Itd
	VJuRSj8oEAgYTSWLaFXqsonzvVCR9e1xJBbcEPGGESgPK9YLWv955F8dD+CgK4Gc7LXWIiTrkJX
	9Nfi8Md1Wuyctus9tI2EYNoi6kCTkV0KB/VbxUZUbUovjr8NqBeZPixkMJlgXolbuOpoqGHzsLZ
	GkfgznEqg4h7xzbSazzJnkHrYVgHfPbYYaz2T9U5j8KIYIRXtUX5geCggnWDPfdcSBwYwC2yoqy
	O18D2P876FQZoSUKuaexKXjX3iggS938zvcu63guwiWMH26QZUm+WvNV7pAviCM8sFs/p9NB/iC
	1zgrla3Il1OS095RQjJ6rxCOG+Xq1smscJwMflTI
X-Received: by 2002:a05:600c:34c8:b0:49e:732e:6b79 with SMTP id 5b1f17b1804b1-49fc574eff6mr149861745e9.32.1789997998153;
        Mon, 21 Sep 2026 06:39:58 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-213-26.dab.02.net. [82.132.213.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc585920fsm617171605e9.4.2026.09.21.06.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 06:39:57 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org
Cc: asml.silence@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev
Subject: [PATCH v6 11/13] io_uring/rsrc: add uncloneable regbuf flag
Date: Mon, 21 Sep 2026 14:38:55 +0100
Message-ID: <9b71636a03f2345bcc09127d77eb6b294a1d0938.1789997898.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1789997898.git.asml.silence@gmail.com>
References: <cover.1789997898.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's hard to implement cloning if the internal structure needs to be
mutable and/or relies on other ring resources. In preparation to such
buffer types, add a flag indicating that the buffer can't be cloned. It
might be possible to add cloning in the future for them, but that would
likely need reallocating the structure and reacquiring resources in case
by case manner.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rsrc.c | 5 +++++
 io_uring/rsrc.h | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 83a7ad9f5bc7..0b526b094dc9 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1434,6 +1434,11 @@ static int io_clone_buffers(struct io_ring_ctx *ctx, struct io_ring_ctx *src_ctx
 		if (!src_node) {
 			dst_node = NULL;
 		} else {
+			if (src_node->buf->flags & IO_REGBUF_F_UNCLONEABLE) {
+				io_rsrc_data_free(ctx, &data);
+				return -ENOMEM;
+			}
+
 			dst_node = io_rsrc_node_alloc(ctx, IORING_RSRC_BUFFER);
 			if (!dst_node) {
 				io_rsrc_data_free(ctx, &data);
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 9ef88383b363..73d7b1ebf0b6 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -26,7 +26,8 @@ struct io_rsrc_node {
 };
 
 enum {
-	IO_REGBUF_F_KBUF		= 1,
+	IO_REGBUF_F_KBUF		= 1 << 0,
+	IO_REGBUF_F_UNCLONEABLE		= 1 << 1,
 };
 
 struct io_mapped_ubuf {
-- 
2.54.0


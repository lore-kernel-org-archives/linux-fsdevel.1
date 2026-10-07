Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAC43783C5
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Oct 2026 01:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791336755; cv=none; b=oy6DiBjOuVqUqJpx6fbKzyDvz+3ewCCjuDn3fFnQ/sgGJwM16dwiJM/U1u+X1MbH2Wo5AAR8ro6uSTIbyvjc1Sc0qPtQE2QW/zaHjXuJ/otCwIS/2T13oaMYrNJcMRP8yB3ZgYuoLb7PaXpjKcqf5hQsOLyEz29db+6PIOnOesw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791336755; c=relaxed/simple;
	bh=sZSKKXCePxitJxwkXP2zXOFTkw2i/N+YLyO84coSzgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UpkUpSAu+IdWRCdcf8F2MP8zDlMztSVHbBJXuWGbH2TKh1dYr+0UECNN8Dr4vFJyCl92tPRpbBOISqEkJgIIi+cLUxkPHCyo4mvdtjT8CxfUlivFngWUFA+6UvI4/lY3bccDIH5C3ZjFURInVSKuKYhpTczZNWPC9/jLMVztZHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+Epunvb; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+Epunvb"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a0286c981dso31547285e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Oct 2026 18:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791336751; x=1791941551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PKjZvbLAs20rdhF/f8LJ7mlj5bzqJB3zMFv/Fdm/dPM=;
        b=l+EpunvbcMA5SflAzvTL9YJ7ZLnJ7g97QTIhTvfYpTW40y+EAPnPf1bHB5YP07UVA7
         5IwoleGBjc47C5LNN2OWSsoX4Ic6axtiCG9bso+LJQ2CrqLwYu6FSGlgmOGg4hzfHcJY
         lI49yX8uq/h2Nduori177q3FrqFwaExhIuRTcSCrrnebFWe13TMdgCmSJSPrk3r7+I/U
         EXY6F0Os0TRBSgtc3K6J2xDIknjIy1KvQ08XkErL10bGQ1r+ExfoekG8UyZvu+PEOsFm
         ifHrKrrNyghLLIsNlJ9QoF2jPnHrhS0Q7AUaBaK4iBoaOFQrCAkNwMgodosaMtL6P8w6
         YazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791336751; x=1791941551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PKjZvbLAs20rdhF/f8LJ7mlj5bzqJB3zMFv/Fdm/dPM=;
        b=eIEqwR98SPU5q5bQq+TrCn7F320EwwEAcBOFfJoCz+SXvGobVpuJnAS6kZgzt0GzXW
         8p6o3fTZqlBRFu0HXTKN+P6NJCi6lZxF5Wo1VywUgTMsP8ZXgh3pCbpOm2Moe2vWrqAM
         N/AMm+uJhEGpmQuF+w4d2JT4nXtsFmD+fNaVqodMa0FZNsEojdKUWO/iVajCBPKK4a92
         RN0oqxyJyLLoXYur6BLMs4O/bwRA3NAjF+2+lp+g2hgk/2n8fbS/hsvuvuNNeKV2pSxh
         Tn94ljsUUbAZiMrscMSyhNTzQSR21KFzfAEcSMFhLgrbrdWMMnrtnR6erQxbnazjSnV9
         w9lg==
X-Forwarded-Encrypted: i=1; AKwUvByF7yqMNhIHvF19gEx7TmN/EoVT0EbjhvFpYXLkNXih4xKS1PWtVxKzd4x3uYR4zfF+BoE88tg5rq3HOlU/@vger.kernel.org
X-Gm-Message-State: AFuF++kubL9gwt2Foo7rCF4cLEK3bS4tdRrcWFTXd8l8ba/JfgSZyCmQ
	wRjajjRpEQdskakwKuB0yG01g1nDciFsIamVeuLSz8CRpPLH39I1W5fe
X-Gm-Gg: AYBFou2fjhb5yEo4xGM9mwRl0wv3y85+o91O1TPyJrlOMWtG7kZmyBHfMUoJ2gAoPAL
	wVdO8TlYFYTGeRS7DzneMtkBXus5gMGcNQ91KVg+wXwDE7AxlpNumIyOX2TUWazEMKjpXi+xVxe
	eW8PG10l0rpnRq10BE6iY2yO7stdWtvDzdeM1lkBVMD8FmsvNOasHuLE8AMFOZPw1hOxlMfIRfQ
	ShR83QQKLjIOFSCIvaXQHtIYiaP5oGbJbY8cQ74KrNnv2B2IMymNZ/1SmJJ9iPaghVEBojTLfR1
	eUTZYCG7comN3aWkT2B+3p0J5KjFANn6QuNBhAPfckF2FFojnFlRWciuoClg0wC0Ge1c9HagCmn
	hns3QAfV3UVh6/3qWVJJ5F27QW+m2b7aBEhMsZj9WOa/HKqTJqJa0GjeLXz2Ic0Bx0AD4uJPMj8
	94/cJguCSokdXYla0i8Uu0l5WpjmtmMOAd0R37l/xHylCZZDZQ4wisAeOISErh5r+muM3n3bbEY
	rFNpp27HORj0ZzQhsljBQhQYXUIuK7kPkSEuu6pNYWpLMlh9XtMHYDlLqflMHeYxbAf2TcbXoZC
X-Received: by 2002:a05:600c:3155:b0:4a1:7ecc:b23c with SMTP id 5b1f17b1804b1-4a18041ad89mr5983065e9.6.1791336751486;
        Tue, 06 Oct 2026 18:32:31 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f6538b7sm21183615e9.13.2026.10.06.18.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:32:30 -0700 (PDT)
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
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev
Subject: [PATCH v8 11/13] io_uring/rsrc: add uncloneable regbuf flag
Date: Wed,  7 Oct 2026 02:31:54 +0100
Message-ID: <5ccde8461121af903a18cd6085ccac98656aba4b.1791336002.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791336002.git.asml.silence@gmail.com>
References: <cover.1791336002.git.asml.silence@gmail.com>
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
index 77e6929f665d..6930a6897b41 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1456,6 +1456,11 @@ static int io_clone_buffers(struct io_ring_ctx *ctx, struct io_ring_ctx *src_ctx
 		if (!src_node) {
 			dst_node = NULL;
 		} else {
+			if (src_node->buf->flags & IO_REGBUF_F_UNCLONEABLE) {
+				io_rsrc_data_free(ctx, &data);
+				return -EOPNOTSUPP;
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


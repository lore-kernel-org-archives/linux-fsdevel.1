Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794870416;
	b=SRYhE3KISbr2DqLW22JYZRtTDQjWtqq1oaucMBNCa/6eXbtSldVyGwkTBkepeI9fzC2c
	 Sc6LDlZDmsBLTaQ2hpgh1mYs5cmaN0fBIqgSfej7TMxuKaWZXBhXlLugpZoQDfWjYdo83
	 iKnNK/L8hq/ZTLJ5L0H5/By3JzZZFnbrFFs4h5wZRDOmHbJx2sj8/WbqPI1PQcCfaVlxu
	 SiyifBFToshzpRVCSBG6HjBVJeGK+qHwlpoBTEGppFn2RyQeOGmPv3c+dZT5yyGtCw/M9
	 3H+NgV3thjUJmE8T2sdCtBus+QAjY2g5CWXGz4CvPgeaMiELpTbtZDexFThG0DIWViA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794870416;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zVQdcEYHvCyjprjE26wtkXBdOfSzxTsxBRAupk9G74A=;
	b=Fg+/1fS2yfqpzJBBgqXuZtGgKV7gkvZSs5QM0y8K5QElqVWSGBWS5hGXy0jrEySSixLE
	 r0YJ/fjSz8+UxEhEU/63ibcZHkJYq6jNBm2O/+abms8OgoMGFw2+DcYya0y/SPTDaoMvP
	 sLYl481knkdJmxN7fTfmrAq2R3OLU9VrI9SDMrbEwYz/3aK+6+43Di2U+J/tKrCFljqbN
	 rphUcrsAgj6Q0h8L+YcZjvQwmH+yuz9UXTRfX3dNJh5wKL6tfYkUhq1yODhcf41HhOc45
	 cd08OOBRs2S1ff3V0A/zSAV/Vzl6ya1iIB/mpd205qKzANqrzYKy/CP/cf1IzgMRJSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="kBxS/UZT";
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D9860A3806
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 23:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61D9860A3806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=kBxS/UZT
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8b5e147f101so405807b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 15:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794870415; x=1795475215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zVQdcEYHvCyjprjE26wtkXBdOfSzxTsxBRAupk9G74A=;
        b=kBxS/UZTglZmGP9tKhITS6JKD8E8PGQDBl6jSDCVWWoYBxwYzsjGicqjnxQFifZ0tr
         kJR6FMqKqG1TshLoJTdhpL+quw3/mgoQKQ8q5SBBquA+mXrP9gJA6yn0sJr2qE85i2cZ
         cfwXg/GLROiqLF6lM4lj+f6UdqUy2/ledI/Ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870415; x=1795475215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zVQdcEYHvCyjprjE26wtkXBdOfSzxTsxBRAupk9G74A=;
        b=SUYziRGUkAbCA2EuU3XR2XL3FlKLrEKlJSQpnSPXsigCOdRdp1Fg4/0yXdQaqCqubE
         qrshhQ2H441oDoJrlASEPXw2OtcQDc0NIrgL590rYnK+bnQKythHN0CQRbcjZcuneZ/1
         zGpOQw2KmkEY0mo03vvIS/KauhLdSTq/+g6qFnTlCOTlyLg8nNwAaErUuI3Sr+7TcvlV
         NvQl9ZM34TB0ukJ6zm4O9d0myJjR8D5lDpYgZ51TpG4Ub1BR7P2kvb8WBfi5v4G0vcub
         fReVbYU/Bx8aK0wbooqZZT4S2JioXFfe6v1Ud555mQ0lr5l0GtVX5cC/AT59OZbWZMxS
         vwoQ==
X-Forwarded-Encrypted: i=1; AL+hErGQh7JufHbI1xeCDoH89lVF64J6aAY/J51FwQz2sJol8LUD8kMDXiLWh5rG5HQ+vM/Cg/qH2lQKkhZVKTIX@vger.kernel.org
X-Gm-Message-State: APuU4Z+nNaOn2l9dYtG5kc2Ln6E3Fs9NyLvHxNR3vBQ8Y+VMC8jXWzRD
	2xTKaD/xUnlGjlxNTokf0FcTiHxdwu7iUiQhEP2GzJdloMZzPSQvQ6er6/ZGlDICjQ==
X-Gm-Gg: AYBFou2VgDOSR4Xq/UuKegYgyamD7kfrX5FzwwRUlG8g04e9iXS8uAyTALxEfKrEsGQ
	kf1UUWzT0osx7TAjdrgwh2ktvVBT8kVyuTTT5og2cy7Ly0eVgTpJNBasI/CiGMu5vc6N3ThKoDp
	x680AYzoHfBxwXj8If2UtHoPqns18jyFjaLgp7kF+wHAFJpu8pGg1K62ATjUHM4T5KUhd4X8Fpk
	ob02kPDiPacfISd7mSjWjL+2O7LH4qD1aeVRqQuTK/eE8CGJa155xBK8g0Mdp2uakmEts/VO3OA
	b7jTcc/NHLV3tKvA+NDfBks21zShvZzv6vpQcRL+U9fkCWCm4Ug+fkRgq6E74MPlXWA9doPr67Q
	zeVuzoGet6LICNTY0VkkCNJmBDcJo9Xs6rqF997YnM6lIwemwBLaA77wrv1PCk/eifeDOZEpt7p
	rB9kdOTu4cAPH9ZPWYWN1OOZspDTkvVg5jaBg+kguTGrjOtPAxDlems/jRU6EX0ay5lKvj2mFIJ
	byGIlPY2uM9dIfX0sahLU4EWXeJ4ESktMKX6i27OkozaWM2RfCp9bs6sfmhtol9qyD9v7OBR5oa
	5FYjrlzNu4ftoVV14CUQkwwmWJDblAlI6nsKdjZFVsndAeFZpuZJ6FacoqK2DEourVrJkBA=
X-Received: by 2002:a05:6a20:3247:b0:3ed:b9c5:df15 with SMTP id adf61e73a8af0-3f7a6aa5facmr12150421637.1.1794870415604;
        Mon, 16 Nov 2026 15:06:55 -0800 (PST)
Received: from localhost (221.247.125.34.bc.googleusercontent.com. [34.125.247.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-8bed1a6dbbdsm4310921b3a.24.2026.11.16.15.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 15:06:55 -0800 (PST)
From: Jeff Xu <jeffxu@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Jeff Xu <jeffxu@chromium.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Marco Elver <elver@google.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chia-I Wu <olvaffe@gmail.com>,
	Dev Jain <dev.jain@arm.com>,
	Evgenii Stepanov <eugenis@google.com>,
	Ian Rickards <ian.rickards@arm.com>,
	Jann Horn <jannh@google.com>,
	Jeff Vander Stoep <jeffv@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <kees@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Collingbourne <peter@pcc.me.uk>,
	=?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Tomasz Figa <tfiga@chromium.org>,
	Will Deacon <will@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Baoquan He <baoquan.he@linux.dev>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Allison Henderson <achender@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-mm@kvack.org,
	kasan-dev@googlegroups.com,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	kexec@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/7] net/rds: use GFP_HIGHUSER_KASAN for message pages
Date: Mon, 16 Nov 2026 15:06:24 -0800
Message-ID: <20261116230627.3537051-5-jeffxu@chromium.org>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
In-Reply-To: <20261116230627.3537051-1-jeffxu@chromium.org>
References: <20261116230627.3537051-1-jeffxu@chromium.org>
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

RDS allocates the pages that carry message payload with GFP_HIGHUSER:
the receive fragments in rds_ib_recv_refill_one() and the send payload
in rds_message_copy_from_user(). The kernel fills and drains them
through copy_page_from_iter(), copy_page_to_iter() and kmap_atomic(),
and they are not mapped into userspace.

Allocate them with GFP_HIGHUSER_KASAN, so that they keep their KASAN
tagging when GFP_HIGHUSER starts to skip it later in this series.

No functional change: GFP_HIGHUSER_KASAN has the same value as
GFP_HIGHUSER at this point. Build tested only.

Assisted-by: LLM
Cc: Allison Henderson <achender@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Cc: linux-rdma@vger.kernel.org
Cc: rds-devel@oss.oracle.com
Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 net/rds/ib_recv.c | 2 +-
 net/rds/message.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rds/ib_recv.c b/net/rds/ib_recv.c
index aa50b85b0f99..907bf2977583 100644
--- a/net/rds/ib_recv.c
+++ b/net/rds/ib_recv.c
@@ -316,7 +316,7 @@ static int rds_ib_recv_refill_one(struct rds_connection *conn,
 
 	if (gfp & __GFP_DIRECT_RECLAIM) {
 		slab_mask = GFP_KERNEL;
-		page_mask = GFP_HIGHUSER;
+		page_mask = GFP_HIGHUSER_KASAN;
 	}
 
 	if (!ic->i_cache_incs.ready)
diff --git a/net/rds/message.c b/net/rds/message.c
index 47d5e9ab9b10..80171ae2f40e 100644
--- a/net/rds/message.c
+++ b/net/rds/message.c
@@ -515,7 +515,7 @@ int rds_message_copy_from_user(struct rds_message *rm, struct iov_iter *from,
 	while (iov_iter_count(from)) {
 		if (!sg_page(sg)) {
 			ret = rds_page_remainder_alloc(sg, iov_iter_count(from),
-						       GFP_HIGHUSER);
+						       GFP_HIGHUSER_KASAN);
 			if (ret)
 				return ret;
 			rm->data.op_nents++;
-- 
2.56.0.611.g1030f0b940-goog


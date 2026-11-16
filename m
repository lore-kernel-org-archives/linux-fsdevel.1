Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794870412;
	b=SvuaKXBo/myNBtkqV8qAm9R9eI3jK1QD8ZlDr8KpB4QJdiQHzDK5RckcopSbl0kbFfL/
	 YbdoHu7FlkfM+V9D4b9061frKRKYYaJmdcNKmdtSMQX7wbH2xi2BSdCDZurZBqFQjKCcl
	 /fwkb4QXhGb0nCQ+ch//3ePwg6pvvP35Y+lTdSztVM40SD+98ce8KwCn1d37a5Iv7FT68
	 hFbcsHL3hoN71KEPlj9HEByYX6MZoHUEfwybKaHw0Qw9h0sXQQQXkGBO4FEGdfy0bIl8Q
	 KnuiNVS0MVqrnn3MghtnIbpm82dbADDV+B/x+zWt1uxZGqwpPMFPWyPJK3Z+K7W9WNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794870412;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=04YMYN0F09iXpQbtyDGXKPSGIzq5fh/Gsn7Dty8ViAw=;
	b=HofOIyYurQYBzpIfEPHt1mLlmXP+IICxBq7KZ/6uuXsjw1qdpsMm+EgKOKh9a5vU4QSo
	 Qib3RYldnCnhxT5mfvvtJJBJpt2VIKbX+FpPAaH7It7i1nc+gMzt9/I2/xWvYdCsZKFHz
	 G2Nyi74kL98CFaZMPjcBtIj+MzDw0vSXyh1RcOGd2kz6SumFZ6y4ldUBr3WdQaGP8o1c7
	 aQPht9wgz9RAyU8R7IHzde2sXBW2JkCf8/GftFjv2xXp+eLvYVvAe/b3rrYJ4mXUHP6Ez
	 rnoF3uyGVj9ziYiD5HwCrDSS2GkXxJRWxB9t2mZrbPoX7c5l9g0cKfHjzpMsJw10a4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Vw4q3+7J;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3349B606A88A
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 23:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3349B606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Vw4q3+7J
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b18bae2d56so594572a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 15:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794870410; x=1795475210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=04YMYN0F09iXpQbtyDGXKPSGIzq5fh/Gsn7Dty8ViAw=;
        b=Vw4q3+7J0GTgcSWFxg4Zuev6Td1Csd2F1YArOtz+EmHp+gxPgNOgtp4qGE5OPD4j8d
         8kMC/9FQsVFuqTXrWeUl/o210OhRp59ba5RQZzU7CkwS6iWkfFaXLl9A8QIJBFxoY1SP
         bjUYPHwoaCqN1KjkM+WmK83bXCgnxSkp1hmfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870410; x=1795475210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=04YMYN0F09iXpQbtyDGXKPSGIzq5fh/Gsn7Dty8ViAw=;
        b=dw4ATSwOvDWs+GZQPqfePwDuk45S9Dukh4eO2q2dm+iLjAVd9W9x/JLCltY7+SK/KY
         EhxomBQLpqCeGs7f+SMBs1XhEFyuvlkDH2ihge7EerMcXPJzLUL9rtjp344vSK6emhku
         EkP1s+deq+mG8EYyEJiO1A6EgDMmUBe9DPOMuiGKQHEqZ59rNZn207Dn6A/+v7dv3qlB
         jGJeKHqn6HghmszCAwZ6GO/iqP/xpewsLYPNXfW16NV1MV2SWa2S7bQ+XUyHPFrlDv3F
         IpfidpNTwTMuGgqchpAP5oUspew+x4F8MXEFzuMnY+hgNQVlVrXhcLkfUVwwxw29Mud3
         VTWg==
X-Forwarded-Encrypted: i=1; AL+hErGE9evhIfhhjx7uRCKNwb6tRTCTAYK6lhUiyt4R2oBN/gq3b3it0F5MxhVBcwbGU3tVSu0kuf39cc9vokms@vger.kernel.org
X-Gm-Message-State: APuU4Z+lAK9LnPXsWEKRpTQST808q6zjGmcmj9V7tr4Y74O0C9iZmGfl
	ElJ6E7GMrVPsrZaW1+kgubR5gwigcUe+QAaLog36WTHWSmCH+2b4cu2zoxQKP3pPUg==
X-Gm-Gg: AZFdTZdkXq3zvdbceYrrqKo1vDGFNjU2PAXUnJfkbHkk7KZcTp/1FK0aoqyTfzs0JCp
	HX/hJLSvydLkvCFwqM6Ct2ButoL2sTDQ10uIlOJ2x9rjrmyck7xrohFai6w8237v3TIrRdmR4YS
	7i5nHdzKge0aWaIPdtKcpUx43CjlwJVSshMCmC1wwPEYB7f/JPObQLhvxbuiQWw6dYNp7C8g4sq
	N7F8f9RZrpdhKNqeZjb+1QooSFb5IaYZOBEZWUwgc4MnOx7RS/rsPp8NyhYYC+jE9eAN7u0UHj5
	px9giBIm8KbH+NbwcjLEToa6jqdb+0rcaZrMhvVLuR4HRjI/45LRiXQ88J2m+Ehi7rzTTgSfs2/
	z3Ax0I8hpsHnlayu6IEtibZE8nS4Mf5MCCk0k5D+1jD/V0zY6gfxQQLLP/ZrRmKEWjYcy8vTKC0
	8+jO8SpXOSRsdgX3oaYU4y5HcViuSUxQiFZufyWyT6rM0xoZGtjMfDAwdIbBUmJeg5WuKxLAtA3
	qK5Q0sOyKvBtaiGW+mzpwmc5oVva4VFPWRek68sQ+Y3AjiHlaZeejOVjpP+tAs7KgT0ZQKZ5hjQ
	pUWNn3fysDPoQNb/DGid4Ol5aBCygrfc+GPmDriLL/trfhWaMz1uNqk5Qao59ucRA7Pc6uA=
X-Received: by 2002:a17:90b:1650:b0:3a0:c162:51af with SMTP id 98e67ed59e1d1-3b1b05fccc2mr17699416a91.0.1794870410469;
        Mon, 16 Nov 2026 15:06:50 -0800 (PST)
Received: from localhost (221.247.125.34.bc.googleusercontent.com. [34.125.247.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3b3abe8b263sm1120355a91.13.2026.11.16.15.06.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 15:06:50 -0800 (PST)
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
Subject: [PATCH v1 2/7] pipe, fuse: use GFP_HIGHUSER_KASAN for pipe buffer pages
Date: Mon, 16 Nov 2026 15:06:22 -0800
Message-ID: <20261116230627.3537051-3-jeffxu@chromium.org>
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

Pipe buffer pages hold data in transit. Pipe writes allocate them, and
the kernel fills and drains them through kmap_local_page(). The same
holds for the page fuse_copy_fill() allocates when a request is spliced
from /dev/fuse into a pipe.

Allocate them with GFP_HIGHUSER_KASAN, so that they keep their KASAN
tagging when GFP_HIGHUSER starts to skip it later in this series.

No functional change: GFP_HIGHUSER_KASAN has the same value as
GFP_HIGHUSER at this point.

Assisted-by: LLM
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org
Cc: fuse-devel@lists.linux.dev
Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 fs/fuse/dev.c | 2 +-
 fs/pipe.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 3641abb90d6b..fdcb11679dbb 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1044,7 +1044,7 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
 			if (cs->nr_segs >= cs->pipe->max_usage)
 				return -EIO;
 
-			page = alloc_page(GFP_HIGHUSER);
+			page = alloc_page(GFP_HIGHUSER_KASAN);
 			if (!page)
 				return -ENOMEM;
 
diff --git a/fs/pipe.c b/fs/pipe.c
index 4fa69192e6fb..87792ef63564 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -155,7 +155,7 @@ static void anon_pipe_prefill_and_lock(struct pipe_inode_info *pipe, size_t tota
 	}
 
 	while (n < need) {
-		struct page *page = alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
+		struct page *page = alloc_page(GFP_HIGHUSER_KASAN | __GFP_ACCOUNT);
 
 		if (!page)
 			break;
@@ -201,7 +201,7 @@ static struct page *anon_pipe_get_page(struct pipe_inode_info *pipe)
 		return page;
 
 	/* FWIW: This is called with pipe->mutex held */
-	return alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT);
+	return alloc_page(GFP_HIGHUSER_KASAN | __GFP_ACCOUNT);
 }
 
 static void anon_pipe_put_page(struct pipe_inode_info *pipe,
-- 
2.56.0.611.g1030f0b940-goog


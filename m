Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583257;
	b=R62/+rpIuIiYtZ45IXCr4dZfZHApliq6JWsE+8QKonwBGRMGUQzqMHbNsfL1DgD4dFSS
	 k15LJNSfGxrJgUrk/8eY7FkhOXB1tpjmpjnHvxxAIqBMd4TPToQV2xIFeFoMeqDMFeQzO
	 90RiEibV2qU5352+DZPIjJyJOE8tBDb21yir+Sh5dFGZ70o3OryzQqLKPmM/hRq76mYRR
	 wQvQQJGdxxWaZd7k48TtsT59LiW8uqMmHXhfsBU9OJIBo5qMi9beKmdUlvypGfOKbxFDE
	 v5k1B1KqIrifQYcYHDDHVKE4GJwSi392XPX+gpL8WZVR90Qk/lVnrTL5wamCIK+bRjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583257;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=xmGAfN0OUSjom6l6tSM04XwloAAVNUFTiyZsdBthbKk=;
	b=pVr8M/etpMzGWV6/5qdX4vx8f+rdagd0bFFSGCT+Ud6FaiiD+yY9731BZpKtdDt58u5C
	 bcHfxBEa6zcxnOoCbY7V39KO/ULM/0/x86hsEPQxG0+68rg1VUg0mXDh6lB2uSEHsHOXi
	 kSk8b4tVVjFtQrsAA9MjtE3S9UNQ1GR4Za3VhP1kLBudBd4mhG/gJENKSWEWYEhJQtWaT
	 NL9xqoAX6qHO8YW6Lv+WHoXZZqWIjQWrrD4zONdIY0qY/9fLSKI9OXYZj87C4AzDBxr3T
	 raL8Ne2I49DgcNuJCfhwV/ldKCfVLWkuGXIbltassjAYus7qlVVYp5ZYBy3HvkXsEdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BeuXHl5T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800FB606A332;
	Wed, 21 Oct 2026 11:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BeuXHl5T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DF41F000CC;
	Wed, 21 Oct 2026 11:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792583257;
	bh=xmGAfN0OUSjom6l6tSM04XwloAAVNUFTiyZsdBthbKk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BeuXHl5ThaznPZ77wIYWyo9/5rDjGihXybfs9KKYrGQFkrH9E7G9jjXt3F+L2XFBV
	 failJjUnDCtrZ8vZHxg1VbR7sPAcVW/7xbsblf3OgQGzSF2pUNtsrezVuvkxupmPpA
	 dh5LvFx7fFd9x5TgqRruffnnc4D7THmdb8+IwXX5mZ14w8s/Ja0UGtywNPUKpzmeVl
	 T3yjRdZ7bFj5+gTCDphvRWwvbpUUWNfa+VUCjFXVCszdquxSnxlT5nxbbZgM05COw6
	 aRLTyc8qmwwgVaQ6A86rB3onZXwCzSlUDawagaZ5KPEpAyuPr+4wwl3noa30meeuYT
	 HNXFOurVa57Pw==
From: "Harry Yoo (Meta)" <harry@kernel.org>
Date: Wed, 21 Oct 2026 12:46:45 +0100
Subject: [PATCH slab/for-next 04/14] fs/buffer: specify SLAB_MAY_ACCOUNT
 for buffer_head cache
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
Message-Id: <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-4-096800aa3330@kernel.org>
References: <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-0-096800aa3330@kernel.org>
In-Reply-To: <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-0-096800aa3330@kernel.org>
To: Vlastimil Babka <vbabka@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
 David Rientjes <rientjes@google.com>, Muchun Song <muchun.song@linux.dev>, 
 Hao Ge <hao.ge@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 "Harry Yoo (Meta)" <harry@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org
X-Mailer: b4 0.16.0

Buffer heads are allocated with __GFP_ACCOUNT to charge them to the
memcg of the folio they are attached to. Specify SLAB_MAY_ACCOUNT when
the object may be charged to a memcg. __GFP_ACCOUNT without
SLAB_MAY_ACCOUNT will not be allowed.

Path: ext4_getblk() -> folio_alloc_buffers(GFP_NOFS | __GFP_ACCOUNT)
  -> alloc_buffer_head() -> kmem_cache_zalloc(bh_cachep)

Assisted-by: LLM
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
---
 fs/buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index ed966fa73b1b..1cbbd065cab6 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2993,7 +2993,7 @@ void __init buffer_init(void)
 	int ret;
 
 	bh_cachep = KMEM_CACHE(buffer_head,
-				SLAB_RECLAIM_ACCOUNT|SLAB_PANIC);
+				SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|SLAB_MAY_ACCOUNT);
 	/*
 	 * Limit the bh occupancy to 10% of ZONE_NORMAL
 	 */

-- 
2.54.0


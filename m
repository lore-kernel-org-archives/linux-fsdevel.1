Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583282;
	b=0OSqew1cneWfZ+yBQCo6jGrVLrzqMnSOD2oijh2PdxGhS13wooXum0cgDExGjz0TTfsz
	 Cqen9Ku35KswsuGzYUKjF+LJfmadticEhqCJXgEbSpyM5vleK/c+LhzTmrldAMy+CIXbG
	 9GlshXT86Cs9m2mvz+Nj2fC5Vflam/O3yuqo8wIvsVm43k/G69uAgGlqGCSGnCDwVVKN1
	 whKvrXAUmTJXtkHVSV1HqCSKLlKIGrfl+bJZV35XKyd3QGSHnz2PhXXvQdEv4AJHHthJ/
	 0VLiPZAkxfvDq0wGA0npAM3kCwjoQg0rzYzGMTVNDucDkkE/eKYmqN5dNzbIkHSovZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583282;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=UIvPhIRZOXHZ5pivfsKNKW7qsEyxT6PjRp1D6g3/ZIc=;
	b=UOtEnsus6wIe1Cy5g2g5FS1VJCgivDPD0Ll3EIAAmaNAeesJqO5K2V/KbI1lWf88GXg9
	 Dmi5sVG5rEsD4/v08HMLVVUy0zVexa2CigEyG4FlZxfuillHFevKo5BuF3cg7WHT9ns8I
	 gtKCf+itjkpGvZyycwJwKWqTn3O+Iet2ONHKl7z5X+AsJFjZnIBSHsY2KPVyFHd8r5JCG
	 HiLx0y0TVefm4VmC1z+skvmsXdDELRCycv7OSFatiLyNeMmVHf3MVuwRm1vB+ZB6iFwv1
	 YfcZ8cpM4Zjz2wguFm1ouxBgbV3fgVRC/qld8mOTATf1MNcjlECAkA6lAf5Kt8r88Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UEiUIF61;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6D4606A321;
	Wed, 21 Oct 2026 11:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UEiUIF61
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59EF71F000C5;
	Wed, 21 Oct 2026 11:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792583282;
	bh=UIvPhIRZOXHZ5pivfsKNKW7qsEyxT6PjRp1D6g3/ZIc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UEiUIF61PWjHXaujmCUo3lHTkwT0rOwBz/pimHwq6xsb98Nk51S5FVHLcVJldFKyE
	 zwT+rIzRyNIMu8C4sh9+s+FxwTZ6rKF54hbhKmChPa4Mjt0iV5H0rmh1+fnpDvvUoU
	 WXFilAFLMjQSWv3qZ+fISA3X1mcD+naUh7LjdzKo9mfmALAl+Xv6lkJxje6RuzTZdY
	 H8aTNC8PTOYMEEEElPz2N0UQGnYBXZF6/CnvEAiDU3zxTxOIqJcpGjlnB98Q6XHGFa
	 SFk9utPZV1TP/6p0k4DHDT5VcjcuhyTgg+eaxnK+SoiI6m0oeHy24LxI6UPpFWwzD3
	 x0YmTpdPrP7Bg==
From: "Harry Yoo (Meta)" <harry@kernel.org>
Date: Wed, 21 Oct 2026 12:46:51 +0100
Subject: [PATCH slab/for-next 10/14] fanotify: specify SLAB_MAY_ACCOUNT for
 event caches
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
Message-Id: <20261021-memalloc-prof-dont-waste-slabobj-ext-metadata-v1-10-096800aa3330@kernel.org>
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
 "Harry Yoo (Meta)" <harry@kernel.org>, Jan Kara <jack@suse.cz>, 
 Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org
X-Mailer: b4 0.16.0

fanotify events are allocated with GFP_KERNEL_ACCOUNT and charged to
the memcg of the listener. Specify SLAB_MAY_ACCOUNT when the object
may be charged to a memcg. __GFP_ACCOUNT without SLAB_MAY_ACCOUNT
will not be allowed.

Path: fsnotify() -> fanotify_handle_event()
  -> fanotify_alloc_event(GFP_KERNEL_ACCOUNT)
  -> kmem_cache_alloc(fanotify_{fid,path,perm,mnt}_event_cachep)

Assisted-by: LLM
Cc: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Harry Yoo (Meta) <harry@kernel.org>
---
 fs/notify/fanotify/fanotify_user.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index a32c6634d592..bc1227e521a8 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -2184,14 +2184,16 @@ static int __init fanotify_user_setup(void)
 	fanotify_mark_cache = KMEM_CACHE(fanotify_mark,
 					 SLAB_PANIC|SLAB_ACCOUNT);
 	fanotify_fid_event_cachep = KMEM_CACHE(fanotify_fid_event,
-					       SLAB_PANIC);
+					       SLAB_PANIC|SLAB_MAY_ACCOUNT);
 	fanotify_path_event_cachep = KMEM_CACHE(fanotify_path_event,
-						SLAB_PANIC);
+						SLAB_PANIC|SLAB_MAY_ACCOUNT);
 	if (IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS)) {
 		fanotify_perm_event_cachep =
-			KMEM_CACHE(fanotify_perm_event, SLAB_PANIC);
+			KMEM_CACHE(fanotify_perm_event,
+				   SLAB_PANIC|SLAB_MAY_ACCOUNT);
 	}
-	fanotify_mnt_event_cachep = KMEM_CACHE(fanotify_mnt_event, SLAB_PANIC);
+	fanotify_mnt_event_cachep = KMEM_CACHE(fanotify_mnt_event,
+					       SLAB_PANIC|SLAB_MAY_ACCOUNT);
 
 	fanotify_max_queued_events = FANOTIFY_DEFAULT_MAX_EVENTS;
 	init_user_ns.ucount_max[UCOUNT_FANOTIFY_GROUPS] =

-- 
2.54.0


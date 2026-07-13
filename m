Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E77B2F7F07;
	Tue, 14 Jul 2026 05:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784007448; cv=none; b=dzw6gqbNuWasFaaCIetwllHqDmwW/JyTys4Qk/MN5WTXm8mzxU6VnX553pWjd1AdpiezypfvQwKf2DiRTWnjeLg3PJtyJAIedn0LkWXisFCr6vfvhfWz5vlvh6z562pLAcU8YpEVIfiIVke5TRx646r8slvkk94KC38EQI+aCCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784007448; c=relaxed/simple;
	bh=z6FQArLCuElTj5bjyJw6X3SvoHjbMNrAEpClkm7UgZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sTBcXPqNa4JW0zJx91Nb6tb98D/Z4GLGEsexhiBIzNK98D6stOrRF0hYgm4x0waqnA13Vno1iekfAsxG0eEHXl9vy4AObnptZHL+sbMwWEfQVQwhJ3aiZB2h0XowzLNFxJO+Q+yextGuNtbZ75ydJ7xS35O27/hJbcJA/guUYm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 143314e67f4611f1aa26b74ffac11d73-20260714
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:73862262-7e6d-41b4-995e-6c0e08d58451,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:70e7befb43287a0e0a0a2e4f907bc485,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 143314e67f4611f1aa26b74ffac11d73-20260714
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 361920587; Tue, 14 Jul 2026 13:37:18 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-fsdevel@vger.kernel.org
Cc: dsterba@suse.com, brauner@kernel.org, jack@suse.cz, jlayton@kernel.org, chentaotao@didiglobal.com, chuck.lever@oracle.com, mjguzik@gmail.com, dlemoal@kernel.org, liuxixin@kylinos.cn, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1] affs: replace get_zeroed_page() with kzalloc()
Date: Mon, 13 Jul 2026 16:32:57 +0800
Message-ID: <cover.affs-kzalloc-v1.1783931577.git.kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: affs/send-local.py

Hi,

This series replaces get_zeroed_page()/free_page() with kzalloc()/kfree()
for the per-inode extent lookup cache, using u32 *lc throughout.

The cache is a per-inode buffer (AFFS_CACHE_SIZE) for extent lookup
tables in process context, not a page frame mapping.  Use kzalloc()/kfree()
for this zeroed heap allocation.

Please review.

Thanks,
Xixin Liu

---

Xixin Liu (1):
  affs: replace get_zeroed_page() with kzalloc()

 fs/affs/file.c  | 10 ++++++----
 fs/affs/inode.c |  8 ++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

-- 
2.43.0


Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B1943F8D7;
	Tue, 14 Jul 2026 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784021291; cv=none; b=OZnNPb0hym0LVMJpdOvZichzxV9117N4gvHuTflD0IJa1xM/+hCP5GsNKiO+1TcVBu57JoISY1f+E4spRNX2QEr99WqHerxzw7/hb/34d/20lNSAcvBsec4QsOH/TXyuBG3LqxT9IKHya6Ujeck2qsV1n1EBsplHOCDvSucPCS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784021291; c=relaxed/simple;
	bh=/OQ6MxISq2fZTQ83OMijKKWEUrYl/DBv5xv/PSb7BWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=flen/yfxFXfGuFdfvKHiNZJ+NWAwt+5VMpOGFz0khgrmHOOgty4nzb/rBZPpQxDwuzzC1jDtTPZUiT0m1imbFU4YzbZyE42751ijUjQoSCPoKCSask7wAogAx4AUGdysywxL39nl285XaMsH8J5WPENp/4fyZXD5f2kvqa01z7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4adf88747f6611f1aa26b74ffac11d73-20260714
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:3ab14871-1539-4b2b-92b1-277ced324801,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:fb159130c0c9f794ca301b1c2fd88747,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4adf88747f6611f1aa26b74ffac11d73-20260714
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1100810845; Tue, 14 Jul 2026 17:27:54 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-fsdevel@vger.kernel.org
Cc: dsterba@suse.com, brauner@kernel.org, jack@suse.cz, jlayton@kernel.org, chentaotao@didiglobal.com, chuck.lever@oracle.com, dlemoal@kernel.org, liuxixin@kylinos.cn, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] affs: fix OFS i_size, sb_getblk NULLs, and rename rollback
Date: Tue, 14 Jul 2026 17:05:29 +0800
Message-ID: <cover.affs-fixes-v1.1784019929.git.kylinos.cn>
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

This series fixes three correctness bugs in AFFS error paths.

Patch 1: OFS hole extend failure left i_size at the full newsize;
set i_size/mmu_private to the bytes actually extended and
brelse prev_bh on the error path.

Patch 2: NULL-check sb_getblk() in getzeroblk/getemptyblk before
lock_buffer/wait_on_buffer.

Patch 3: rename/xrename: after remove_hash succeeds, roll back on
failed insert_hash so the object is not lost from both directories.

Please review.

Thanks,
Xixin Liu


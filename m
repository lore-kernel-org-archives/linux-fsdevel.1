Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11DC14A4F0
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 02:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780972889; cv=none; b=bzQxDYXZRKczHNmhkgJRUv/Y0C2aBuBjO2L62dtt2mYEbVWfDp50JJ9iVpXKWVlqiZRQDlqPNR76RcrI8c0tfvfO2/Tilm04VU9wr5NcQP3arrJhv19MU3SM3Zp+V/vWh2Jmtb1TQw6/TpWg4h1EOVn7VAlUhG7WYEvo2RohNn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780972889; c=relaxed/simple;
	bh=QDGHKCIln9B7lDzMBWKe9TaI18kHgQZFGynPH8fRX5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NayNIh5Ev/wxV/4Lq7Pdv8lsozUX8zwrgL9wR44YCdTmwqWWMh1At53IbEy67LQhZdj6Y1UMCNXtzSfNaRABvLFXjz22x71ToyNFxnwlSN9ad3agBIg3Vep4iBDB1C6O+YufBMAh0L4GkXG1ossG7NESxyeVQLJ6wjdfVC9ki3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b28a28f663ac11f1aa26b74ffac11d73-20260609
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:689a21ea-9fc5-43c9-b0c7-c524a4268a90,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:9175d5319d67c7b973fb48696eb112ab,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b28a28f663ac11f1aa26b74ffac11d73-20260609
X-User: liuxixin@kylinos.cn
Received: from [192.168.122.73] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1646461604; Tue, 09 Jun 2026 10:41:20 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-fsdevel@vger.kernel.org
Cc: almaz.alexandrovich@paragon-software.com, kari.argillander@gmail.com, liuxixin@kylinos.cn
Subject: [PATCH v1 0/1] ntfs3: fix boundary check in ntfs_dir_count()
Date: Tue, 9 Jun 2026 10:29:04 +0800
Message-ID: <cover.ntfs3-b1-v1.1780449274.git.liuxixin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: ntfs3/send-local.py

Hi,

This series fixes a directory entry boundary mismatch between
ntfs_dir_count() and ntfs_dir_emit() in ntfs3.

ntfs_dir_emit() skips index entries whose fname does not fit in e->size,
but ntfs_dir_count() still accepted them via de_get_fname() alone.  A
malformed $I30 entry can pass count while readdir skips it: ls shows an
empty directory yet rmdir fails with ENOTEMPTY.

Factor the shared check into de_fname_fits() and de_countable_fname() so
dir_is_empty() agrees with readdir.

Thanks,
Xixin Liu

---

Xixin Liu (1):
  ntfs3: fix boundary check in ntfs_dir_count()

 fs/ntfs3/dir.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

-- 
2.43.0


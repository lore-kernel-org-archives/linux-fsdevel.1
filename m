Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8092DF6F4
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 02:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784168947; cv=none; b=a2zu84fIWPLEPU5Bp4wJ7SxEwGckUFSFa4QglLb896RvC+kO6icHnYhnqZYDLT+eO4J8Ai9w/BNbdDxaH7psfO6zkzjHLGQOU29PYUPIbX1jDtCRMmMw1hMRE4AOHfi2NjxbhFZqDcFeZgSHVR6gNEHPoiSwGOMDnmN8Ac/XIB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784168947; c=relaxed/simple;
	bh=AnGpF4x+NBDsLoP1m63oud2k+YU0ZerHWOaZ7uchJx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NIxoaYWICX/YosAUN2cgeo1RjQJYoPdioNzAVetn3thfoDOi7b5jkmVYeF8QyVSTSvBykTn0lJYlf8UXKGz+r7gUVxxr3wcC8gMOXhm3z//D5cj8kGRfxdoH1K3efmFFrZpLcwKyED9OyvlRm3mKq1rhqlJLlOjDFydjqW/fIVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1987449880be11f1aa26b74ffac11d73-20260716
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:08603d37-3cee-46cf-9c15-589924228dc2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:6f7100532515241c31354a43525a74a8,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|865|898,TC:nil,Content:0|15
	|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
	0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1987449880be11f1aa26b74ffac11d73-20260716
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 738002868; Thu, 16 Jul 2026 10:28:58 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: almaz.alexandrovich@paragon-software.com
Cc: kari.argillander@gmail.com, linux-fsdevel@vger.kernel.org, liuxixin@kylinos.cn
Subject: Re: [PATCH v1 1/1] ntfs3: fix boundary check in ntfs_dir_count()
Date: Thu, 16 Jul 2026 10:20:00 +0800
Message-ID: <reply-konstantin.ntfs3-b1.20260716.liuxixin@kylinos.cn>
In-Reply-To: <abf5663b-68a3-45d4-b6a2-375d99fe61b0@paragon-software.com>
References: <cover.ntfs3-b1-v1.1780449274.git.liuxixin@kylinos.cn> <9211aa31fd02d45e42b4981497c6572ad8e26144.1780449274.git.liuxixin@kylinos.cn> <abf5663b-68a3-45d4-b6a2-375d99fe61b0@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py

Hi Konstantin,

Thank you for applying the patch, and no worries about the delay.

Thanks,
Xixin Liu


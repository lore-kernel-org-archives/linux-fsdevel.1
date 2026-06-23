Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3451033F361;
	Tue, 23 Jun 2026 09:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782208621; cv=none; b=qRuq/5qMinhf7QGTHQrWzHn7ahCRcERb9NXkOmhp+wZDt1iMNfzwyEyQBiRLo9YqlP00aOFlalGxFUj00rs2fTJQTIlm0mBPkk+SS8t73tW2hflLEZmWdIJ9W8Ruidy0TcjEdBui17svWs647b06h1f7I687LBz8VcjSGEZktuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782208621; c=relaxed/simple;
	bh=yG4yXRaZ3kft6oknPdvtgINUD4v3PqTns8m7+GPGKCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I1NkZTgItDPCb8gXzyj4Y6YwUt0qglSEF1NqwMHtPz6z4TgMLA7u6Ve9b+/6xuDwFwTAVGNshCHK+CrNZI3K9L76hgAZeiim0s3Gml38sfUcNV5lG0rPAUkAmo1AOIBDYqcoOrlP6vuHsvKJ7NMhxZiLY26rrCR7K8ddLCIGsGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: dbd692386ee911f1aa26b74ffac11d73-20260623
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:d7523a35-4669-4746-a931-191c1311e91b,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:21992dfea4215b877f41caa6ae3c6d5c,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|123|136|850|865|898,TC:nil,
	Content:0|15|50,EDM:5,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_ULS,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: dbd692386ee911f1aa26b74ffac11d73-20260623
X-User: luoliang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <luoliang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 889360935; Tue, 23 Jun 2026 17:56:51 +0800
From: luoliang@kylinos.cn
To: Shuah Khan <shuah@kernel.org>
Cc: Liang Luo <luoliang@kylinos.cn>,
	Christian Brauner <brauner@kernel.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nsfs: fix wrong error check of NS_GET_USERNS result
Date: Tue, 23 Jun 2026 17:56:48 +0800
Message-Id: <20260623095648.440638-1-luoliang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260618070805.144324-1-luoliang@kylinos.cn>
References: <20260618070805.144324-1-luoliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liang Luo <luoliang@kylinos.cn>

Adding Christian Brauner and linux-fsdevel to Cc. Running
get_maintainer.pl on the parent directory
tools/testing/selftests/filesystems/ surfaces additional frequent
contributors that the per-file invocation did not.

Original patch:
https://lore.kernel.org/all/20260618070805.144324-1-luoliang@kylinos.cn/

Thanks,
Liang

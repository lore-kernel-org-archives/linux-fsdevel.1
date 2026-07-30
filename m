Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9BB4028D8;
	Thu, 30 Jul 2026 09:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785405356; cv=none; b=HIgaNHJvKGSlYBqMTUmlYcGM1+9iG3LB2oCFqABRM4x00abBoM+/oPsjgepsun9r6/mVGpEmCQ6sVfpu47DG9Ge8J0RpzrM7hbLln5yqNbp7/bSH9oAHyfvmOIMzs0MsveD2puf8WZjNzHhBS0MP/Xz/dK9Por3wRZr4tbrOpZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785405356; c=relaxed/simple;
	bh=M5/koxxn0ugyrMzZKVuuf6hp5KuOxqayxGxlP6elYmQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dXErIdFY0Fr649helU/+7lzRIEkKZUFc64/iWpZxWhnAZg/7xAJz8Bo/7H7vvi2NmFkjeMtHI1Pkbg4jGVLJLYxuxms1VcG8qceggFnigS3EQ85jstrRH9h1vxXDmuaR3qnwwgQJbyprkIULA/mIpnPllHvn39g3+/zqpqY+Iag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=BNuBQFaw; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=sG9d4O3I; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="BNuBQFaw";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="sG9d4O3I"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 2535F209655A;
	Thu, 30 Jul 2026 18:55:51 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1785405351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M5/koxxn0ugyrMzZKVuuf6hp5KuOxqayxGxlP6elYmQ=;
	b=BNuBQFawSw06pB/pIPGD2OiFNst51lvH+vJ/ZOS8dufR60G2joH2wNOmSr2fgXcgKh4DoS
	OYtmfTmlkzrG3qmFEIN8CNJRf2wpJYnCCnZklpMP9v/kN5251I/lpGIjik9ddMIPS5Z/73
	MxLDgnmv3euHkjOUCXZZFJO63myyqGR9PoL0xVX3eK70edKR+cOTRN71zEh1klCKHP09sW
	EHBPgmIEeOQuZSFu+xRymUeP3fhd1ZB4McXil2GozD7snuXl8bUIwKinJwv/M6YzHgm3lT
	y+ByNjYGMTHGCUbMqi1qfF6yB8kIRgsnYHSnDhPInQR26U3E8Y98xmhdL5xlBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1785405351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M5/koxxn0ugyrMzZKVuuf6hp5KuOxqayxGxlP6elYmQ=;
	b=sG9d4O3I9UyutnRlzJRVyyECNIIO6rrpmCXyIAxuHNHp9pvQej/srHjzKWe6aH6KJCacKg
	JEZQX3IwkFu/43Bg==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id ACD3AE0099B;
	Thu, 30 Jul 2026 18:55:50 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id A26AB2200185; Thu, 30 Jul 2026 18:55:50 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: guibing <guibing@nucleisys.com>
Cc: hqfang@nucleisys.com,  linkinjeon@kernel.org,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  sj1557.seo@samsung.com,  syzkaller-bugs@googlegroups.com
Subject: Re: [BUG] fat: race between fat32_ent_put FAT update and mmc_spi
 transmit on shared page
In-Reply-To: <976A3274AE66DB00+9877ce61-dcab-40c0-bcb3-08fbf30548b7@nucleisys.com>
References: <3C3DB358BBDEF242+9bbeab6b-4de5-4fc4-a4c5-fefd915fb562@nucleisys.com>
	<871pckvq3t.fsf@mail.parknet.co.jp>
	<976A3274AE66DB00+9877ce61-dcab-40c0-bcb3-08fbf30548b7@nucleisys.com>
Date: Thu, 30 Jul 2026 18:55:50 +0900
Message-ID: <87h5lg2449.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

guibing <guibing@nucleisys.com> writes:

> Hi Hirofumi=EF=BC=8C
>
> Thanks for the explanation. I noticed that syzbot has also reported=20
> similar data race issues related to this. I was wondering if there are=20
> any plans to support stable pages for FAT in the future?
>
> Could you help me to review the workaround ? Are there any potential=20
> issues with it?

Your change is unconditionally waiting the condition. However, if it
doesn't need the checksum or such, later overwrite will fix temporary
corruption.

And the issue would not be only that function. All metadata would be
target of same issue. Also, no need to wait whole page, just a buffer.

Thanks.
--=20
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

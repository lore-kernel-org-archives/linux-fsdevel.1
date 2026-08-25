Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9653F356772;
	Tue, 25 Aug 2026 04:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787632321; cv=none; b=uBNtlvqzLvO3+qkDA/bnB49ZNDeDFGJ/dSDcVwvYPsuoyljSmCZHFRyRyBpKQswJVQz26cKc3l6Ni9KXHACMKxcO+rQ70Ya3jfBsUsiXnpa7QuQ47q2KNcBbZUzppBL+zBhz5JQIOSKEtYpMDR2jBcuigcGHFy6oyAR4/pRSB7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787632321; c=relaxed/simple;
	bh=aJnK90FSt755JAJsbV3kIKalVnrfBmcWPLuz1sBsOQU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F5zgpnaXOxa5e+RPKwxI0B/ZdcJ4ZyjtB2zLGb0reb4TOn3HtY30x6IHVqTgf/IZ3R/Ej+3sh0I26h6aypWuSxhPJbuxRsMvLD5MU4lj5G0YogOEMct4LvHHsiTc63Gwh2znkv5SxVd3rTKpK0MNGGFh/788+IZwcBQzJYlOFfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=mzcoBNvH; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=87Zv93jw; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="mzcoBNvH";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="87Zv93jw"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 5B38E2096798;
	Tue, 25 Aug 2026 13:31:55 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1787632315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zjTbPJM27rJA89OB9jMO2Eplt053t8dZL9wr02py4xA=;
	b=mzcoBNvHVMof34R0QQuPgJo9iaKAr1cNx//+8UUQ6xU8X8duZK6kbmF5Au57hkfj6qXCVc
	VRo5fLcx1rWg3MuGyaPExJKiBuENr2tGcNTw+Q7HrxUENZNtuov/n+q94rerVvoVwoEW//
	8EPhKu4INTlEPzRrQP+HJ2EVlyEG/v1Bfbt+B3Ce/0fAgMNg4FNgLbmxoo4xuPUccAKeHu
	abR4eHsjmdTPeCQ+Q3W7Dj17bdog/vBUoNKOTdgsnXBKR5wygebHG3xLm3x1Ex2IXKxdTK
	fSnXj/5Q9H4qV4b1Lc9vNVuV0BXcUgBxbKVcRu+pUKBrowpdo2W1trswOpNVSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1787632315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zjTbPJM27rJA89OB9jMO2Eplt053t8dZL9wr02py4xA=;
	b=87Zv93jwVlZc8aPWsKjDHzbCGJLw7T3PEVyQ+bcTpy//ewZa1MsKV2LPTeAZbSd5oA3VhC
	t2La/HQdLdlDv/Cg==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id D808EE00090;
	Tue, 25 Aug 2026 13:31:54 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id C043122000D1; Tue, 25 Aug 2026 13:31:54 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: David Timber <dxdt@dev.snart.me>
Cc: linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] fat: add noflush mount option
In-Reply-To: <787aea79-beb0-4f29-bb67-ee57f6c654c4@dev.snart.me>
References: <20260822173732.10230-1-dxdt@dev.snart.me>
	<871pbn6edz.fsf@mail.parknet.co.jp>
	<787aea79-beb0-4f29-bb67-ee57f6c654c4@dev.snart.me>
Date: Tue, 25 Aug 2026 13:31:54 +0900
Message-ID: <87ecfmrfb9.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Timber <dxdt@dev.snart.me> writes:


[...]

>>> @@ -1110,6 +1114,7 @@ const struct fs_parameter_spec fat_param_spec[] = {
>>>  	fsparam_flag	("debug",	Opt_debug),
>>>  	fsparam_flag	("sys_immutable", Opt_immutable),
>>>  	fsparam_flag	("flush",	Opt_flush),
>>> +	fsparam_flag	("noflush",	Opt_noflush),
>> fsparam_flag() is not including the "noflush" too?
> I think I should use fsparam_flag_no() here. My bad.
>
> It seems that you don't object to the idea. That's a good start!
>
> If we want to do this, the
> documentation(Documentation/filesystems/vfat.rst and mount(8)) should be
> updated, too. fyi, `udisksctl mount -o` won't accept "noflush" so
> that'll have to be fixed, too. Also have to make sure if "noflush" is
> used in fstab, udisks2 overrides the system default settings.

Well, with a your patch, just remounting without "flush" option doesn't
remove flush?  And this is a user visible change more or less, so if
there is an objection from users, then it will be dropped.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

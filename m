Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793377611;
	b=u48nlaX6M/m2/VZv2Ndt9Y9Kbkv1KpJH5bQliVNKjQIWvlPnIkZgDXrNtZV6m/iW8WLG
	 KLCTTg7jKaPu4WkZmkKx8Q+zCzcGAYe1izMKcXawopgDLVGcqZOCoEpUVzzGm6Ub91NBv
	 +AeXu6zeyhsf30KdyJ91YheZTSRaJ6zzB7kb7nTEhQjEo4TMZ08XAmhpuEg1FYWM1O7U5
	 l0/TiPYmKFCLUyrCihvX5Ds0dS0p/ozkh4Kk4cno9aCKG68pvUtLiTRaFV1PTd23Byi3a
	 NHMwOoCw89FFa5Jk28f4MoPneelV8ByejBxHXBghQdEGRy5BTZ1/z/6AXXL7OqY0Rmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793377611;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=UqTj7R0pwlnTMXjf/RenNA8RWxehVq/xEHeqhHXQaug=;
	b=eb4oXGpOoNbml99svHV68qE86S2mPKifB9NMf7lnrYXgGun2y2KKJ9uQqGIASXJQPJ7D
	 goTxbzrxs1iYl4Ypi+9wx6cpVEX6NleC3+KLF9Zzar20nOwwJkgwWArAEB6TEELi3F24E
	 Qg2T9439XNh5UA0xlGpMvvolPUPv0TIimTNst513D4d3h3vt6BQJjKgtHcfg5rOaa+YAW
	 enygLtkrK9cqxORbu7QQRz94xZNYCED+fvheVoFLeBtMLX3P9vc1rv4n2mkvuAD6+ZmQ2
	 b5aEeKJc9HzQ/oWEze2BxetDKdyAuYsDv2V8LdcF/wsDBgrI7jXvgG6Cwyy/yell05w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eY57jPO5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D8E606A322;
	Fri, 30 Oct 2026 16:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eY57jPO5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D241F00A1B;
	Fri, 30 Oct 2026 16:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793377610;
	bh=UqTj7R0pwlnTMXjf/RenNA8RWxehVq/xEHeqhHXQaug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eY57jPO5Xkxq2uq8qjWCQlAaydOs8nS9+jG36tgegPGMBtZhET13K0YceJ7PkDTaB
	 0ShzUMNfeuKAhleB4RdOWRYTXqWLnC4Q3iBDCKsak18kqN5fQ9JX1FamaZnCp0IUBO
	 NUASPDoGSToGdzXrSfGQPCA2b7SZejIM+lZGJnSziLr7kDtsUEJJA0wGMVvMFfU43x
	 EecfUPNPWfAUAVEWYGE0ROqCcaFyM9ucgY8hGe5+b29Y84/JsjnH8tUj9QDw6ewPTs
	 HkHkJ3L3+0fkL88+eq1lgmGFBToy+hm87uY/zbCQg4UpXw5FUZI7hP6gzvTkus+ZAT
	 euVlBZ/XpDa6Q==
Date: Fri, 30 Oct 2026 17:26:47 +0100
From: Christian Brauner <brauner@kernel.org>
To: Marouane El Moufid <eun0us@espilon.net>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/sysv: validate free-list counts from the superblock
Message-ID: <20261030-ungut-saugt-benachbarten-6d4d5cd7de92@brauner>
References: <179296581973.931625.11883539052974567803@espilon.net>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <179296581973.931625.11883539052974567803@espilon.net>

On Sat, Oct 25, 2026 at 10:03:57PM +0000, Marouane El Moufid wrote:
> [PATCH] fs/sysv: validate free-list counts from the superblock

sysv was removed in v6.15.
-- 

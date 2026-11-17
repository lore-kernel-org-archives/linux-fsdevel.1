Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923392;
	b=ldT76j+d5Xy9WkQT6pPNlfPV+gKitABV4TGT0LPiw+CEUyM7bVvS+0MoL1IAzwMzq7xV
	 Ih5gPmdao36jd24mONvmPemZFEJ56tiEAB3b8+Kj2yk/B3iU7Wrgu1o3NiPDItMI2Qx1r
	 ZqEipaMfHLzyAT4bDbb3kSykb8SUkIXz7EhscPfB0HrI/k2F2nWyTGoz5uiV5vQb6WCAV
	 Z/KG4qfsBBbE04Rna8svh2A+mWuVDDNYdj/1aEt+XjuQ+mFNa/7oM6MA1VZQT/fAR2BGj
	 gjLJisfQM9LhLpzzhLWu4NxP+ZVUnN08ea+1QA2VYZfjHx6jZOMEc+u+mOWRLZ2GGpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923392;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=47hLO5bsk5qu1Oh/V41Ywjaewmik3CTKm631lRB8I68=;
	b=UYuZEjLx+PeXGkE8j/FSYobjiVU5rvi3cEKwsAehiKEEDiAaIVLRau83z7JMd7EuQG9d
	 QC14LiEPeeCZtlDKA09kDKYoBnSK7APUSGLCxxu7QGVQVl9y0CWkfD+L/12r+KPtNGSh7
	 wIgwso9PoNKmXKHt5lC1hFPwbXdp/6/CO+QFP2+4EHnZM+ZyzIsXZrRlm5tjSwQ9jpjTV
	 PquMXw0eGd0Tj4JtGZtLEWTrhgnBWxlXWMsnHku4M0vdWRu9GUoajn8Lry98GDtdQ8txD
	 jOo0XZsrcejuWBof9Tfr6qYVYsGz/w5IfbFoJ1wwhoJ+9FAwUPCG1yXGg46B/liawpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gHCJuUzv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989EF606A331;
	Tue, 17 Nov 2026 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gHCJuUzv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850C81F000C5;
	Tue, 17 Nov 2026 13:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794923392;
	bh=47hLO5bsk5qu1Oh/V41Ywjaewmik3CTKm631lRB8I68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gHCJuUzvekaWRtvN3rwlIXMLCO0QH/tVspIL1i2+MDwy9YZbY/FfQnZyRVGRcHEyT
	 OhMNUJl+72lWtG82xJKdsQnb9DgezIXsK8x6907iVXSXiWDjMJuxo6Df3y9egrScUM
	 YAG7HSxF+uzCcFEMe1jobBD0/KkwQ3OjS5G7S37iaLfjPE1dZ+Dy5uD8U5oUz3WcXz
	 GH5QR7M4Z2YQdvSwY7EKxynbVwI6EUicFtYqWfGHQhW+4kODFXsNhTtvP8AMGSx6EE
	 fdgBs8BaPfgC3BZIgJhZoCX6BNXAzC4U9fjZNqdO/+TP4cEXCOA7+Uvozjqy8yRlin
	 27mgfGSwzhlLw==
Date: Tue, 17 Nov 2026 14:49:49 +0100
From: Christian Brauner <brauner@kernel.org>
To: Guikun Yang <yangguikun19@qq.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qnx6: validate di_filelevels against the block size
Message-ID: <20261117-anheben-kauen-botschaft-efbcb6e18d72@brauner>
References: <c4-qnx6-filelevels-ubsan-20261031@qq.com>
 <tencent_BB8BEFED1159A70D5381A81D1F8EA88BD407@qq.com>
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
In-Reply-To: <tencent_BB8BEFED1159A70D5381A81D1F8EA88BD407@qq.com>

On Sun, Nov 08, 2026 at 10:01:00AM +0800, Guikun Yang wrote:
> diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
> index 1111111..2222222 100644
> --- a/fs/qnx6/inode.c
> +++ b/fs/qnx6/inode.c

Same as your ufs patch: this diff was never produced by git. The index
line is made up, the second hunk header doesn't match its hunk, and the
Fixes: tag sits below the diff. It doesn't apply.

I'm not going to fix up hand-written or generated diffs. Generate
patches with git format-patch from a tree you actually built and tested
the change in, and send them with git send-email. Anything else won't
be applied.

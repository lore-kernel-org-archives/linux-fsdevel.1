Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.79.88.28
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794495489;
	b=hYethVi/9827oTjvSpz0eOoku0TV6TrzY/0iqfQNwZs8A1HnAm29SqgtY4FMcCiHOPPr
	 WTl/ucpsYHW9qNphOmgzkgYCldR5UasfTCDJDHfE7UQzlVRbqzXOfRArkhRSsPDL0TC/G
	 1sunUwSc6HHRjsA3/JsDoXiZqQqIc9DlOgjOaMx4n+RSYqe96sQ+az/4pkj65yOWEOoUV
	 QWpFXBqdHXzBmjrRU6Nbflo1g1lhtkF1f3wBImiIz6Z5V2xHdTogLWbLyRCQ37Mejufax
	 YPdgsNdeJ9upspKeh3WJxZz76a9/+h2nfObqg/7FIFwVMq1bkLzCcNPxQEu/mBx1Xqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794495489;
	h=DMARC-Filter:DKIM-Filter:DKIM-Signature:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=mJiAcVKGt20rwDbtZ267Ib5ukUoWE5uGUXiOfLnifSI=;
	b=QsJuuvSXtqNThSHejACT+ZD/iFqxY6BaGhffH8aW+hNDEuTqe8HdjXliShGT5W8OUBum
	 /c1VZyLpFn3N/r/+SawZMoMUxCHg9j676l1xg8sFGJdVOaeQO75PpGtUqFctYRByonw1r
	 epyxqbTON3hV720qEtVFsxGBV9azQw9zsHGyn2LEMx0nbGEPC/S1iEVlgr1CTH9B9tsjR
	 bZcnJhtu4ii5mXcAsm2aPVujFPYwY6qDcYCaG5gbqTFkWm8dnONLTQKltA5wW0wIm5ubZ
	 xI4eCG6yNI6Ga3r3WHGRdR39e7HufiHIhSMDQHxWjM9rSfvnquunIc9r/l2WG3wTJ+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lwn.net;
	spf=pass smtp.mailfrom=lwn.net;
	dkim=pass header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256 header.s=20201203 header.b=ofZudNUj;
	arc=none smtp.remote-ip=45.79.88.28
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3351D606A321;
	Thu, 12 Nov 2026 14:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3351D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256 header.s=20201203 header.b=ofZudNUj
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7A40140E3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1794495488; bh=mJiAcVKGt20rwDbtZ267Ib5ukUoWE5uGUXiOfLnifSI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ofZudNUjfxzIuc9YnHvCSMNP3UdhwIEUjeA4Qksu4oSV+kcM2Zkdw0VZqr+bnMNoQ
	 8sGZX0i2YEdZVE4tgmRCyk8os5+9sSkmT2qP01AXr9+rDeoaLCypLarG9JLbctGmR4
	 oSlhUO3rwjREHzNMlo7L/D3l6TTO8Lk0UJqMkYkir5EDJuTvdXUDelPVFZ36TS+piu
	 to2OPMtqoH34RZiQt531jjc2Glmh2phGWbqzitA55enpGpOmmtGkDdNChOeBpQh+oP
	 EGLEAolGcdJirv0Onhhoi0aajMz114GBmM1JQQbtGbNOsambcbftbkfVDP9lu6j0xd
	 yWJ5CH3/s8y7w==
Received: from localhost (unknown [151.38.237.230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7A40140E3D;
	Thu, 12 Nov 2026 14:58:07 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] f2fs: fix various ABI documentation issues
In-Reply-To: <20261103033713.2709978-1-rdunlap@infradead.org>
References: <20261103033713.2709978-1-rdunlap@infradead.org>
Date: Thu, 12 Nov 2026 07:58:04 -0700
Message-ID: <874idm6qrn.fsf@trenco.lwn.net>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> Clean up the f2fs sysfs ABI documentation:
> - use "number" instead of "#"
> - use "seconds" instead of "secs"
> - remove an extraneous period ('.')
> - add a space for better readability
> - fix grammar, spelling, & punctuation
> - break up comma splices
> - use a list for "gc_urgent"
> - add a blank line for the list in "extension_list" &
>   "effective_lookup_mode"
>
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Chao Yu <chao@kernel.org>
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Cc: linux-fsdevel@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
>
>  Documentation/ABI/testing/sysfs-fs-f2fs |  114 +++++++++++-----------
>  1 file changed, 61 insertions(+), 53 deletions(-)

Applied, thanks.

jon

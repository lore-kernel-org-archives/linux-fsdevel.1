Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.89.141.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795364418;
	b=zDjfPbtddh/olnJEAIeUJbv3V52GSINbS0i6690+NMByvInkDzAkPWdO6zUCdWdt4far
	 KkrRzlOyc16dYYxq/zyqS/g1yIcRxbHkPL1/sKF6Ibk+tEkARGh/wD75yNwdpI1GyBKpX
	 0kxPJqzGn1XVCWv1ANPN1mRHEIs9l27pALHOKPtpandJ8giE3SS69jBWvLPlM3QJtIZWh
	 Qo3232fB8jSW/55flBJ7yvbxWy71p+eb/hW9tI6ZL2R2Mv2XSP3E2q00Wpm5GnmlW2MHf
	 Tyt5rwuF0ok1EWQz8vEcbpKPAeohPV0zEeCU7oQ10k+KKKa/jkr8DipXiE7cA2ZsQxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795364418;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:Sender;
	bh=3DbqJp0X7Ve7PIo1s2t06ZLb4Fsl6YMV0xgxf3cnB+E=;
	b=TDzPrce87ZxD0vwxZHZzf90pqz7TbVjtsHka9mOn5s6R7Dwq+nCpVajmZw/jXMmnWiDi
	 nIx5kYtgkAv/TW/4uMDFCzVTvjo85GlufVyMSKSkMbf2XqlUCBtc2eyXB0khz3GaOiqph
	 Yph9yY/9/S0QEnMob6WIC4tcMXNP78IoPY0nGDbN1aBTVU0aEWX7iCM8psXbxlcEJfBHv
	 5LqwFN2UbPba6zSsWq9VDKILMHXDZOXywP1keyptVap6w+kvnLfP4eHW0cvgc+hAQbpFs
	 kh8FGA/VHCjfvGQr0yPr76kUlRnMfnGcu7llYzUb5rHcPGz2Ix51TrVJH9dLe8t/Y0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zeniv.linux.org.uk;
	spf=none smtp.mailfrom=ftp.linux.org.uk;
	dkim=pass header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=ZS2gWTBJ;
	arc=none smtp.remote-ip=62.89.141.173
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D309A606A320;
	Sun, 22 Nov 2026 16:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D309A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linux.org.uk header.i=@linux.org.uk header.a=rsa-sha256 header.s=zeniv-20220401 header.b=ZS2gWTBJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3DbqJp0X7Ve7PIo1s2t06ZLb4Fsl6YMV0xgxf3cnB+E=; b=ZS2gWTBJzykWsmG5LVmWZttcK3
	3SJwQsFsbVVgjAyjc5UXa4bWBY11SEvfuhmEvYUR1fb9qP/hIstmGDYyBQh+hMuQVi7wtwmrtm6Pr
	Rifqqyw+AmKrzjmKVckCJhMaNKAzNnWp3yG7huyZR1LqQvoLHXGGZ+rJ2bU57nsB9jkgpKiyAplQp
	GDl6Sd9xnwH9QL/HKZgQ0T9qhZ5GTwGj5GtdLCk5etaPTl90uXLo6tzrgw2YqHy2A8mMnJa2uD1vT
	8SSwDeszZzn22s9H4HG+3maQLAVxWe9FECYGkrtI4VPD/kPn8iv8nwRxUVEfskpz95VbT1Mfh6usj
	fgWpX0jg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVAIX-000000029ZQ-2UK0;
	Sun, 22 Nov 2026 16:20:13 +0000
Date: Sun, 22 Nov 2026 16:20:13 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+5585f47221c0de04168d@syzkaller.appspotmail.com
Subject: Re: [PATCH] ufs: validate block and fragment shifts
Message-ID: <20261122162013.GA453747@ZenIV>
References: <20260925043337.87879-1-matheus.aalmeida@inf.ufrgs.br>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925043337.87879-1-matheus.aalmeida@inf.ufrgs.br>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Sep 25, 2026 at 01:33:37AM -0300, Matheus Alves de Almeida wrote:

> +	if (uspi->s_fshift != ilog2(uspi->s_fsize)) {
> +		pr_err("%s(): fragment size shift %u does not match fragment size %u\n",
> +		       __func__, uspi->s_fshift, uspi->s_fsize);
> +		goto failed;
> +	}

That's an odd way to do it:
	if fsize is not a power of 2
		fail
	if fsize is below 512 or above 4096
		fail
	if fshift is not equal to ilog2(fsize)
		fail

Why not
	if fshift < 9 || fshift > 12
		fail
	if fsize != (1 << fshift)
		fail
and, while we are at it,
	if fmask != fsize - 1
		fail
is also missing there...

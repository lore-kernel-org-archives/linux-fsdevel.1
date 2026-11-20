Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795181179;
	b=5aCj3UtvO29PbrPiw4OBWs51zBJYStKRbw4jL+AO/L9yGEg0Sy9oZvUCzf59QPgGiYHE
	 5LFCQ5xrVAanQ7lR1FoZmlduwGlPT75gerHa7mL4asHRPuApH4ibKi7BcwwCK/M2ti9Xo
	 tiauICJbsHKJZFlDU0vsxXH7hoUDJ2vQYT64cZupuuz19xOzjUAh8W3wce0cxWneEhm9g
	 E3a3mi++24b3lZPWnclhTZY8Svr8+FJoc5DvpzxAAslk7e9YzAQ0YqETfrpyZydWF1Xoo
	 BchoxjBYacClnloPsC2IMnjrdL2rFXataYYX/6IkSpVPllYCw12AzZJ+xDqFwVbn7oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795181179;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+qPEsvFXONL/okawMye/YF1v1r0UqU9jtonOZSZ2n3o=;
	b=BxYtJyh+vACTm6c4/ke+gJg3CuHeETBnNhYVDW9MBFnr/B3JZZkGJMJ0J7jO4hk1G7PS
	 v4vXkfhg8sIMg9VMRm1a0QB+yuSnOxB4/2MMQYFgVyFVpJPJVTvizA49orFjimqfDvXlR
	 w/8Xiwseuda+aDcqH8bJMNzdDFqNAdjvUrHGDg+V3aathhXSTPeEHdKPcyGq+ZYMXQBTS
	 MkfUHx45FCIPelX58/viCS5V46NJQr9SO6nANB+CikfKKPPo9NU0tG1Gys0ib4c9AjGT7
	 Is/3v7XF0GqwXpEbiq1msVHSBt6onceh/5TSXCdkuwbmRGYpDHsbW8ybWedMPDmGGsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aehjaZRL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D244606A33F;
	Fri, 20 Nov 2026 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aehjaZRL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74F41F000D4;
	Fri, 20 Nov 2026 13:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795181178;
	bh=+qPEsvFXONL/okawMye/YF1v1r0UqU9jtonOZSZ2n3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aehjaZRLMjwKbowAbOLoRQR48dZroMEfnHf/YoyXYDEft+Ee52TvKcVEbs+mpbw/A
	 l+4bEwvDRQzgcl2dBZs+/Z9HrbFPjZrTuClEIqTLezyqLIxoX9U5GHwKW5ojJGpdWD
	 nt3WY9y5yzPJTwpgh+CtVBOSoEU3yG/ga0+d1gLxVyu7cdSejhoO9HzlFNZwYLdmiD
	 jFdDlbYqj8CDJHHI+V+UVHZ/MxsuORJKsyBlx+haByDt7XPmkZtOYAyh4zsLb1lZa0
	 3Ux5Ua2KBH0M7GCgg/NgMyF50IDiiFi+Diltyvm3WjBG9fRtO6L+Gt8G6ChbtyOXZX
	 HgXwETvQbTzAQ==
Date: Fri, 20 Nov 2026 14:26:15 +0100
From: Christian Brauner <brauner@kernel.org>
To: Guikun Yang <yangguikun19@qq.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ufs: validate fs_cgsize when reading the superblock
Message-ID: <20261120-abfolgen-ballen-ansiedeln-3f0769da1408@brauner>
References: <c5-ufs-cgsize-ubsan-20261031@qq.com>
 <20261117-absorbieren-geduscht-holzlatten-0552aac29cc8@brauner>
 <tencent_510BD3ADA8229FEA28E3D4C9EF8491482707@qq.com>
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
In-Reply-To: <tencent_510BD3ADA8229FEA28E3D4C9EF8491482707@qq.com>

On Wed, Nov 18, 2026 at 02:05:00AM +0800, Guikun Yang wrote:
> - Fixes:/Signed-off-by: placed in the commit message above the diff

They aren't. There's no Signed-off-by: and no Fixes: anywhere in the
mail. And your note to me sits above the first "---" so git am takes it
as the commit message, while the actual commit message is between the
two "---" lines and gets dropped.

I don't know what you're doing but it's not helpful in its current form.

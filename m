Received: from mx.fmap.me (fmap.me [51.75.121.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175A83E1CE5
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 May 2026 16:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.75.121.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777913695; cv=none; b=O1cdfrFtBDt+aBogdC3umV/gDZEBWGeqpUk2XqegHWSSNRk9YtBfyht44FBTR5VXh3xq1ycni0U1tu1HxTKQsFAzDtwR18gK2Auq/i1ttCLemJtKuHCyPL+dyysfqvcxAdF0XS6wfwrWaE+FZLtXeScJrSogWmkgzfSfodDGMdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777913695; c=relaxed/simple;
	bh=kbfgiZEVR6XEHKoJLxsYwISmQTQBgaTsGqgOjBuxx2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XAa8cunr8pxJ0RGMka3bwe+xzY9pEY1QRHGtO59YNc/AczHEmOv2/3TadCw4jotHkrz7hXyaIrOLMrS+KL0XP/M5g+P3/kwRYshYaDOAAKq2neR5w1Alkm12fY9QMzqePX8NNtre+DNHOvLpKyjtKN+UbdDno3/+PNDjCLUnNXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fmap.me; spf=pass smtp.mailfrom=fmap.me; dkim=pass (1024-bit key) header.d=fmap.me header.i=@fmap.me header.b=J0GuFscf; arc=none smtp.client-ip=51.75.121.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fmap.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fmap.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fmap.me header.i=@fmap.me header.b="J0GuFscf"
Message-ID: <9fe5ff50-4c1c-49ee-a8c2-4cacc3c6781d@fmap.me>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fmap.me; s=mail;
	t=1777913368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=stYj82WGH8bA5rmt9vqvvbBBjdMNd6riTWEwiJA6O3M=;
	b=J0GuFscfOWbUw9bnmsn0vb0yp46l/jaXBHbfblwsfGETOx9KsUAS+9dVuNSPPwfic4gTy8
	NUss1G0pMNHHXtFe5ObhaUBF1zsTNKPlmAyil/sQaNWpjy5J+4Pvkr+K1Wmmpcr3ElRXEx
	r6FXlweKKruMbGkoTh2BELs1/bOkXJs=
Date: Mon, 4 May 2026 23:49:22 +0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [fuse-devel] Debugging a stale kernel cache during file growth
To: Miklos Szeredi <miklos@szeredi.hu>, Matthew Wilcox <willy@infradead.org>
Cc: fuse-devel@lists.sourceforge.net,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Amir Goldstein <amir73il@gmail.com>, fuse-devel@lists.linux.dev,
 linux-mm <linux-mm@kvack.org>
References: <898a4e10-6193-4671-b3b1-7c7bc562a671@fmap.me>
 <CAOQ4uxjoS-PvnZ2poh0bx0C6ocTYwuEpfV0q5md15SjS620OMg@mail.gmail.com>
 <CAJfpegvxF7F+XKFKokSH4eOgCA0V2RNm6B54MS9nr9wG=U66OA@mail.gmail.com>
 <59ab54f6-680e-456e-91f4-0a26889844ef@fmap.me>
 <aeFuarTL7xBbut0F@casper.infradead.org>
 <CAJfpegtAeyMRENdneJkJrMKu8Uwnyk9LYBThjvTrFjHmPr6O_g@mail.gmail.com>
Content-Language: en-US
From: Nikolay Amiantov <ab@fmap.me>
In-Reply-To: <CAJfpegtAeyMRENdneJkJrMKu8Uwnyk9LYBThjvTrFjHmPr6O_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Kindly bringing this discussion up.

On 4/17/26 20:48, Miklos Szeredi wrote:
> Should that code check for a truncated page and retry?

If I understand you correctly, this can be accomplished with a new page 
flag because there's no other way to find out the truncation happened; 
would you say this is the right way forward?

Sadly I didn't have time to try and make a PoC fix yet, but I want to 
try tackle it this weekend; meanwhile, any guidance is appreciated!

Thanks,
Nikolay.


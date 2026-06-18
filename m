Received: from mx.fmap.me (fmap.me [51.75.121.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A71298CB2
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 03:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.75.121.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781754685; cv=none; b=RWhTLDeDIf38AoRkla/uDdpDuZhy+Sj5kEWO4JrT6pNdJhP2Ns/qtO5ZZkYD5Wexa3A5INvh+ApPAyiIjURCkGBTLiU1HgBmM95zl0+PuH3wlKFXEhmqMMqkrWAUmemGTEnlUrbQXHXoWxJY0WCud4lc/rlJ2U89UAgQgRTogIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781754685; c=relaxed/simple;
	bh=V0FkDuLl0BdL7VpEpvtzaELJd/9+3SNblsf0CQlV9pI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MqavmZotCCkHw88HUGb0V7Vw0z4e3mQR0b2Gr7VzAU1VPsb4WK8a6CXfFR5Ybf4dmE8Lk9brwUMkv4NHh9lHrFkTKqNHQFMuqr9kiN2ip0eAg5A4I0/UKY11EyTKm6fEQiM1Geujt4KnymF6ZdN7tFqkjbVXaW46SLLudg6WfdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fmap.me; spf=pass smtp.mailfrom=fmap.me; dkim=pass (1024-bit key) header.d=fmap.me header.i=@fmap.me header.b=bHMC7p9x; arc=none smtp.client-ip=51.75.121.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fmap.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fmap.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fmap.me header.i=@fmap.me header.b="bHMC7p9x"
Message-ID: <e3300529-439a-43cc-b1c4-feddcf0a1fa8@fmap.me>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fmap.me; s=mail;
	t=1781754682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7SYt43RIG9v2dC3QgKvpmy0JZQxvsc5yk7A7+TUWvQw=;
	b=bHMC7p9xfc9tmFFLoTIz1IjtFxJihZu30JxJ3HuXOedWg5mkm+zdiVFEBTm8e4743JJYYn
	ZROedv2oJC8q4uY1kopgmaC0muwyJbyGdpDZQXGEyxo/hzXucmESty7ShmLj+k/QaryNBM
	kd6GEo3fBh4rD/SSjFrTuuuFlwxqlyA=
Date: Thu, 18 Jun 2026 10:51:15 +0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [fuse-devel] Debugging a stale kernel cache during file growth
From: Nikolay Amiantov <ab@fmap.me>
To: Matthew Wilcox <willy@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Amir Goldstein <amir73il@gmail.com>, fuse-devel@lists.linux.dev
References: <898a4e10-6193-4671-b3b1-7c7bc562a671@fmap.me>
 <CAOQ4uxjoS-PvnZ2poh0bx0C6ocTYwuEpfV0q5md15SjS620OMg@mail.gmail.com>
 <CAJfpegvxF7F+XKFKokSH4eOgCA0V2RNm6B54MS9nr9wG=U66OA@mail.gmail.com>
 <59ab54f6-680e-456e-91f4-0a26889844ef@fmap.me>
 <aeFuarTL7xBbut0F@casper.infradead.org>
 <CAJfpegtAeyMRENdneJkJrMKu8Uwnyk9LYBThjvTrFjHmPr6O_g@mail.gmail.com>
 <9fe5ff50-4c1c-49ee-a8c2-4cacc3c6781d@fmap.me>
 <CAJfpegum=LJTCGqMUfLHehQE19kgdZbE2eXS_002fdpX_sd6jw@mail.gmail.com>
 <D4988E64-C9AB-404C-AA95-E5F4725BB646@fmap.me>
 <ajGabryrn7A2VUAq@casper.infradead.org>
 <08666fa4-e69f-4dad-8ac7-910102ecaeb7@fmap.me>
Content-Language: en-US
In-Reply-To: <08666fa4-e69f-4dad-8ac7-910102ecaeb7@fmap.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/18/26 10:28, Nikolay Amiantov wrote:
> I'm not exactly sure what happens with `mmap`; can one catch a moment 
> when `fstat` shows a larger size, but the mapped page is still 
> partially zeroed out? I'll try making a test. 

It seems `mmap` is also a problem if my test is correct:

https://github.com/abbradar/fuse_growtest/blob/main/check_stale_mmap.c

Updated the README, but here's the test results for convenience:

 > mmap-reading /tmp/test/testfile, checking for stale zeros ...
 >   STALE ZERO at offset 430275 (page 105, +195) t=0.002s
 >   STALE ZERO at offset 430295 (page 105, +215) t=0.002s
 >   STALE ZERO at offset 430340 (page 105, +260) t=0.003s
 >   STALE ZERO at offset 430414 (page 105, +334) t=0.003s
 >   STALE ZERO at offset 430535 (page 105, +455) t=0.004s
 >   STALE ZERO at offset 430611 (page 105, +531) t=0.005s
 >   STALE ZERO at offset 430755 (page 105, +675) t=0.006s
 >   STALE ZERO at offset 430795 (page 105, +715) t=0.006s
 >   STALE ZERO at offset 430828 (page 105, +748) t=0.006s
 >   STALE ZERO at offset 430992 (page 105, +912) t=0.008s
 >   STALE ZERO at offset 431209 (page 105, +1129) t=0.009s
 >   STALE ZERO at offset 431221 (page 105, +1141) t=0.009s
 >   STALE ZERO at offset 431247 (page 105, +1167) t=0.010s
 >   STALE ZERO at offset 431289 (page 105, +1209) t=0.010s
 >   STALE ZERO at offset 431301 (page 105, +1221) t=0.010s
 >   STALE ZERO at offset 431340 (page 105, +1260) t=0.010s
 >   STALE ZERO at offset 431354 (page 105, +1274) t=0.010s
 >   STALE ZERO at offset 431420 (page 105, +1340) t=0.011s
 >   STALE ZERO at offset 431647 (page 105, +1567) t=0.013s
 >   STALE ZERO at offset 431769 (page 105, +1689) t=0.014s
 >
 > Bug reproduced: 20 stale-zero region(s) in 0.0s (431775 bytes read).

Are my expectations that the updated `mmap`-ed data should be visible 
after `fstat` shows a file growth, without, say, using `msync`?

Nikolay.


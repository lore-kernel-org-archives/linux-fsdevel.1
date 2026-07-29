Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CD5397954
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785335974; cv=none; b=g/frDvRPZQaOEhG9x59hSlbhHjnvhP3B2SPWS38AQDgloKV7nOUSu1wKb47TfDTcBnZgbFS2Jn4vxC8jZ9nBG9JIyIPIqQoKlx2RYvNSsPqsWgehWg4BFacoLiOBPfFcw2sJZ3aocHsTxwasLQUCiXvJStsLIFuwbNmtp2qzfew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785335974; c=relaxed/simple;
	bh=fIUbVxx+9yGhh+eKf/sW03xCy81ADYP7YU5oj2Goa4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KfbxhcE1GlBOCvYFGyoHLe1s70cpzqV9wzV1z4DZzt6AHXnIRUDRmB5j3U+7Q9XgR0OTvOkQ4PIMONCWCdGTAP9M1ZYrcitF0pvowBUlzD+H+tIVaqJmUwyElqZFZfE0Wr/DfBSXH/XuMuZETSUhrZK6+VBdgqD8F95p9RNrek0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=a+il8zNR; arc=none smtp.client-ip=188.68.63.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="a+il8zNR"
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4h9F9d6xG3z6KpJ;
	Wed, 29 Jul 2026 16:30:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1785335430;
	bh=fIUbVxx+9yGhh+eKf/sW03xCy81ADYP7YU5oj2Goa4o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a+il8zNRO9pCbtaYDvlw6gxO6YxK8sgxQJPGyMQhok6pooIX4lIThdk/nFEB18VWQ
	 EDIIKjVI+z+eTD8tm7QaBDiya3n0eCXuux10gznjcdgmDcOCpwGasbj8cKKSP5aodb
	 7wF0z80fcSXGNLAWm4S1hdj/IiXhkRbCBsC1bkcqrnwrKbWgc7m8DXpE9qs9fdKMBW
	 0SRmh1nF00EbX6xhfsyWWHpsfdKcaOuMhevhYhoavjUD4/fXdkSBigxw0yTYWdI5SK
	 m/XgFb2mRzr9UTFNayBNRv/Myldc7Wf+JMVd8drZO1vrq3npPRIa2m0FuYB3KhTEjI
	 h/AhpOBNUS5rA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4h9F9d6CZMz4yN2;
	Wed, 29 Jul 2026 16:30:29 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4h9F9d0gVGz8sZg;
	Wed, 29 Jul 2026 16:30:29 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 8C7AA5F961;
	Wed, 29 Jul 2026 16:30:20 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <eab16020-eb68-429b-a261-e02e65ff9980@leemhuis.info>
Date: Wed, 29 Jul 2026 16:30:19 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: regress caused by upstream commit
 6650527444dadc63d84aa939d14ecba4fadb2f69
To: Jann Horn <jannh@google.com>, Pasha Boroffski <hex.dec.bin.oct@gmail.com>
Cc: regressions@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: 
 <CAHmU7G=Dsf31mJ1VH4+Tp-McSvXCg=GcO-eC+O52-_t5gc7Pyw@mail.gmail.com>
 <CAG48ez1UqV8E8nHGq50orS+3oqXbP80R6g7kVa3Hq-domHCSsQ@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <CAG48ez1UqV8E8nHGq50orS+3oqXbP80R6g7kVa3Hq-domHCSsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <178533542083.1487494.4997040334203509554@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 8C7AA5F961
X-NC-CID: n4plyXSHRf4TnWxZTX2f0cqWAxsIBaOTrfXbFX+07mdSoY0T2n8=

On 7/29/26 15:45, Jann Horn wrote:
> On Wed, Jul 29, 2026 at 11:08 AM Pasha Boroffski
> <hex.dec.bin.oct@gmail.com> wrote:
>> Hello.
>> I believe 6650527444dadc63d84aa939d14ecba4fadb2f69 has a bug in it as it causes "kernel bug" with PREEMPT_RT enabled.
> [...]
> Ugh, yes. This is not an issue on mainline, but the API contract of
> mm_access() changed in commit cd3f8467afd4 ("mm: refactor mm_access()
> to not return NULL"), which landed in 6.13. So we'll need a
> stable-specific fixup for 6.12 and lower.
> 
> I'll try to come up with a patch for stable later today.

I believe Sasha already handled that:
https://lore.kernel.org/all/20260726195203.stable-0001@kernel.org/

Ciao, Thorsten


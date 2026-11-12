Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486198;
	b=FDVKldnlmMJXL3iPeBmWkPUpAJllmXEEImIsABcOai+qfTre/hVfLTIggVsXQHmVJwTk
	 ulv0+mgiGzSKIHXyIQ6C2baz6AKo/ktfhKLxedyXIlQ+Ej/19uRdCqE2YRfLmyorepW4Z
	 iXpKXsqkjyxVvs+7yN6VOFh86qUnlJDjx4zFbI9D4778KBlLFWGr5rdfpjqyZN+/bfP8R
	 irJhqplR3375accLWCLY5KMomep/Kv/zsmJtQE0ZGJzzE0pM12vc97efRZUvNw6R5Vzxj
	 qrbWy9D7wmY7Zv17QyY5XXb30MjgeYIerN584JFWFKoFKsUV6V1JLsoTMq5LHNCk4lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486198;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=pQQOtAWIajuSIjlpRm2vXAuyWpPNUiVztPgT4AugiJU=;
	b=vgOFvSKY3HSHls2bFrg/D0I/XAH25afTRz/PE87tfJV5jW+PimedmoFB1In/8ledz6km
	 RkjQH0EdDL9PgpGFdvVY80lO1YGUUaqA/B6IEruA3fXmjdpwmr3U3wI7nkp+PZIO4PexR
	 /xYxFMhWTZAtQ4MlN0VCZOOKVcExHWQIG+RsnmgB94ZamFpBSO9C9gYkwYVDXw97nia5G
	 ODDM69RdfLCA1hzYqYI/byxKdc5c3TTKCW6jB/7BfHh6RUCvW7xD9Uqmv0qWzWiGixqFZ
	 VUNw+XcVXH/vLywJxWQK5V2KzCZ0O4vXHjqA+Sqc/kSICna5cHgK0Qwg2yZ1V3e6TAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=P3crDTR2;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fSUUtdbR;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D852606A889
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 12:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D852606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=P3crDTR2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fSUUtdbR
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6F9CF7A012D
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 07:23:16 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 12 Nov 2026 07:23:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794486184;
	 x=1794572584; bh=pQQOtAWIajuSIjlpRm2vXAuyWpPNUiVztPgT4AugiJU=; b=
	P3crDTR2QrE3mDKXA0pzvG/J0bybuc/GE0R2+MUdZp264RpkSMcQVZUcYrDDpZgb
	IF+xz7OFlA2tZ1mPVXTCRlHno9SutFrCMpp0k51JBZDEbv0keJE4XFc7UCBBsbu1
	z5onelRGFLzhRVe4TDGTEy+caDsXmV/0vQkR9L3QcLqzqVWjjRtJV/GZsPcOQArg
	TFVocEfVeZn3ldcZG9Zw+36qsWWQweFRqkf561gT/9CziFep7xz+6ynjjfATsBE0
	dDxnnAdPXLtTWCfAR5HvCihTN1MenKC3qxdhalWsDf9cehT8iPjbkvssqTUmP8Ca
	rixYuPIXf6Edl8S85rwsgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794486184; x=
	1794572584; bh=pQQOtAWIajuSIjlpRm2vXAuyWpPNUiVztPgT4AugiJU=; b=f
	SUUtdbR4HBO45/mk5eu0YAqBeAKShi7GKHdQyo/BWkb825A8Zi9EIqwWRVSs1pcN
	2shVokvXjHddAXp7isok9lwDLIHuHWfHz6MNmkmQtn9hidGG8xcTZrxrxLs4ERmj
	nnVUzsilTXAPPOFMD/tFoVHWYowqJS6SM+jBC74dDQt6d6doMt0uaYne/4RzxYm/
	89EbxzKiZzolJ3h7lYx/Ky2Cl1+SZPPNnWFwJxKLaG7R284peEknvZBcSlslGRzw
	5132kjSPejun9DRxwYozg+HXZkI0d5PX085EOoASVy5d7xZ1sJCrtlCPdoVwB7q1
	IGZa0lXrdLbZFFX1aXggQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794486184; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:IYwwx1P6wzPGyHS8u2sEqHqgIofDp2qesGCSP424aU3ZRTU
	FqCnNU0S//m1fahyYU3iX375C5w8OZvr+LrPAFtvBHnPn+J7MjhO0PiacgEzMw3k
	zUG9Y/IBLrb/YBTk6k7dynOnLHYDTVU5cAZ5AtXW3vjnbLvvttZYnw45DRgEGDsh
	n8Wxd//rCdP3FdjzEyRdXG1PFZjwyWo2+8iqxdl66sweDtC04AmRRQCTkRQOGxIo
	n5ZPFG4mCWXpxnIZpj1L7b7ulCLlhhBeCfWjrfm9dEFJem8QSgILwAdvusCLp1cs
	NW4F+gFbxN6cXPfZrZ8QNGLwNCsL8lwdDy3PXIQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:70yQGtggowVYDRHL6YKfPxDiilpVHlWmnUJX12t/gPs=:O91qDgHCDp/h71v8TAj9HM3/MV9+IU2QNkfmjp6XH8o=;
X-ME-Sender: <xms:n6_1al4q7t8sPbNHk9ZcDabDfZWI--PS3yobCtKgM18RJUCK6pIt8Q>
    <xme:n6_1attRr8BlRCZWHT1U2n7s_V_y0dEuMhbW4yU00VZPFcT55_MhPxgRjZRP0LOYJ
    6l7M0RT8hyR_0q_RtCQItOEBMp-FqCFbVSgk_l-UUC_MGSuMH9MnC0X>
X-ME-Proxy-Cause: dmFkZTENDWCLZ1AsP1BwOxKngdvuCCtkQqE4MZA6iiupg9JFXObYdnXpxnrsIceDQ9snZR
    PmdDa3QNSvwQc2VnXG8kK3uQ1fnh26r6EfLM4tXSRfWOEQqnKY9QII707R7oHHunYlR01g
    GM8ofyASf4KacOR/q5T8wLVy3McGB/LL6qJQykGIUi+PLyL3GEZNkdC7swMBvRvdaUSHOa
    M6JzuiMhYCBPCJMgSaZEwSMVRz1tUEnOxeRtP65pSti3rsT7bpdM3lDN4Cj8hM9B2GWc3F
    gYdQn21QY9Vm2bWRWZGFAt8nRliVdU80mdPzxWLE6QfIrmj+LKKjwBinE059J3TaxrezFd
    z+ptb/+kggG/4zwdHsIjICNOsvzsn93x8woktqYPxE5S138aWckanjQhcqqD3Xz5I3QGwZ
    HyaIy4NSEFB3rZpP65nB+MFiBId3H/KnEp59m+ePZJsd888ZbLhkbYQZBeCeRGpIjbN/rN
    xFntOBhfjEJQcdR2QVwqMwq3LV//Yn2vUarjPKtXnJF8ZmzxZS26D454NlUS8+eCVnL8WG
    j1LYpBLCtx3CXLg73JmvkDA+JkFH5xFnfEXNtSuMu37pKYM8585zicLTLL57nFdGvPMTk0
    Dqe4DgJjMPnlK4WgoG4UoRPv8KB5d+hbDv2o2t79uWli2h6kBR+54AW77UpA
X-ME-Proxy: <xmx:oq_1apRThMMkkNGJOzyUpycDUFHQQE4INZFdKrFWfr2OWu8HTU-TLQ>
    <xmx:oq_1anplsAN-TbH3FxxNXMyiawEjF_2FUQ0eKkV3FpIIPUs0FEFGpw>
    <xmx:oq_1anYZC5n6m5Iqm1LV-oAHoxmb1zzdOln3kyIuaSt5-UeCt-vtNA>
    <xmx:oq_1aiQqZcsE9b5m0AGqWLb_c4i5j2hdZ504PsPdpJkby3ByOXXBsw>
    <xmx:qK_1alc9eIARixlfcZspNkIdgxoj4uKJOu89rmelOEnZi-d-kZjREk4z>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 79EFA32A0099; Thu, 12 Nov 2026 07:22:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AfXj_ROFnIdR
Date: Thu, 12 Nov 2026 13:22:35 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Mike Rapoport" <rppt@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-mm@kvack.org, "Andrew Morton" <akpm@linux-foundation.org>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Christophe Leroy" <chleroy@kernel.org>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "David Hildenbrand (Red Hat)" <david@kernel.org>,
 "Jason Gunthorpe" <jgg@nvidia.com>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Lorenzo Stoakes" <ljs@kernel.org>, "Matthew Wilcox" <willy@infradead.org>,
 "Malin Jonsson" <malin.jonsson@est.tech>,
 "Richard Weinberger" <richard@nod.at>,
 "Russell King" <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Message-Id: <219f5451-1cb7-4a2a-8423-3a071f8ad42e@app.fastmail.com>
In-Reply-To: <avWnS7MLyPaJLaLR@kernel.org>
References: <20261112112528.1116405-1-arnd@kernel.org>
 <20261112112528.1116405-4-arnd@kernel.org> <avWnS7MLyPaJLaLR@kernel.org>
Subject: Re: [PATCH v2 3/6] ARM: drop CONFIG_HIGHPTE support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Nov 12, 2026, at 12:47, Mike Rapoport wrote:
> On Thu, Nov 12, 2026 at 12:25:25PM +0100, Arnd Bergmann wrote:

>>  	if (!pte)
>>  		return NULL;
>>  	if (!PageHighMem(pte))
>
> With HIGHPTE out this can be 
>
> 	if (pte)
> 		clean_pte_table(pte);
>
> 	return pte;
>

Makes sense, changed now.

     Arnd

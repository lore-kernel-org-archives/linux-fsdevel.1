Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3BB225417
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 18:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775845855; cv=none; b=bf2rAE8bWL9JlxX5B+miNF9rYuo7LGNdf7dH9L3wtoD3Rkrl8Ti9GTJnW9U5zXkSlUfK9tgWm4uueEozB/M+ewVYitu+U24Y7vSDsYI2+DtmskBZBRbUCiNf013poqMMh5BDODec1jh3508dqHK5QMVEoXQ1zKCPGPBFAmbNi58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775845855; c=relaxed/simple;
	bh=295UKGUue6/eZ6tKDQiPBUBJxdDndlUStSS7W81AEkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P2wIMmS+KZ7+XTXdv2Q+eeOLr5eGGEjAptA2GLZNUiR0xp+18IiQr8LcHYphpIjZW/Ns96wQxsmiuSV8+8kwleA+slwWmWwfQAcMrPDu2O8VQzexb8ElfcR4XDgvPg1K4Yy3Ff7mMabhnD7I6YOUjcWZlUsoexnXAT+5aUYN5KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=fTHDukYC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bd4eFhXR; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="fTHDukYC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bd4eFhXR"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A79147A0271;
	Fri, 10 Apr 2026 14:30:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 10 Apr 2026 14:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1775845852;
	 x=1775932252; bh=FUWbjRMM+ee9BwExCr9D7qGmvS2lUpAF9yo5auaxQjg=; b=
	fTHDukYCj9J2ZuyG6b34LhzxUEJ7eV6LsGFSSL2hRaJ5Q4kNFeRumopScsPRaz2t
	fLaGDoiSuWPUkRjzqyU/aL0nJTaGwGb9rgnSIvVYUKqHp5oz3szZQ/Tup2X+iqs4
	JXEN8vQxjj/41DbQjeOnokj3EqT/JRKQbvGHPmP4nBTybus1sFqF1OeqR3T76Du/
	XWnw6SUTSIE1CeVZa1hhuNTzw06HQXKIHUZovyl0oeMad4qUK+WzCcx+ODZT5Omw
	/5NDsAmtHrf7l4V65yQzxJVTCRd+nQOF2xQ7vU0wzZoyIictsx6LVsO6ac9ZCBjP
	B8iRKG5lEepBrF8XZKib2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775845852; x=
	1775932252; bh=FUWbjRMM+ee9BwExCr9D7qGmvS2lUpAF9yo5auaxQjg=; b=B
	d4eFhXR1pGNhqB42Qy43ooBYkjuwDMPjO1P0MuIIfn2qBeFjr38C3+B8c9mu5rXE
	DkDEOwByRP6xPeIW8xfEBsJXoXveKXjt2+JekABZvhFFih2NZftN3r9oCkMUr1jQ
	oHRnXsytMjriVtmcGlM5QOSPDW2nDlxmZaCpBxQf4jZQC/PGLTTXE+b3Ew71voym
	YdmLGKAgJOzbzKK/CNUD8gMfvKlpTSoD4HbysU7oycb11qk5uiIQ6x9vwp6LR/hc
	eBqWMyyZ/PAIKQQZCuEYAnYQpa9tAvoDgA4t2Cf6k9MthUimkfaqgFWmySQnwc4M
	SfpxVdcKjugtuOMzvWTLg==
X-ME-Sender: <xms:20HZaROYL09RyJWROStfxMFOyxB8MpZLhiaBbFIVE0aigwrQdBoRzw>
    <xme:20HZaXoT2hw_Fl25wbP2bjdzGTPXQ2gN4YiMvIBBTdxncEfHNeSNO-F-af0X9YMa6
    d422ceSONx3Znmjj8_xNh-YhVGcUdGOG_J5U0bCVg_mI8vgDWc>
X-ME-Received: <xmr:20HZaaFBlT8lhTBnL3w1iRnYiCpLCdAuEe8w-6d3IhDc9Aa9O2EYq2teWaTvzzs4_PJuxCiiu2CT9sxcpJ2_hKhM_PHm-8GWH-8bLFoqYY73vrRN5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeftdduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnheptdeghffgueduvdeuuedutdduhfevteeiiefhtddvueffhfevffefieeuhedu
    kedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnuges
    sghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepughjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegs
    shgthhhusggvrhhtseguughnrdgtohhmpdhrtghpthhtohepjhhorghnnhgvlhhkohhonh
    hgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhklhhoshesshiivghrvgguih
    drhhhupdhrtghpthhtohepnhgvrghlsehgohhmphgrrdguvghv
X-ME-Proxy: <xmx:20HZaUoH3S3NXPUG7cmeZPrtsGI7zCLv7i-ka_iGPNoM4RhJwtWu_g>
    <xmx:20HZabZlVmZfvUapE1XD-jxOzzzdBbFNGe5YXlTdztz0DKSU4ezGJA>
    <xmx:20HZaVXxIlnJU1P5gijdcShVkDu72hx_EjdXfwVsoM2pceJiLYVzAg>
    <xmx:20HZac-VF5da2WNPaGKfehT9KX-8jqeGVwxIsVwObzP0K-mPhE3twA>
    <xmx:3EHZabmuxrjPJkArdeeo_ahxZVTPhgzr7SXexXsRDU800KJEyC0b__G3>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 14:30:50 -0400 (EDT)
Message-ID: <5de6956e-dce5-4095-a2fa-199c2dc1408a@bsbernd.com>
Date: Fri, 10 Apr 2026 20:30:49 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] libfuse: run fuse servers as a contained service
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: bschubert@ddn.com, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
 miklos@szeredi.hu, neal@gompa.dev
References: <177577271287.2064584.12214566734023027732.stg-ugh@frogsfrogsfrogs>
 <549999df-d6eb-43a0-840c-43310de667ca@bsbernd.com>
 <20260410155601.GS6254@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr
In-Reply-To: <20260410155601.GS6254@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/10/26 17:56, Darrick J. Wong wrote:
> On Fri, Apr 10, 2026 at 02:24:28PM +0200, Bernd Schubert wrote:
>> Hi Darrick,
>>
>> On 4/10/26 00:24, Darrick J. Wong wrote:
>>> Hi Bernd,
>>>
>>> Please pull this branch with changes for libfuse.
>>>
>>> As usual, I did a test-merge with the main upstream branch as of a few
>>> minutes ago, and didn't see any conflicts.  Please let me know if you
>>> encounter any problems.
>>
>> I had already merged another patch beginning of this week that
>> introduced a new merge conflict in
>> .github/workflows/install-ubuntu-dependencies.sh
>>
>> I resolved it myself now.
>>
>>>
>>> --D
>>>
>>> The following changes since commit 3bb9cd99b3688df1bb7536de158ed9e532b277fb:
>>>
>>> Add the codechecker/cppcheck github action (2026-04-07 10:08:49 +0200)
>>>
>>> are available in the Git repository at:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git tags/fuse-service-container_2026-04-09
>>>
>>> for you to fetch changes up to 0db39a8f8844ff88496ed36da417554cb4f3751d:
>>>
>>> nullfs: support fuse systemd service mode (2026-04-09 12:31:08 -0700)
>>
>> I had quite a busy last weekend, because I got libfuse security reports.
>> In ordert to avoid lots of reports, I just added support for CodeChecker
>> + cppcheck and CodeChecker+gcc checker. Clang CTU is is prepared, but I
>> need to let AI work over the weekend to fixes for these (obviously will
>> need manual editing, as last weekend).
>> In the end not too bad and I don't think and urgent need for a new
>> release. Although I should probably make a new 3.18.3 version soon.
>>
>> That also made me to add new checks. I actually already that github
>> codeql checker in place, but only realized last weekend that it didn't
>> generate any reports. On your PR that gives
>>
>> New alerts in code changed by this pull request
>>
>> Security Alerts:
>>
>>     4 critical
>>     3 high
>>
>> Other Alerts:
>>
>>     4 warnings
>>     10 notes
>>
>>
>> Some of these, like "This switch statement should either handle more
>> cases, or be rewritten as an if statement." can be suppressed. With some
>> I probably agree
>>
>>
>> 	cmd = malloc(iov.iov_len);
>> 	if (!cmd) {
>> 		int error = errno;
>> Note
>> Declaration hides parameter
>> Local variable 'error' hides a parameter of the same name.
>> CodeQL
> 
> Oh yikes yes.  I probably ought to have added the same "turn the gcc
> warnings up real high" patch to my branch that I use for xfs stuff.
> 
> (Huh.  No warnings.  Well, that's good at least.)
> 
>> The new CodeChecker (gcc,cppchechk) actions also complain, the GUI
>> should give the output, but I don't see it yet.
> 
> <nod> Any reports you get about my branch, please feel free to lob it at
> me and tell me to fix it :)
> 
> I can run cppcheck locally, so I'll try to fix all the warnings that
> your copy is throwing out, and send you an updated pr.
> 
>> My plan for the weekend is to address your comments in my series and
>> then to merge it. If still some time left, I would like to fix all the
>> reports in your series and merge that as well.
>> Then maybe next week to combine some mount code dup that comes from both
>> series.
>>
>> Ok with you?
> 
> Yes, that sounds good.  Let me know if you want any help. :)

Would be great if you could fix the cppcheck and gcc codechecker
reports. For cppcheck you might need to inline suppress some wrong
warnings - needs this patch

https://github.com/libfuse/libfuse/pull/1477/changes/0322af4d9bba93aad5f6445346aa83a549bb3d19

This commit also shows the path how to run it:

.github/workflows/codechecker.sh

Fow now we we ignore everything in example/ and some cppcheck warnings
are ignored for now - these were too many for now.


Thanks,
Bernd

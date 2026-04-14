Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D0E1B4138
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 22:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776204048; cv=none; b=IU+DvS90JYxI8Vc3p4eLm8cMRzyQ9n38RDgzOl8pxxjf+qhaf8YZus6wlGe5EYf52yMJ29Lje8viQBnH0/iw0k5ydkqwlaLjRa7Y5q/Jyv6f5L3rhMQKeMzCgvAdLymVU4F37RGECITl/fSN3unUQXHnkfjQPR1Njw+z9xCpbLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776204048; c=relaxed/simple;
	bh=Vq3zU3D/2KxZVRn/5h46GYDp+ELv3uQmf36tiPjEXV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WWoI7PvT5Mt2DGXcfMSIQBhr/CWOqcbkU3eFpiKyXI2bpCVPdwwFeHG0Lc9t6YU6x8sv5kMgy4CVitDoZDZjfHiDodnrfDev34+kl8VWco9348Pt2rMMri7v93NET5PDT2aNzoK/LoOTMKFdjmL1TDqpkpYnsrjuGlHpp6cJ8XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=UaZuENsZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hc/l1Obf; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="UaZuENsZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hc/l1Obf"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5EDD97A022B;
	Tue, 14 Apr 2026 18:00:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 14 Apr 2026 18:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776204045;
	 x=1776290445; bh=GkHNXkWKaVPEfySorKzTM2xq77nuAajaFVkWcqs+MfM=; b=
	UaZuENsZH7y9KKbiZEi0JgHTT5rXMMIE3Xa2oQ2qniIID+FBuJYzkvVvPq0qwNbZ
	ZpQeHU5ARXUXU4aEzgTxY2S94bohT0rHwFFzAqaunULbUuAND23DC0g7DDQbK/VZ
	u07odgUy6zfhlNj5qc96kHARyeG7yjZCUXvFG9avErfQ+Lt06jeXAnZAt+NV2bzI
	o1YVyp/u+O+UyYgdlWL30OTLR2a8p/PmxN5LonG2uHOhO8OQMYXgj+9P0QZ8qgQe
	I35ImLsppfeSfxyiWhDcvELFmRLyAXxMLQAfLoqaTKOnKZ2IguylF1UrNScSGe1P
	L3je1U2y7yMrb/5uGjs2Nw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776204045; x=
	1776290445; bh=GkHNXkWKaVPEfySorKzTM2xq77nuAajaFVkWcqs+MfM=; b=h
	c/l1ObfT/v3oii1ivL95KfTrj0dCvxqUhmqUMf0IkEhKioMqC+iOINi0HUWBFLBJ
	KPbeirrjTW6Sil0fEpkcftmCKkb92s/VZvDvxJ2p471J9rMkHEKduB3oaBx24sPR
	9rRTivU1JW49ZIdsdf6nHFoz5mYZzCJBtQb7+5lDGjd2Wtkybut5njTA8pHktL7V
	eFI0/sGbX7ZLPLcvyuhCqZM6ZcwGctawu99GOhi+3IfBLPf11OWb2v8UvO0H/tws
	9wln4cfiiOG8zTa4/kCya/EduLPBWZMyg6mBW2+iaeipqXStxRRtoX72PXw4T57+
	ciE2TtUtE0bwjk+CkZA7A==
X-ME-Sender: <xms:DLneaS5FNNlyH5p5R-n-oQVBzGKeqqgN63SG1Gadgn-6f6UaWvItUg>
    <xme:DLneaSyv_Ta-7vUHlPHKMGY9ooUY7m0X8H6A-0Vw0kr7xMsUmGFuX-Em7wVembV07
    JfbuBrQ3HYZZWNBngXs4HAlb5QJwKoYJXPEwiXNDwMEKsvv4ZjC5w>
X-ME-Received: <xmr:DLneaZywB50VeXhgoPY0rg3ZEObVnfiYbY9nwLuHcZKkz4f3yWZ0iG7ij26Q0iYR4XDkfXfr-qU6X9xrpxIw_qxHGmFBksRCtDSaoSP7bZhdUBIPEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegvdeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhephedutdffvdegffehheelgfduhfdtgfevieduheeigfduhfegfedtuedukeeu
    jeefnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpughjfihonhhgrdhorhhgpdhgih
    hthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeehpd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepnhgvrg
    hlsehgohhmphgrrdguvghv
X-ME-Proxy: <xmx:DLneaayEY2J4t9ZdQrX9-2KdTEuYqdp7bEUu250zDuYis8jYu-UUlw>
    <xmx:DLneaTbCN_nc0bKwAMgJEgB5FTrxL2GLinFMI2ylldGbheAUfXto3g>
    <xmx:DLneabWO_hahPCh_ST-fDq8yJ4dzUDBw1v8IF6VFWA2yPjl1bpK2Xw>
    <xmx:DLneaRiprlmrqLPJ8BV5EY_FebkTerT6a2UJgNLaTnuCnfsVSOWR9Q>
    <xmx:DbneaTgusR9YNJHh4wD3_8Yh8DljHRay5HEMx1RkcLzE9EVXTMHfLBIb>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 18:00:43 -0400 (EDT)
Message-ID: <774cac3c-0ee9-4bd3-a32c-249953cb32d8@bsbernd.com>
Date: Wed, 15 Apr 2026 00:00:41 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] libfuse: run fuse servers as a contained service
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
 neal@gompa.dev
References: <177577271287.2064584.12214566734023027732.stg-ugh@frogsfrogsfrogs>
 <549999df-d6eb-43a0-840c-43310de667ca@bsbernd.com>
 <20260410155601.GS6254@frogsfrogsfrogs>
 <5de6956e-dce5-4095-a2fa-199c2dc1408a@bsbernd.com>
 <20260410221210.GV6254@frogsfrogsfrogs>
 <20260411024835.GV6202@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr
In-Reply-To: <20260411024835.GV6202@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/11/26 04:48, Darrick J. Wong wrote:
> On Fri, Apr 10, 2026 at 03:12:10PM -0700, Darrick J. Wong wrote:
>> On Fri, Apr 10, 2026 at 08:30:49PM +0200, Bernd Schubert wrote:
>>>
>>>
>>> On 4/10/26 17:56, Darrick J. Wong wrote:
>>>> On Fri, Apr 10, 2026 at 02:24:28PM +0200, Bernd Schubert wrote:
>>>>> Hi Darrick,
>>>>>
>>>>> On 4/10/26 00:24, Darrick J. Wong wrote:
>>>>>> Hi Bernd,
>>>>>>
>>>>>> Please pull this branch with changes for libfuse.
>>>>>>
>>>>>> As usual, I did a test-merge with the main upstream branch as of a few
>>>>>> minutes ago, and didn't see any conflicts.  Please let me know if you
>>>>>> encounter any problems.
>>>>>
>>>>> I had already merged another patch beginning of this week that
>>>>> introduced a new merge conflict in
>>>>> .github/workflows/install-ubuntu-dependencies.sh
>>>>>
>>>>> I resolved it myself now.
>>>>>
>>>>>>
>>>>>> --D
>>>>>>
>>>>>> The following changes since commit 3bb9cd99b3688df1bb7536de158ed9e532b277fb:
>>>>>>
>>>>>> Add the codechecker/cppcheck github action (2026-04-07 10:08:49 +0200)
>>>>>>
>>>>>> are available in the Git repository at:
>>>>>>
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git tags/fuse-service-container_2026-04-09
> 
> Hi Bernd,
> 
> Here's today's branch, with the static checker problems fixed, I hope:
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git tags/fuse-service-container_2026-04-10
> 
> This is the codechecker report that I got (u:x p:x, I'm too lame for
> anubis):
> https://djwong.org/docs/libfuse/#sort=file-path&asc=1
> from pip install'ing codechecker and running:
> 
> ./.github/workflows/codechecker.sh --gcc --codechecker --build-dir build-x86_64/
> 
> AFAICT, none of those bugs are related to anything touched by the
> containerization patches.  Though I'm not 100% sure of the outputs; I
> didn't see anything about a switch statement.
> 
> --D
> 
>>>>>>
>>>>>> for you to fetch changes up to 0db39a8f8844ff88496ed36da417554cb4f3751d:
>>>>>>
>>>>>> nullfs: support fuse systemd service mode (2026-04-09 12:31:08 -0700)
>>>>>
>>>>> I had quite a busy last weekend, because I got libfuse security reports.
>>>>> In ordert to avoid lots of reports, I just added support for CodeChecker
>>>>> + cppcheck and CodeChecker+gcc checker. Clang CTU is is prepared, but I
>>>>> need to let AI work over the weekend to fixes for these (obviously will
>>>>> need manual editing, as last weekend).
>>>>> In the end not too bad and I don't think and urgent need for a new
>>>>> release. Although I should probably make a new 3.18.3 version soon.
>>>>>
>>>>> That also made me to add new checks. I actually already that github
>>>>> codeql checker in place, but only realized last weekend that it didn't
>>>>> generate any reports. On your PR that gives
>>>>>
>>>>> New alerts in code changed by this pull request
>>>>>
>>>>> Security Alerts:
>>>>>
>>>>>     4 critical
>>>>>     3 high
>>>>>
>>>>> Other Alerts:
>>>>>
>>>>>     4 warnings
>>>>>     10 notes
>>>>>
>>>>>
>>>>> Some of these, like "This switch statement should either handle more
>>>>> cases, or be rewritten as an if statement." can be suppressed. With some
>>>>> I probably agree
>>>>>
>>>>>
>>>>> 	cmd = malloc(iov.iov_len);
>>>>> 	if (!cmd) {
>>>>> 		int error = errno;
>>>>> Note
>>>>> Declaration hides parameter
>>>>> Local variable 'error' hides a parameter of the same name.
>>>>> CodeQL
>>>>
>>>> Oh yikes yes.  I probably ought to have added the same "turn the gcc
>>>> warnings up real high" patch to my branch that I use for xfs stuff.
>>>>
>>>> (Huh.  No warnings.  Well, that's good at least.)
>>>>
>>>>> The new CodeChecker (gcc,cppchechk) actions also complain, the GUI
>>>>> should give the output, but I don't see it yet.
>>>>
>>>> <nod> Any reports you get about my branch, please feel free to lob it at
>>>> me and tell me to fix it :)
>>>>
>>>> I can run cppcheck locally, so I'll try to fix all the warnings that
>>>> your copy is throwing out, and send you an updated pr.
>>>>
>>>>> My plan for the weekend is to address your comments in my series and
>>>>> then to merge it. If still some time left, I would like to fix all the
>>>>> reports in your series and merge that as well.
>>>>> Then maybe next week to combine some mount code dup that comes from both
>>>>> series.
>>>>>
>>>>> Ok with you?
>>>>
>>>> Yes, that sounds good.  Let me know if you want any help. :)


Hi Darrick,

thanks a lot for the updates. And apologies, I didn't get that far
during the weekend again :( I also eventually wanted to send the new
version for the reduced ring queue patches and then xfstests got stuck
at at generic/650 (cpu off/on loop) and I was searching for the issue
kind of all weekend. Unfortunately searched in the wrong place (kernel)
and only noticed when I had added debugfs support to fuse. Patch for
debugfs support follows during the next days. (The ugly part was that
passthrough_hp had crashed and got stuck in backtrace_symbols - process
alive, but not operating...).
I will get to your patch series the next evenings.


>>>
>>> Would be great if you could fix the cppcheck and gcc codechecker
>>> reports. For cppcheck you might need to inline suppress some wrong
>>> warnings - needs this patch
>>>
>>> https://github.com/libfuse/libfuse/pull/1477/changes/0322af4d9bba93aad5f6445346aa83a549bb3d19
>>>
>>> This commit also shows the path how to run it:
>>>
>>> .github/workflows/codechecker.sh
>>>
>>> Fow now we we ignore everything in example/ and some cppcheck warnings
>>> are ignored for now - these were too many for now.
>>
>> Ok, I got the cppcheck part working, and the fixes were fairly straight
>> forward.  As for CodeChecker, is this the one:
>>
>> https://github.com/Ericsson/codechecker
>>
>> that the yml file tries to find?

Yes. this one. There is also a codql yml file, which is githubs own code
checker, it complains about these single case conditions. I will just
click that away. I guess you cannot see the reports without a github
account.


Sorry again and I hope I get there soon,
Bernd



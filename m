Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB7325771;
	Thu, 25 Jun 2026 19:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782416098; cv=none; b=q2TVRfPGduXd/o1rueGFhcBjXNrObm7Ui7fZt4tIx36LXMRtkUWDDyc5BgR4d6PiqXb22f4GoDnFmwHcJriwJ0d1B+gwsIM9GH2uMIP/b+9rZc+/8Dhsola5cquuSDHEkXzUT5XtIhUhXGeMl5dhLfQkPrGNM4E0ODNqlxTqRwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782416098; c=relaxed/simple;
	bh=h/VJcPO5ZLOadJ5wysEz6lTyDoIeInuqp7ujvz9zGfo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ddfa/CrDE1rMeZbpivX4HaX7t/W69qy3nrqJyybPj4NQNIK/EauMhyfVvGiMDcq4vjHyUapkq7egwm8N2c3hvuTKNnKD351EZpbm+RI5eaETIUgmlXFZ51XNiM8fflmyNlSL5hvihXkyuPqJv17tDQ2DB/W21qfX9PVmpz889Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me; spf=pass smtp.mailfrom=johnericson.me; dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b=abF9ft4k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bBu/Gwgz; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=johnericson.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=johnericson.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=johnericson.me header.i=@johnericson.me header.b="abF9ft4k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bBu/Gwgz"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7DF511400089;
	Thu, 25 Jun 2026 15:34:55 -0400 (EDT)
Received: from phl-imap-16 ([10.202.2.88])
  by phl-compute-05.internal (MEProxy); Thu, 25 Jun 2026 15:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnericson.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1782416095; x=1782502495; bh=h/VJcPO5ZLOadJ5wysEz6lTyDoIeInuq
	p7ujvz9zGfo=; b=abF9ft4kvzbIc8aYNSRz0Uofgjh8YFqyA9/pM+bt5o/HBqMd
	4okZovNx0/iizQY8FKft+r2i8DryTUoRxIUAX8ds7Tdok2N24W8xkHwknJpPb1Vm
	x8r9jNjGCoQoBAfB74vDxL6J7vUTAajWwChf05c2JkGjsqCzPc6cKtq4fZnPVYf9
	kxzaVf1uT1Y+Koo+WChi2v+2Cmhhm5H5LI8evEH7BN/CvvQsf/JXn3vQ02Tg2qI0
	JULBVvaoZXoV1hrRj6OcadKW5WX5t/1qDyV4aSKfiKSSq/eLtZNL4e6l5X9fvC8b
	uzDpUJxuDPTGcT2BOJkKVncZL0xcF8XOGmqrxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782416095; x=
	1782502495; bh=h/VJcPO5ZLOadJ5wysEz6lTyDoIeInuqp7ujvz9zGfo=; b=b
	Bu/GwgzkIw4a0CO1b3uncymfOPA2SJFz7coLMCF7atUUPVfpyY8LP1Vo3w6PgLp0
	nyPr9wRRn3euyM1NCzW8eF5ndc6+7K0pjC5dFccSVpfSwmmcqybpbFtMxbJqfSbw
	0D6X7ul5btN1KzCrh9P/97HXMEn5UHb7WJN5GgHcoK10owrE9h4djD5PdpBt/N/4
	FU7qtgz0mZrZ0+ZxDqBB0X6VbL8HAH0GsHv2ftnNHDW6NnLncBGHtbhUILkF1kY6
	l7nRx+j+qOIjiS5EXVkTgs9NmS4wTOCNmhCtdUuU8xucAqb3caL+lX+xFV9w49QH
	M/VohyQemObsOsQeMH7cw==
X-ME-Sender: <xms:3oI9avA42e-F3q1SrOClqUqWIixerRxW2AEje3rRmqhlFGTUEDipPw>
    <xme:3oI9agWyc8FIZ_4x3nqthL_THvhl4f8xq3kMCVgtAcBgNHI67aMmTz7HbnzOe44qy
    CGicPCoVDQnkYVe4oh9jxozeaAfW_uTOtGWpfXQiBdNKU_hCgxYeOA>
X-ME-Proxy-Cause: dmFkZTGwWfvxyF8Yo/MGgzR2q6tZRih46h6eDc0VHDJ2pRBK5ZLZ7SSxh8USlawBG3Ionz
    nNzQIKNAseFIJbn9/qEnT2y+FMvZaCwCMcOwyKQPdpm1DZ+ASf5zJ4gKan2cNthkC2xyk1
    z1TxDOQgUv6eBgvjksuIm72egj4axJgylhP6P2ON/VLtgPckdlJrpTsTBACxLImbcXljbD
    D9cVHv/FqOWPuuevvbVEd5oUESfnpfVwHpgZXdOCR0WFPH9WnYY7VfQkinAZ2Bhe54I5Ca
    y+pUtTjBGYbkJzfE9oqtsml4iTEu0b0V45H62UxjgnAhDNxkmwiyntx/Z9GKOwrAfce/R3
    9mvE62nTjt5a9+aLLjK9LsmHeiMYmBBZW5urTSPEuQ7uuhdNU8RLF28NTmVKHV1C/cmudm
    BWJZC/FRy7hL4hmt4N/jFjvZlp0lWwRBIj4LnVvE3wwEYQCqfz8dBdZOf8dLYGqUvf/tr8
    B76qpzExCYCPJj9X0Kf1M+Jzqc0zKoudkh0D47IL4sSs/X1Wml/r+6emBi7OFWL3jLZeBX
    R4Z4vDfMl9PsBUvkImElwRgxPHSKdUYdrRXcSgLQjYkjV0q+EcuxbcXzkDxRnFAAHRB3Cb
    ewYDL8Pk/iPOnyjDpVyNatgBrpwZdV5K0lsqOQCfFafWvD6y8y/0tMsdtctw
X-ME-Proxy: <xmx:3oI9asmTe8ZpTmoKswMGIu_WJAHRQhsWnnlOIIcWJuNJ0-U58aM_7w>
    <xmx:3oI9antVlQs_UO-pk-WMpU2BhqzYnNWZ6MH4A5FVvhYHtGunFJKscA>
    <xmx:3oI9anoCkWCOtPaCWyIvQtlLfb9jZvwQzyvrsGIFl7JOkdS2aFc31A>
    <xmx:3oI9atcUoTee-0n0XVI2QpvkgIB0vJ5M7qGyeVgjjFGZmZP3rZUF5g>
    <xmx:34I9apnPMV_xMBFsfpM-LU_FXjKvoFWzbXbRiuMH-WAevtXFRzElSmMY>
Feedback-ID: ieb4144f1:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BC6772CC0088; Thu, 25 Jun 2026 15:34:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1dANeNfTnWJ
Date: Thu, 25 Jun 2026 15:34:14 -0400
From: "John Ericson" <mail@johnericson.me>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Farid Zakaria" <farid.m.zakaria@gmail.com>, "Jan Kara" <jack@suse.cz>,
 "Kees Cook" <kees@kernel.org>, "Al Viro" <viro@zeniv.linux.org.uk>,
 shuah@kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>,
 linux-kselftest <linux-kselftest@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Message-Id: <ea5dc2d9-9a90-450a-bbcc-8ae3429ae85c@app.fastmail.com>
In-Reply-To: <20260625-atomkraftgegner-hunger-kursbuch-b452ff2becab@brauner>
References: <20260622043934.179879-1-farid.m.zakaria@gmail.com>
 <sfv7zc6jboy2oxv7zuyofysas4ncbzenwsuzveiyduisfr6i7q@mx23er7uxdbg>
 <CACCo2jkDuwy5w_yhX8833m+s-rY736pk8xtKjxg3_y_7BCOHeg@mail.gmail.com>
 <24420045-a6eb-4999-ab19-1e344eaba8a4@app.fastmail.com>
 <20260625-atomkraftgegner-hunger-kursbuch-b452ff2becab@brauner>
Subject: Re: [PATCH 0/2] fs: support $ORIGIN in ELF interpreter paths
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jun 25, 2026, at 4:50 AM, Christian Brauner wrote:
> Also, we change long-standing kernel behavior which will be very
> surprising for any userspace that might implicitly rely on the fact
> that the system loader is used. So even if we were to do something
> like this it would very likely have to be configurable in some way.

Yes that's definitely something that worried me.

> So I'm not enthusiastic about this. I want this to be consistent.

For what it's worth, I somewhat wish the `PT_INTERP` field didn't exist
at all. IMO the ELF spec is very weird for some parts of the same
headers being for the kernel, and the other parts being for userspace.
If there were separate data structures (think encapsulated packets) so
it was crystal clear who was responsible for what, we wouldn't be in
this situation.

While I earlier complained that our
<https://github.com/Mic92/wrap-buddy> work-around was likely to make
some security analyses/policies go haywire, arguably it implements this
behavior: from the kernel's perspective, everything is statically
linked, and the program, entirely in userspace, takes responsibility for
whatever loading it needs.

Put that way, this is less of an ugly work-around than the way I wish
things worked period in a world without `PT_INTERP`. Dynamic linking
would be entirely a userspace concern and the kernel would not know or
care.

----

What about shebangs? It's the same problem, with the same solutions and
pitfalls. We can also make wrapper executables around them that do the
right thing, but turning mere scripts into statically linked binaries is
a bit heavier. I assume the answer is the same, but just want to double
check before we close this off.

Cheers,

John

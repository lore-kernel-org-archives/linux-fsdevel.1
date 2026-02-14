Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913D515ECCC;
	Sat, 14 Feb 2026 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771081033; cv=none; b=TqZupMBlfigdV7DJULB0JAdUsZEOtLZ+KC2bbp+QvH3S6ypeWLUEv4RppigMQnE0dW5no4/2GrbEUTC3W0UILGt2xZNiM3RRu2y3O4mDMJzlMVwY1DMYmj+gSggen3b0OuqG4tD1Q2w74vNQDGJmX9p5358VsskI88AJu291KH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771081033; c=relaxed/simple;
	bh=jEA/qXJdFzDwGJw/PQ74iSIPzhK9C4Fgkc5hJtv+jtM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=La7I7t5pIOd9W6HgnIXOO+aemmQ/leOhSlrY2ecyeNKcBJxd9mCWBEMcHw66Igr5lwuGpbLznpKMUT3E3CkZfiTGMUdea9kKpuuwZ89Pth2E3dImggsl41Z5tpAjELYUZBRdeoj14yEPX9hVYf1KGq+KZ/Ste6XcJo+c227hGhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=GbqH/2B7; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="GbqH/2B7"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CB55A411E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1771081025; bh=XXRfMeDTxgrLPvdt9qOWHFDKksHhh8PjgJMcdb8J3Lo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GbqH/2B7UtPqraQAoJZROudiH5rnpFIAYsyL34vc8dI8kDPt1uiL9BuSdcn7mi2ZI
	 QwygA34nGNaYVP8yGwpTh3yIpMNflu75rAsWhpinwCoQJOTUkhzDUq06hUEE3L7nT1
	 5nl607azT/C1Ry3n35GnW9t8gNzti1ijeosuxGCgav47v7BYCfyIeTwVC2yg58+HWD
	 yQ9FYVF9PT+AEFP/jP2cwoPMqovQrm8j81eDzJFZTtcSB0nXPL12chyVrp80vgTVxN
	 zJEHMMl9DmartF1x3zbvMpzMLvu9dTtmfkDkThEIz1goD4mU25s+q3tX5+ZwT+VOQA
	 V0CAmILttlrcQ==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id CB55A411E3;
	Sat, 14 Feb 2026 14:57:04 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Wojciech <wojciech.develop@gmail.com>, adobriyan@gmail.com
Cc: linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: proc: fix double whitespace
In-Reply-To: <CALGt97-amOrBjW0LStyJSoT=n0TsR8nbEuE8rk7ME4joq51+5w@mail.gmail.com>
References: <CALGt97-amOrBjW0LStyJSoT=n0TsR8nbEuE8rk7ME4joq51+5w@mail.gmail.com>
Date: Sat, 14 Feb 2026 07:57:03 -0700
Message-ID: <87v7fzqsow.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thank you for working to improve our documentation.

FWIW, there must be a lot of places where proc.rst is need of actual
updates.

Wojciech <wojciech.develop@gmail.com> writes:

> From 67259d718da986c176cb45f861a43eb04dfc481b Mon Sep 17 00:00:00 2001
> From: "Wojciech S." <wojciech.develop@gmail.com>
> Date: Sat, 14 Feb 2026 09:51:35 +0100
> Subject: [PATCH] docs: proc: fix double whitespace
>
> v2: Corrected Signed-off-by email address.
> Remove an unintended double whitespace in proc.rst.

So none of this belongs in the changelog; the changes in this version
can be noted below the "---" line, but the email headers simply should
not be here.

Overall: it seems clear that, at some point, somebody wanted this
document to be right-justified.  I agree that's not too helpful and need
not be there.  But: "two spaces after a period" is explicitly not an
error in the kernel docs and need not be "corrected".  Avoiding those
changes would reduce the churn here considerably.

Thanks,

jon

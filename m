Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256B81F5842
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781261929; cv=none; b=bJojgT3F4OHUU/gqlf+2eZbJ2OFUpL/qU8CjiL3wJPiGMnygmxm8r/1/utKQNr6zhR12mSRCdDSMTJiAi1hXqAE0YhGOJPjCt3zCnrGg6OipqCIwynCrl1Pgnfhr79bdqm1vKk0FHAGFSf08Nd1mG9eOLHcbiqALoy4gLNiLcsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781261929; c=relaxed/simple;
	bh=QV70zug7pUsuHJm/j+4dKuiEaiBdOZpK58/NCc1YEzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thurNLlu/v8TVLUATTELG1kXOPMYBNfUhyFCT8kT6ASz114jPlbJGMBPW2FX6tmq7NFk6zGw9SXrNnWqfx3rQ5zbCsrwduiiiomkj5sVHvLsTdF4rpZad7WqSKrutKWxAx6ATUr79Vu5gzOt/xjGPC6iE/CFpuSHCgDjae6iKu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=gXEFMQ+x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e6fkZjkq; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="gXEFMQ+x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e6fkZjkq"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 4B69E1D000E3;
	Fri, 12 Jun 2026 06:58:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 12 Jun 2026 06:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781261927;
	 x=1781348327; bh=9uyrq9L6Fone56GQvPSX4+qRMkkQPO1Z0wLQFPb+fe0=; b=
	gXEFMQ+xlfeELskDWh9QCCmfs/5BYtaxFQiLmw5r1/ghnc02fQwmwGfpLI0Rri3r
	QOYG+E4iDyV1wAbY1t9hRXAEUysd7VqMqnauUAgoxMJHNjc/fnPCvvJJ69PAEZR5
	/i9SdSODIKAUW+ikoltkVCst0ihlkkM2qXhIC5GsJclsSHW7KUuzbMWLUlhX7tWG
	Jd4Ul3ZSosW5rajd64oQP65cCkqE1Hqo8n+tAW+UusKO5Oddwzt//eaN6bq3hO3m
	UrMyrnbDXTS36k1ZqLbWGbLHe3LZ5QKeg3c4Uia71UgZlwUSm82IUACxdPFr+pv2
	5P4NYBGgbCbuoh6vyOwyoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781261927; x=
	1781348327; bh=9uyrq9L6Fone56GQvPSX4+qRMkkQPO1Z0wLQFPb+fe0=; b=e
	6fkZjkqq165NBjgel5wdOxpoWv+tbVKETb7AoDWA1HUsvcQjYS7317NQ9HM4/Rx3
	mqLJAyThy9edt4zQY3A0fBRN+qTsg0A9Fa14N7tYx7zZf1O0pXa5ICwrMVaHUkF5
	PUdSR2PtSzQQDWLwuGOwP3C0hVlzTo5uw31yNL0UQJ0snTGgmgaJIQYO3JcC7IaL
	keMe2E8wO5WOQ/QwRadkC4PLpN18y0Xn+QpZW38pGGMksyNOSFKkHGLyrVCJ3bkm
	S6p8thjKNU3TFllCVqCCBi3/v1z90JX7gkayRpZD0qlOdVw9g+1DYTCxIKuEn5TB
	IlujUZszSz+2kdDEFllzw==
X-ME-Sender: <xms:ZuYrakavxWUHIbjV3Tr4OgfnFwp7wmQLrT7ac9JaT4PIBGqdNk20Lw>
    <xme:ZuYranII9yHsx0CYWS2oUGYMl6wTLXKlLrF0d1eLewqIykTvNXnaysMRdEs5exv3S
    8tlzcdQHtLsdtRuzotLaAGW8i0aLmG0GN8WrnsrOIqd4U-AIHUw>
X-ME-Received: <xmr:ZuYraiCAPnfQdpx7eDTwClFOuJ7Idp38byvHRHrojnjmZIpx0qoRrEVx-x_4C6-oMVIDre6pPafQcHUFurD9RcpfhzagX8Ft00lC9VTRlK7Fjr5r-g>
X-ME-Proxy-Cause: dmFkZTERrdIpjGQNgIG/OGWz1D9bVoz5V8zWLwtO867Cs6ZH6AMFdMopiIej0jD67aczkQ
    0aZyT705H1QUkOLV4E5X6tItQSEmnP42ID1YRn0jz2vu9FjqbnfMHdaL23/3Oiy2OndmaK
    9kCKLxsQMlOmbgA4Qc+YNn6/NIFh+UIGjJmcXTxITpzQ9uEpzg4r7EzSitFtKCWXrgmEBn
    EwfdaYaoQggGndSuzJI3Hg82Sdx1+0B+RSeVXMmws6kMfUoRQcyShp8ndlX+QQs570NqY5
    1J4mC2EDpagqGprfjqk8tuDqTicyU0ftYW9wz2e0U9kJxmgbOfueDaktvI9ymLoUmbWHpQ
    N4+nmXLSlCm6LMFU6MaOzKyQutybQRTOJvBYM8ligKUapNhvODTRY9tGFCu1D13GXiypUB
    Dsyy7q2MOWfVgmZyalutbjgdbRMTQ9z1KDVRtL8IUxzKRDUEXR+6giJ0RoUtgkR62O0htL
    XoLGKvlmdi/l0DtZp9d1az9PYJN4swr9WjPfmwnisc9OqoZyHoDMcSq94+r09FODg6Ip4c
    Jd3KPoYl8Ja8iFrjvZgEEi1KYMn6EyydTGPAQmsCRYYDY0D5kqTLL14An0Q4MvXHyXl+yk
    vKPuOydtr+EPeK6IMovagNez0e6IQsXqy0Rja39w2w1bWnkwbL4DKyLH4KvA
X-ME-Proxy: <xmx:ZuYrasrOytSMg7H54Mf6OjKAJDan2oodRv96eBg7CKemcJUb4YH_MQ>
    <xmx:ZuYratiRLgwSZaRzOUEXri1EGNvW_4-gScoIvThm9FJ5I6wv0TLpjA>
    <xmx:ZuYrapDpKi0Mwj5FCkd_2gX9his-KsPJJ5VevVK0D_AT3cvbHQmwnQ>
    <xmx:ZuYraiHgxmdT0KJCsxLW7tMl3qkZaxWuHq4vK8rUJ0YY_8SU5-TROw>
    <xmx:Z-Yrat6h1nGwNblBnveWnR9HyhSBb6DAa22KbcJkli5LweLG8-H8x8NJ>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 06:58:46 -0400 (EDT)
Message-ID: <90a8094f-29d1-42a0-8c87-f8cc567c4e0e@bsbernd.com>
Date: Fri, 12 Jun 2026 12:58:44 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] libfuse: more random fixes for fuse service containers
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org
References: <178114032924.140224.9298472352650513008.stg-ugh@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <178114032924.140224.9298472352650513008.stg-ugh@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/11/26 03:14, Darrick J. Wong wrote:
> Hi Bernd,
> 
> Please pull this branch with changes for libfuse.
> 
> As usual, I did a test-merge with the main upstream branch as of a few
> minutes ago, and didn't see any conflicts.  Please let me know if you
> encounter any problems.

Thank your for all the fixes, LGTM and passed tests - merged.


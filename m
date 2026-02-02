Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EDA37FF6B;
	Mon,  2 Feb 2026 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770050994; cv=none; b=iQ8t2+jgryCcs5GBFLnV1dOEOvp6NXAupxMRsfWTYUyTKZbjUzZOsHgmoqUaw4c+pOSMGb9oIz6BFzlpL5SCIU5x5FEafkeMam3D+xro33N5ZguszM6PFF/UNEFX7ud05cGTznqf2CC04P3ZXx+oEHQMXhm25q+65ubR78XvYA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770050994; c=relaxed/simple;
	bh=ADDh6DNwFvJna8kiBvcUDU8sjLzuXvXrDQsTmq9Vrsk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oQYL+/RDoCijLensHB4y4AuUT1Q6QxIszpo9UVRh7D0znV2eKIM3UxXIPQOPM6gGj36UpF64ZsBii3Y54OID7ffmYWlOPg5Co1vRp8bMtkDjf3R5ZyiiYQkdMbMnMi5WaAMjlxsMknJpy3Ze863I3xROH1wCo0rOl7tXRcwSQPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=kHqOXfXk; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="kHqOXfXk"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C01A140422
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1770050992; bh=IzqmL+e8bE7ABGfszn/rXJ/N4VUMGs4sZodm5aNmARg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kHqOXfXkPZ17PKUG9DsV3yvrjFUvGOQIYrBTJ5A/5gAkvYgjKaKP7qojTuSpG8NKv
	 yJmyTPovFPom19TueaRg98OTG5+NGfqZMHgt/Dq5H+OvZK5zRPT3os0Ghaw0HTBDkL
	 DX2PE97/+2S/lvHJIBrP5pWBo0MsOQfqRyTbLEULvzqBWllAdi8r0ulnF0XRB+3vde
	 X9J8nIPr1KiXx5MpeHPXlw6QIK5elpDcRHmZaw+CT8W5DREYmSd/REXcBVl6Icf5Mj
	 YwD9yxuC/ZgRgPn0RMC4QvC+lpIyHlQaYb3oUyJ5CK6cwRtU0g5urHwbdqzqnzmXBC
	 IGded+aQ5QrlA==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C01A140422;
	Mon,  2 Feb 2026 16:49:52 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thomas =?utf-8?Q?B=C3=B6hler?= <witcher@wiredspace.de>, Shuah Khan
 <skhan@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, Thomas
 =?utf-8?Q?B=C3=B6hler?= <witcher@wiredspace.de>
Subject: Re: [PATCH v2] docs: filesystems: ensure proc pid substitutable is
 complete
In-Reply-To: <20260131-ksm_stat-v2-1-a8fea12d604e@wiredspace.de>
References: <20260131-ksm_stat-v2-1-a8fea12d604e@wiredspace.de>
Date: Mon, 02 Feb 2026 09:49:51 -0700
Message-ID: <87wm0vrsy8.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas B=C3=B6hler <witcher@wiredspace.de> writes:

> The entry in proc.rst for 3.14 is missing the closing ">" of the "pid"
> field for the ksm_stat file. Add this for both the table of contents and
> the actual header for the "ksm_stat" file.
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Thomas B=C3=B6hler <witcher@wiredspace.de>
> ---
> Changes in v2:
> - Also adjust title underline to match the new length
> - Link to v1: https://lore.kernel.org/r/20260130-ksm_stat-v1-1-a6aa0da78d=
e6@wiredspace.de
> ---
>  Documentation/filesystems/proc.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

jon

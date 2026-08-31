Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A7C3876CE;
	Mon, 31 Aug 2026 21:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211745; cv=none; b=hD4XVc4NJY7b5NMVZx9nzj2xlJ7t0c8mvCyz53LDcmwE9iDHhs/MwD7qeNKhqedmlbQ5Pn9c3ZIzZ8NTvBXJa1WhUjYoubUZVTazEcWSlP1tx8LRZ9aJj1s+9DEb0jwmeJES9qIBqmFHwGH1L52pJBtF1xZ7Kf/yK0EeLiThFs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211745; c=relaxed/simple;
	bh=PCN9UfOzO3Mn7Sfx5XGmo5b2BoiX67PMH8e30uJgX4E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dTsrenN2YkfxqwRq6gDIMSAFDddI8LChIDxMpapcsniBUZEoKQThzrBuwmcuhGFg0N4NFjacGTnmnRgzddE5haR/osGUTrUSaV1V694goSmahtF4jwyZ1lur55spgpf4/aqRHFjUQoz355ktLzOoVOgimGDJXrNiOYDHACl+IEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=TRs4nC3t; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="TRs4nC3t"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 98B97408DB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1788211735; bh=1iZnCYqMD/YORvHC+qRafaC4pSWVVewj4ABJOj6lxlQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TRs4nC3trGNVRCCRIF3aIvQOiRWhEnhUNHzF7hlQTH8pPamL98eSipPqFHWc/I0F9
	 kFJ/hmq0+beMJmX6cXDsyZDdz1ClEqO4kSEyHtJpRlbUdN0N9RgOWRvtYkJPdQUp8a
	 /tkX2afr+xnbN9G+d+yn6RgnYUPQ9/TonQ5WPRkTP+gP5eiDgsO2x2Ku+AdrAgvX/R
	 iRurCswgkMdHuMBZR8JtAK+3PsxQ3cKYrPgdPsBjrukXMa+1Z1c0GAGU+z/kO8kGYj
	 iO8tT1oCqckVWkaSWhi9AIeqTC8sh2xwztbMq7hJ/tvgI9rVIDddtMJALzUPiq1Xf/
	 MDkic9vAnui8g==
Received: from localhost (unknown [IPv6:2601:280:4600:814::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 98B97408DB;
	Mon, 31 Aug 2026 21:28:55 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
Cc: skhan@linuxfoundation.org, rdunlap@infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Drif Abdelmalek Mohamed Said
 <drifabdelmalekmohamedsaid@gmail.com>
Subject: Re: [PATCH] docs: filesystems: proc: fix typos
In-Reply-To: <20260818214604.20349-1-drifabdelmalekmohamedsaid@gmail.com>
References: <20260818214604.20349-1-drifabdelmalekmohamedsaid@gmail.com>
Date: Mon, 31 Aug 2026 15:28:54 -0600
Message-ID: <87mru2gesp.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
writes:

> Fix five typographical errors in the /proc filesystem documentation.
>
> Signed-off-by: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
> ---
>  Documentation/filesystems/proc.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied, thanks.

jon

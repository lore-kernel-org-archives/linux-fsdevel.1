Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD0B39A058;
	Mon, 27 Apr 2026 10:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777284200; cv=none; b=Jx/C00ASb/3rJxH0eH4G3JYJrkNVaIv/zizk+vxHl4GkN/tqvgVOXSFU24NOFp5dCt+mOsvMVS7fYCQ2J/+UeWWD3hLIY/XQklfrI86R9VGPxFoZs2mBH+/D1phLigKKFJ5nQJbI1nTwu2zLN/BJA0JLtk7OWPU0YrzNH/Ye1xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777284200; c=relaxed/simple;
	bh=XyNYRoYdwgKbFVrPXjvyBroC5GmpKh3iMSvPNId0JNk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UO4InfUMoPiycGfkpj7lUJmuRETeRiF1ejdXcJ0futMYCGVF5Tbd2SNQe5MAjIDxzyTYQZha5NNAYqrG4X4I81gsEoJMpl18qjCv3UpykiuYyl6ybV1PurR7NgADDEmVCvNtlf3uuFj2QHeJYfe5BDS5X569r8vRcmVZpB21tJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=XjiFec+S; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="XjiFec+S"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 76C9241098
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1777284199; bh=DEsgJQZ/FcIxBV5HynNEKW8D+865vS9BlRDMv2OrAZg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XjiFec+SFeHMtnM0vOe4Gxbx5aS9aXGXB97wbwBvAr9dWRpDZu7FzA6IcTqIBlLv0
	 7nncPkkjms2Tx8YiGHyGxeRxbp9FtZtfyH87c04EkCfBvobKLQ1hkqN6SXo2Z53tf4
	 GDsVQrthe4nciG2jFkrk0NT8SZqmdrQHH1XuyqsPZfPy4CYkiSfKfYbDonZzegYf2Y
	 /GvE1AdmOEPIVX8H3jMcfWX3StEZ8zY5dtmfVRT+TgKoBhVOH2Ox7K4hXuG2g6i+E6
	 WitzJJWruE/7EfGg/H/d6uf18hoC3udMQECaH+P41iMbGdQsbh415Epd7jfwOcOLSM
	 A8iWZtTR+Mt5g==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 76C9241098;
	Mon, 27 Apr 2026 10:03:18 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Myro <mirademche@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Myro <myro@myromyro.com>
Subject: Re: [PATCH] docs: proc: fix minor grammar and formatting issues
In-Reply-To: <20260415175230.46721-1-myro@myromyro.com>
References: <20260415175230.46721-1-myro@myromyro.com>
Date: Mon, 27 Apr 2026 04:03:15 -0600
Message-ID: <87fr4gpvoc.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Myro <mirademche@gmail.com> writes:

> Fix missing "from" in "prevent <pid> --from-- being reused" and
> add spacing in vm_area_struct range notation for readability.
>
> No functional changes. :)
> ---
>  Documentation/filesystems/proc.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

The patch seems OK, but it needs a proper Signed-off-by line.

Thanks,

jon

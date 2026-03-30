Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C82369985;
	Mon, 30 Mar 2026 17:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774890188; cv=none; b=c2YrBOn1pybgt4PNsJ1NmUESqGxOj9DGEqI9h7jzY+3QJf41rJexaKM494GGLBnc4d2fv6qzTWgQHln0oErUssG1NNJ+eD2/ZPJBlxwm3DSmdM5A5g6ZXJtHx1vfrvCkrsmGyRS5l2nHi1YqNzPIjJyku7o9Jc6/YJ9InWyHDNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774890188; c=relaxed/simple;
	bh=Q7xKbRz0+gaT57ra7L4y2lOaXhY8zaftbWtQ5kC93Hk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ksUMoNl8mSdyGmx7gxOJusNeHjthogJO+mhLb2l0/KMjs/i79gUQA6ZIktJ0sdK9vN3BiXGtxKwAvYDFBTQqoYFjP/xEFXSsgF/wnfoRgL64Yqzi4qRFsC30iv+D0B7lKLT6wV2DwiLBQRUfDXnqbhs1ArlsjMlKpkkcexKiV+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=s7RgPMFz; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="s7RgPMFz"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6FA56411C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1774890186; bh=LUDSAEbcy/Ks3bczFDg2JV+IiP4oX1z6FtakAazPjjE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=s7RgPMFzsMteaUxvq2/tdctIIjHDoDXSvKIHlBlPcucfO9Z/AjtemnOgHQX93xe3E
	 ybkqYDdnSsPtroHXVAspux3aRPev39g6zfaRpZrl0tiXbTLOQVjfXitGNWQGBScSIU
	 dOObZJXEo8jePthjJI7nZYMjyDTwkugTMKq60n6yuTEZnAi5Ak8QN3zQfs9FHeEjM1
	 b0ZukJ849iiQE+dMPKxTgrR12Al2lDgmOu3PLw5mBu+ljyiPLvUmqju/z4qYdSDwsB
	 FevZRJTazVWvAsciXg5WW6+qbdybuFCiDgVK7w3qubbxEqZRFkKU1IMrhTjpPJ0IOR
	 QxP+8/SrW03+Q==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6FA56411C2;
	Mon, 30 Mar 2026 17:03:06 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Zenghui Yu <zenghui.yu@linux.dev>, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org, "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
Subject: Re: [PATCH] docs: proc: remove description of prof_cpu_mask
In-Reply-To: <20260311070940.94838-1-zenghui.yu@linux.dev>
References: <20260311070940.94838-1-zenghui.yu@linux.dev>
Date: Mon, 30 Mar 2026 11:03:04 -0600
Message-ID: <87ikadmerb.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Zenghui Yu <zenghui.yu@linux.dev> writes:

> From: "Zenghui Yu (Huawei)" <zenghui.yu@linux.dev>
>
> Commit 2e5449f4f21a ("profiling: Remove create_prof_cpu_mask().") said that
> no one would create /proc/irq/prof_cpu_mask since commit 1f44a225777e
> ("s390: convert interrupt handling to use generic hardirq", 2013). Remove
> the outdated description.
>
> While at it, fix another minor typo (s/DMS/DMA/).
>
> Signed-off-by: Zenghui Yu (Huawei) <zenghui.yu@linux.dev>
> ---
>  Documentation/filesystems/proc.rst | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

Applied, thanks.

jon

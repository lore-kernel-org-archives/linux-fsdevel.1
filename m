Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B963CAA2E;
	Sat, 13 Jun 2026 05:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781328490; cv=none; b=b/VYmpoKRFFNePP7DAJj8R06nqbaW0YsjzVgltzvIi5fhD9Zz/oQtQCKBRCq5k4p/Ga56ns8btAITGDbbGeQPo+a7S0anz/VgDnYpOCs2QDBjzEdMykgYttwTO+N1RCb5s/v0j0nD4plyghbQ+HZl2v/+xy+4jZ4dH4XYQqF3eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781328490; c=relaxed/simple;
	bh=F0cyY49RatAxk6HHMWOuyq05wFIxYcoBs1nXdtxvJF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T/ZrevjmnGj/SXrS8H8yPb1QX9nsO9Lb7i8ooSm3pcrbPz19TgpBijSfQOVnWisVEo8R4cHojAlqQ63r/7Phgqcy/U+P0CavklU3YTgZ82cPpJXtUI6N8poY9qBTl+kAg3YJaNpCiKGl6yFaIsooio/DG5LwS4ugikm360qjGQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fLPmw9vF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fLPmw9vF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=y4/6Lc/+651vbxRHr5V6jKndyAO/QJF1z4yHsnYQ6O0=; b=fLPmw9vFRYdes5FAmLXwOqHfHu
	dl5TeojJJUxLlXW46s+5FRhAo0FBBofNc7u4DwgEUxdkbYln+LLANdedVoPsgYHF3dLaWgtCkJW9S
	OgaJLOJ86f8ilHO/A26CcxwDDpv6ShE+bz76fXjlAIqLgPSWIrLjKWC+zPdIP/BQ/ranbKgS8gDq4
	RZdN1m0BJaq37TL0DbEHQ0ah3YAt1AEYbv98DX+avFRLulcAVrorLw5o4oI0nkV4nmy3VeoNjvplN
	A18cYMEV9NTC2MObQFAnyBqHooHCXM0Nd6NlcCD/YFCJbGyvy2qwG+2Lf89KS9pg6SNy/G/2rrwPa
	00/zu3tQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYGuU-0000000By85-3rEg;
	Sat, 13 Jun 2026 05:27:59 +0000
Message-ID: <bcd5576a-5d4c-44f6-a773-2344ba8c6432@infradead.org>
Date: Fri, 12 Jun 2026 22:27:57 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/31] fs/stlmfs: Document ARM SCMI Telemetry
 filesystem
To: Cristian Marussi <cristian.marussi@arm.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 arm-scmi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: sudeep.holla@kernel.org, james.quinlan@broadcom.com,
 f.fainelli@gmail.com, vincent.guittot@linaro.org, etienne.carriere@st.com,
 peng.fan@oss.nxp.com, michal.simek@amd.com, d-gole@ti.com, jic23@kernel.org,
 elif.topuz@arm.com, lukasz.luba@arm.com, philip.radford@arm.com,
 brauner@kernel.org, souvik.chakravarty@arm.com, leitao@kernel.org,
 kas@kernel.org, puranjay@kernel.org, usama.arif@linux.dev,
 kernel-team@meta.com, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260612223802.1337232-1-cristian.marussi@arm.com>
 <20260612223802.1337232-21-cristian.marussi@arm.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260612223802.1337232-21-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/12/26 3:37 PM, Cristian Marussi wrote:

> +Design
> +======
> +
> +STLMFS is a pseudo filesystem used to expose ARM SCMI Telemetry data
> +discovered dynamically at run-time via SCMI.
> +
> +Inodes are all dynamically created at mount-time from a dedicated
> +kmem_cache based on the gathered available SCMI Telemetry information.
> +
> +Since inodes represent the discovered Telemetry entities, which in turn are
> +statically defined at the platform level and immutable throughout the same
> +session (boot), allocated inodes are freed only at unmount-time and the
> +user is not allowed to delete or create any kind of file within the STLMFS
> +filesystem after mount has completed.
> +
> +A single instance of STLMFS is created at the filesystem level, using
> +get_tree_single(), given that the same SCMI backend entities will be
> +involved no matter how many times you mount it.
> +
> +STLMFS configurations gets appplied by issuing the related SCMI commands to

                         get applied
or better:
                         are applied

> +the backend SCMI platform server: for such reason any configuration applied
> +by this FS interface will survive the unmount or the unload of the module, but
> +not a reboot.

-- 
~Randy


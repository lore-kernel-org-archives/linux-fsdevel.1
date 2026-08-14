Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7435348986B;
	Fri, 14 Aug 2026 17:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786727910; cv=none; b=l0x4DPZ+47HsaeGWmB6Y+AO3vaeGMOx5WDLU9pejscHsV2OTeg4wLKtZms3n/JA7uOrvu+a4keriLHF3WS/98F4jFF/qfsjs2W81+Cbu/2mSoUUMbm5YBKB4dDsmFxeOxxW/GTgmsqJR/MbfPIA8ckisZcMJEkAYIlqcwXBrDDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786727910; c=relaxed/simple;
	bh=IwdqeWZnjxwEtCIEl7VLdPWxeLhZIMc1FdsaidIV/B8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=emS0QnUqxDTaRBQI7Vi+ypyWb/CQKh0CDY6D4VppY2yBxx6AD7ePjgmLxq8w5BOmoQW8KrwqH/bCmK0SWzzLjmujllaNzg9LR45CFpAJiR2NZdUx4gUuOz1Tpi2F94E7m7QbuxUOXqzaWhqnrnLdRwTkHmdxrFj2oWNu9DxgJyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtDh6bqG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtDh6bqG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D5E1F000E9;
	Fri, 14 Aug 2026 17:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786727909;
	bh=Dr/l12RSEyep1GEBnmjxR7b9X1pp8AOjVzwzfDa3Sh8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QtDh6bqGaTEVnIdHQbmn06lufxOqzjlDpqCEATarnMLIZWKQGV3aELEoGfgIOogts
	 eaGNQzZETAxID4JfCH9yX7zsJDq8LlUb1jJYQS1VercesdNQOPl62DNNTLGnBcUSZD
	 0WTeuCpSXs+/WDUb+ebtm3/69Y2bJz2fbQ2cEmL8Sa9aONBP23zGaRjpRM0svUt7VP
	 EJKXT/YlAIBxhQ+AOAGBPCEFRR7LK8axlei0TByu3PAKDbyZWbnXZnLdxs9UcsdEpc
	 7T95ilVa9cQRyS46q2VrL7GeTkknv7XnID2Kli/elYUkpriPnOVwBAtvxT7nHgbrp0
	 n4B21W3cL9BpQ==
Date: Fri, 14 Aug 2026 10:18:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: brauner@kernel.org, cyphar@cyphar.com, kuniyu@google.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 0/4] net: af_unix: useful handling of LSM
 denials on SCM_RIGHTS
Message-ID: <20260814101828.2ea54f8a@kernel.org>
In-Reply-To: <1036785927.390839.1786639504241@kpc.webmail.kpnmail.nl>
References: <20260813162818.149248-1-jkoolstra@xs4all.nl>
	<1036785927.390839.1786639504241@kpc.webmail.kpnmail.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 18:45:04 +0200 (CEST) Jori Koolstra wrote:
> My "smart" email provider blocker me from sending more email. Since I am in South Korea
> that is apparently suspicious. Now patch 4 is missing. I'll try to rectify that. Is there
> any sane email provider that any of you use?

Ah.. shit.  I crashed out at you on patch 4 assuming the rest of 
the code is in LSM.

You gotta repost the whole thing, sorry. Patchwork (and lore) weren't
able to connect the dots. We have 2 separate incomplete series in PW.

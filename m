Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA9F366060
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 21:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776893816; cv=none; b=WlfM1ydGTFj8CRxqTU7BXa1nYV6g0ta4YjhkNUbZxjCuhYnOuNG2uYhuuaShVZC4+8U6YgrEhWP2xU/SuAbfnmWmfZhRnrgO/MxrFlXXdKe6BoXpC/nk2IqwiillmkoMebkH7n0xCNl+tCM1Gi7mFNyo55av9Vxeg9LeqDJNe2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776893816; c=relaxed/simple;
	bh=a3+q5MUu8ppPnjvBb/ehJbydztKmMhLWlRPSDg4ocCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEvcdAZzDDss7z6dN6Xxp4jwktkbUMsJlqcGzFy6R8JYPLzLgYh1xYC8W0n7J8hgFG+F+y8wgdRx6z9kJHWYC4Nnw2WWHhSzpj9m08UTJgYrxU1ZQYzPfe6aVmV3Wco28htu5eYmUT/ZEG9aJtKpn29Xby4n7DOZJRtfCQeBTy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CrmtTCPS; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CrmtTCPS"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d7213b6ebso3918828f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 14:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776893813; x=1777498613; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pcsE8J12RB+iiTLbs8m/rRHiS6tG18YSfYB0Ds2AHis=;
        b=CrmtTCPS6b+9Mhju0fVNsPBFoIp4zQaFCxJxTJ4mae4xkgvVFk4BcYrxYJRiJ5tAfG
         PUY529Glw/QCieLwvk9q928WWTYpZZYGvmfr9jXXEpQIUXnIhjxGpyH11Oump3WkBOfP
         xYMdKQe8282+DLtgvlFOm+QlOIwOzo+ua6zVWGUyp61VNlYtapreGQJf4yDsaPYn4IZQ
         W4rBjorePjSyd5hqYB+URU7PM/udhECO+4fajyIjmKN6oWWb4woZitmforwcm/rpw1ub
         2gQ9vxL8o5ftoSyCoM/30rzoCywPR4qEgbeloncegsSMJii/av3DrRlUF/PsP9o4BDKs
         5DBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776893813; x=1777498613;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pcsE8J12RB+iiTLbs8m/rRHiS6tG18YSfYB0Ds2AHis=;
        b=Ys1s4WOxljXql/DwCGBjxi4KjGaQr+a+jTOOlHBhsqi/6Xxm0Ns4lnzgb5exq2RcNO
         NnMKB/EFCncfB6RqLYRaYnGCP7ae8KA8d5ai451wfDQ+PtNuT1CGecKALtMlKpFaywcX
         kVa9jUd49ucPJHP8HGLyc3gzsbxhcRxWTzNlmPrh0PMHYEq0GeSqKQvgJ6TETno2EuT8
         tMLphRF9uFdBe1VLCzfW+4ySe+a7YMq1GBWoerl7S47qQGK5K6u6Iy9REfwFQNP4uD3v
         jF9RIiLRmP/jc7nDfxgFcRA6aWMIG+7bVf/K2wsvZJWzCYDYaZLa6fawkfe33HKRK9yi
         Sa+A==
X-Forwarded-Encrypted: i=1; AFNElJ/lZGm5s2F7EXtG7dl4Ej9rwSwjS4ewANkSZLHWx67GAhyI2C0OEhT8NXWH3ObXTUekKELkbwddUjPqKyXe@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+hzVs8HAxFE/vcNtQOryctB8bdSaDxw2QrQILxpzAzC5pq+16
	t9WRgMUkQQ9z3lJtBshRL6+/10rtwuUa+RQ0+YGpCpWDLcQOy3owpOH9
X-Gm-Gg: AeBDievb2B/EUKKVp7W8XO265j0HlyTSVvpSK520kwI3SIRffzYn1dgVIYleDf7a3Cv
	VQu9gXMcQxXZyAvZKIIbEh5QkmcHCnLl8xdP9b7hnAq/gz+50kKoj+UGOZvy/T2nnLdE52GVkTh
	H15Bj01/kdusyzM5eS8KiSz1o+1Xa4a1IIWOKuc17/pPfCnqVdBWjV7+a+vOGzsl17zacDBXZnh
	yI3GrB3/Xs6GBD3FsRzn8by5UwZqUU278138X34hfV2UKW/LNjXHidgdn4dyCR0sLbytV28xS+J
	vlB1g2QZoAfabpd6J/9e7+T6ftnKSthxaa+WCB5FurQbPRfCs3c+FTceB4+nkYyBrYRwvfg1Cnu
	4mXeR7GMlJGzcu/L7afTWpHsX6JZsftcZ4GD2jR1aztQn47NXISOkFp3VIWFd0Q9I35NITbBVCv
	sm6U+Zj0mlhPfc2Rifd/HkqujH1AfIMGa36oof7RMu/hXVh9nChxAZyak/q5nTScK+QQBytg==
X-Received: by 2002:a05:6000:2909:b0:43d:30ea:9383 with SMTP id ffacd0b85a97d-43fe3dbe020mr37478584f8f.8.1776893813247;
        Wed, 22 Apr 2026 14:36:53 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a18csm55085919f8f.20.2026.04.22.14.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 14:36:53 -0700 (PDT)
Date: Wed, 22 Apr 2026 23:36:51 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Lennart Poettering <lennart@poettering.net>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Shervin Oloumi <enlightened@google.com>,
	Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v1 06/11] landlock: Enforce capability restrictions
Message-ID: <20260422.7b9d51611964@gnoack.org>
References: <20260312100444.2609563-1-mic@digikod.net>
 <20260312100444.2609563-7-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260312100444.2609563-7-mic@digikod.net>

Hello!

On Thu, Mar 12, 2026 at 11:04:39AM +0100, Mickaël Salaün wrote:
> diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> index 152d952e98f6..38a4bf92781a 100644
> --- a/security/landlock/syscalls.c
> +++ b/security/landlock/syscalls.c
> [...]

> +	/*
> +	 * Stores only the capabilities this kernel knows about.
> +	 * Unknown bits are silently accepted for forward compatibility:
> +	 * user space compiled against newer headers can pass new
> +	 * CAP_* bits without getting EINVAL on older kernels.
> +	 * Unknown bits have no effect because no hook checks them.
> +	 */
> +	mutex_lock(&ruleset->lock);
> +	ruleset->layers[0].allowed.caps |=
> +		landlock_caps_to_bits(cap_attr.capabilities & CAP_VALID_MASK);
> +	mutex_unlock(&ruleset->lock);

See the example in the documentation patch set [1]; I think it can be
an incompatibility if we ignore the unknown bits here (and I don't
know of a scenario where it would be a problem to reject them).

[1] https://lore.kernel.org/all/20260422.5a7059c06fb0@gnoack.org/

–Günther

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC2B32F770;
	Mon, 27 Jul 2026 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162490; cv=none; b=aKXIxVOP3++VBD/qe8LsK8BvMYb9GkrMzuU3r3OoeNtbm35vL+yKO0HyugJngaJQDp0kWU1xHusNPtLWcmgxVpwAWhVmj2s2TyEYO1bHv9ybDfaW20hsumjT/PsJV617t7DkSpvW42HI9OWDClxdcWE8nnTi2pve5GiILjBTbnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162490; c=relaxed/simple;
	bh=9xzmdGThkWtwSnWIM0+es9oumG1x+anNRR8bFp2UVYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJ2DaDuIMJFvepL3wScyeRClJIwN0Z/FMvqe53ErrukmEflh27/FPoidrd+T7ViBOaWTJYwM/SF1nWSQX3viT7ayqoOiOo1AsNjM6ppwAEkOpHlvV4/V+ubuzDvEFFHuaeu6ddEqwWrcsrBHqtVFCECWddj9QuaR+aS70mrAYHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvKvXXRd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvKvXXRd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612161F000E9;
	Mon, 27 Jul 2026 14:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785162489;
	bh=ptCiNT74n2ClApn0GPmUaC404n0sknElOCX6NQwLjW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SvKvXXRd7ea3f/0AmXK7+cSSqgTyE/JREJX+W4fmWFUoXtiNbIXyAvKkAHzNuBynu
	 y8tLAI4uPBxubfJGOxi050VNRH9jEyJhYYoz/k7AH9BMKkcXtflVxflSBuv2aqYMqO
	 ZbA94Ind3ewx2l8/mrvmu4ceVFUaZuddAB51Vtywt2vq7smcWeya1GMurP5nxtG6Iv
	 2PZw6n0x6dSTblPwqlA+ax7bRVyCEHyoVnBGQJ0nnl5tlPFxKGsYyJ7RlypQMZeMXp
	 qy4YMEoLH7MBUnSD7FtC2y/vDhgnbLf+mnkGRt8gwOuBhIju6CPBr4JvlyXK5c+Ayb
	 IMPuxdYMaBNiw==
Date: Mon, 27 Jul 2026 15:28:03 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Fayssal Benmlih <Fayssal.Benmlih@arm.com>
Cc: Cristian Marussi <Cristian.Marussi@arm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"d-gole@ti.com" <d-gole@ti.com>,
	"david@kernel.org" <david@kernel.org>,
	Elif Topuz <Elif.Topuz@arm.com>,
	"etienne.carriere@st.com" <etienne.carriere@st.com>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"james.quinlan@broadcom.com" <james.quinlan@broadcom.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"kas@kernel.org" <kas@kernel.org>,
	"kernel-team@meta.com" <kernel-team@meta.com>,
	"leitao@kernel.org" <leitao@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Lukasz Luba <Lukasz.Luba@arm.com>,
	"michal.simek@amd.com" <michal.simek@amd.com>,
	"peng.fan@oss.nxp.com" <peng.fan@oss.nxp.com>,
	Philip Radford <Philip.Radford@arm.com>,
	"puranjay@kernel.org" <puranjay@kernel.org>,
	Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
	"subrahmanya.lingappa@oss.qualcomm.com" <subrahmanya.lingappa@oss.qualcomm.com>,
	"usama.arif@linux.dev" <usama.arif@linux.dev>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>
Subject: Re: [PATCH v6 00/22] Introduce SCMI Telemetry support
Message-ID: <20260727-bouncy-slim-badger-bad63e@sudeepholla>
References: <DB9PR08MB86510C934D2EF25F625A5F38FFCC2@DB9PR08MB8651.eurprd08.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR08MB86510C934D2EF25F625A5F38FFCC2@DB9PR08MB8651.eurprd08.prod.outlook.com>

Hi Fayssal,

On Mon, Jul 27, 2026 at 01:53:45PM +0000, Fayssal Benmlih wrote:
> Hi Cristian,
> 
> Thanks for V6. It addresses a useful subset of the V5 feedback: the
> uninitialized feature flags, signed exponent, group bounds, bool casts,
> SHMTI enumeration loop, scoped ioctl magic, compat support, binary-only
> interface, ABI information, reset, and oversized mmap requests are fixed.
> 

Appreciate your efforts in reviewing this series. But the below format
of dumping all the review comments in one place is neither the normal
mailing list practice nor much useful for other reviewer to follow as
one need to map/follow these when reading corresponding code which is
painful IMO.

You can look at other threads on the list for reference or we even have
an AI(sashiko) which does inline reviewing[1].

It will be really helpful if you can switch to that mode for future versions
or comments.

-- 
Regards,
Sudeep

[1] https://sashiko.dev/#/patchset/20260724144430.1440170-1-cristian.marussi@arm.com

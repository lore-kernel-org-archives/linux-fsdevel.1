Received: from sxplsmtpa04-13.prod.sxb1.secureserver.net (sxplsmtpa04-13.prod.sxb1.secureserver.net [188.121.53.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6C330D3F1
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2026 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785770578; cv=none; b=qG0ALRfMzXGQ4QvVAA+eQ/3MLxxo8oBFmcAQ9WCaix6GV7z+8rhiBqLH4kW4Dd0HrgvMQty5Upi69AkR2GvINUMCLFdvnvmrDZcX54GUDO0Q39nIDq+2Hz7HWcSale2W073HiSHNA7JmUvXZc/20bXJPTpIcL46Ih/DfH5+nmR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785770578; c=relaxed/simple;
	bh=wsr/Vgr8FsBlJK3Nl5ZA/CgGz2EiQx1+o8RdYs9W9HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZC7tIBb5ZIocJinRkawkmKcPqjPQ7BcjeH/9krhb1064ievDgOI7h/LOUaAjup60ZL923g5+adOvdlViP9vvxDo9xtYHEF1uxHAYOR9SVtrwMTjzdhuc7tdr4c6FACeFBU92qTkxF9HWQh1vIQvFDrEIvFsrDFfQFadEDK/IFWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=squashfs.org.uk; spf=pass smtp.mailfrom=squashfs.org.uk; dkim=pass (2048-bit key) header.d=secureserver.net header.i=@secureserver.net header.b=R4VOpb6l; dkim=pass (2048-bit key) header.d=squashfs.org.uk header.i=@squashfs.org.uk header.b=Y9jGQEO+; arc=none smtp.client-ip=188.121.53.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secureserver.net header.i=@secureserver.net header.b="R4VOpb6l";
	dkim=pass (2048-bit key) header.d=squashfs.org.uk header.i=@squashfs.org.uk header.b="Y9jGQEO+"
Received: from [192.168.178.95] ([82.69.79.175])
	by :SMTPAUTH: with ESMTPSA
	id qtnowdWTm94CIqtnqwECnB; Mon, 03 Aug 2026 14:38:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secureserver.net;
	s=secureserver2; t=1785767888;
	bh=ZigqBx1z2fVxk9toGaTHW+JROtjibxjm+YBaxQst+8g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=R4VOpb6luB8GCeDYNKo/yCikLtJTdQoUcj9f9kK7QyNY7weLwkNL86tsqEtjivWlp
	 3mEQPjGVhMXjP3g0nYuKF43RhDLbFgfRMnwXkpf3vg5CstNgxhMoW2cZMtG8uhoAPF
	 pn9YkViUpFM/3K5ItWV6xpaPCrLd7euw7RULL1Gg46S6pPoYeVXeHRlhnnqAiEyHDC
	 mWYymhfHEfDAyhhluC7zq3L3gDSAab2Dyx2RXEBfoKcTThJLq17BQZiFSSL817lMoX
	 X5ORtAtWWDqD1v4iQpMLjgjvCk1lrr/RbqKMNXvMTTjIyndg0hx/mCoeXWpv/Bs+qC
	 n3uhBkhm2lVyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squashfs.org.uk;
	s=secureserver2; t=1785767888;
	bh=ZigqBx1z2fVxk9toGaTHW+JROtjibxjm+YBaxQst+8g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Y9jGQEO+r8bXLf1hxOekx5IVUbHJU6sqyGViLRdGnFTQDJ90X97f+Pa5VqG4BqYWg
	 6hW9ekYq53RHdo+dxSNXacNK11SQToX3ngkXtChyDGZmY0b4BU20eLu/CXPeeE70Vi
	 fup22h2e0TSqzq6oEuglg+QRls0FYew110zFUddfaN7Q8Z9UFP1iNTKJzOXQi0if2J
	 Uf7L9sFysNCvtn5K3cMTU4U3PVITHUdlQmD4+VYP4mGhQxokC5UeQMBGtjkE9ugtM5
	 fjVjNDSFXt2WfWDrkp4B5kNmnnYUWJ9tabXbpopFZkYk1GWnlXBoK6sNEH+4alEGfu
	 bUVsmRkzqQ3dQ==
X-CMAE-Analysis: v=2.4 cv=OuTlDS/t c=1 sm=1 tr=0 ts=6a70a7cf
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=IkcTkHD0fZMA:10 a=W7u49nuzTVVRffdvvHEA:9 a=QEXdDO2ut3YA:10
Feedback-ID: 1cd59531474cef23836056c1d21566b6:squashfs.org.uk:ssnet
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
Message-ID: <20f40e87-02b8-4714-b417-2730f304d624@squashfs.org.uk>
Date: Mon, 3 Aug 2026 15:43:03 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] squashfs: avoid thundering-herd cache wakeups
To: Usama Arif <usama.arif@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, squashfs-devel@lists.sourceforge.net
Cc: brauner@kernel.org, hannes@cmpxchg.org, shakeel.butt@linux.dev,
 jlayton@kernel.org, boris@bur.io, riel@surriel.com, kernel-team@meta.com
References: <20260724190556.1950693-1-usama.arif@linux.dev>
 <664bff99-ef20-44b9-9c5f-aa6c8755133e@linux.dev>
Content-Language: en-US
From: Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <664bff99-ef20-44b9-9c5f-aa6c8755133e@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfIoewyXLu4taQINv0gjAFXaxTPvtlYpiW+JEkuTsqIECgkASybn1kPXdqc8B6mLE81SkrtFqFVGiwSBC02rHyNeqcUTfhBEbSUyp6I0UGwAkE4cbBvJs
 YlhFT7Kr9lgqCyT9929fnM7BhkwhMxeuikbCeORJdDVzfDw8H/ZuXEoxVWFpXb6YnxGvQhBZVDnshoCmbH892D5fjU2YRIJ/7z/NrdwmJrKHAxWIDYrlyvRu
 yhLkXowoTni9esEHbQMeos851AW3W+Y/uZL5oBdVoK5oz193cCl8K5Aqx4rag8hB4SoE5Ln74R8rRAlmuAivTb1i7iF0mdCBXvBktmGxZc8ekeqBXZOT6ucI
 5fta7mc8Nc41Rv+eOejFVJP5dH1846GSufrhz4ADVX3c7XkYX2YIv/O23z5kpIuKYqG9+D6lIzaM3vrMcqVLf7w37QNZzj8gjLoKYgCeY10vZ+Sz3BvBsLCh
 UjUV/h6RIN8+nZGjs2IrInZ5m/w4vs4ydO5Zx/PXMoYuxS/g4EGbrBO6URzuAU/eGvU+0xD+EwthiSYkMlO48WuXenSL8tkGHl/oFg==

On 03/08/2026 11:16, Usama Arif wrote:
> 

> 
> Hi,
> 
> Just wanted to check if there are any reviews or comments on this patch?
> 
> It is attempting to solvie a real thundering herd problem we see in our fleet.
> It also doubles throughput for small file reads and stat for squashfs.
> 
> Thanks,
> Usama
> 
> 

I have been on vacation.  I will review it this week.

Phillip


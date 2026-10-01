Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D3A3D9020;
	Thu,  1 Oct 2026 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790866091; cv=none; b=SFeCeT9CMUWPVrLaIm53SXaLvnmYmy3hLPIZGpfoq2RrzU3NJp5jbsLKHZc1vBdla3JmqMLlohwAwPvsbSDxVN8dXwEajMJbArmRTAihyJs+8AunIrz1e8zSiCsEzGMYyHJnDSw0rNTAH3yY+BQlgx5M7hSo4ichqB6iFqIsbhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790866091; c=relaxed/simple;
	bh=nBoTjTKUwo9FEje/Uo8ieqr0BBHnpwexPSuOt8wrpwY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Cg1ERNRP8KlrHgwsrXtt2uuZzw3w0aL3r+ZTvMypPtr7EON88P5/q0/AL10GuvZx2orgvNgQRfyGlAe39CFrK6fUrzGUAMEu91dq+A8PZWN9+OiebrKSwZ4jrifUgzgaGRq+bnFyZsTpiJeIAoxMNgcGdLtY76GC3vydNARgiV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=WA4MCbjA; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=uiTZNyRK; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="WA4MCbjA";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="uiTZNyRK"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790866080; bh=eYcrqBdFH3goT7upcHl6vqR
	PqlYEaFv4BxPBigH58zU=; b=WA4MCbjAmDelAYP/U+GyVZcmVxom7ppZSxhK6AnCiAEHsQAm4+
	K8l+79kD7fg3tfk+rnlNXUuSXG7dV+4DuQMSsMn6YmqBwWoP+wrZTGUFW3Uqe/xMXI+vvpvmJ5f
	Sab6fOHsJ+LNcG1f9yvLuMyZAvySQoLotjDoPHt/S/9o0XOh6K2xUUW/U+/kro1CHb3lPCy5Fg/
	E/LIEXVdPpD7NZtYYqRCWbDhmNSreAu9IlrDOab7ZeDioQpZsAFFhEj3YYBTgjFC5VeWcuAPc+x
	zmurJebkSBFd1v3gfvEYqYbmjvq614UwJ1kwlGHqqMUxaavfCi93Dfp2A+w6bc1b81Q==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790866080; bh=eYcrqBdFH3goT7upcHl6vqR
	PqlYEaFv4BxPBigH58zU=; b=uiTZNyRKtHErHvQAwvdaAtF+9l1LbhEsezhRtP/Hh8mAXxdk95
	wJkfy/nHoNcuf7YnCc0KeI4r0XE2eVhM7IAw==;
Date: Thu, 01 Oct 2026 15:48:01 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Joel Granados <joel.granados@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
CC: Kees Cook <kees@kernel.org>, Zhan Xusheng <zhanxusheng@xiaomi.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] sysctl fixes for v7.3-rc6
In-Reply-To: <zcnee7kd4z7ncgccbh4cpmwoj4pbdvrscjl4chey7c4oczzgwg@fy3tb5yzdkii>
References: <zcnee7kd4z7ncgccbh4cpmwoj4pbdvrscjl4chey7c4oczzgwg@fy3tb5yzdkii>
Message-ID: <64BB0700-D4FC-4797-A451-987D1D875570@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 1 October 2026 12:38:46 BST, Joel Granados <joel.granados@kernel.org>
wrote:
>Linus:
>
>Missed this in the tag: tested with sysctl selftests on x86_64 as well
>as linux-next (for a week).

Also all tested on my PowerPC host, with the tests. :))))

>
>Best
>
>The following changes since commit
>72d3fcf802c45d00b300f25b848a93c3a2bd7c7e:
>
>  Linux 7.3-rc5 (2026-09-27 13:55:01 -0700)
>
>are available in the Git repository at:
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git tags/sysctl-7.03-fixes-rc6
>
>for you to fetch changes up to fdd6553e1e53b0421d89c7469c8a36d2eadb1115:
>
>  time/jiffies: Saturate in mult_hz() instead of wrapping (2026-09-29 10:00:40 +0200)
>
>----------------------------------------------------------------
>Summary
>
>* Fix sysctl jiffies conversions errors introduced in 2dc164a48e6f
>("sysctl:
>  Create converter functions with two new macros")
>
>  - Ensure that mult_hz does *not* wrap
>  - Ensure we pass just the magnitude for the negative branch in
>    proc_int_k2u_conv_kop
>
>----------------------------------------------------------------
>Zhan Xusheng (2):
>      sysctl: Negate before converting in the int read path
>      time/jiffies: Saturate in mult_hz() instead of wrapping
>
> kernel/sysctl.c       | 2 +-
> kernel/time/jiffies.c | 2 ++
> 2 files changed, 3 insertions(+), 1 deletion(-)
>
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds

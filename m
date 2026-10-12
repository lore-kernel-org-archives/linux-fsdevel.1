Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998A3279DAD;
	Mon, 12 Oct 2026 02:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791771468; cv=none; b=TOCH9SVdBX+8hp2+UmP1GOcmjv4ZThWxyqjy2XBOBRR6Q63qZYwg9oHyLUNwxkdXBt6tk1X0XZSf1Z4RFXhK/T5sxcYJfewGoSjHXv4iPTFUCVNrAbjfNOyvUrtUOsLQ4Ku70owV3lDsvQH352CWbTubNBJJSpseS0ixkXigQCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791771468; c=relaxed/simple;
	bh=NeIhnVyQKaNytg2s4K6k5O17iEb2RcJCXU1dJyspN0M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hgEhXmNP3zN0jt8ilvhr4zUuXzNeZFYWBZKcULFZLfB9uL4MH4T5gw+4FYdyCV9ZytHPZJ55mkbq26NjQc/jABdz/alpjlOzNlTLrQ1EH64/FKEEMwMGFoiqCh9aFvYanmHdw9g3kaAmUpG+njNVSdlatsuiFBvZ89amcXgmtuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WNmuX8Wv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WNmuX8Wv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13991F0089B;
	Mon, 12 Oct 2026 02:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1791771467;
	bh=/oIw8dlAhbEmZVCNjO1QyPQXa9ogDOK50cPedC21+qo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WNmuX8Wv+RBkbGogF/DHD5r+narc0DsnjWEd1gOtqV6h7xTqNWZ8tgRgy61d7JSue
	 vooKNi3iZN6jPng9A29KJOTqx/uN+HRzdAEpQM9PBNGTGxtMs9I3FFqcKaeqnlqxgt
	 Pt5FPqQR4nr+rBZCw0cKyaR+X88uSWsgjmp96PsA=
Date: Sun, 11 Oct 2026 19:17:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/proc: proc-pid-vm: fix unused variable
 warning on non-x86
Message-Id: <20261011191746.52b84811a6385d4ee414408b@linux-foundation.org>
In-Reply-To: <20261011223358.2327625-11-sashal@kernel.org>
References: <20261011223358.2327625-11-sashal@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Oct 2026 18:33:39 -0400 Sasha Levin <sashal@kernel.org> wrote:

> g_vsyscall is only used by the x86_64 test, so other architectures get:
> 
>   proc-pid-vm.c:224:21: warning: unused variable 'g_vsyscall' [-Wunused-variable]
> 
> Mark it __maybe_unused, like str_vsyscall next to it.
> 
> ...
>
> --- a/tools/testing/selftests/proc/proc-pid-vm.c
> +++ b/tools/testing/selftests/proc/proc-pid-vm.c
> @@ -221,7 +221,7 @@ static int make_exe(const uint8_t *payload, size_t len)
>   * 1: vsyscall VMA is --xp		vsyscall=xonly
>   * 2: vsyscall VMA is r-xp		vsyscall=emulate
>   */
> -static volatile int g_vsyscall;
> +static volatile int g_vsyscall __maybe_unused;
>  static const char *str_vsyscall __maybe_unused;
>  
>  static const char str_vsyscall_0[] __maybe_unused = "";

Can't all the x86-specific stuff be moved after the #ifdef __x86_64__
which is a few lines later?


Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4132829B78B;
	Sun,  3 May 2026 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777820897; cv=none; b=eecjxmSbnllfL3ag7dQxsDR3aA3eJkkGk/29Up8boBjT0d8JfPO/vLf/RroAfxcy1zSgl1E7wqBuWoMI9oNxIRFI3DcpSkgB9AeMbZB3PPRbO7/k1cXo1K0ozAsHKBq2kdHNsWqns4VKd0oa7JI9XYRq6XeqfXfRXvpyMRJS9Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777820897; c=relaxed/simple;
	bh=4kMyH3o0/5Er6i7De0D/h0b8a4ihDoO4OEd8UX2tGDg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tclY6E+VUdfzXByLXCr7HEJ05PsYhU4f4J7XpM8lUiQXtHp06w1xZhpt7s+71wBY3aZ/Fmh+N7woWB1EicvPBuwUdHZVQGArUXAD13Y3yyliRlxIhlvqGkkKG2Wu0VOFTNgZ+lbWO1X2iOd266ToMEF5u3pSalWkTxEZKY5npwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=apesZn5T; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="apesZn5T"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 54D7E41084
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1777820895; bh=EY31/lB+p3Ty2G2hZ4XxiO9VJJzRrgjaTW0nSguAHI0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=apesZn5Tz5QecRd+DB00WmNdlmt1iqV/SIexTW9DLiHWIWqR8BhTRPj1pQIwU/uFT
	 52DjmGROvcylScP0rqBzXG3OYRfRe7rTT0L5y60M6KkslvWwPBFaZNDc+UkvUo/wxp
	 +W9X4QCPjrsW74AJjs9J3jDorJSVXWsJjREmlv8R5r+C9fwjAgQmOwlx/W3I2pCE9y
	 a8HhpISp8y0z4uYDB0Okx7iPPG6OtZnJad/1nyrp+HP3ZJkNxxEq4+KS6TlbfT/3+p
	 hWSBfKzZrQ799fOm7R9nVyRR14jTPfggdj1f7IdAflry43E1yWTzE1SfxTG6Vyk5Tb
	 uPPMdW25+4U/g==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 54D7E41084;
	Sun,  3 May 2026 15:08:15 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Myro <mirademche@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Myro Demma <myro@myromyro.com>
Subject: Re: [PATCH] docs: proc: fix minor grammar and formatting issues
In-Reply-To: <20260428133001.11384-1-myro@myromyro.com>
References: <20260428133001.11384-1-myro@myromyro.com>
Date: Sun, 03 May 2026 09:08:12 -0600
Message-ID: <87fr48cyzn.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Myro <mirademche@gmail.com> writes:

> From: Myro Demma <myro@myromyro.com>
>
> Fix missing "from" in "prevent <pid> being reused" and
> add spacing in vm_area_struct range notation for readability.
>
> No functional changes.
>
> Signed-off-by: Myro Demma <myro@myromyro.com>
> ---
>  Documentation/filesystems/proc.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 873761087f8d..d828006bd91c 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -118,7 +118,7 @@ PTRACE_MODE_ATTACH permissions; CAP_PERFMON capability does not grant access
>  to /proc/PID/mem for other processes.
>  
>  Note that an open file descriptor to /proc/<pid> or to any of its
> -contained files or subdirectories does not prevent <pid> being reused
> +contained files or subdirectories does not prevent <pid> from being reused
>  for some other process in the event that <pid> exits. Operations on
>  open /proc/<pid> file descriptors corresponding to dead processes
>  never act on any new process that the kernel may, through chance, have
> @@ -2199,7 +2199,7 @@ the process is maintaining.  Example output::
>       | lr-------- 1 root root 64 Jan 27 11:24 400000-41a000 -> /usr/bin/ls
>  
>  The name of a link represents the virtual memory bounds of a mapping, i.e.
> -vm_area_struct::vm_start-vm_area_struct::vm_end.
> +vm_area_struct::vm_start - vm_area_struct::vm_end.
>  

Applied, thanks.

jon

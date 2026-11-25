Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795588437;
	b=yhyojFn4Y0AUvtPWFkHJcY0M33yu3slunZpCnZFJlcq8r/CE34PHA60B6YGHCEecTnNp
	 h60SvFC7If2kM09hKSX6YzmvJiAUANkgOF3CvIfjfzuq8flKnxTwRQ9sHOEo1Te1AaPLS
	 3zynRLcRiBay8YOnmFc5Hv1dXkmvfwwjR43AnZ3I9xqn7H21qcWtIXIjbyv5RK2Gjqr98
	 6KzCNXnVabvVky/lKV8m949E2ReEvYA5W/+BAur8GJsaHuzju1jT66QAGw1hm/LbkG/Gw
	 9ohZDmt467FC9a7qSl2ZCdc6OH5ha+2Nh9l77lafNVnOrCyjY+i5cnMe4DaX/52Z1Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795588437;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JtR1J/tjzg5++JWccn3tur0BBmBLKynjew31a07ikO4=;
	b=jvC2xPeBvLEsZFgRvD1zXxbe7S1fjGkPe7GH2DcNN062CWDblOZVEZhgyKPrz81nUdAC
	 O+OB30udGPbgIpVaXowfbGng8Ni+wxUcfwk4Thqgeuj6a3BDYEiNlAuyAyFp6RKfVqt5Y
	 oMmYupUzDMlrmBsj3K3MuNZ9u9XvJHOceLzU1MrXVVkCLo3gMVIrgAye4neS445vH0Xhs
	 y2DV6SzO2gJy/N2j7Ow5AsXkZfRQGMsMq6gemh78DD7c4+rS7gWckx1y72BK1kzftj/Ff
	 Hx+DM7sKy1ExLIfGGb/AuEWK8pht0NeAzsCKeI+6qDtjSqwNw2gCVB7DY2TlUV9SvLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=jBbWCYfH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B6A606A321;
	Wed, 25 Nov 2026 06:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=jBbWCYfH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC041F000C0;
	Wed, 25 Nov 2026 06:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1795588436;
	bh=JtR1J/tjzg5++JWccn3tur0BBmBLKynjew31a07ikO4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jBbWCYfHkceRQwvYbmv9tmw2C1uexEIzRdCmOWyDVi4/rSFuItNFxXrpynITgIuXR
	 O+QpKrRuLFP8bxw2naRGIao9oXlgMo6TI417BzR9HkdPVAgL/ncVvPu7vgMO+QTlAN
	 MPyd+MjU/TnhwNHp0APcwXwe620cz84gvalUTwfs=
Date: Tue, 24 Nov 2026 22:33:55 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Qingshuang Fu <fuqingshuang@kylinos.cn>
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Shuah
 Khan <shuah@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>,
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/proc: skip fd-003-kthread if run as non-root
Message-Id: <20261124223355.15a364523377daf5cf2734cb@linux-foundation.org>
In-Reply-To: <20261120062933.3169112-1-fuqingshuang@kylinos.cn>
References: <20261120062933.3169112-1-fuqingshuang@kylinos.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Nov 2026 14:29:33 +0800 Qingshuang Fu <fuqingshuang@kylinos.cn> wrote:

> /proc/$KERNEL_THREAD/fd can only be opened with ptrace access, so
> openat() on the "fd" directory of a kernel thread returns EACCES
> when the test is run as non-root.  kernel_thread_fd() conflates this
> with "process is userspace process", the scan over /proc runs to
> completion without finding a usable descriptor and the test exits
> with 1 (KSFT_FAIL) instead of 4 (KSFT_SKIP):
> 
>   $ ./fd-003-kthread; echo $?
>   1
> 
> Distinguish the two cases and skip the test like the rest of
> selftests/proc does when privileges are missing, so that unprivileged
> runs report "skip" instead of a false failure.
> 

Fair enough.

> --- a/tools/testing/selftests/proc/fd-003-kthread.c
> +++ b/tools/testing/selftests/proc/fd-003-kthread.c
> @@ -36,6 +36,7 @@
>   *
>   * Return /proc/$PID/fd descriptor if process is kernel thread.
>   * Return -1 if a process is userspace process.
> + * Return -EACCES if run as non-root.
>   */
>  static int kernel_thread_fd(unsigned int pid)
>  {
> @@ -88,6 +89,8 @@ static int kernel_thread_fd(unsigned int pid)
>  	fd = -1;
>  	if (flags & PF_KHTREAD) {
>  		fd = openat(dir_fd, "fd", O_RDONLY|O_DIRECTORY);
> +		if (fd == -1 && errno == EACCES)
> +			fd = -EACCES;
>  	}
>  	close(dir_fd);
>  	return fd;
> @@ -168,6 +171,8 @@ int main(void)
>  		pid++;
>  	}
>  	/* EACCES if run as non-root. */
> +	if (fd == -EACCES)
> +		return 4;
>  	if (pid >= 1024)
>  		return 1;

Why "4"?

(and why didn't they call it EACCESS.  Also s/creat/create/)

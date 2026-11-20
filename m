Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795145048;
	b=5TxilCx+Qd1PTpLzY7UiOunvqQ3jZTQ0ZrRTonaR6x5BkCMgrH4VMJklWWUMiDuXOyjj
	 zoUAXftGAkMSQ1Tkt/Z9a/aWqn/vH7uXPd8xuwEf0XKOx3MUxBlKV3Oq0DSzkj4KVzh1U
	 99CZexcwbSKKj0tqC17+sQjPorDtZ/Am48dVA+ejCuJoqSxkBbNCiuwZGTFH0s5f724Xj
	 +WPOYAW/hf9yi7HBdHcqxslMPrlS4hbqDDEre1WTzhzKp3PMnb7xc8l7dtRg+HxUTvLdE
	 MnBocA76bBXVyu3SAXxGR7tncWhCwM1zjVMd7LuC0HQEIGOll3BW8dmPMXbWsdvDtOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795145048;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3yX4FDoUFu7qkSNjWtKhvMEyfxtx14m6ybjPdJONghQ=;
	b=RjpGjJA7avMQ+/9mAHLOXlFSg3GKMRfhAjwyHSx34qpm14PfbQlOvXYVGVD3CmUeFI1y
	 ANEBlP9gp4RM1HX2pWEs7G2GsgSqOWFcGjakb/X6zhSDbtZsaZunBAQShOKsCwR9QCCmc
	 7EeStO2mp6449IoivaKZAQi3QmEbPB7F88/+QqbodK0A1mTYCuUwbdz8R1Ty69dL6aNMe
	 4dV8GKCemmJLhZ+gfi9UakdcxF3jQSGyKCDmiGXh84o5d6MeK4MTOXkpN311eVHVtthd8
	 77Zw8KHlcQZzwBPKDyzLUiUgDTNMixC0V6IgIcCBRXhzq+UKDk3dZbQq9hcN+3aUQqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=W3PrHeGe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB6B60A2617;
	Fri, 20 Nov 2026 03:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=W3PrHeGe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454F41F000C4;
	Fri, 20 Nov 2026 03:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1795145047;
	bh=3yX4FDoUFu7qkSNjWtKhvMEyfxtx14m6ybjPdJONghQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=W3PrHeGehRuiXr+cz0ko5CZbBrXgntivry/WM5clfbAMItcHQ34+SI5+Ffn20hTA3
	 s6XBcVbbd70dj2/nNs4W39r5wsroGej/E7ytXCyZX80kcyXRG1+Pw7+g3FcBV4z7Hr
	 scruvOIeXifAWOcruTEY3v5CnIQ1mqJPCuNQ+crA=
Date: Thu, 19 Nov 2026 19:24:06 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Qingshuang Fu <fuqingshuang@kylinos.cn>
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Shuah
 Khan <shuah@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <liam@infradead.org>, Karl Mehltretter
 <kmehltretter@gmail.com>, Bala-Vignesh-Reddy
 <reddybalavignesh9979@gmail.com>, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/proc: include linux/mman.h for
 MREMAP_DONTUNMAP
Message-Id: <20261119192406.beb3f4ccc1451f87450f858a@linux-foundation.org>
In-Reply-To: <20261120022710.1585112-1-fuqingshuang@kylinos.cn>
References: <20261120022710.1585112-1-fuqingshuang@kylinos.cn>
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

On Fri, 20 Nov 2026 10:27:10 +0800 Qingshuang Fu <fuqingshuang@kylinos.cn> wrote:

> glibc versions before 2.32 do not define MREMAP_DONTUNMAP in
> <sys/mman.h>, so proc-maps-race fails to build against them (e.g.
> glibc 2.31):
> 
>   $ make -C tools/testing/selftests TARGETS=proc
>   ...
>   proc-maps-race.c:691:58: error: 'MREMAP_DONTUNMAP' undeclared
>     (first use in this function)
> 
> Include <linux/mman.h> to get the flag from the kernel UAPI headers
> instead of depending on the libc version.  The proc Makefile already
> adds those headers to the include path via $(TOOLS_INCLUDES).

Boy, anyone who is running 6 year old glibc has bigger problems than
this.  2.31 is full of scary-looking CVEs.

> --- a/tools/testing/selftests/proc/proc-maps-race.c
> +++ b/tools/testing/selftests/proc/proc-maps-race.c
> @@ -33,6 +33,7 @@
>  #include <string.h>
>  #include <unistd.h>
>  #include <linux/fs.h>
> +#include <linux/mman.h>
>  #include <sys/ioctl.h>
>  #include <sys/mman.h>
>  #include <sys/stat.h>

but OK, patch looks harmless enough and lots of selftests/ are including
linux/mman.h.

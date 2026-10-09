Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E887836B92F
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Oct 2026 08:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791533011; cv=none; b=H1pMW/hwTYz6BNs98knho+DkC/sfsyWxR/FGwnWA6jmn34YsiHE6Z1MqBMSFKXWnm7hkkFmiHdZVLAlyFPG8NM0kKe+BbLkxA4LT/WbF9456emj4T9WcLRTV7QZY6Dbra+Jdc+O9G/2fuqmrw4/cBRFj+bwdjTl4LTSkPBdI7z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791533011; c=relaxed/simple;
	bh=eDDKw2EBETXPuyR/nSoITab+tGl+yUOFfplbHj75dRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArLKH8AzdraBZGNExOH0fmVsk9xse6Ch8tbN+RyqG1MwwOpbiDJ8JzNu309WoCZ7X6Vnn/YsfJKrKmE+MOP/7A1yl38FZ2pVR0yBgeXLwNiJ3pB4g1TaMX5QORtyhx+lJZH+EcT617ijEwtlNMCBm2ygoq82DMwRaMbReCoVkXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=MUsbyvT6; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="MUsbyvT6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1791533004; bh=v4iAb1JiMyNxyUVR552FoUOzhrXmdiN3D8aO/ZKIRmo=;
	h=From:Message-ID:From;
	b=MUsbyvT61oO29SmnR7MyjMrf4vdfcAY6oKfu5xkiEn1JQDRSRquOv60Dfi2Iwj7pN
	 l7VkUjW1+30F93rDmKaAGrA2jZbokeG7mQu34dC6Sb6PtcjfSsUGtdtb3l8Q9BaBxe
	 UDDv/UKiGzbr0RhxvtTz/BG/R24lbUFbEWD8j3YA=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id DD5A4C090D;
	Fri, 09 Oct 2026 10:03:24 +0200 (CEST)
Date: Fri, 9 Oct 2026 10:03:24 +0200
From: Willy Tarreau <w@1wt.eu>
To: Nikhil Agrawal <nikhil.agrawal@pazago.com>
Cc: security@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [SECURITY] fs/nls/nls_cp932: Guard 2-byte output against
 boundlen == 1 in uni2char() (ZERO-368)
Message-ID: <asifzGJXas2HOm7E@1wt.eu>
References: <CALMgpqZVwJBKVuJPXwhUYseE-MJRfozL73eXiGpqD7torhP9Wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMgpqZVwJBKVuJPXwhUYseE-MJRfozL73eXiGpqD7torhP9Wg@mail.gmail.com>

Hello,

Note, there's no need to Cc security@k.o when sending to public
lists.

On Fri, Oct 09, 2026 at 12:45:42PM +0530, Nikhil Agrawal wrote:
> Hello Linux Kernel Security Team and filesystem maintainers,
> 
> I am Nikhil, a YC founder, and along with our security research team at
> Mettle Labs, we have been conducting systematic defensive code audits
> across Linux filesystem components.
> 
> During our audit of native language support (NLS) character set drivers, we
> discovered an out-of-bounds write in `nls_cp932.c` reachable via crafted
> disk images or virtual machine shared folders.
> 
> Below are the root cause analysis, reachability notes, and a proposed patch.
> 
> ===================================================================
> 1. Vulnerability Summary
> ===================================================================
> In `fs/nls/nls_cp932.c`, `uni2char()` converts 16-bit Unicode characters
> into Shift-JIS (CP932) multi-byte sequences.
> 
> When processing characters in the Latin-1 supplement range (`ch == 0 &&
> 0xA0 <= cl`), the function writes a 2-byte sequence (`out[0]` and `out[1]`)
> from the lookup table `u2c_00hi[]`. However, the function-level prologue
> only checks `if (boundlen <= 0) return -ENAMETOOLONG;`.
> 
> If `boundlen == 1`, this check succeeds, and `uni2char()` writes both bytes
> into a 1-byte buffer, resulting in a 1-byte out-of-bounds write.
> Furthermore, `uni2char()` returns `2` (the number of bytes supposedly
> written). In callers like `fs/vboxsf/utils.c:465` (`vboxsf_nlscpy`), this
> causes `out_bound_len -= 2` to underflow an unsigned integer, escalating
> into an unbounded memory write.
> 
> Sibling charset drivers (`nls_cp936`, `nls_cp949`, `nls_cp950`,
> `nls_euc-jp`) all explicitly check `boundlen < 2` before executing 2-byte
> writes. `nls_cp932` omitted this check on the `u2c_00hi` branch.
> 
> ===================================================================
> 2. Affected Code & Root Cause
> ===================================================================
> Location: `fs/nls/nls_cp932.c` (around line 7866)
> 
> ```c
> static int uni2char(const wchar_t uni, unsigned char *out, int boundlen)
> {
>     unsigned char ch = (uni >> 8) & 0xff;
>     unsigned char cl = uni & 0xff;
>     ...
>     if (boundlen <= 0)
>         return -ENAMETOOLONG;
>     ...
>     if (ch == 0 && 0xA0 <= cl) {
>         /* DEFECT: boundlen == 1 allows 2-byte write */
>         out[0] = u2c_00hi[cl - 0xA0][0];
>         out[1] = u2c_00hi[cl - 0xA0][1];
>         return 2;
>     }
> ```
> 
> ===================================================================
> 3. Proposed Patch
> ===================================================================
> From: Nikhil Agrawal <nikhil@mettlelabs.ai>
> Subject: [PATCH] fs/nls/nls_cp932: Guard 2-byte output against boundlen ==
> 1 in uni2char()
> 
> In nls_cp932.c, uni2char() converts characters in the Latin-1 supplement
> range (ch == 0 && 0xA0 <= cl) by writing 2 bytes from u2c_00hi into the
> output buffer. The function only checks 'boundlen <= 0' at entry.
> 
> If boundlen is 1, uni2char() writes 2 bytes into a 1-byte space, causing
> a 1-byte out-of-bounds write and returning 2. In callers such as
> vboxsf_nlscpy(),
> this can cause unsigned bound length calculations to underflow.
> 
> Add an explicit check that boundlen >= 2 before writing the 2-byte sequence,
> matching the behavior of other Asian multibyte NLS modules (cp936, cp949,
> cp950).
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Reported-by: Mettle Labs Security Team <security@mettlelabs.ai>
> Signed-off-by: Nikhil Agrawal <nikhil@mettlelabs.ai>

Same comments as for your other patches.

> ---
>  fs/nls/nls_cp932.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/nls/nls_cp932.c b/fs/nls/nls_cp932.c
> index 2e6236b..b1c2d3e 100644
> --- a/fs/nls/nls_cp932.c
> +++ b/fs/nls/nls_cp932.c
> @@ -7864,6 +7864,8 @@ static int uni2char(const wchar_t uni, unsigned char
> *out, int boundlen)
>   return 1;
>   }
>   if (ch == 0 && 0xA0 <= cl) {
> + if (boundlen < 2)
> + return -ENAMETOOLONG;
>   out[0] = u2c_00hi[cl - 0xA0][0];
>   out[1] = u2c_00hi[cl - 0xA0][1];
>   return 2;
> -- 

Same space mangling that needs fixing.

> 
> ===================================================================
> 4. Coordination
> ===================================================================
> We adhere strictly to the Linux kernel 7-day coordinated disclosure policy.
> Please let us know if any further testing is required.

Since you sent to a public list there's no disclosure involved.

> Best regards,
> Nikhil Agrawal
> Mettle Labs
> mettlelabs.ai

Willy

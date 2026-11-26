Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795713687;
	b=15WQpzYsWn+CCGsRKoBSBpejcL1QC53zDj++BH5fhy6NdDHVJ9uYJPQIODpwFPWaIXAe
	 F67zP8xCvnZm4W7MeWaLVdllm2XE+GRV/LBsT+HIJ6p8TqOA2Zo65CNH5GPRHxuoc7HSJ
	 xxUz2krkRfBU76ir8+17MYpAok3gKQfhEBPUmgep8r+M1L6gu2lPFszVhogucS1qspOSY
	 w2MobU8Hjb7Trna3xzpKC9M9w3TDv6Z3DncM/Metlu2Mpt7Cw3mXLK+UVN7Q68xm1az/e
	 4TQITxyVl4tb2hFUqefHLxrucUG43rdtFQJ9jpOtjNNm42nSsyny/Td9YMTKV9PYeTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795713687;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=hFMU0WQIu/Khu5nkOekEsJ9G7/wupBV+7k9T9skPX/c=;
	b=1qWQA5vBnAa0VUHHyPPWa6V191ovYtTSOnkA82YAwplGPPyyfkvHXhqz+ajCWoNQepcf
	 5Ip52HJhXuNABREQxksTiXHubv4th5/IZPX13dL6LlBQFB4o2tfAiovm/WWIONYouYJO0
	 ETM2JOfCflA+lzXDRbscMEKPPZvMbRT5CcU5YWlcW2a+5mONxmkY1CflqrIXfWg+HLYNG
	 BEZJsu8wvuotOi/UMViKFi8SdXFpNPsvMqd0huQ4D0m+WkCx2cYN/DrhC/IpbzxNlOZeZ
	 SVZGPga0O6m0+PyT6G1GGPVpDHoMknLGIEjCrsF7KYPeLUhLtdvLSlubGvYHltAINQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eAUyELCh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90041606A323
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 17:21:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90041606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eAUyELCh
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c51d158acc6so39478066b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 09:21:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795713686; cv=none;
        d=google.com; s=arc-20260327;
        b=aLkm8nQRWieMXZavhaGnZIMYl8xCWRuxzB9zW9+MduX6m7KL0iiDdMp3QKu/+ShbVm
         V0zQL/1yITQa7QwPMYRjiMLvuvITwl4V5tLq7h8BauKtND0WKHTSkLGrzqG1i45fXPMS
         DSlGbvxUGkMj6pORqf2aFHDEyl0stl6RKAleTrRUjO5PEIUWZIYoo6yDjRYO1/brv11t
         ifhaS2B4XxcWZB43Om7Oy7BlJMbw3PRteGXeMpx7MDx9dLe/FSPf6OoV2W0jDYz24+G7
         QL9WOX46ujNqLL25x0iatz0yGqrsAnzjasWFf0dPNqdVtrlTS/IYuEFiJuzBT8VSR42U
         LYBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hFMU0WQIu/Khu5nkOekEsJ9G7/wupBV+7k9T9skPX/c=;
        fh=+sbt7Nq5OAurrUsRyVY6FLO6L+V89TC4NMZ1lFj+2qw=;
        b=oNzQlPC+NLYBWz7m+oNveDRXBmqpYUUkZfXbwfcFZlbFFfdzX2Yk4QrR48B1BqWfE3
         aC/XK+xB9z96pALYvvJ3Xpo8JXlygVd1Z2xpc0bcIRdWQl7lmteE3bRt41B/79APZSm4
         YZwIOYm6/UUZigG+W6Hf0y4FxX0ZRcjH06VPl79ClWGUcpGRBd1f+LUl0xj2wQxCPB52
         nkFAtXg7gCQUCM9A84RgIsiBOCT+2UhQP/v4N0p8JbJpeH2UT5Cw2bvNdZJaudOiUU1z
         bb3BEDbyL/KmmjA8o7y+rFPmqIQX2VLsHPxu7xDQdsJaS0OiBiZQ7qMlloUpF8/XaR5T
         gR9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795713686; x=1796318486; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hFMU0WQIu/Khu5nkOekEsJ9G7/wupBV+7k9T9skPX/c=;
        b=eAUyELChNxN03tFWhGSn40N0o3gjWO71tl5Ghcmskz8b4PGVkssqVMVbtcP1ufdgYD
         siuET0E8+b/8ouzgAVqs2MIlCaW9vlronDx+CN5r4hENRnHoThYegScR0BXwbEXaFWVv
         vbCqNQk7tkQOJoCj6JvZkgF6A2MrU7JYcLhNOXZ1Xe1EpXiHSTAa8An0988zX+AY8Pep
         2FxXxxd9Yyf1K1seELTv3Pu/d0l8SVkab2alnZfc1y6/i2PE4nJZz1OmTUDwKwoKvPhp
         1ls0QPxv3w/sWpsW686NeXrfa9MjQEe1y8xx6d3P6ciusGwK3AyEX4jEpfF4Bn9DZiMX
         a+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795713686; x=1796318486;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hFMU0WQIu/Khu5nkOekEsJ9G7/wupBV+7k9T9skPX/c=;
        b=uZ2GPpkZTN+7pIKo1pyFIAwoyXrd8Dvop45LTbOUYY+XiE0+IGdvQuUBpDoznyKnY+
         k3NEq4EFrVAn3+Bkf2rnq6Bm6DHBmwogUZMOr4IxMrlYM4TG/R+NI2rDFxgcO7loOrnt
         RXhmJZCWQIKtCnHGsbSGPQlukukMBm0X/mW6kDTj0/YqG5yd1Jtnc0HNO3Z/FiAJ4l2u
         J12V6fgFlx3iJwegVBVtcFU/8d6jASh0VErUx5kZ8+Rbb5yFeN0K+2R6HicWDyhfloZv
         2tPoEqfRVZK+k9STCVOc5PctSn3w27dwyQS+HtH1qt3carhAnv6cj3poW0k/DXbfwCFT
         tevA==
X-Forwarded-Encrypted: i=1; AL+hErGO8U16HypWeKjyOxgVGzpqJlcKITAZLC7B19p8Jsmbzy+M42LyXJnCSnAFkNjUReHMO7EvFp34RLs2TPtg@vger.kernel.org
X-Gm-Message-State: APuU4Z8QTDuSFoPEuFqqU2ezacpjIyeeXRAJeV/dVJ9zMKcDK2k0OqLV
	96rZBKm++j7eMlIeQm7iPIsVgEHGCEq6vEvWyEWjpz2oYpRmlcy15o9Hmp/OwKfwxFYxYOglswh
	KYrwuIf25gRmL02bL//ugRG/o2J4fI05bpWuFBE1V
X-Gm-Gg: AZFdTZfCa+rwBvXg5mXL1Rjj+XHvcQsdH21a/4XWaJzDRAGfym/+NQJ64tYq6oH6V+f
	FYMOpivywtLGxhSSRYLPGSKtDZks2VfaZPHwKk8dBaHfGki8EsY9+1hUsmXZ3yxkBy1ctxmRMo4
	ACh6cwzLs4oTOf2kpo4kufYU4i9oQ/7sYqraUrVPgKxhFtsb5JglJQnx29A6Hh4CfCQdhvrFvEb
	4dXuOViJXhIR2piuJM/Qflix0I9UWy0Mjb5qAA6KwhMDFZAFqd5ddLsFHT+GfzkQKDMZtAuTfOR
	2hpik8HP5OCHuE4OGhIsQ2CmkSNKHnaPWDUQ3DRYImL6CmfJAgUkHrj1PDf0M4gpPfkjyl/Xiow
	Zi3g3G+JAgYQA7Pc96WUimDvRJqbSWsA8gBBBvZ9aawgM/rNtIAqneVFOtE/r86V66a43FA==
X-Received: by 2002:a17:907:9612:b0:c2e:2baa:a642 with SMTP id
 a640c23a62f3a-c513a8845femr1932673766b.30.1795713685324; Thu, 26 Nov 2026
 09:21:25 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113221248.3535369-11-wusamuel@google.com>
 <20261113221248.3535369-14-wusamuel@google.com> <a40ad738-cb7b-469e-b67b-353b64622dbd@suse.com>
In-Reply-To: <a40ad738-cb7b-469e-b67b-353b64622dbd@suse.com>
From: Samuel Wu <wusamuel@google.com>
Date: Thu, 26 Nov 2026 09:21:13 -0800
X-Gm-Features: Aa3M54rqUPDLnBBM9ls6-9-k9q7s0wsA5-hr6KgHVGGraAEFEEYG4syBhxuXwjw
Message-ID: <CAG2Kctq7Mb=pb-SFU88eRA1cp2Qt_HJ0nADY5fET7Es-_CcCOQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/9] kallsyms: Add KALLSYMS_QUERY_BY_NAME
 ioctl to /proc/kallsyms
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, 
	David Laight <david.laight.linux@gmail.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-modules@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 2:45=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> On 11/13/26 11:12 PM, Samuel Wu wrote:
> > To find a few kernel symbols, users such as libbpf parse all of
> > /proc/kallsyms, which is several MB and text based.
> >
> > Add the KALLSYMS_QUERY_BY_NAME ioctl. It finds a symbol by exact name o=
r
> > by prefix in the entries of /proc/kallsyms, with vmlinux matches first,
> > and optionally in a single module with module_filter, or all modules by
> > default. Each call returns one match and its position; pos + 1 continue=
s
> > the search, until -ENOENT. The output returns the address, the size, an=
d
> > optional name and module buffers. A buffer that is too small gives
> > -ENAMETOOLONG and the required size.
>
> The kallsyms data in the kernel can change between two
> KALLSYMS_QUERY_BY_NAME calls, for instance, when a new module is loaded.
> Should the mechanism provide a way to detect such changes, likely by
> tracking and exposing some kind of generation number, or is it
> unnecessary?
>
> --
> Thanks,
> Petr

I'd like to keep scope of this series simpler, and I feel it's
unnecessary for now because:
- today's multiple read() of /proc/kallsyms have the same race
- vmlinux symbols are immutable (I imagine most queries come here)
- ioctl is size versioned, so a generation number can be added in
future as needed

I've documented the non-atomic behavior in the UAPI comments, so users
should know what to expect.

Thanks!
Sam

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794752676;
	b=G5dUVlHMf1N+j/HCqxjccfudBe8Z+yfaGtNMrNY78Q5xdq69GQBsK7ZwUueNvuh2XE18
	 kE9k54H/Jt/UTpIhGNNlfd0zEJfPchI0iQINYIhwH9zGDoPV+i2mPT2kmIUmOT51nUleK
	 xyNHuMotjUmoIt2PU//8zF1jwkhEpv3xd+Z4pARTNXfapwQVdTfvvFrauectbQC8pYX7L
	 4mgrKb64iWzoS6NTJORzM6XBlCAYED3ublES7UANyWXvP1B+vjgGxz0I8GAC/S3GaUMVh
	 LJYe+rONyFONW0I0ptjYtZHpcfKRTHN1B1RgPaLmrK5KmhHtyHCvinwoIHbWbJolbIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794752676;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7QzzvIBZ5m85jb8a3T2vbOcaHxM8nqWRH2JKBq6oOx8=;
	b=nSyJeKeuNZZLl0jWgLdYGHYP/7gcRYHRJBEN85Q0U3mb1gYS/PmL+18qLqcSLCjfVYJC
	 2ea2E2fhegwNJhc5zHBbhXljciFb8yyQQUoN99ZWZTD234+fh1D2KHB47Xo5Mr+OEGKkp
	 4NpiXnKssaJ8pk/3U17arab/q1X4oVzIP/46t944FKa/wybvt42KDIAxdFREik+pbvOqX
	 W289cwhvJSPLrK3M/ZNHEMWDibm2h9jtVxUYq3O+JYfUd3C9C/Hc1VL/HKAXh6tyTdSXz
	 o7b7rw7vhR9O+6FiaKNNndubbnz/LpE7/SY1bul8fUBADRsoeWRBoouoOPSVMGhqXWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jxVes4fN;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B873606A8A7
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 14:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B873606A8A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jxVes4fN
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so11746495e9.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 06:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794752674; x=1795357474; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7QzzvIBZ5m85jb8a3T2vbOcaHxM8nqWRH2JKBq6oOx8=;
        b=jxVes4fNS9TSgGvlHsTT80+9II9XinvC4prossPItwxQmdIh/ly0jdC/cdyT55vVR6
         dxr87FlrY8HaEzKWL1k6AkuqQTejZzqNuP03IkWn/1QKMcHCGusJm7Uzh90VmKNatLHN
         /Ur+ln5v7C1S9XPfNu7fKUrI1pDdBwtHp9o72Tv8ddrZYc02/UP04z5Cj9qKvnMUiuBc
         AKlR1i85YUHuEqLhR+nPnOGxB8gyhi3BmtQiXq42P2XoLdScRFWDqb++9b0P9t/EHP1y
         PjbWv5kEkbF943EnXhorY4a6wJ2J69Bqn/WcjcubzUA5IRKt9NLekdoBKWqKwl/hWu6c
         NQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794752674; x=1795357474;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7QzzvIBZ5m85jb8a3T2vbOcaHxM8nqWRH2JKBq6oOx8=;
        b=x+dS71dy3ZKe1bKKcRm5Ianf23kdrvQYEby3psQZnOfpqWe9JPoySCvw7OWKirXU7T
         JPSGJuGdge7RD6yL+f3wtB3d729sktBffjIk68av5jFX4Dc01ywh86HosztyAFN1+/4j
         Wkrz7E1Ve4TrGPGE7esU6W/myzHYmJiUZnQlncaNpoPzYcwLqn+UxA7iCW1Yhkrn+kmf
         vRyk1YL2B76935aVyj8U9BYVwoIE+S0KkQmb9awMVLgkST28DgfN42CqiwrEZh3nZUoD
         jK+lDI9ihzOvXoCsmjQz2u1QmXhM8n1sDiASuj793ICKPldtumbOTVctwswM7Z9I9xxz
         6Puw==
X-Forwarded-Encrypted: i=1; AL+hErFc/D3Rvdpf8lAE2vk2x83WlIH/9qgEXFDEYS0ZVAXZmKyzuuT8I6fqOIO3ervVX58rNLa2QakSAeBk6LxL@vger.kernel.org
X-Gm-Message-State: APuU4Z+GDFdxnGkmNXnlY5GD4j37ZjN8kxqAquPPtOnUDHgQrMWS1RtW
	rQ/RhIZaeo0Z0jUiWFggPl3fmDnosgtKljTKbkOMAtmh6wd0HBu3NjoS
X-Gm-Gg: AYBFou14NjgnYBP4v5KOSw6PHBtRQDn7+999PWhx6lTg9O5JQff0RsT1xnBBQn6GAHr
	KIcTp51mcxP94cPAD4r9nhWkPFJ05do2E8iOOR4VExiHMp0ep7Ub9PHqcHwIJR7u3pcO33n7siE
	SiD7bNfRgwg3mWmoynT/WkziTIOfYzF0UdYJ+U2Dgxi1ZT97zloPyrTbYmJTTatPFZT+V8gPxmC
	LdtIQxMaiNv0x3drEc/cG2RL91RhbzS6PjvJIsghbcEX4T2Y9YjCq9vC8rMMpdSkj4ArA6gk9aF
	PQEj8cFKC0mCGTOZVN+l2ZtFpuZivx9LWSuykHLN2BO5HwG8dHXf59DXF7atx9eCPwBIoI4rvsk
	WKHnUGZ0Y+Gbq4iVaAgsdZGSKRdY9BINq7NNUFL7OTS8qVYtRMMlfeFsca08mIir5oBvIcnZ3Ql
	K0vMs6EZ8EcBF7m0n/DijnZIImrfQkFH99wHLm73n9jB4/dRKIv6+g7N38R7fLOJPJXIzWvmTCq
	HMOC+6Zg08kXBVNAM/TCK2JQu/Q8jOvdT/SNIgu525Vt1w9iYuqJhKTYn63WgQc0iZhB06PurTS
	erIo37lLZRc0fyxLcpFfa3XLioiQBZPazBKQ4KbcYeBaQLfsJDMMiWcfnfUo+1eSeXF8veDBnAF
	qD4DspYABLxc=
X-Received: by 2002:a05:600c:c0c5:b0:4a1:cef3:fb3a with SMTP id 5b1f17b1804b1-4bb55a6602amr130912825e9.9.1794752673813;
        Sun, 15 Nov 2026 06:24:33 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2adf53sm318854915e9.15.2026.11.15.06.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 06:24:33 -0800 (PST)
Date: Sun, 15 Nov 2026 14:24:31 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Samuel Wu <wusamuel@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Luis
 Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Daniel
 Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Aaron
 Tomlin <atomlin@atomlin.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-modules@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH bpf-next v3 0/9] kallsyms: Add KALLSYMS_QUERY_BY_NAME
 and KALLSYMS_QUERY_BY_ADDR ioctls
Message-ID: <20261115142431.1587690a@pumpkin>
In-Reply-To: <20261113221248.3535369-11-wusamuel@google.com>
References: <20261113221248.3535369-11-wusamuel@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Nov 2026 14:12:45 -0800
Samuel Wu <wusamuel@google.com> wrote:

> /proc/kallsyms is the primary interface for userspace to query the kernel
> symbol table. However, resolving even a handful of symbols or addresses
> requires reading and parsing the entire text file, which is often several
> megabytes and takes thousands of read() syscalls.

Separate from this, I've wondered about separating out the /proc/kallsyms
code from the code that actually handles the symbol table itself.
The two parts are pretty much separate.
IIRC it uses a static function to get the symbol type (which does most
of the work of getting the name - which it also wants) so it isn't
completely trivial.

I'm pretty sure all (well almost all) the changes will be lower down
the file than my changes and won't cause (hard) conflicts.

I've been compiling kernel/kallsyms.c and kernel_kallsyms_selftests.c
in userspace for testing both, but had to cut the bottom off kallsyms.c
to get it to compile with a sane number of definitions.

David

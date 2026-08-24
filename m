Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DB840DB4F
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 11:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787571398; cv=pass; b=gxmo/GoB5j8MxBU3mOdp1hxc/b0Xel+fu+YxKaAfV63TtGTRqRtIprAHilrmLP0pAKx3yABdBrmCUZIfe/zmVKMd7vnyZM1dPfqaes4lWTeeRQFgggx+WxIO4Vr0/TZQ82AWccsd5eyahsW/p+enKMm5LExwlQi1FC4FZUjEAys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787571398; c=relaxed/simple;
	bh=FLR8gNeFJ9TssEfTR8tSkoTtg4StSpJ+7GNVLjYl8Vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T01Wj1Fd+gSGubz3WlKxMMwx41I7+tI/fQAPzhpD6zIq7HTaU33lJHAp3jSvtH0rDeHonFAsbZsOZvv/t41BJrBwCmcw0EFfaIO231CqIY9ob291sZ5c5jHidbWMi0tcqOG6NhKF5wIZBG5iaxl4MDYQTV17cf4UDgL1gWF0U7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFt7WRk9; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFt7WRk9"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d30c22b1eeso2420775ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 04:36:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787571396; cv=none;
        d=google.com; s=arc-20260327;
        b=kmp4GSnpHytcDMqcriNG9JxAJkGzU6P8/Wpex+KT5aWiNml0MVB6HNuMQH0xIgf/BO
         ukCWZ3CknM8jqA0AZHo71MkdI/I767mrr6s28Gx1+449Gg4UgcaEH5LtNHnxHBxC8tp0
         DWe9VwPD8XXJYFaVhbDnlo702YpuGCngPh+rBjasfYWsc3GKxZBz7ENDX99+N+B+1PH1
         D39bpGSdxRpR0breEYeFuEgAH/gPQOOB7grhtmrB5K7OoIWILvsHsq1kML6itBmsTFQj
         78klWG89GNX0E/nm1zwpDfXVPL/imHQDFdXFnp3F3XYNSgcG17+XTz3g5MoEC2neYMeD
         /P+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FLR8gNeFJ9TssEfTR8tSkoTtg4StSpJ+7GNVLjYl8Vg=;
        fh=WEaJAGNbGNb7IXCTcfLpTrSZrPQjlSaBd1IwDOInDCw=;
        b=am2HIMIY1FTd1m+s++pia38RiVpWIrZeh7JfKMyC9IMz4+rsBxsRgBBEEm4CKysx8l
         L7+1VtSkaFsNIjgi1UafR8Erad7d/qSmgmyHwvQh0J2OPWhbbZcRnByy3MOkxBFTo5Hm
         zzGkVTM4wcPIhmX+I/bdmBwN+9rY46pazAPlKN5zbVILeFgziTuO0NZRImMT66hbKeY1
         j9M1xkJbUUgAfEhH1BrNiqr73QHjd0wvQQxutbg+JnYxqbpNQLGDNKfYK0qI3aOdlR0N
         omIZJXQEoSgY4u8JiFs3fJg6Gz9YjwCD9jBJbIZR7rKhqXAyBRDoR/NgpygfpNU/uDBx
         gCZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787571396; x=1788176196; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FLR8gNeFJ9TssEfTR8tSkoTtg4StSpJ+7GNVLjYl8Vg=;
        b=YFt7WRk9Nw5n+i/byMsiEaa4pUCFMwIOshTiaBYfmARkFAcX/qqf8idooFji7JpJ4V
         8I34V5VPE/KG8FVWrMOwRcHp0UY7rjPa7LnUR+B2rG5woJ3E9vuC/Eh2yg/2usdoBvp/
         sgDBOYdtWrBqrUWgwPwBFa0oDvKfFJLzefi2in5uq4x8w4fS8H4cBSKU8F9Y2M+WR8RF
         QkcAvfYl7OjkWvMO/Tb3tcOzaneE014I+i3hMlZOBVF9dLsLPSrerORIU6H1VrLq3Jh1
         krdI/j7GbiJT+hC7CSjdD2Uv42ryCAzdRaCZFoOZqJ9FlvCJBlxcPbPAHtRNv4k09cv3
         hG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787571396; x=1788176196;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FLR8gNeFJ9TssEfTR8tSkoTtg4StSpJ+7GNVLjYl8Vg=;
        b=ErfK9bEiBNZ3pE8bHXk2Q26awY/mI8DcAEQbdDcvatJhSpIpppX2UrfIrmACiJPov/
         mfFG6vBIyfxWkm1c3DOlkSJ6MUrQCNS+WR+MFmct11GRGu0SvtKTV6G7FkLeC5YoVKYR
         RLzEA+vKvuhodQC9oT60BJePdUfcjKLEpSPKDsw2JgU7h09aOF/ms8sDOjVWiR5j01fV
         kx3yXbqDXuxXUkjTV3Q+9kGOeFuj+R2M0ixr6KB89YgPRrjzGRcnCQ+HyfSyyZ3mnROM
         WtzALm4X5+mnBVYNRL0yNiC0442vebyYv3CO2oA1QcrQfLBN6OsPmB7dG7LatZwmQg33
         2nZw==
X-Forwarded-Encrypted: i=1; AHgh+RqA3kWnrB5bF3mI0DzZIAXTk6SX31z0ulxgNgvMNmZA2eNFTZyX+x6owLIuioViGvCdbggkwHM4/QUDbsLJ@vger.kernel.org
X-Gm-Message-State: AFuF++lGxEWhGa2djBDg8ZussOGCN7i13gBagv/ALvLjFXTXJUmvpz5R
	NpouxrJHf93lEi2ufcvnyuggjPfjayNyFhLaHHdJyPT0UUSiWzkX0C/D0ErCk6jpH2Ill4uMiwB
	+bfPjQ0TQWBUXNjk/1V70ZRHj3L1ONuA=
X-Gm-Gg: AR+sD13DWhfIqpU/eqOAcg7R9hu7qe8VNaJ8tFCrniqpcHgoFxoDGXHpI/4jcrVmlD5
	S34lOwbSsi/UQ9PDTgmOGvBxxOiJzIipgmp6weRv5PpQoFYn1Icpj/wyJW2GPdq2qoMRdS+1WEx
	q4LuN1f36nPUKhNmFWuyIL04Dl1uZn+lGsAJtSt0tQ8PpuFkwLRHdzGqdXa7nqQKtu21hhRq06l
	JAHu2g+P0oObm5Soh3NLzbNvq2FQQvteHXBeJQDlm/KXkik7271mSrUb34wzBl9ZTuXIlkMWwlI
	bY47rWVOawDGQjMLGcAdDyKqLeoe5Hpjig0cuS7nortPaDrhGD72BYDwN2rv2cZaKPTjj3Nmm2/
	PGGn7oo88w6oCHmt4yVHFL2eSNeYZLQSmMQsw5l32kOwoz8gJG/w7S8iPYMdqm4BmpYoFHXY=
X-Received: by 2002:a17:902:fc4d:b0:2c9:e846:a582 with SMTP id
 d9443c01a7336-2d64a9a668bmr222250785ad.0.1787571396025; Mon, 24 Aug 2026
 04:36:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824-unique-ref-v20-0-490735672187@kernel.org> <20260824-unique-ref-v20-6-490735672187@kernel.org>
In-Reply-To: <20260824-unique-ref-v20-6-490735672187@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 24 Aug 2026 13:36:22 +0200
X-Gm-Features: AcwNN1XvVB-Mna-bMRr_-WAakhrdmhTEWRag6uYdZi5jKauuC-nwA9j0nxkTDxw
Message-ID: <CANiq72mPLrKQMzb37ow2969m5r3Z2Kh_4LHERUun6ALw3ea6tg@mail.gmail.com>
Subject: Re: [PATCH v20 6/8] rust: Add missing SAFETY documentation for `ARef` example
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Lyude Paul <lyude@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Ira Weiny <iweiny@kernel.org>, Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
	Oliver Mangold <oliver.mangold@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 1:19=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> From: Oliver Mangold <oliver.mangold@pm.me>
>
> SAFETY comment in rustdoc example was just 'TODO'. Fixed.
>
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Please see/link https://github.com/Rust-for-Linux/linux/issues/351.

Thanks!

Cheers,
Miguel

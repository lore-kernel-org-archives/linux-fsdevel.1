Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02D53CD8B5
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 09:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781690093; cv=pass; b=PFAI1K03BgG8JqBhTq1kibF16jx7bhRiuCcBl7ldVfbokoftUER4jHdhlzBUdn5k8KtdmngIo0h9aRiqUDXCGYDFxbIcuUBKVqAcgPj3kTXuSXJ4Zkk4U1uBTgG10FkAyChW4XXRMAE+4vL3RP4VLuyROVgHkTsyiaPAJr2ei8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781690093; c=relaxed/simple;
	bh=WKF34iFNpf0eQktLcuPksLJYduBCknZ/BznJRp3knLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODzeDld0WEffQn9Kwmbsxs+5A+PpkVm7Vj1XthMZ7E7kHVIt5vs45WgijFw0wY2z1VU//xomS6TWa9yc5OT00jOfxnZhz9DFDgQfzS4ccpOU3Kz6HLvI38/P+V298LjaW1r/JvvSi+KM4A7vQbawz99ohXTiWpXvMbYUrFZmcrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P5uxNMeG; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P5uxNMeG"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-460166910e6so2987440f8f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 02:54:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781690090; cv=none;
        d=google.com; s=arc-20240605;
        b=CcQsjFE+wrKUM9hDe0T4s3UE47dXAXtTM1uTpLOWdZwXpQqqC+rPHuAHruB7W1sbFB
         csV3xtyhDr4Jcj+8Z3Y6af7SjZxiiLxE6mQOA32gaqrZLvOr9qdFGX3/dAufNOrpVkpd
         zDVnLfW+KM2UHKFc0yLzYj1WcD4q0HVip7VepXjjJhpa9tTrmfo+MsAVZntzuUCwZ+kY
         xUbuRubHUvB9V0NXk85wyj0UcqfOoJyoVdNGgYxKOqAz9DLsCV8qaEljn1roCbLTuzbb
         AuloNuFI1ASxBPu/Tv4gG0xcAt1FaH7SSq/jQ0FWNdhwBFgyYq3lK2XQvBEVl0D5csP+
         HMHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WKF34iFNpf0eQktLcuPksLJYduBCknZ/BznJRp3knLU=;
        fh=5B2jnrgcJ4h3h0qbalYUdngXnYjx7zUE81+2sje2bAE=;
        b=eVNvhBzN/a5z+gJ472KKGRIa3C1UEa0kZRHRa7E6RWduUrshBlaqu3WVMu4l0VQwGw
         LhomWzfj77DTRqz/+FLWqBRRbBlg/zx1k5GE1/IvZtjPHwSUN/3s24va6kP+ugL0gFwX
         x3lfIM8WKpaha27GCsa0qL4KMTCmC6MXzc0l4Juhjz2Gw709BNJ7gF/cxRJ44buqAqAR
         pfhnYlhN3aMa9nU75JSiUYJ0WBMqUTMP1if/uA0nxZgwyMzeZ3JziLwXW5EjDMiUoWpF
         lNHKgdFLZ+7QkQ/VEFTKfAOiZM1HJzX9UB64f0V1fHOAKeTNLOuCbvCik5viDb888Y4a
         Xfog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781690090; x=1782294890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKF34iFNpf0eQktLcuPksLJYduBCknZ/BznJRp3knLU=;
        b=P5uxNMeGcDIN8llkO0LerOZseMvI0xoedivCJ9FZTvVkZQDpB2XH0vEThBBsXiWG9u
         sffI4uZumgWiX1nzBNMDek3/+k765xSl2pY7u/w/2RicT1DEfhmO3fV0tSyaaYwcGcUW
         sDIXq7Nca7LlV1xIEunZuyJ9m1LZ+oEW7N8dbZE1czoJgFmOXyNTjsG/v55Westq675s
         acUzZoCXnMYEzFXbS8+neVOK/fnhKQe+EzbGYwDbJeOrcvNmrqkC4agNzuQkCHFs6iTV
         ZeHsur1G/4T4lhO749KNW2vcfZXCrVawQX8QPjkJVWTDVb+5i/q9LvGGwrB4P6paWDbi
         4AHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781690090; x=1782294890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WKF34iFNpf0eQktLcuPksLJYduBCknZ/BznJRp3knLU=;
        b=Tq7JQGChIb3SrPNNbo6vUpHO+MMqPaQc6SXGWSZiOjAwgc3THwK5MTNjPgQU+crPs0
         lei4A57K3eFT1n4iKZW7Jf7hK5ty8Z+uuKW+Yl14D/PfjmqUoWAWJ/dCDPdry2MznMO6
         bFYrm/aPqRL2TXcFlXuchsNonbIYQpd+CA3Iru+PCH/06BNiHgeHqzy1/H5QtCPrYLVS
         q/EL3JhL9s8nHuxRxhkrMjYXjwat/FGJtAGNHhmlsSwwh3RJdGAKuSw2Qr3GjvMcd3pW
         AmQIJXpsiP1mzEtHjSN/fVWdgJttyA0ULgWb8AuaPmYmThyKqm+0m8mhCgplwcYBSEpb
         Yq3w==
X-Forwarded-Encrypted: i=1; AFNElJ8H73AlZYuI1xV02clT2FRUmytXyRGKVMYTNjrpKff6N/oWd3rGsPbDY7Pm+B9rPoZw6P3QbQ1rhDkZ0eyy@vger.kernel.org
X-Gm-Message-State: AOJu0YxrJ3c9HLXcxCvC4BPOOUq+EOuOGz46k5s02Z4fH7X0aoxQZ++8
	fCX7OE9BtWFzJ6Vg2Bgy5q9YonIiQk5cvi1q2NxxXKqPzEkuzEMhSOBof90YLeBO5Rj0lE91y3C
	7wdp8INU+aWOytxcv8NvL7iJhjtVJdRbO7isiXd0X
X-Gm-Gg: AfdE7cnNYq3C9UYjzUVEO6FDG0DRFx93PMBLW/a3a0IVDR+da/d1PuYh8CrheJuBXeH
	whPujnXMo7Ax7DhhKGJM3kI2JewA/HoSkeIUUbHOQvQ69WzLLu16oTc6dZPg9Ow0jE+MmS30Q9M
	vm10x3AA2VR4qLqbbel3w2hN3d/cLG5o3f4+/Qd/l5yXZ7qnKn5l/i7yQtH0knR6EdEV/bknBk0
	+cqAF6v/eNczjQEKfTwrnc2dhlvFBPKizj4gNPRdeTjjQGIaS3n7+en57l4Q1CLHDefFkETNelv
	q/rpfPXZbsx98BAZDR8YFWiPu+qhqILXb38LU+SklTYl87TWqEUe/aQl+NY=
X-Received: by 2002:a5d:4a91:0:b0:460:f36:79b0 with SMTP id
 ffacd0b85a97d-462376a4df0mr4361735f8f.19.1781690089839; Wed, 17 Jun 2026
 02:54:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org> <20260604-unique-ref-v17-5-7b4c3d2930b9@kernel.org>
In-Reply-To: <20260604-unique-ref-v17-5-7b4c3d2930b9@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 17 Jun 2026 11:54:37 +0200
X-Gm-Features: AVVi8CfPlpZsDlv9ciJ6wpjG8CPXMs720UTUcxwfh8qgpqFIXUpU1m_9T99wYrA
Message-ID: <CAH5fLgggdf0CM0o4Oa1VbY+y8gQxrU0VU5z_yB4GWCxnbqsFuQ@mail.gmail.com>
Subject: Re: [PATCH v17 05/10] rust: page: convert to `Ownable`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Viresh Kumar <vireshk@kernel.org>, 
	Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Igor Korotin <igor.korotin@linux.dev>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	driver-core@lists.linux.dev, Asahi Lina <lina+kernel@asahilina.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 10:14=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> From: Asahi Lina <lina@asahilina.net>
>
> This allows Page references to be returned as borrowed references,
> without necessarily owning the struct page.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> [ Andreas: Fix formatting and add a safety comment. ]
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

This will not compile unless Rust Binder is also updated.

Alice

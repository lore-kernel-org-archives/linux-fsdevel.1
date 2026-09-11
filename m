Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4558477984
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 13:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789134214; cv=pass; b=XvUxD2Xkt6vLHF2ee1aj9e+1E9jyCydUl9vjZ15XUR9u6ZA/77TLndky/qpoEgVCJcO1/3O9pO6wWDobnC1pEUt5TBGf9m57EEz8FAdfe9hGT+2EJD2xF/uCXyWEr20ECMhtTmhnZfvslkR2fyeKcq7Kgonx6h7Ekhdb/vchGwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789134214; c=relaxed/simple;
	bh=qqONGiVmU3Y+JSEn4qygivSbxUuzyWx0IT02Btj63eI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZW3DOCSdjDVJz8MuigrtSPJaB5NWbV14nk2vjsXLwMzYRP8kc2AYHkR0HhzTBiCmfIW4eL8nytE2sYb5R4p1y7D7lCrlig2lWSsdkMNMlmKAKrWe16gXlIaqpO3e2bbb9rIUKCzaMRDmJ7gF2JKjH01JtPxiFgGxI12bmFe6f8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ehf9dS9K; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ehf9dS9K"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49b965570d7so11607455e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 06:43:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789134210; cv=none;
        d=google.com; s=arc-20260327;
        b=hbBCB1KIKGYOcP2VpOkhkthpSfZ/Cj2NEm8JqLvhiC1u+gXA6ERfM0UA0orQteRFU9
         CfDJ1eMyToPDRe2lCy1fy9f4KTKpw3MaoESCmSd9wUrfquJEln/b3LhwENly/E5p43wg
         L9HTmgaaDn690JN+OGMtVvWqpYYI1MZzJXkLbi8Xd5GXRXzVUbpW9LtL19Wbb/3aqGF+
         OcfIEUHngXt1uwEkC6IibuO3GxaDYVuaVlFQC/fG5iwSiOgo8zp0AdnmuiVuFD0TiqIS
         50JEyh5tg3VRba5+z+Ny3KnSTmKU4BP3Ug0uKNavxt50xUctLhlmvGc0mklXxYfvtjCU
         Zr7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qqONGiVmU3Y+JSEn4qygivSbxUuzyWx0IT02Btj63eI=;
        fh=cyTzQiGPh3+/EcoAIgOU8/EaFWUixvLLqVUHPntuEuU=;
        b=JuCZrQadBm3Cgdrl6eUCmIlx36zwL0dag/lvjUpxNce0ayhot5VdiWWgI/9Lx/AjdQ
         kSz/CgjUwHpapdIdZgTYkxo2xGAjn+I1iyo+OhadIaz/eXPHrV3eEtCMsAddZRFvyYYr
         tbVciUY5G6Am7RVUOiYWI9izRYWLvNm8MwFuSKtN1HUHHW2lBmN1IFzsoKd/r/aH9FeL
         aNyt/cnZyoIwb/GzFK2TknuS49osS1WKiAhd0m69Lbk1RgXdq0+G+hgVUfXRrTI8BZHK
         ehpb0IYjM88ZS2xqnRdHudQEqnXPp02hL4xoDuMWfmVEi5gEso+Wb29HILh4LhIZBDeJ
         qNyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789134210; x=1789739010; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qqONGiVmU3Y+JSEn4qygivSbxUuzyWx0IT02Btj63eI=;
        b=ehf9dS9KBtz8dLPV1eOtxc8kmJv+fOyIVW2ZdO06596kBMMRx/tyUK2lDgVQgI5M/c
         SSpBMb7uUs4G1u34797nfCD7P+9zLvxXZxAHnuR56Buv7tbMHFhU+KXC31bwb8LxfuHW
         8rSFo0UCiOxET6/EGYFoQmdn13E7BSnpGDUmtBh5eTd4sQzXsa+4KMiX2L2pwFInQmBd
         XbtYZ8PflSCvO08pB5VAXZaYQ3wTj5HZ2Hp+yRGmtaYxRkpKM8QUHwvM09P+tJQDQK9v
         QG0xK00MrU/0875Gy+xMQiBhNe3qdsPJOLSKMbDDhT7ODGKOfLVFvcBzJ0WilrEwQq0E
         IdaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789134210; x=1789739010;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qqONGiVmU3Y+JSEn4qygivSbxUuzyWx0IT02Btj63eI=;
        b=aa2mOpFktkEgzSnwhpCDkBzyyCNRPkrIjTs4b2hdBhApbjdvCWjIWtHe69Te4s2Nij
         uEV803eMllh8sU8msg2np+SYEQ78WsMT+wPdRqeMGK30TBjsTAWPP1rs49ks0XjUxrJt
         IrU8ApdQqhQjhhq1cWC7KPsztanPwRnDZm9Vkj5RFLpKy+LRyj6hwp3x1pVi8Xgdu5Jw
         DD2G8QC6HD1gl3UwHUO8hHN4pjz78EyPmrWuosZzs6nZYSYIaYD/bTn5c/rQbmcWRSDi
         3F0aTDPRbAc7BOTVVrMIxFgnrFXZgIoxHD7Q25g18DEBu8CVMtL4OCAfAfSIwQeA0h8c
         Frnw==
X-Forwarded-Encrypted: i=1; AKwUvBxJ7KS1HL6/9zo65kcCkP38RmxyDuVceIkK7RBN9R76H43YvrwsOXUwhXB6J8ELjN6n+jgMpE2m2FZcbNMz@vger.kernel.org
X-Gm-Message-State: AFuF++lImyVEu+ma7fNsKPy77AvGFALJNRDsZit79SCtZL7G3N0MOazX
	1GH72KMsZvhpPbzlEmm9paqNl5caExu16hMDvIpj2E4hO3rN07M4qkVDH+O5JVw2ixNi/2JJQr1
	BNeo7+MHzMgm6EUswkVgMMk+H7ljCjW6WhRgQmuCw
X-Gm-Gg: AYBFou0XVM6QkGEJ3PXP5QMd00XzPweXAvJ3zOCkpGconjAzlyWwhX6C0U468uCumDt
	tyDJhFQLu3pAZAp5krCkNUH2B7Yh2l/gaq1DRlTcIyJ0u/wkLCWCMP84Tv/zjGupU1fop8C1KRN
	6AsFDuAcManFWhoO695DO3/7B9L276jZS56TP5sx1NK6rga1IVgvxd91OMjQ6YWg3xJJWEWdeOL
	6TjSi9nq6Z+ewFmjEBo2pqohEChefLYSfT6YgcUpKB7I8Nnm6QLSnOSTK7KPQ+iTWhD5WhxSrgb
	bHvRQCVDAaOUTiJZIVjtHfvjcRt8eBhhUZfLEOwz6dcNM5/VImlKmogYAxvOxXxImXBvap6DhxQ
	RX2AqybdEgfrXnXHjaZRrthqdM48BIcV+EHMYYSZ7C4nZxhQeKGD8
X-Received: by 2002:a05:600d:8445:10b0:49c:cf18:494e with SMTP id
 5b1f17b1804b1-49e6198a3b2mr36939915e9.12.1789134209249; Fri, 11 Sep 2026
 06:43:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org> <20260910-unique-ref-v21-7-e83257373062@kernel.org>
In-Reply-To: <20260910-unique-ref-v21-7-e83257373062@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 11 Sep 2026 15:43:16 +0200
X-Gm-Features: AcwNN1UlYe5vy_4Ph8n7W5xph6nzuuUOW4o-tvYKznIiNAx0UgbfO_rFNfVUhuY
Message-ID: <CAH5fLghC2qRh8qNmMHMWQXiWW9FAPdd-O4z-O-17FFDB3hy=+A@mail.gmail.com>
Subject: Re: [PATCH v21 7/9] rust: page: convert to `AlwaysRefCounted`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
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
	Ira Weiny <iweiny@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 11:01=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> `struct page` is managed by a native reference count, and kernel C
> code routinely takes its own references to pages, for example when a
> page is inserted into a VMA with `vm_insert_page()`.
>
> Thus, implement `RefCounted` for `Page`, backed by `get_page()` and
> `put_page()`, mark it `AlwaysRefCounted`, and return `ARef<Page>` from
> `Page::alloc_page()`. The page is freed when the last reference to it is
> dropped; for the order-0 pages allocated here, this is equivalent to
> `__free_pages()`.
>
> This also allows `Page` references to be returned as borrowed
> references without owning the `struct page`. Remove `BorrowedPage`
> and update users to use `&Page` and `ARef<Page>`.
>
> Assisted-by: LLM
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

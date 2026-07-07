Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BCF380FFB
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429469; cv=pass; b=JJO+DR743iDeR6RlWnt7F7XM+6N40zPn8vdtO16Dh2Bj7+D4p3Rccwj9PD5CnZkr/Ac46VVGlJ2BIYCnVzziWhW6z2iORuA7R4HeF8x6/X8AF1Yur9+9FEr/VUhUQkKbprRrpk0SK84W5jSYCGIfX/M7UElF+zhLJYI/r9M13mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429469; c=relaxed/simple;
	bh=TmPGIYAzJvC80RsuDMRwEJ1EsP9UZtxlgsFYi2qUwwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IBiSzo8zEIsgUNsqu24t4Wd7Grq3Zo5W5RLws6KYYfW+qWHidAp9c4LRlBsZ/EiXVozDHrlzcpXt02/qBTHRrhPv1Y/mkSa2j/cHnxLlx+ZMYeEZRNVWj8HVwKSf6KnPAstbiQ7QcS/BIcP9GI2/kIgoRpqanUBeG2362+x1GP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nts12kSM; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nts12kSM"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493c733f15aso40224295e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2026 06:04:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783429466; cv=none;
        d=google.com; s=arc-20260327;
        b=MZCUUpw1UMbpDT/+D8IVuUZKl9Z5g9yCrBX4CaIi7h5e6nE7y5DOw872NgpaRv2cvR
         T0X/L7rE/oUU67GFGgItua8bsN81JOmXubyu6P0Yde0kCWM0Lty1e8GaR/HRayyhUW1i
         oyZLmabw5MbyjrSKJJjaYNfMnGybsdRqZbRmDxFjJ+KD/0pXu6hChuayTbAVYKrLj49C
         oyV3MdTD2AEtRPGopW98YgtLZEDrcA68BDDJJl6mf8oJoPSVM0Afds3arUZ1PzK7NBbU
         Jjjna46vo5L1nE8oSYEiV5r9LkoeJNq/atrSWpukw24zsbbZb7zq420uf8bIW/d+ufSi
         ZdGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kMZTTwd8MYpbLMhgPf9wJy+JM0u3tngYW75375hm26s=;
        fh=XL3e8c4nWgrOi2YrhliqO2976YvrOgvrytax7J/K+DM=;
        b=O4olpUTomyMOatnwv8fnlZ5z0ATUl52ZwGz+LQ6c/uaJAlMGuKtfv+B1+mYkRuPglQ
         6bbNG1Q+otVfNYjUCEhy0oUl2CeWeYmQFd2TDh7pfwlVZlyzNYTzzWfSN7zaucVSwPdy
         W5RzAv2MVp03vAQm8eZc6oe/Mv9WupIgm2lhrBNJfCkXGx20W8If5lSLg0oC2yMiO1k5
         gr/1QubrrG8nvIdLs+g1Vi+bI/P+2sOmoVE7nQGzKMH8zFhon+H5/MOfNmtscdXAuWV0
         cfENPh4UsfRigSQZX5Ul/gCnYVuq1WHbx7WZfCwH3Mb7zvIqjgoOmZTTULQeSqy26Gwl
         0khw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783429466; x=1784034266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMZTTwd8MYpbLMhgPf9wJy+JM0u3tngYW75375hm26s=;
        b=Nts12kSMv14kT3Mm7Kxs1r2f7tWqlEGnFU6tFoIeMP51PoarIMC4pShI/bvjl76EtK
         eT3KNRKzth5yyVfwhc+J3Og2gPsHACsw6eydKUS5ZEXruyJhPCzRGdCZ5eoisZKHSJY1
         oMlspWCeU2jv5eRZ6PZLiMuG7a3rpEE6QmJ2pvzGxrOvoe8aefU7t91JcO/P6Lun1uI8
         U5OMIwYqYtEHjG59SmrqN3VhGNEwmI5aLMpg6GP+FLSH63i6poR2wbERKVFFH90DEG/a
         cSbPa49XXsG5KTzY0dPmu5qDvEdnmS1UNrUq2X1hTNzhd/REC6s0q2GpWCJNnzPRejHJ
         XDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783429466; x=1784034266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kMZTTwd8MYpbLMhgPf9wJy+JM0u3tngYW75375hm26s=;
        b=FPuKdPLdkDBlNqqcQC9NavRDWsw/2S2ypsJ6FYPtd7emghgBHcnASTjqDNiE6dpm3O
         azAERTLNWnTutQclBGoxPTKugwHHfyFhZkvGkW1ZYEr8W49NdJakdA9/RFKMSZ/eFuj4
         PmblTim10KBEn8ngbJD3gK6jqqd3k1KLQEVCv+f2gz5uM0c2tZc+KlfpJeaunDXIK9oY
         9ueOjt57tfR+HtnjXHdCqvK68Xd2VMmKRzuryX0Hp2ETT0+tAvFgQniZ22mNBQhJ2bCO
         JNCCxwGzoEHcS5iquzoPvDYx7SdJ2K4IQqZK31LQhqn4ferRA11ICYqLAF/ZooDeEm75
         oLZw==
X-Forwarded-Encrypted: i=1; AHgh+RoWGjmFg8Gm3T4eMgi8+oCZpNmXfMl/y15RejD/5hFZGUTVyyHHRkOISSVhVTKQDs20scusQA66zu3BeaW6@vger.kernel.org
X-Gm-Message-State: AOJu0YzEoV2lIcgrnziH+6aBdZ1ffTlqFWGiSsIwvAMZGwQd5NvqP4z1
	PXi+bV1zDXM7MUI70ydP6FjWVOTwmjsSO66/hkG8ySlcaU/Lz4Gc8pPv/KnzLG+6nIhw0/X6F6+
	msAqbC/BtodZlJiBHoEO9JZNB/Kg2l6PIcBYMuCXN
X-Gm-Gg: AfdE7ckn81dy9DHTF49K2cnF81Va32lv3/Rb9shc8QjwLx4IvQ2yaM26eOUOErfdZXL
	0Bs7bPygaoCWJ9fSPK1BTe9VxgCTzGtshRLS32G5YTj1N4u5g4ivYhKKOpAX4toxz0+6hGgEWjX
	RepU/UJSwHKQUmPBLykRDMWb0zAK/81uDErHqWZJegM/1XG9/PYInvCD4zBTNzisB3i8D5ll0fd
	jE3PjoTA92pxb+q8kJLXd38PgBRu20qBfQss1a3an45h7kWkJ+pji2f130bPL2spWRHVYYR3faC
	I+Qlgb3l850h3F3ME+uB4JkQmEM=
X-Received: by 2002:a05:600c:3e14:b0:493:bc4a:e7d3 with SMTP id
 5b1f17b1804b1-493df0a08d1mr56240095e9.39.1783429465838; Tue, 07 Jul 2026
 06:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org> <20260626-unique-ref-v19-4-2607ca88dfdf@kernel.org>
In-Reply-To: <20260626-unique-ref-v19-4-2607ca88dfdf@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 7 Jul 2026 15:04:13 +0200
X-Gm-Features: AVVi8CcTh9Rs6YX_7yLE2pYLhG0EOfuYJdmTfdwdI6hvKkhrcisIrByGWFuDPNk
Message-ID: <CAH5fLgguLAQG7mUwD1NPECYSsPdpPD_tLskU3NdwLZhKR1H=aQ@mail.gmail.com>
Subject: Re: [PATCH v19 4/8] rust: page: convert to `Ownable`
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
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, Asahi Lina <lina+kernel@asahilina.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 1:56=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> From: Asahi Lina <lina@asahilina.net>
>
> This allows Page references to be returned as borrowed references,
> without necessarily owning the struct page.
>
> Remove `BorrowedPage` and update users to use `Owned<Page>`.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> [ Andreas: Fix formatting and add a safety comment, update users. ]
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>      /// Returns a raw pointer to the page.
>      pub fn as_ptr(&self) -> *mut bindings::page {
> -        self.page.as_ptr()
> +        Opaque::cast_into(&self.page)

cast_into() is mainly used when you have a raw pointer to opaque. When
you have a reference, you can just do self.page.get()

Alice

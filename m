Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7629E46AEF4
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 09:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117715; cv=pass; b=kD7fW1R90m67TPBDnJ55GEZmPz02m8B0nPR+iAeIITgdIrFJMGhVl5L0kNIWZEq3I5AoEFtmc16PH97veS7yf4NcfeZxJYDDLNqpYM61kw41eDF/yc8rsTiT+auSOaO1V1vkQ70Acy6Y/URhdtQ9v2YNuoiqpabNYYBfWt9iFPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117715; c=relaxed/simple;
	bh=9AitBb1GHyxUD8itXAfWQrOndn4vr+DMbiE1kW67HMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ibKZDplQCe13cibloq9Vuz8KjIw4/54fgsFqnsXCphj6LgfRaAGvHBIWhSTcbiPbYUsHNoVIAqZUpg2Nz6oIGbSEqK1UfzRgbJ9KFtKiuJkcRF2S8eUGaOATQ1k912SMJp4oIaVWaV3v15zIuS0oV4mnYnRFL+CaYFXVtcSNFL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ntc0+0D2; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ntc0+0D2"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48586861639so277435f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 02:08:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789117711; cv=none;
        d=google.com; s=arc-20260327;
        b=IgEoQjyN0oLw1SIfcg48IwAI9c6YZEHAFIbKetF2+37PUttDfio3UEqfmsV/ccT0d5
         DBwxUsAHCvf7Yhfa7Do66DacHCL5J9Dx4sFbEhQthAFFDtW1kgdcreW9P1eakXBXid+h
         n27uk5poIQG32xFt4K7V22mvqYydqle6rkTTY3Zr20kd6buIxqu+Wgft+iPELJ1vupS2
         7DFwLMTprFOgd1aZcF2g4QkqtR94LXXsDtmT2CiHf0oI9sKfc6L2XphgyXrACnwtMBlg
         yJPwFwzP2XLhLo84BdD4a5cZiFx0SlACBoVVGRkViSTcITkkhS+neRBo8NWduw0w+YU6
         0hGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8V6E7xJ2vtTyuoasuWVTwqEDTbAd7Nywgb6H8W3xPYA=;
        fh=9S1S3PKMveDnczaKVZ4qAc575TZ1Z+fvzlIeuYbLPTA=;
        b=mEKOuIhFQlDlnIKRNuclC2lwj6b4AaFNfzgryd3ARfjHKa1jZUsxgiUniDEIeyaouf
         oG7V+ewwPntBzP2mS2KClIdpBdXNDsJIT2L7Od16mTRQFXtKs25PAthuiWnI+JoPwhb6
         ZEwUa5rm+0a4588xo4aGD8dChe7jYp/q2klnFPl7w9LrIrm+pRoEBl60/sYwGowYQ968
         oVz1Q/lK3ncud9eR58s1BM5rfvdKJ4HoS2BGFdFrk8y7/L/9q/2E/uc1iuEweFIsvEY+
         AgS45g6mCQArHZinK6T7AipCl4XkRWc3G+y3N9aPc0MxB0JlXB6vjrJ3BRcyzL+7jmzM
         sg0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789117711; x=1789722511; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8V6E7xJ2vtTyuoasuWVTwqEDTbAd7Nywgb6H8W3xPYA=;
        b=Ntc0+0D23+YujkzMEy4eJ6nXRpHFOnm4AtVkxEhi5vnpCexhU7KW4PmGmKyNMt+kZa
         TPGlSB3IBPA9MiD4PQN6ttGdFWT2WqMR0/+bikrH32dyf3RHlyaDpdo24c0XMpHO5GJU
         lDTJahlTxAMonEnDUsydvsqrYYCX0kfnhBDCQrNCn+atyDFTDkDtjvAsv2M6xPLh4eMe
         a/AWqeYbYlOAESo9Wgc1GsNr33dNbudqVttD6Sl4VuL4rsbQ/aL6gINrZx4FRE2ZMT3U
         4K5dculSYJThgW463pZtuOMCZuRhxZHA32PPtyLFovJ2VLCOKrv7CixBauixl/iB/3rB
         IKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789117711; x=1789722511;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8V6E7xJ2vtTyuoasuWVTwqEDTbAd7Nywgb6H8W3xPYA=;
        b=aXHM97nilw2m+zQC25x4GE/uWFQXOs0oQOVJN15S/QWUzezB0kSB9/X65t9Fk2Qksy
         jzmFa7jKc4jqFBRzcZGg87SmybZ1fK3wybZiKVRj1Og1oVlsINQptsQuwMmKwQn4/TCW
         tLyLOS6QtLnK/hagqRcIK5SPGuy+cGtJ5Fafo9E6Nc66sO9F+iEJAZkwAIBh8tfj4CG9
         WoSCo76HYOYAFbTM31Sk6x1ZdyAZyKu4UnO2il+yOA31Ga3cj+36erJe4y28set83ZoA
         AvLx6fZjjH3SF4+/kCtLVF2TXvbEMcyM/MV6N83L2voVEJNy8dHKu3gDeIZzQ+m93ju+
         nFfw==
X-Forwarded-Encrypted: i=1; AKwUvBy5/fA7/FgIV08bDiGsemUx/d1gasHcb1RPrBlVV6lJR5ztWN6/T5yy1F3juyWBvArlXap4aKRim4TZTind@vger.kernel.org
X-Gm-Message-State: AFuF++nnJVh2xG6YqFpgamZ9W8RD1wevtC0dRJWXQ3OYg8hHwEus7CQ1
	w7/IuzNgKHvEbm31ySknr87EgAFEJ8lcOmevCq4AbCeOX5wYeQGZGHiZ+vHIYlElDRps2T1V4mM
	+p3kU/i69hsT1JFDFlOLuUJS82rlvxuXKh7HBXxWW
X-Gm-Gg: AYBFou1XXpkJkK9w1MoDh8OgM1aeAoAcHluwG5FtUUgeJ/IzPvfcZMYDRke00KHXzX5
	5Za1GyYBGHoyOyBejZijZbPlTrUk4Lg9wGMnHfjqXIGDXLkzfZ1JUqGRe7Q3nZTskrVLNbMZivc
	UVIxTdERqiAyTqSpuRLoYRdMHgX46vUnC71Otkf8ZnxEqHOkIvF0B1r6zULKFvUCxRTOSMDEr2e
	PWPaJ67/2Ld55FlZzvCC6K58l+vpgsSQanNXBNcQMRAu+JdF3jy/GS7w/NEGYWstxYsxGO49sug
	mHG6dMwDpog1B7/qp2xN6Kg6X6z3HHjw21/zvmnu6WsGgfm0nbVs26yo7O3NJFEwbTFXHJgb03y
	ClQ/hTifjuQuurCFghroC4ITfXCqhWcG0gsFbxGOlf2AVQGy3dguySNPvWlJRJiev
X-Received: by 2002:a05:6000:46d0:b0:485:8226:c691 with SMTP id
 ffacd0b85a97d-486e0f6ce92mr8157059f8f.16.1789117710377; Fri, 11 Sep 2026
 02:08:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org> <20260910-unique-ref-v21-4-e83257373062@kernel.org>
In-Reply-To: <20260910-unique-ref-v21-4-e83257373062@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 11 Sep 2026 11:08:18 +0200
X-Gm-Features: AcwNN1Wcpw91RcC64bgI4fLKPGdY59qIT8O1U-qjeWGvrNCV-tRUtkCYbazUk4w
Message-ID: <CAH5fLghUQW5urTfLCCDT4BhuqoFVoLUAG46TS-SxaS37bJcgWQ@mail.gmail.com>
Subject: Re: [PATCH v21 4/9] rust: rename `AlwaysRefCounted` to `RefCounted`.
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
	linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
	Oliver Mangold <oliver.mangold@pm.me>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 11:01=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> From: Oliver Mangold <oliver.mangold@pm.me>
>
> There are types where it may both be reference counted in some cases and
> owned in others. In such cases, obtaining `ARef<T>` from `&T` would be
> unsound as it allows creation of `ARef<T>` copy from `&Owned<T>`.
>
> Therefore, we split `AlwaysRefCounted` into `RefCounted` (which `ARef<T>`
> would require) and a marker trait to indicate that the type is always
> reference counted (and not `Ownable`) so the `&T` -> `ARef<T>` conversion
> is possible.
>
> - Rename `AlwaysRefCounted` to `RefCounted`.
> - Add a new unsafe trait `AlwaysRefCounted`.
> - Implement the new trait `AlwaysRefCounted` for the newly renamed
>   `RefCounted` implementations. This leaves functionality of existing
>   implementers of `AlwaysRefCounted` intact.
>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> [ Andreas: Updated commit message and rebase on rust-next (7.2) ]
> Acked-by: Igor Korotin <igor.korotin.linux@gmail.com>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Assisted-by: LLM
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

This has a lot of safety comments of the form "This does not implement
Ownable, *therefore* it can implement AlwaysRefcounted". But I think
the safety comment should instead explain that it's okay to create an
ARef<_> from an &_ for this type. The fact that Ownable is not
implemented is not sufficient argument.

Alice

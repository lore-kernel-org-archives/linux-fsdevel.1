Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3403E357CF3
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 18:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101834; cv=pass; b=dzLaRvWmNu6nBvwhgaQ9Sbs+QnCXtmmPjRFD6XL/dipL8c9O13b8bpreFs/V7DQ0AaFoxN65Uc8r6aoJYg1wKGlsabCIp2UYxKx8AXpFI/M0sZeZrSLoYXDJ9f4w8TrNCj/9C47T7vNSjFER1t8cGNH1AXZb0xWsKI6cdDnGIH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101834; c=relaxed/simple;
	bh=kblI8jvzuw+DdDqY67GusYDiVjYY1AFEjqn2PvfijFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ny2w7TKU7fE7RBPZLb08gR9m6D64ga3+mXll9hM+Oil0MswQkfVph6lg4s/T68lq8FodH6B5ypXDieTm+Mscjqu+8YnLJtJ21dv6/60KdF4CC/K1NJlq24S//LOh5NsIPceRcg83N4Cvw3dI0r4ALcURem7+Eu2wi3iFm/LcLws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7Y0Qsbg; arc=pass smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7Y0Qsbg"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4b37a3688a2so201932b6e.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 11:30:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790101832; cv=none;
        d=google.com; s=arc-20260327;
        b=Kz+2Yjcfbol1Pz6kIP1jTBZeoKOEpb/oRANQhvHNNWLypd+WGJWeXgU8+YP03PEjaf
         fe0WrnVj3ML5XjcIjxeEmVtO4S8OIEcy2Z4qBz78zoY2q8citC0Y2pGbHdFKDBqEbdZM
         dsUesR3oK6rRxVMwm1OkFkAoVgohFLXVzvxp2kCzqxgGr7IlkuYA8m9Vk7AMhuAm281a
         Hja5jEv09/gYSxdWtFE/bOl6ROcnALJH2P3gbleEIAsrSlMCN5EauD/PgBmPC9x4RZOc
         0jarJUZjKtezcLcaxR7tuEQPnii3a0qiFeabM5QKwwna/PkfVNdHYH2AlzvDLGlXb5W6
         zUqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kblI8jvzuw+DdDqY67GusYDiVjYY1AFEjqn2PvfijFA=;
        fh=3WYqXtCy1AoT+4/R7RI0jfnz/dt0lFtn3jV1woSV8WY=;
        b=ZdpN/uu4Px+pfT743EC4iioZp0waWdxlnnBkf8dPelLjGswNwW8JBVPZQGum/CzgKE
         LowcmTg6dPro4lvIZ3rdTZT4UMdCRBpbZgxK9JhFLMsKflz2+oA6R9YGPJBs0LhUwZVO
         4m9Tj2YVVmZPx2tujc4++SLJxBCCZCIwj2l0V+4PODJ5P4oI6+7MKRh1+K37we2OF6XS
         Tr+b4nhD945r4HyTVGNApC1ykfKEqjH6J1wv7mFWnDx1TZLMFfMYRkw+ufoh4pzxzmfn
         TK/Pi8b4rusXGvBlkRGe4ENMF1LwUGedVkqkdupLzqgTbBdzURdx10xm+imoB2PmBHnY
         fSMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790101832; x=1790706632; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kblI8jvzuw+DdDqY67GusYDiVjYY1AFEjqn2PvfijFA=;
        b=l7Y0QsbgxSeX7YI6DdTjrF7Aev0Ksef8ZwY7Fk8NlV/FSRo0NwRxp23nQgMb4hK3Uo
         jfotH+1SG2sZ7D3wgzjgc7LzsXUa8YPojVdU4AvSkYmugHSKtiuO9J8F/UmkCzPkxk5J
         qAFrTyN3+AjbroiQSKgCC71lkrk7L/iIoQ671k8UIxLFBZVgiBhi8iSBRImAXI97XuzK
         FlWiy1xkzoHGC43+ARG2B98dJb8jNrSPefW7R1mAdj1ej5TUz2pfeK4BSUfxMO2gqJL4
         lkiYlkLUS/3niQMv2RMd1KkyhvYJfOCOQwkAzDYfZnrVp0Hg8jc9z/LHorUSNPAvIQv3
         RArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790101832; x=1790706632;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kblI8jvzuw+DdDqY67GusYDiVjYY1AFEjqn2PvfijFA=;
        b=opu1nNOnk+Q2/ZqmiEFhiyokNXV9WfUbJFgpm1ye7XxcqYJAZpq1XXTt31rkRne5CO
         RuZAy7xJ/xN0/PbwmVL6vtGTt+eDKkJZIBN407CMdtn8xGjWoue6V2YgKBUQmOrS38i0
         xMjTVY+/TavDpZUgKO2HbztFMSeVv+bw7nFVk+hWhXVregdXbZJsXbAFZeXojewrlrOk
         8yotB06nQZqOdtljXXEHtd+jQKyj3rw2i2DARKyIxxxcbfUbmwAuPnLx8ziQ/658I6cp
         5jZwu29/7i7/oNP8NF51clLGwYviAGN2wPr+v7DNQf1YcOlO77DGLrWCXxOayn4Jm6MB
         w0tg==
X-Forwarded-Encrypted: i=1; AKwUvBwNe3ao6uBq8QYjgbYqdGeoVkp870+mf8QLWFdQ9ZveVwbfQeUvSQ9FxdwmSeakmN9W3w5dfjGHVln0jlnu@vger.kernel.org
X-Gm-Message-State: AFuF++n//waWuwngBvdT9uEJZkWLoMfV6oP5J+Wt+uZttk8p0f9whjNw
	55rVnxSsdBLye8whGzvPEJ77r/kL79f4VhAM86qOyV7+IPD7ThiYj/H81EVKiM5trl9OvWSQeEh
	K5Krz+U0xB1LHXFXnlpL1Hmcx4urQIGk=
X-Gm-Gg: AYBFou1mzZDXRIqjr49yErbnCGqDWohCK5pUPPcZrbDxntYPnaZ9GD951GxkXUtdBEJ
	k/0ZUhIwzHHloU/AFSWULEHNZymaghNMp5hNfrX0rqpHiOFaXX0+REPSWKVt76dHMSBlC2cJbuS
	E155V87/QcbKNagCchYbFDbe1rSKehQ01hhyjLvrjH6rCeXVq1BGNZza0iEQxkRSAf4qM06YdYp
	K7RWa78lkwzdlpc5T5VJ1nYpYppYYhrRnHnUEcHOivockdob4fXO8jQimJva5ZTPBjdLI/kgz5D
	HSlH52E8iMR+XfWbpJoBm4nbXCVNxmJ7oKir9V2MWyThdsqsBRDcJ0ki1qZaChxt1v48rQsP9+n
	zi/8pYMY/bWrgNTiZuJFYtiSN
X-Received: by 2002:a05:6808:1247:b0:486:8a11:6e8b with SMTP id
 5614622812f47-4d5b7508c71mr243620b6e.2.1790101831981; Tue, 22 Sep 2026
 11:30:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920200154.1194983-1-georgeandrout13@gmail.com> <DLKFTVSN56P2.2NHCFW6NIUOAH@garyguo.net>
In-Reply-To: <DLKFTVSN56P2.2NHCFW6NIUOAH@garyguo.net>
From: Georgios Androutsopoulos <georgeandrout13@gmail.com>
Date: Tue, 22 Sep 2026 14:30:21 -0400
X-Gm-Features: AcwNN1WCk-bP1a41pSc70f2QVB_IR4W1RwREP0VVcFOJquCvEG0378Po8h1cQFo
Message-ID: <CAESH5oeuKoDyr6ZcGR3Fa+_nPn+ceg9PbqBXoXjRsstaSKtJtw@mail.gmail.com>
Subject: Re: [PATCH] rust: file: handle fd table teardown in file descriptor APIs
To: Gary Guo <gary@garyguo.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Jan Kara <jack@suse.cz>, Boqun Feng <boqun@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	=?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 4:48=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
> I think we want to add `unlikely()` on them (which is being added by
> https://lore.kernel.org/rust-for-linux/20260406095820.465994-2-ojeda@kern=
el.org/).

I checked current `linux-next` and `rust-next`, but this does not seem to
have landed yet. Should I leave these as regular checks for now and add a
`TODO:` to use `unlikely()` once it is available?

> I wonder if we should upgrade this to `WARN_ONCE`. As code being executed=
 when
> exiting are cleanup code, for this code path to be hit, it would mean tha=
t some
> code is installing FD descriptor while being dropped -- which is likely a=
 bug.
>
> Putting a "BTW, some Rust code is installing a FD when process is exiting=
" in
> dmesg is not going to be useful to understand what's going on. We'd want =
a full
> backtrace.

`WARN_ONCE` does not seem to be available on the Rust side yet either.
`warn_on!()` is available on the current base and would give us the
backtrace. Would you prefer using that here for now?

> I think we can remove this warning. Skipping put_unused_fd isn't actually
> leaking anything as the files_struct is cleaned up.

Agreed. I'll treat dropping the reservation after fd table teardown as
normal cleanup, skip `put_unused_fd()`, and document that this can happen.

Best,
George

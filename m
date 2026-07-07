Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA48414A0C
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 13:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429501; cv=pass; b=gBHm0/kNvsMrMhC15CFIeMLzRRhPsj1W/uSKBTCzK5M3tbm6hXt4cDT/TXAzMUHCzcYO5GDvILFSdWJkjKfLB+CFxhd/xJ5VPGtgh1S9yzpZ6sqiCEzy/k8d1+CxQMATRIMtcdSNqE88rib5Knv8A/uvPBxPiSU9m32+QdmEwz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429501; c=relaxed/simple;
	bh=Qa3HvUOBiikHOm2hv7akwkWqjggqpxhg4jyWQbcbbM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TrrGfTVPqJHUz5nT4xCj+Eqxrx9XudmeaZ2mMk2Ut+KSl79D+CD7hK/+D9ZDhdjcexHVzaicNy68W9kAcABGZN7vx7iIQIF9abfW/kxzKsmt+pzOF4asdPY4M+BsQ5nguTcwIAZ2AD2RABQI1kUvV8Zy4904IN1kgFfFlqY0kyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nwFqpWQm; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nwFqpWQm"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493c19bad03so39168635e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2026 06:04:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783429498; cv=none;
        d=google.com; s=arc-20260327;
        b=BMTcs9c2EwaQVp5n8iDMPJHJLaBRO1s+cZH+JsFdCL5yED7XL91mdwNEnE9RYWy6Si
         Wc0UthH1zMqMO57b0vxAvxLWn/6/KswiG8Z+YitzfG6PLAbZYNAVCnKMSbxPpK1tknDk
         DL+PFb8PuoTM46kXicWfwhsFTDSuM//wVGbtCZ9WEuKJWWTGdEjUxsGvAzdpwoPsedzw
         wPUL5kP+ItCUETBzRzHTBPMVB0Jim8usaOFPbe8YaGbI8o2qVzJLRvhI2N6+21evoNuj
         K8OhsXJ01r4OAGw4ZGdjEp5bQno32Gs56h2vksrjrZ0wAc0pNtt5xejVlFb1EguJgxLV
         Ps7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qa3HvUOBiikHOm2hv7akwkWqjggqpxhg4jyWQbcbbM4=;
        fh=T0wGFuFPyZwMW5oBQzbJW6kCRS1w5qGuO+dyM80krGI=;
        b=Ij0zpPAS93tUhgJaQaSLkxtqRW2Q0QzDfV6GlZE7si/B0NCYwyzr3OUVqhbabauYHi
         sc8ydfmKxEAPf1zXnIiB6bpTVEm6rgdQYo8Nc7py64UzOip8wFml9QbFUreZ9lAYOEGx
         C5IKwlZXkBU9SaSYjVW0acXosfgXhxt0iohJdOe/T+djX1EpisvYDDR3HJgn00p9N3lc
         cYXE7yKTzoKR4JuWdtvM7HAptANRrXZBH4kVbb1xRENvbtQPgpoMUsxw2f5qfcclTkJ8
         /h4rWDRoRFbQJg5joqOhiO1/C2nD066l3vq/CfxqXDMVPOLlK0A+49pCXEBpVMv9RF12
         WY9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783429498; x=1784034298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qa3HvUOBiikHOm2hv7akwkWqjggqpxhg4jyWQbcbbM4=;
        b=nwFqpWQmjpkhT5N166ROjlsHRUNBKTRpXMHaTMJhkX1rzisW+j8ZNBgqb0gt0uMyFK
         kJBGogIRdGOCv+IfwKTap7nCADTIGP8KSe2axCh/K7UPtN3Y/fPn4dG6mxglUfb5sjDe
         z9wuNw/bh4mOjkdHneFd2IGooWxjn53QI3Stm22mJIjhjpbdYFfbUmPDdJ+o5ujoCGZU
         Eb2D+u6aPJP/dPUUL3BCwxU8hiDgJqf3hxk/zmzS8CtdaNnPAk27A0y9mKwZuZGJ8UZk
         RsXJ0igYAos9Lsjb5CO7DSUU9QppF9kBmRG78Ibkhp9dKy3x75qDooky2A3617Q50Udn
         s5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783429498; x=1784034298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qa3HvUOBiikHOm2hv7akwkWqjggqpxhg4jyWQbcbbM4=;
        b=lAoZKTPEyMqiKaxfbiqSodX5tTUz8385WpIkqU3cMhtUh+iObvyyioLhv8SWnxC7QF
         5uLxVC1StbHBYHNUu7XhjDFFVtvYvux5ha5YJrFNqm7PV86WIdjGxHkrR81aNZblddUc
         oR4Zp0g1j2kNBXOGI3uYl5j4hQ9S4Pq1xJDMNJuJmBsuEMw8tae6rMUnnFh4wUO0Rznu
         StMdstFvQSUelMmvBb7hwK4DEL0iLIFhwPmpriaNtL5Le139Td5M2nKRKEd+rk2SHilR
         31uXvptbZxPRETnaz185uL2hCZcqUtF8unyRUhYH8kyX1ltdlqQLUO/ljykuUZFaU79y
         I1YQ==
X-Forwarded-Encrypted: i=1; AHgh+RoCTeb7sveex12TxqFHwYYZvnmB5Yhyf91t3UaCiq3ai1uUyGaOhwNI8BECIDNftaAiFarLs915bFTQFU5U@vger.kernel.org
X-Gm-Message-State: AOJu0YzTsTcIvv/Il74R0Z2q9XDBI0ZTaPvZBkHzBQSieXdH5h7xBUsj
	5pWhm3vLEnOF2Q7piLlp/IXxQ9NrPFc6brUY7iYzLblnccvkDs6DhQHzpQHeWafwjOPj6am8Lmi
	8Dc70lzE3LAImF/x0t/S1Yo/+eV1h+D/FsSr2ngEj
X-Gm-Gg: AfdE7ck8wuL22dhUSE5xDmGSiG/wBqvSwNIoIZW3QBYpvMKGyfhr+isSLPtuIbIgvaw
	wMaTsALlXO8xjANweC+HVtlFLw61Ruo8sjxMyc4LIdtKMu5TY2Zco+CgcdgO5UqITeXNAF6S8+8
	2fvGoLGcX9DfE0h2bZpTSXJU0fFg0bfrM79vW1N7Pm0iH/dxHNJGVKDMGa/TpRoIeGuDGdvi322
	Ce4JnNoEKIgy2E/H6VizIzZngCnW95aZKRK5WWrm+DPXQ5XxfraUaxKvEoUYn76bf8zPrOcsaBe
	YnZ+i7SqcF6JwEzJue29bFhC8OE=
X-Received: by 2002:a05:600c:8b70:b0:493:b6e4:fb2b with SMTP id
 5b1f17b1804b1-493df06e943mr52096855e9.25.1783429497735; Tue, 07 Jul 2026
 06:04:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org> <20260626-unique-ref-v19-3-2607ca88dfdf@kernel.org>
In-Reply-To: <20260626-unique-ref-v19-3-2607ca88dfdf@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 7 Jul 2026 15:04:45 +0200
X-Gm-Features: AVVi8Cd8GrEsrkEwxzhRkanTcpbMUA7MU6OpTudOnt7DIfIGqhosSlF_BI7LYTM
Message-ID: <CAH5fLggMeHUgXj7JGYSJejUrR2PdWymOOb+3E1VmHokzcox4hg@mail.gmail.com>
Subject: Re: [PATCH v19 3/8] rust: implement `ForeignOwnable` for `Owned`
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
	linux-pwm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 1:55=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Implement `ForeignOwnable` for `Owned<T>`. This allows use of `Owned<T>` =
in
> places such as the `XArray`.
>
> Note that `T` does not need to implement `ForeignOwnable` for `Owned<T>` =
to
> implement `ForeignOwnable`.
>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

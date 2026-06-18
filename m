Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773883F8229
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 13:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781788023; cv=pass; b=e2YZZN1IzcW113E5tVJXdow8pbjvdOffXCykLzB8fqLAVvdWIEqhPO+tfKV5+Fs4LiD1TGPTJsc6O7YTzWSHh72Xp1Xgrdncy1c3TZ6oOj1Lxx4W5SaqWqEtqwxGKEKRKHgfjofGHORdTkxaWIp5usOojt3rIhwBAFsIvQuLQsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781788023; c=relaxed/simple;
	bh=xLDEczlFg03N7NCLGvlcEdzsmuKKaWL0tH9EnNveSys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jJ7FYHpHHcnv5gRcMkI56YLt4fiZEzmcTQaSW4/cs7G/Jh6A/nJGlxZrHXjt03nCcBCZQHFJkskv4Hc3dNOZ0ojm+RS1YSQOCI+ZkEeUC8oGQq7FUOcaBC0jz7cU2WwygROsaWyO3yD4vUPsErG/oWGTioXraeNl1yaS1tKy4kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TtMY2Ngd; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TtMY2Ngd"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490b64c8311so7986205e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 06:07:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781788021; cv=none;
        d=google.com; s=arc-20240605;
        b=eNwl0g0Dd3vIO0cXFBc/wv60oxS9SA0/gBzcClx3/QAOPZCAH5C0fkUUC3iasbsQG9
         /+KtOAYtSWJpf+/pX/76nexqU9RJ223zlrXpIGIaoMQntNqbxS53086UhqLx852ea9q5
         yMRHiOdAxIZFMCP42urYDH8tV7IwNGHSCQBLF6LCsqRzQQhubpr4qpMezjpxn8DlblbP
         W9Ez6pPq0fMsaLPW8A1ZacMIZSZbl8/Lcto7Eo10NKXH0fgCh40nfCm97riJIhHnPBs2
         9KNThHSTd2GnXMnxTOV1AK55xWSjSSzid+jemFeS6g4A2wiRafaiLcXTbgbSr708wykl
         y2Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xLDEczlFg03N7NCLGvlcEdzsmuKKaWL0tH9EnNveSys=;
        fh=k9GgfTQEA52Szz/aS5sqFdQjXyQrmjCkeBW9ue52xf0=;
        b=NzBOzl2tUQdtAWzB8Dn8rgHRfSoioaM/EW0A1IQ5xyVKjGfVWwrivIufaU+68P0emm
         iY+2NhQZ7/c5BkkJIep+dKjO7/lGhfLJjytL0rjgcHvPtdVaQWG72E+EbBQ8CoafE7Cq
         vEbPx79uPSCQazmFycOovYebsyUfXI0xAJijjuLkl/YnWyd9vz4tQXpTusZpWCvipocU
         NZmrMB60/fdTseRlt3x+EsJK7SxCYUa7frSgXEfeJIWKzDB31hBZZToILPz2DRUlxl+U
         mPYELWtcuoRLvwatvVSne8KQLWdCxN8eoVyV9uZloBodm9Y5SYiIiWQIqR93EQ7j0gq3
         HnjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781788021; x=1782392821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLDEczlFg03N7NCLGvlcEdzsmuKKaWL0tH9EnNveSys=;
        b=TtMY2Ngdb1sGxR7NWU5wrnWHaPWlwbhatx3KIrmFxc40lldg3ynkDML56ZrDvKKRoN
         2M1cw3lKMqP7w0oPa7tFW9XafJoGkS7SqitZOh32VYodI7J0d7MhWGhjV/PHpwRU4eox
         fvgh4U1JQWCAitWzxKPf2A9WlQ1bHXJWZU82FTjMhZsRf1AiNAXKk3c2JB7IVVWjChhn
         YqpFF8TcftE2Vr+EnBOnCClrwT1G3nWb516PHZQ/ShHakueJEeTQAnJdVmFXTcH8Ti9X
         ZI1N9HHI9BqGnUVd50Zh8E2AFufI6uBpAA/rn3Yz+dHVLzSdbRpnN2hT65cE5PaN99cW
         e6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781788021; x=1782392821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xLDEczlFg03N7NCLGvlcEdzsmuKKaWL0tH9EnNveSys=;
        b=Vcw1gXgL9pDAhNi8H3kx2PUw4hhcP++eASMA1VKVz7QC1RM+gixbv0/x26uoN87XXT
         RiY5HUhgrbjmqkGaTxpYduvEoNGfB2yGC8BvyVTowzF9kQROfTzJdvYU/7zTNuFQFr5n
         55cZnQ5gXq4DZOGb8LUI6114en3GiS+bfZLW5miS32kDd3aZ7QJK2Vc14MXsUSN8E4QY
         HIbeu0+DRxBWO3i31BcKq4iuGDs1jIdCzYLh1LxvZtLhgu9BuKgxjWVN0+Sq94afsiAr
         H7M3V7FdY/IHIw4wIFqq895/8T9zssHuKfJuFx3XAyfDirsZK59vj2w3gXQv7gdzNVzE
         oh+A==
X-Forwarded-Encrypted: i=1; AFNElJ+Fvq3YsijpVJPLIaeaS5BMfwTs9Ce+evYnUER/YUHcOWZTzHbu29xSubqBCGsyO0eHJViTzu4PcvEykupm@vger.kernel.org
X-Gm-Message-State: AOJu0YwSwr9FrxpCl/MaASskQTN7k0lMOO4aZB8qWfQ3sVI6oV8M3JSv
	5v+G7ObZDjFN8XTTtio3rTytQDfbGFHXGWJ9QemMO25rbrvTTVXROLDrKG5aV6PmYYWykzxFneB
	B4ylxYDjc6XBFu4Y2ZkNAiNlCK45cjfHp9IqwYpzq
X-Gm-Gg: AfdE7cm81ZAHChWu4ioe+tPo1UK8D+7cAPp31W/4OeuJWW8fHPDp1ACSE1zlALKaPBd
	5kunBn94dOsmcbw2iNnf4vFJH/GyRpomf+L5XqZLqekbcPY5yFq8LRPulIH80gKR8H7SwAJWqKU
	avfGtubhUWdDCEPcxFIb3cSO66dzrpuMKT683N1EBLC6sSBZkQJqh25RprKPx0uZqDD5dtwFW4e
	Mo/sBQU391icMHwNrR06C/NYIm0JBpyp+5PiLnlMIHylnxQL/o9dBVoGH6dEUQ/9vnducqhwc58
	N6DFVb/jkbOoOPHCDZ13qp2z5x098NjvaI1zKYJA8JN4Njm+zCkbH15Yp34XhMakXMTLlw==
X-Received: by 2002:a05:600c:4c09:b0:490:b355:9c8c with SMTP id
 5b1f17b1804b1-492333ca42bmr96135075e9.23.1781788019918; Thu, 18 Jun 2026
 06:06:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618095952.3687099-1-phasta@kernel.org> <20260618095952.3687099-2-phasta@kernel.org>
 <15e81f5bf354cbe3cde765526762e4ebb3ef6970.camel@mailbox.org>
 <ajPa4_U_gcxr8SKO@google.com> <81c530248789f79da265da772a6f248a0d524eed.camel@mailbox.org>
In-Reply-To: <81c530248789f79da265da772a6f248a0d524eed.camel@mailbox.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 18 Jun 2026 15:06:47 +0200
X-Gm-Features: AVVi8CeK2MScB-t7m9DsXQaFm4-l0PDopN55uoi7q9D_cmJhkYOY8sxrgmKJWI0
Message-ID: <CAH5fLghB3Q-Mc4YzVMX3nGVSTzfh=jqFzsLMcXqXLTiVcgxhKg@mail.gmail.com>
Subject: Re: [PATCH 1/3] rust: sync: Add abstraction for synchronize_rcu()
To: phasta@kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lyude Paul <lyude@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Christian Schrefl <chrisi.schrefl@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 2:47=E2=80=AFPM Philipp Stanner <phasta@mailbox.org=
> wrote:
>
> On Thu, 2026-06-18 at 11:47 +0000, Alice Ryhl wrote:
> > On Thu, Jun 18, 2026 at 01:40:05PM +0200, Philipp Stanner wrote:
> > > Moreover, this would be an opportunity to change the naming conventio=
n
> > > to rcu::synchronize()
> > >
> > > But since Boqun & Alice are pushing for rcu::RcuKBox for the reason
> > > that it seems desirable to explicitly highlight that that's a special
> > > Box, I guess we should be consistent with that and also have "rcu" in
> > > the name here.
> >
> > I prefer the naming of synchronize_rcu() here.
>
> We might be tempted to at least call it rcu_synchronize(), though. It's
> also RcuKBox, not KBoxRcu.
>
> But I don't have hard emotions on that topic.

I don't think we should change the C name without quite good reasons.

Alice

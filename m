Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7A046E019
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117803; cv=pass; b=IDSJi4mXj1sZvQBFlq+LVpsGmQngD7eZfmlaM8ZkyNaAa42hl4KrL7vP6tEcgQiPfflKalyORQpctdauqdlHBdUiTBFt+CMkjcct+kIUncpFSWQREgGnT7MMpoc8Wj0/yHg4IbNSpjtBearoepo9Y5mezjCMXv9u34lZWNl3PeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117803; c=relaxed/simple;
	bh=DqoU+uWaz7+Vutomy33tnRZ5BBkjj/lsKZ4FCxPriAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HpkpfgckN/qzbcWYOlMs6EH3mkcvTPkyzJ7JhdGdloD2J1ExodYHYDCLLpBHrZGFpgLEGqk5QzSGagdgEtx6UYlwvMh9xx2/wP4UKlrxwzaDVNDViKhW92nM97+8WeZCeOoD0rXNSf0VK+m0BI7HP9Dgkdxgl+4Z8Tr6sB7xjig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MSlPe9Et; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MSlPe9Et"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-485888b3c3dso595539f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2026 02:09:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789117793; cv=none;
        d=google.com; s=arc-20260327;
        b=p4ABPwcVch99lq8PaUfmMyrcoaG4BinNvx9CAhuHRg5TdsPoRO832CbJ2lBV5Gfwwt
         4SILVb60uGIHZ4+ncc0blA/24UvQFVQJX7qnI4hGUSadi5J4amERmJM6efidCI+B40XR
         VOEaRDepSjLJgA4bsIJRDffhGXTpiiLWQYTSEzZ+pnpURE9mj4cnTdWH6VaBV5ASpwDc
         zcDvuINci93uubM7V20R+kngX4zg8ZQwMwPZUNhW2S5xABNntY2zgUfpfqBE/bLVIjtH
         1kAzZx7uyuNTL9qJyyhLLhg472OFL0pr2SqLbShAMvlru8PhJWNwq6c1zgbBaU0F4vLg
         0gTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DqoU+uWaz7+Vutomy33tnRZ5BBkjj/lsKZ4FCxPriAw=;
        fh=4LtIUINlRDhIQZiOj6auR689n0PR1tjMmp3DQFYt28Y=;
        b=p9O4bdINBOVzaElgzXkzObHDf00F9BUgBf636V/v1/FvRH7vprSEcHlqovMr97ww6O
         Ui6YW5S+Uu/MVxFt+VQ5PZK5TZcOK+g71+NY+1Qcd0jqG8TXoc3n8eQc3+Hqk8VMzNKn
         q+vJfHZzw9Ulf+EOBDO/8L5YtmuJPRlTrAl+wrhY9/YPqYHo5HxT0f/h1/DXayV7OYDM
         C4cHrajCXUoa28aLKL3T+mk1/otIcs8XAwvdU/AkLDGeoXr8Mox/36OYGe9JVo9Xcc4b
         k4D8nKuTRKZGJKlp+CFJc0MHg5J/z3MEcUQiTxMmTR03BRP6b0Yu0vEBAMdOf2dlUi+V
         Bb7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789117793; x=1789722593; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DqoU+uWaz7+Vutomy33tnRZ5BBkjj/lsKZ4FCxPriAw=;
        b=MSlPe9Et/aYooxs+mmr25pr80uFZG23i1Ff+HYNwoUYblRVkid0l2inKFKvyYhCHpA
         74RMEIvUI+LYnoLKLKfOmV3XsO+idJkaF0kKg+yth0rRQtl5E2y2iqZ2+BzrV44esGe9
         Gfqu0/0FtTeTt/gj1nMdkeGllp4GG8/dPMW6SAduAajB2PJTTh0EyTtISUFtDK6olxs/
         iuCpPN7ycYnpIx1qtI10WS4KO12IM90KAskYtoHYQeaRXYEsRQKGp3BGi7i/JLvOBusZ
         K3RJXi816wGUGyT/m2NeekI8C+6tI9P5dFmWFfKhpigFYWlsVGwnGy/m0LuueQHmrlvX
         Kr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789117793; x=1789722593;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DqoU+uWaz7+Vutomy33tnRZ5BBkjj/lsKZ4FCxPriAw=;
        b=GVZD8sXOQD2fQUbTkSLbzF4TYQq7vm/1N6A4dbMFBCqFUOeM32qB4V+CDF4rg2wUUW
         PAveaULSMBi/5DVBW0RZS9NxpPahNrHe1fVyf7jexuwq8D1WweW/SUN2DaHtZlFoscb4
         q4fDantwdQqO/ZG8D2h23UQ8f5uw2k4fJiuEolKysPXalNJHE1cHNOhbsmrQiHqcHjCH
         3A0x4+Be9myHxlxZ0wkZULIIwSrp1uzdnKMfmE9/60oFqrmPtnByMogYIpM77zW1ESS8
         hMRF+soh7jJZpXIbkqcXixH9PGUjxrlH0vVSfgqqU3JjYnvFaAbAFZR2b0/YAjNKWxWe
         T5fg==
X-Forwarded-Encrypted: i=1; AKwUvBz9TKh2DgIVzvMGqUtVQS85yNDZqT4d5X7Is9GabpgWszxSQy2FVEAKUaygKa1jp/xBPQ9eoHJZcaOhnd6A@vger.kernel.org
X-Gm-Message-State: AFuF++k77lQwJhZRz434SFYyOg6CFD98CkXTR7LkfH1yrl8DUgmVLbAl
	wyeDPga6VawHUMHd+o3voZqebU1v6x3WgnD9R446ch3cCUS0ut63glLfzMk6yHIccbZgbXrv0QZ
	k5sFIa1v06CcSWUrj3hAtDHQm4KgTfAiePVg8Yuye
X-Gm-Gg: AYBFou1vrq+wEKXGL9r6wdwrDO9CcpwWho7mzQMCYlFyFU8nkZvqEpRHmaGAVXHR5YZ
	X+0zqefX4bYROdATfm0HFPTltN6vVnsqhrSMEhHvg0hj8ucylgiosqJa/G4aS2aZh8jREDMFLhi
	EWd4ekFZoe2lmrpgGW9DpayFFz7kaoaBse7jJGqktDJs8GnVsYQpnf3P5W+YltYYqgSbpz39a3K
	gP/EyRn3dnlzQKsev1/D0g5SaGh8kDG48ZreYx2DROYVFCVLLW86HWnzozpj2W8qj8ROIVvrG+Z
	1lqMAcsb1dpNizQWdqMk+czlv3vr/9PpOtNy2sUuvEIJhzQ2njB0MiDLaUk21uKWKBA6J7+V0SY
	oBDKmQd/LlzLzBMjMJk0nczOoVkwHe84sbEKznUSJqh6WOP7RrtpE
X-Received: by 2002:a05:6000:118b:b0:485:8c16:5ef0 with SMTP id
 ffacd0b85a97d-486eb2fe6e9mr2544735f8f.42.1789117791504; Fri, 11 Sep 2026
 02:09:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org> <20260910-unique-ref-v21-5-e83257373062@kernel.org>
In-Reply-To: <20260910-unique-ref-v21-5-e83257373062@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 11 Sep 2026 11:09:37 +0200
X-Gm-Features: AcwNN1U8uQc4Zj212gVRashrRro-WErwh8uVMQ_MWKQsPaL29993fZfZR2Hn4U8
Message-ID: <CAH5fLggBGvXayMT2QGo5JeQkYeJYc0L-348-kKLsBs_g45-fnQ@mail.gmail.com>
Subject: Re: [PATCH v21 5/9] rust: Add missing SAFETY documentation for `ARef` example
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
	Oliver Mangold <oliver.mangold@pm.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 11:02=E2=80=AFAM Andreas Hindborg <a.hindborg@kerne=
l.org> wrote:
>
> From: Oliver Mangold <oliver.mangold@pm.me>
>
> SAFETY comment in rustdoc example was just 'TODO'. Fixed.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/351
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Assisted-by: LLM
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

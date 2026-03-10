Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443383806C4
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140196; cv=pass; b=l4B93Mbjj3OBYABGnl6LSrchuwh8zJjZf2jfL9T45NXy+qMKzIN6fc7/jDZljBeTTRXc7D9MdqumFKNikhMisA8EKb0rZAwMsCZyVxmx4IRZirJebZWOqIduhNYXdxU+OYiP3iFiNuj14fHdiEVZE1hXihFZUEH58PC0a9qyCMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140196; c=relaxed/simple;
	bh=nL8Tve9qxXBojU4CG3EUAlYMJTfM1E+ZMJp6NeH7Zns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nzGjjgJttBBQMYUFotb8oqAIzUqRmn7FtaUCJ3bF8EEgLqswXqro7qzdf8X2arrzSQaT2x+6q+UTU7+AYryRoSLJncqtDYHMmP33FEra2Ot3IWPoBUaZN6XhUKjIR2rL6YhmGtn1Btf1QMrhBwCGDSR1JRtKACGED0+W8pNcf38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBbGtEBR; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBbGtEBR"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2be0f64a05bso497035eec.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 03:56:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773140194; cv=none;
        d=google.com; s=arc-20240605;
        b=ctiResD41MVdJiHh6DnCvc00ju60uiYdELqJmidfByfH8uoEUkW5ZwZIGU9r8LLV2n
         k7ktlcp4ZHilJXJ4zhCHDpY2e6CS5gjZ1N8sr4QweB+qkbXErZyAFZ0V7FQqTy2Jo1YH
         vCdtDgd5yHsqmrGEZmHCzh2VCM2oXrFSVw7m50roFJoKRrKjdFa01T0Rt9tq/Cojn6GQ
         3yYaZY8FkmxgYGmmSAhg3M4ka53i2GpuZhtSKfVrKltYCkj4PPF5uxD0VnNqzr7EWXG3
         0plf00k5RrmyUDN1YZ7thm1yOsPQwXRXJBaa517wyaFxNrMLQHBL1B25mgDqhEej5VGZ
         u5JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4qBpWaqAk74juZmeca9VRmKlmVoYIHqDYNOH37dt7g0=;
        fh=g67uc4GHYRuRwhPWe46xO+GG9XFlwydO1q0mcFTfb98=;
        b=OcIgFyw2ryjNwrK1pG+Z1Mrc46VbSWCABu5RVYN5SGR3IxokjOcELKgc0fD2CTvfYz
         s9V+WArMBL1BQ9Rr4HvXv3dWtoFu/kh7IPOgxcbi/V3rOdbOF6fN6Z+y4JsqSUGhsxWO
         YE7OAeUnWclL855g5GTeJ7BFXgoXlDZnC77McRuNRMP7R68hnZM6GMpazK6QREIDEDYw
         2DKqiuX8lBSVQuECXykKsLQJYfFRigz250qMv8Sg3Jp+zaw1DyDDO7p6kcuwPH2VZYim
         xeWl9n/elWtYowyWzRLFkRLNmEqKIQAzl60ge6s7+EkusDyPKOjhNsrvd6FM/KPPMcUs
         Dd2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773140194; x=1773744994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qBpWaqAk74juZmeca9VRmKlmVoYIHqDYNOH37dt7g0=;
        b=MBbGtEBRBoxPubDO7aR6dBNxnj1NeX5HfI/2iP8Lzp9seSiN+tybz+fCRUtGLW5x5H
         Dk4DqYa2NIr6W29OV7/5WrHN0FEJ0+ScFhbkZQJ4OBIDWeIUWzj5869zWBkvAx1laXES
         Udu4UtFP+aCcp5tqTGuMUR8kxmr0FTGzsSlplMqaY0hCenwPTPwkdVVfNjLo+2nmkSeb
         ZLZA0ovPwmjNnfImTXGvS4gMKe4x5tYPKrZqYjvhXgCHtOZOaqyl0J7nwehmYLSwCQiN
         4RvcjhTehRXfc9XMyLghddQw5UZF09s2CvUvSITa7ja7/9lOwh6jaZeNRFPG6ODik9Ho
         PR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773140194; x=1773744994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4qBpWaqAk74juZmeca9VRmKlmVoYIHqDYNOH37dt7g0=;
        b=apPXFD0FAPpSHUNE3Cudo8vT816pfr/i1doqIoMXbweTcy7iLwFLnakw+XbOAF1p2L
         PUzqdZv3EY5ydjZ4Ydh757wMLKMEg0r+lavIovy5BCGkiLcUGpyKFl8KZZNOYXXKCndX
         3gnCAAjIaft7nAFHIlDk8ca0ud47wQs2o1TnI14DsjXxMDc39MT5Mb70iqbimT2qBxCJ
         2nxyKAV703jO3vQI4HJZCT9VkK5zSNYNsOlwU3iXzxt4oXRSzciYBMMQt7yP7XTQ2yDg
         5meX6jck9z2JF0nYw5AsM0cyGeoRBeYyLZ0JudUDEylUv/+btS9/+frYHL7SquUEooKV
         lbRg==
X-Forwarded-Encrypted: i=1; AJvYcCVyz5AVW1o0s4TdRDNxFEj9PX7sXs6yNGg8FfG3K6nm0gsu17H2/O0OLYKe6UGb3pjWEto4/UT2xwyeQxTt@vger.kernel.org
X-Gm-Message-State: AOJu0YwbyYXSE2+i23AE0bDOH+CiVusk8j+rqjQJj1wpIEDZPsSRcfra
	dNIAmdzMRdVHSBPbl5kpTBAP8AaPtocRM9ny7y79TbmpqbPbwYIXGE5ML2s4d+wWor8OBtSjB6L
	0oTfC++PKLomrlkKn9cpLHGP5PhJW1Hs=
X-Gm-Gg: ATEYQzymp9DjsQb879v2F8ireimBGWTzh8EYmxlNGqYQWVkjRBAZ+lfo6MXd75y5Izi
	0fB+EIiLpPqcvXofTiw6bVfXWURaEfQPun12A44sIYFCZkJVOuiJ9SYrg0lM+Eaff42JS71BPs+
	/vshOs0PHYCgEJuCHNJz1zUGErK+wF2+nJJm5SFP2gWvjFbVwnIPYhgvqXUTCykdLoVTwvVCIp2
	x+1O4jgQUpUPOLUtj2ZfSO47eHT8wUNSDJXE7/218xuvn3sBDDwKa0Ds6bOH5+DUTcgMwBug+52
	UedG0rpxnflaGbhcbICIl5aZxg0sccLsg+vmOqHDSFSOLjljcgVT4lXm2Ma2If3k9BjvD4z+f+V
	SRGKCzD99TbgFo37oNPvaO4A=
X-Received: by 2002:a05:7300:ef97:b0:2bd:bc33:ca32 with SMTP id
 5a478bee46e88-2be4e09ebfdmr2731651eec.4.1773140194353; Tue, 10 Mar 2026
 03:56:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
In-Reply-To: <20260105-define-rust-helper-v2-0-51da5f454a67@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 10 Mar 2026 11:56:22 +0100
X-Gm-Features: AaiRm523FMnYeZ1Cbp2n7uyCKjNSK8gDXCio5_BkegPeyUfSKYibfT47XJIo0_0
Message-ID: <CANiq72mT2-8m71NtnodVXVBRkhUSiK3Byq5OkBntEQpW9hbU6w@mail.gmail.com>
Subject: Re: [PATCH v2 00/27] Allow inlining C helpers into Rust when using LTO
To: Alice Ryhl <aliceryhl@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Peter Zijlstra <peterz@infradead.org>, Elle Rhumsaa <elle@weathered-steel.dev>, 
	Andreas Hindborg <a.hindborg@kernel.org>, linux-block@vger.kernel.org, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org, 
	Benno Lossin <lossin@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <sergeh@kernel.org>, linux-security-module@vger.kernel.org, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Andrew Ballance <andrewjballance@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Uladzislau Rezki <urezki@gmail.com>, Vitaly Wool <vitaly.wool@konsulko.se>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	Daniel Almeida <daniel.almeida@collabora.com>, Michal Wilczynski <m.wilczynski@samsung.com>, 
	linux-pwm@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org, 
	Will Deacon <will@kernel.org>, Fiona Behrens <me@kloenk.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Waiman Long <longman@redhat.com>, Mitchell Levy <levymitchell0@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, linux-usb@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, Tamir Duberstein <tamird@gmail.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 1:42=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
>       rust: clk: add __rust_helper to helpers
>       rust: jump_label: add __rust_helper to helpers

Applied these to `rust-next` -- thanks everyone!

With these, the series is complete.

Cheers,
Miguel

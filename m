Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465E43AC0C5
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 11:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781783273; cv=none; b=myeGZ+4kFx4881wNQNandzsSbYRejAeu5baBd6rKfrmUbkGKBPvSikRPKNB4GVmH4lVrHZh4zXt9KrBGYlu8R0Gi9tprlOrtdqdzBUq9FotP5h7Dqr6lOnoJ092g2wEyloQOTjLU9XDT5HHTl+XtpM/M4EkXu873VuPXmYXBWeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781783273; c=relaxed/simple;
	bh=W0cpK2StdmVL+ja9a8PSpNEPhuBWL1p2yceMG1dcpr8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gIIticruOWXRzk6dOQA+mBcAZ1XUJkAJp1Ze8HAM0utILadIZFdKPaw6go+aCRMdk9JLodbN0uRGsL3EA5l6j8k97FJqCakb5Lpswg1WxqkqSjnYeCdhU8Yqp6FJ10ir1T1OyGn/EC5sB7DP7ayDdUZ4Mm3+jgD6olWjgcicFJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HuXOM1u8; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HuXOM1u8"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-461a15b716fso422485f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 04:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781783270; x=1782388070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W0cpK2StdmVL+ja9a8PSpNEPhuBWL1p2yceMG1dcpr8=;
        b=HuXOM1u8TYYsLI5JH0ImVny08eNx07ge5UWnepfm5m+zMF+3wdpoKrCrbhPy5ZzNj4
         euvVOI/MsaspH9o/YrKJk8x1Zj1dHSLjlUgrtcp+Yg1LI2RVtPdyFWc900XXamzLLVoH
         ebZWW7wO78QFm6aYfjXrtzrstbQVumVR6kUKD8zDHWXBBgowdfoTOT6qE6+ONIB66cxI
         xUQPe53lgYhYy+TxspcPKnwEFBWdBxT//7AWpjZhB0jeF+hBY5t5LGIxXHGOT4vXmDK+
         Pg6pMRlMXhuvUdMsRlOQXUcpTMdejfh9BMEYdDY7i9C89Gm1AJy8u4sYdXxp4sBe16U/
         q3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781783270; x=1782388070;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W0cpK2StdmVL+ja9a8PSpNEPhuBWL1p2yceMG1dcpr8=;
        b=LHgUgu00u8xfzzGeMcVqJeN0Xj4RaHw338wa2ADfCzksY0O8Co5ZcLxWD2vGYGVLdp
         fOKbmBb/1mCW76NDoM6f6v/EDhAHnjDCWYbLY1JV6kIjWirAaX6l7a1NLxR1kcnwZwvj
         59vz3VFhUX7XVT3lWO6UHNOR2AnOXc385Fjf/KdI8Du1aRkvPyMOgi+QEdS+mDpKVfZs
         OZWDXa9e7mbKihH+NhZAMGaJC+60gvEq2a40LEd939OswYDxlvh7SXcbm8n1asz5HrWJ
         U5dBUhQnQjcZnyuQy6fVNqK4aV/in/oMX9f9lIEUjpIWldhHmNdWe2fjLBem8lJDnTy/
         r6NA==
X-Forwarded-Encrypted: i=1; AFNElJ/qM8DIso+rKQhlyIPlL7YwFSiZo0On5YKuuBTilR0Mkqsk43BzmJj0AOMEo7IQTbBKO86ySeLEyOvMLKX2@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+wRV4PP0Y/cMzomC5U+pcXa8DevbmBWbJL6ZDAy0czeoTPgyZ
	mt1jj1VzKUXjXc9e5LC3H2dGWsVZJOzw5Wwtwu1eEbUzjYLNoUbO1RVEqm44sqToFBUb8KxDPNh
	9S2/L0s3C2wPTpZ76uA==
X-Received: from wmaj8.prod.google.com ([2002:a05:600c:6c08:b0:489:1f08:926])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:46ca:b0:490:b642:ce2c with SMTP id 5b1f17b1804b1-4923a9956cdmr27269655e9.14.1781783269180;
 Thu, 18 Jun 2026 04:47:49 -0700 (PDT)
Date: Thu, 18 Jun 2026 11:47:47 +0000
In-Reply-To: <15e81f5bf354cbe3cde765526762e4ebb3ef6970.camel@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260618095952.3687099-1-phasta@kernel.org> <20260618095952.3687099-2-phasta@kernel.org>
 <15e81f5bf354cbe3cde765526762e4ebb3ef6970.camel@mailbox.org>
Message-ID: <ajPa4_U_gcxr8SKO@google.com>
Subject: Re: [PATCH 1/3] rust: sync: Add abstraction for synchronize_rcu()
From: Alice Ryhl <aliceryhl@google.com>
To: phasta@kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	"Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Lyude Paul <lyude@redhat.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Christian Schrefl <chrisi.schrefl@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	rcu@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 01:40:05PM +0200, Philipp Stanner wrote:
> On Thu, 2026-06-18 at 11:59 +0200, Philipp Stanner wrote:
> > synchronize_rcu() is a frequently used C function which is always safe
> > to be called.
> >=20
> > Add a safe abstraction for synchronize_rcu().
> >=20
> > Signed-off-by: Philipp Stanner <phasta@kernel.org>
> > ---
> > =C2=A0rust/kernel/sync/rcu.rs | 8 ++++++++
> > =C2=A01 file changed, 8 insertions(+)
> >=20
> > diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
> > index a32bef6e490b..9b9addf8fedf 100644
> > --- a/rust/kernel/sync/rcu.rs
> > +++ b/rust/kernel/sync/rcu.rs
> > @@ -50,3 +50,11 @@ fn drop(&mut self) {
> > =C2=A0pub fn read_lock() -> Guard {
> > =C2=A0=C2=A0=C2=A0=C2=A0 Guard::new()
> > =C2=A0}
> > +
> > +/// Wait for one RCU grace period.
> > +///
> > +/// You typically do this to wait for everyone holding a [`Guard`].
> > +pub fn synchronize_rcu() {
>=20
> Hm, should it actually be #[inline]?
>=20
> In C nowadays usage of inline is discouraged ("compiler knows better").
> Unsure how Rust handles it; is its compiler different?

If you don't mark it #[inline], then Rust is going to generate a
function for the Rust synchronize_rcu() wrapper just in case a module
wants to call it. The module might still decide to inline it, but
because there's the possibility that a module could choose not to inline
it, it will generate a wrapper in the core kernel.

For simple wrappers around C functions, we generally just want the
module to invoke the C function directly, so #[inline] is good here to
avoid the core kernel function.

> Moreover, this would be an opportunity to change the naming convention
> to rcu::synchronize()
>=20
> But since Boqun & Alice are pushing for rcu::RcuKBox for the reason
> that it seems desirable to explicitly highlight that that's a special
> Box, I guess we should be consistent with that and also have "rcu" in
> the name here.

I prefer the naming of synchronize_rcu() here.

Alice

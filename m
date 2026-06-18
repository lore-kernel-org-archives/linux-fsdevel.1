Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5A03AEF54
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 12:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781784018; cv=pass; b=tA9Us/Breshu2PCQmMTZwXD5TeXXIiH8HYlYk9jLiCgo3H62djwPhbkJd7mgFWGc/A5048T7mUk3RH00xTl7IhmUHQlAMe/kM+3gY0O7zN2EyfHPMLeZpt3DVaoSj64AMdGZzrv0ozSf7A8DMYGpt+8ocd5oqQdIUOrFxJ6MDao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781784018; c=relaxed/simple;
	bh=81/aNoi63Unr0KciRRcWD9mwbhnyiv2BKpKkKoXYCi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cH7W5E18mB442Zqw2qNR/WsMW2dkE0lJTWhEYziU1heRZfKeg+wnzO1nTJu+BLV2k1P0mcCYJLpXAkd8ntqakhs7cy6QDhTvEDGHFDZhknkxUInAE6iPgAEff9RDLQfzPgC9tpwC/2KEuNRJ9+UTD/xwbQxM0QG9sKtsk13tx84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CXj4EsVW; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CXj4EsVW"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-464192ab2e1so379491f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 05:00:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781784015; cv=none;
        d=google.com; s=arc-20240605;
        b=iEfD7d/oyNV7mjvUEgFezpgW65R9bls7mwn2Zcqp1KTFjQ0DmsKsURFWM8JzLLWh6+
         t0GEYY5PVc9mZYFgJHOfZkUbz/24AbaaTDBZX+Q7tB9M+V3xqfbOKYr+fK7Pg/UOBPkX
         uvvyMRHdWgSwFs7TXOmdQwHfJf6rfdYBnDg+HJ39UUAjv++hErk3AUg7O3miEZzcsAfK
         kItspSQj0ACwtsPv6/qYrY69a6r7bdIwruXlRJYuwMkCNuLj30MuCFt//uuvox0DVAiC
         DsR9/ZMjzbPacJz9F6qwXckRaOxnYWcQ7eQDI1qpRfyleaqsiGf3HmdXDv0uo6rURssP
         lHLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=81/aNoi63Unr0KciRRcWD9mwbhnyiv2BKpKkKoXYCi4=;
        fh=ngFRhGb+TOjU6Q8+dQdSOiKUPTdeIMICfV8KCFShKQY=;
        b=N32ryw0Rj50vw/gN4wJp711YiL9o1pSOe5GQvMLJg6UpbnK2iKyYW8F9nD2T5ys18D
         GW/DghsznEcdjUmzd2Ygg9bHHQfbRSTqDkg6LmhSaKMDX0RlLf0821L1RFf94Z7tOwUn
         iprw0qrNZ6P3bqjvmQmY0QpAwZ1QqmhRWnuEh+QIv4g5OQMkvxwXmWfq8q6uqlTHGL7t
         KA0vwNSBW+RVnl2m4QcUdGao4gVPryJZc27aVVrvkvaq1sG6vCf28gl6yOf4rk6VbBik
         sP6OXhAq0HjGk3WgCnbFdUE228RAeB1c/b5QlL0YjrBLyf2FqY9dK85A8yOqIomH8bwA
         2+lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781784015; x=1782388815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81/aNoi63Unr0KciRRcWD9mwbhnyiv2BKpKkKoXYCi4=;
        b=CXj4EsVW5Lj0uU0EJbHTBAuU3OVNbBjl3aelrrW/DeZdhik7/Nvh8ww2V1eiMH3RVL
         cqXQRWowT6CZ15VREU8g23utiQq5CcP15kSXtg5+uEaX8FcxvNy/O+xLVX0vVNkP0fm9
         YiRaszhUDqc5nHTGdZnY7sMsEP0Yok5kZ9qXHF12WSAKhIgNM3s9z9bYlEk+esmEDpiW
         pj6JyX4hjNQXdmsYcRzizo3cFYHXtUls9KrGzNNg4y2H1tiKbLV8HOIVnP/FRsMPv0sv
         66a6az1bIOK+2kQwWkQEXDABjBnk889jcfmZgzdFqeP1Xu/+X1fLJ7jSfBfwZWLvTRnk
         /zyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781784015; x=1782388815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=81/aNoi63Unr0KciRRcWD9mwbhnyiv2BKpKkKoXYCi4=;
        b=I418o6sL1j9w4N5IGCgTZnZVpqu5Btn/qhpYBpf9ozm6jZR3WEfDw9X/WMOr8mmTqG
         alu8Rp10UzFAFnFEQFq7cTHKHYHFE2grY0d+ppHvQsEg+EM0cuzzb83Z2B8p867ObRYi
         5uz9WY0xMLhgkpTCCZmYWe3YHzoDLzW27mRQ425Jk3jnlHfHmyjaMbQxkB1K71UDV/mn
         5V0GBqiysW3NSXtsIzprl58XD5B2NW3n9Hb+Dn4Fm75Advlflw1wbOUYwdlkPFnKAMGf
         OTRYZG+2mJIQvmcUx5C0hupdQ5iLoaaqgpAHfaDKK0o0QOV+XVDX+s3IJ0SRkOHLdP36
         ulJw==
X-Forwarded-Encrypted: i=1; AFNElJ9OIJs0tzrHxMrDOGfjY0ysW3dn7zQsw258hD5eNT5muWj/Ka4g1/bknU7kLMeV5jBPjxFSetW5Mt0NV4NK@vger.kernel.org
X-Gm-Message-State: AOJu0YzOA4XILMT7sAvZew1ZMNaByOx+7ud9P8M7l8ZwOwF52O/o6u/o
	CNIHYe+PBzi39r2iDU/oeSuNXWLDDjm9QoHe12FXeG95mgKxik9yKDsmTWr1GKi2PuZsSA5XKhK
	X6RB8XTubOq3X/TXdZ7TimROk9sWNFeWK4bxIUB5O
X-Gm-Gg: AfdE7cnvZhYMrhHbeSQV18vk+PuxpyelEKIhHMQ86crbnHkyjJpXh9oHFqbLq55PoCM
	0ztLk7+6eweRk1SfnvYiV1P04/JLJam7p+mzyKqHzV2UNhTHNReVwi9hrmOHmrRQWNbUc8SE4Vn
	sV8W5Cva1kMmG5pGeyn+FbYMPOQx2p5TCsmblcdUNx35ktAjKCkpuwFXkghA1wvG/PuTldTuH0C
	2Vgf06Pf57EMv7MEAB9SfwdHMyn0CYAEkwwBBDVqtuyFKWy5HwSEbFwXQoRmssWfFrDuht/ttd6
	wfVrsuuN7iq9W/CnqFtnsMyY2ipDABHqgcip4EnPwhiBxazmrLEIVhZYaWg=
X-Received: by 2002:a5d:5e8b:0:b0:460:efd:c682 with SMTP id
 ffacd0b85a97d-463ace19026mr5485479f8f.24.1781784014317; Thu, 18 Jun 2026
 05:00:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618095952.3687099-1-phasta@kernel.org> <20260618095952.3687099-4-phasta@kernel.org>
In-Reply-To: <20260618095952.3687099-4-phasta@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 18 Jun 2026 14:00:01 +0200
X-Gm-Features: AVVi8Cd9kHkmSQPgeBR6CxVVcsbl0p2YKmtPm8wUPVpL_M-iVZofLftfM_oENK8
Message-ID: <CAH5fLgj+-Y4XM3ev8cCfes0Qow5Ew=cmyqbPqog3t7OgDNPH1Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: sync: Use safe synchronize_rcu() abstraction in poll
To: Philipp Stanner <phasta@kernel.org>
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

On Thu, Jun 18, 2026 at 12:01=E2=80=AFPM Philipp Stanner <phasta@kernel.org=
> wrote:
>
> We now have a safe wrapper for the foreign function synchronize_rcu().
>
> Use it in poll.rs.
>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

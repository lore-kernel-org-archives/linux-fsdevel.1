Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7262E7375
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2026 07:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781853590; cv=pass; b=JTnPw7A7vvn2aMmW0f/KBFin6UDKbx9l8vVAqXepkpqdd6DeXqvVKcK5teQc6s9MxjbSu4fdUHiP8hGUizQ/Cr4kuyAb1i7OQb6Kg5S3vXb45P5VJd+Uk3afsqo3HLaEZVTlBrTvXvxImODeBsvx5nz3x7F5WSxJL3go2GHV7Y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781853590; c=relaxed/simple;
	bh=+88pK79ZKow9Fb9mNlK3YIEu6a/K2Bzmh7PdNNd4HV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ym/rLAjL0IcQPJ1KurF8Q3jk5bdKU5ZSkDmMQNgVfrPsBfr29HRv9rCC9R6KHZS/ZFoBdcycuSLSD+W+oOffoAm0DhJSy5HvLRt45PKLElvI1gVZu3qkPJ9/io1p+SV4XdBwlpsnJ65NgZLuuj5O/FRkK32DOKmYyVD9FB5eLWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKQ02m1S; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKQ02m1S"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30c00d41e91so118378eec.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2026 00:19:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781853589; cv=none;
        d=google.com; s=arc-20240605;
        b=R8tAVkLkuC1r7Zt9X1+bK1WVVMmxnOTgIeexdFETQTTa03XXcDfVJP1NBAXRY+xTCg
         18D6ZGMm7KasoowKHLon1zqtiyzSb+/rOBlguBZP9+fpAaE60PRVER8rlcaOyonump2R
         TZ+T7/zQ+mhko56cxqVsatKShTfW9UiNbn07Zi+bmqNsP4gapJksLh3WY4eH692Ygw4U
         Yh+GvZk20DB415UjPos2hxMj+rBs2BgvZmIOMamQM6zE+U7Lsk4xVNTpSbKwHKbPPX/T
         Eu7P6LvRksQ0u8i5sMTmbGU1udt2TVJsgBDJqnA9xhygn85aOTd4eqlSgS3tOnC7Akq/
         m4DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+88pK79ZKow9Fb9mNlK3YIEu6a/K2Bzmh7PdNNd4HV0=;
        fh=1Gaq8NzM7Ru9Y0eyq6LYfhby8djr5yu6/J0F4tUmYzg=;
        b=QAOMLcYWO+37PCaxk3D7XMtv9rzbD9j5AVIVB6oYjrGdBpX168rzj3C4mrlvAlY1Md
         t2XoqwBLY0u3crpqBQkh5W65WMLsCbi3cQKM7KYmA2esvJphesURRZM5YWGOWM0tGz+j
         r5OBswa4FkWmVQHBQ2gtKWONEFLL3gDMnkV/qpWZcLlAgg6O2bE3hx5g/DhLj4tP90JA
         FU0FfLt/FZt/aIKffAL4uiZoS/zOHBXFPQpp7bFGo3nC7Nw99okYRWmpDdtxp7Trmn1y
         knVHQUICpM1/WN4lD2LqzkSZQAnUGa2h22CC2iHIVsgIcKY3MFtZ12fjRR22LXR1WSe1
         AX2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781853589; x=1782458389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+88pK79ZKow9Fb9mNlK3YIEu6a/K2Bzmh7PdNNd4HV0=;
        b=eKQ02m1Sq0SOnDgkLzDbAnMZBwm0XzXFwHJL7PwP7fzF8HoTl+pdrl1h16JPyU0KbV
         /2TnY4O9qU1U6AJmMmgU6hJVc56jWip+JZj73R5uXQm7Cr/2xzymbRGuY9gc2A+XQ01n
         5zAVIsNVedDFi6DAX6BYx3Ior3k3DUdxycvlrWNdjajfuseX+R4mc1RBOMk6+7A7P+8Q
         RsY3qYnvKH+MfhR7SG+frWECLfoMMARjG8EckplBNVeYxM9/8Fmm0c0fPIINSmS2f7g4
         r0sl9F6CrVusoG54fJwhlYBkTGwbCbHt0mLN7Z+V6ZHkRn95Jap2vPAS+mmJic5NpPL2
         m3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781853589; x=1782458389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+88pK79ZKow9Fb9mNlK3YIEu6a/K2Bzmh7PdNNd4HV0=;
        b=ghztyki+cLLVo66/E/6eqr3jcaRdYzX6hfpw9Hgm/tSXE4snYKhlA23kO7z84la5Y9
         CmE45oVZDsJuH6yFiwQ0qZxVIDxN17MTQnGGxEbVAnj3ycbcufXp4oz6zswFeHt4O1Xp
         vsI9mA0Z9KWQC71whnsfBzRMB/xXwbg9IAltv2dnbhduog/LtmH9tRdMRdegrnr4TstG
         ougwva9+3xmN0I0B7dr3NLL+48p9dqKQgPMiA6/bp1xSdXYtS3uIKFehqcW6CFVhNVIK
         UjAEQES39RHYLD2K6j3oFkn087EE+cRwjaC+SL9zX0WqLO1VXHHBLHggU5tSN+N+qCtp
         oK3A==
X-Forwarded-Encrypted: i=1; AFNElJ/IlVgLAfp3tblEKPRaMA1fFEAMNXuylXhqXLYwf1ooVU0dgx6AllQ7awpoBYoSKkA+kTgur5czFoYBY20D@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvp4woDMpOXP9NQ7VCiP76XaK9+4icKRkLvtroQNDH1mdswB7N
	3xLnhTVJBIFqsMh6QFnnkK/GjvADYXP7IPyp/K7VhkkSkqyWBtwQgjM5LzowhHJR7yeToNmjXlJ
	0p5u2VYF1pROEARnFxni+PDftBy/ZNzE=
X-Gm-Gg: AfdE7cngTIfeFwKdRVXvnRbtoTp8gYGZ/g9Cn9uBvINtnTQJCm+w2RB2wKZJjOe/4Vs
	WGbE5ksKTD+NN23rg3qnGXFTh/Xiu2Sy6UEjMXrLIIOidZngTl6jZs1soPUbWCXKv9IumknkTF4
	L7LjfRMlgRS9o/eAchXSdO804xxS5+uJ1an1XYg/hSL/X6Jklgnk1yO5V0lhqoiJ/QpXEzJ5aRJ
	1nL/hxX9Qb2Kfy0M/JAPkG4VCrTdMj3FRlV88xWqRU9DIUg7aeAhzcG8WDwclfDAw1Ls/d7OD8q
	11EKz271k0Rl7tOZwYW2a8fyMBw59I+H0Pk4macohQklabN8tPDwJoPyBp2SCMIUN8/T9cjiM92
	On6xQfowTIUj3
X-Received: by 2002:a05:7300:5b89:b0:30b:6192:5b9 with SMTP id
 5a478bee46e88-30c0704c252mr782252eec.8.1781853588746; Fri, 19 Jun 2026
 00:19:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618095952.3687099-1-phasta@kernel.org> <20260618095952.3687099-4-phasta@kernel.org>
 <20260618181142.200117-1-work@onurozkan.dev> <c449f26e2283a2df6d5240879f85bee1b2fd4c50.camel@mailbox.org>
In-Reply-To: <c449f26e2283a2df6d5240879f85bee1b2fd4c50.camel@mailbox.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 19 Jun 2026 09:19:36 +0200
X-Gm-Features: AVVi8CccBt9yDewoCAnVIMsVlxtHnVavxuQfjS-nEO1450uuf_IE5qGPi-jNBGI
Message-ID: <CANiq72=HzRRMNZcNfpZBPmefo=LJ2ckSk=gQS2=XjgnRQCkjRg@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: sync: Use safe synchronize_rcu() abstraction in poll
To: phasta@kernel.org
Cc: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
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

On Fri, Jun 19, 2026 at 8:56=E2=80=AFAM Philipp Stanner <phasta@mailbox.org=
> wrote:
>
> Was already like that when I came here ;)
>
> But if it helps I can format it while I'm at it..

Yeah, we are trying to clean them as updates happen to them, i.e. to
avoid adding new ones in the old style.

Cheers,
Miguel

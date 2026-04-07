Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DF8363C61
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 20:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775593400; cv=pass; b=MthcvYu0pY25U1BnChc7MhKkgLiWo4ZHJKB/Fm7hBat2WDvkEaEnXmx1Dpg+1WQXx6Z4OfpGpPWlDjJUPhQBmmcOdT56sE9pkm55jCIRZ1aue7HwZ4Hal6FixXQRKf2G1y9LCfuO5cprrk64P026VBMPZckTndEdKdA+G+K615w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775593400; c=relaxed/simple;
	bh=/vo8Ho9uK7QNdoBdsxzXkL/VUAV5uKB8HFsyFKhwoOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fb8d0NhUVWl15A0yIuv+6Y2raKk4tOmocPkAZrK6+EaM075sQMm1nvO8SPsafOg9oVX7RW5w2cWCeBJKWYIgBHh0HjzZHzUbmjJyuqDYzce2GoPj2tp5WWaFNjIq6693be8Vc2SqkC3edQ9WVP7i4WOl7P9+oNJnnVY6GQr7DWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C9ShAHrh; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C9ShAHrh"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b886fc047d5so831115766b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2026 13:23:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775593397; cv=none;
        d=google.com; s=arc-20240605;
        b=WTCR4E2MaYwGTeqGx3ATlcm3Np0N5eNns/Phxx0NN9vieeCh2DQlbFncMVueObCfrR
         MaBkEzODwOD4hnM04VTX/3c0Nx9dmk6nE/sB/VGuBjeBVxsq4m00NaCb57otFWhQ6FEv
         1lAqgUrToAt9E2wcbIzGf9DG+lTMNraNwdWO4uMUgPAVv6uTigSfr3Jo0X6/dEoJk4Bx
         Zkj31mw8M48/3ynB6C3ObYwlbXNNV6bq9LO5OJwBgjBZdgdemP/EbaY+gCpqNUT/DjUD
         wtsVknLIUPKVkn+5mw3v857iBR4Yb6Vl6lEmc9ZwQd5q8SPqytlCS06e56v3ui/Gj5qV
         jpBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZCx8twqJvR9nn7bLFe0MWiBT1PMklf9crqW/etIEYlw=;
        fh=aEf7Nn+X8kUT7EtMS4lqm+/B5AunZHTH6hiSOYAxAhw=;
        b=BsnS+WBafwEIabHHYr5gLpKZYlFMdVkPE0MT2jdsVCPa5lunGQnND5PGpsPwqrsb3m
         2AKkgtB76+ALtVrdj2/+FQ7Ecz2lJ1RAH/oJJnymma7NH3PxpkjSGkdrJXC6nM1fLfWv
         pDJDBq6VqIcmJOe0AV50SzHKl4QECoMg5DtsKiQIqmOA+nHixqwfbDDzAIcXDZue4Wvh
         98r41AuEw0nrg0QdHD7uTZqCXTcA1HUNKb/Jr8SBLTkMQbi/qCOxEHf+Xg4ZWBe4cpb7
         vKUIqmea+CHD9tRpnp/QA1lgDrJB89iRkeppgdwdhswdEE4T14RQsM4gvW9BOyLuDOSS
         349g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775593397; x=1776198197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCx8twqJvR9nn7bLFe0MWiBT1PMklf9crqW/etIEYlw=;
        b=C9ShAHrhqE76X97cIBZf5dHkbyR9lBkcPtM+Vqw/Bvk1yZN3HIKf1hCEQr3YmNY1N7
         Zx02UaezcXaHGuceYyemshxBMYz0Q/bbb1pB0Ex/qlRtQLLnRiNAUskOnqDjFEGTLDQ4
         okgc8+lIi1gAObQ0N7NcDC44RicH5dBkpoZNBfyWaKZ1eiVD6Fe9YLnXQyG3dbxfesl3
         T/tCW5VB3BF50RiBp3tqT7OqZgdo4+quvZPicECm0I7YroE9ExG/CcU5hrRb6xkuICaX
         S1g06lzf1PSG1V3vxwuibGeD0kj5OFskWhQHFaNph4P+Q0n7ZLmU1xvD8dIApmw5wMaQ
         TpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775593397; x=1776198197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZCx8twqJvR9nn7bLFe0MWiBT1PMklf9crqW/etIEYlw=;
        b=I9MKNGsJJb+vEoOVM3dCCSl1PT9SPicfTVfAAXrto80Vz1nAbQ/2Nla2qtH7pYK5af
         r48jxddDweEiFolyHEHbklE+erUbSFkYUVlYpzr7EwJjuBupB9vqaegzykcwNp3SmeGg
         uVoq3+odYHW9At0olyd35d6IaQuSpW5AaycV7Cnvow5nVEF9HzDpp6zGutWXxuT7SVXm
         62hQuzHQqg93Cnln2JIzI8rui6FQYj5HuWOT+sosjVSYafg4UwUy3TgkEmsjyI1sAMX9
         phhwkxd4NwY2hQGAWN/TVHyMzDC16lRrj9eaYt97QtWHsrmUxfLXzuJHPTLGDw20mdtN
         U09g==
X-Forwarded-Encrypted: i=1; AJvYcCUzNMgSC7VdCnYm3j1hHQ/FR/i9c40amdd26zT0FSjVZ12zVOvK0JrYynKKjsidJnIHPcq6DlhneEILC1Ne@vger.kernel.org
X-Gm-Message-State: AOJu0YzSBqaO53Nmvd5cCcn/i5UA1gRdAn7iCJfE2FRQLIKFFKF+AP+U
	EADeRo4gY5n9N77zbWXpen0++SI9UiKj4Oh68CfkXyMho7BzaugfkI06/Srd74YUANkWUCimhSn
	n/LUlRcPP6iOgjX2ryTwptBhAifA56xadyAYNHlo=
X-Gm-Gg: AeBDiethOiA9QaNHmzW4UjPuhjc18XGkxJyaH2PSv4AkryDfK7HME6pKSOiCdJGoOQ5
	qTCUfQOUmw48bJMxPMjhhlwNGBgQSN8wClSp3iW1cO17+l4fElaSvIM+lWlCshJAkAQ6EmS53Cl
	JCAyaUWFzLvVzJZBOe5wANAvswZmhwhifK4g3ErDA6SD+VUCA/3zEKMVsX23hWP2RsnOVsH5uyx
	iq0e9r8mksITI8Dd84xTDre5gBFOkVvfsxLwLv+pSAMmnsWRADqX5mouQIrWQwHT55KteJsrr7U
	kxCHaXkC9KZBdnhIUa6Xv9dgtcETSJ2M/JdM
X-Received: by 2002:a17:907:8703:b0:b98:4c58:f499 with SMTP id
 a640c23a62f3a-b9c67957ff5mr691793266b.28.1775593396835; Tue, 07 Apr 2026
 13:23:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407083219.478203185@kernel.org> <20260407083247.965539525@kernel.org>
In-Reply-To: <20260407083247.965539525@kernel.org>
From: John Stultz <jstultz@google.com>
Date: Tue, 7 Apr 2026 13:23:04 -0700
X-Gm-Features: AQROBzB82cXuNdt0Ng1iSzJ-7D2GJGPn4Rejnm3RvPTfCJRZuUw3Y0MamQBLYuk
Message-ID: <CANDhNCo9QZKoEwX0r8JeP_8YTSvKg5ENTSw5Zjj9Po-FywBftQ@mail.gmail.com>
Subject: Re: [patch 07/12] alarmtimer: Provide alarmtimer_start()
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Calvin Owens <calvin@wbinvd.org>, Peter Zijlstra <peterz@infradead.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 1:54=E2=80=AFAM Thomas Gleixner <tglx@kernel.org> wr=
ote:
>
> Alarm timers utilize hrtimers for normal operation and only switch to the
> RTC on suspend. In order to catch already expired timers early and withou=
t
> going through a timer interrupt cycle, provide a new start function which
> internally uses hrtimer_start_range_ns_user().
>
> If hrtimer_start_range_ns_user() detects an already expired timer, it doe=
s
> not queue it. In that case remove the timer from the alarm base as well.
>
> Return the status queued or not back to the caller to handle the early
> expiry.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: John Stultz <jstultz@google.com>
> Cc: Stephen Boyd <sboyd@kernel.org>

Acked-by: John Stultz <jstultz@google.com>   (also with Peter's
suggested name change)

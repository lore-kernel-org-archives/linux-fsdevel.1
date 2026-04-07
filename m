Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD6435CB60
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 20:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775593196; cv=pass; b=rUB2uRkTT3LSxRfZeQNKm2ETKa5wo7dX6T9ki2zfV6z/nPTPVuhue7fxMlb7XfUJsPH6kqf2KXKxFfkMZ5wfv830AtFj96G0SuVjSinzI9ATZmf/9gANQWJSD4jGxXoxZpGwfUx1muWHV+Siklw3XnoKJm/3FEZSjkGVkq9fEa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775593196; c=relaxed/simple;
	bh=cIcwh02YeJrScNHPq9X6XdHj5CJSHTdteY/DkuKKTzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AuCwcT4cwjgxMLDzpjDvRsAE33FfUKo1m2Bxu09qMM1V5KjtIuXCa8JibdhjT5GzTWDNZAa7YptlALL3j9AWloWwzwDZiacj2DwKOITWHbBbHMa0Lpeb1AfvKPBPhhlAE2GMt0QHasz3w2i9Ao5yQc1c8PLSAGnUc02+e0QsVMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CJzTthZs; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CJzTthZs"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65c4152313fso7153904a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2026 13:19:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775593192; cv=none;
        d=google.com; s=arc-20240605;
        b=YruEWyUKKdGA9ysoGV9qNqcUPhdiuW7Vdb+p79xpDHGNEYa6LLcnubIw1QtJwXQvXO
         piqQeorAfXRD3YHs0cqLyqrV03IUyqzSqCjzg99NzU7xArfPKQgWl+bPWRonT2gzmwNP
         tHqc8TPbdFiJmOI8hKOzSwGTGQdMb2SlAkDDWalUzWlEOA+ox3qZpTkX4p0VJV6OQmJE
         tMOGfKdZXuADaWAA+AdM2RodcxZsESxMEMtilkbw7Ivi7WWYEjWSoFX30swbG3NoH2DI
         sPugu5xqfd6pKT3QS9Jkd4fI2LdM1jS+Zld4KQJ+cT5o5OUf/XHrpQoNkSEsS/hWmU3y
         SiUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5F/h7KugE6fbvjgPOHVFnVDYl0H2cgQ8aKqNXa/3w5M=;
        fh=r/7Ft+lb+0m6rxSPaQrK+Ehu5TPwWjvHbKL+zl5Gp5U=;
        b=Aln+aHTuwkxzv05oAhyLFnUY8ftawMCTRntBLnLdoYMhFb0HO2PcVob/2HCbM8cWEb
         wqaYPQngjp35IJOA2OldKxuhUC77bqnsQnmi7Pet+NOJJxfU/nKaAthGHeKrUbhGShzo
         KXsWUYOj6hN9Z034xeW7kpLU0hXDVHxcemacZfLMbBOkra9EcOoNKy+yUtl0PlBMuO3G
         iPJJu4vrSNWQ9lDgNd2sfYGKXkbaoP7Edesw2E9rD+o969CLXTq0pUldja46TxLHNZM/
         FLHNIvbPn4Xto4kKdymP3QioPn3MfAgbqoCdQI7lQjsdWJECLQFhRYUfOH7DMobSiujQ
         CPBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775593192; x=1776197992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5F/h7KugE6fbvjgPOHVFnVDYl0H2cgQ8aKqNXa/3w5M=;
        b=CJzTthZsicvaYDSAqkcV9esA41ipyUSssZax+j3EkI1EusdOVdTk9qmMP3ZzxAbQuP
         arOlA2tVispXM08ee3P5K0LEmZ6LQJYeGm1H07kM9LjI3G7z3U6hPr9qJHiOaZGP0SsR
         voGK5gPMRC30sJqeTD3NbBmDebq4g+riI5vNQrtAXXDwjeb4h8Kb48AB12zNQWRlDVtY
         d8XfTBe20778fIJlFgsjRsiKCfCXKrEbEjY7REIHFBfzwP06DnJa531yrNZXd0hjzI/X
         KC9h/NRDvcU8OrhRRpsFc5jKWCTfO1jCYTUSRwFfkPBafMGBHwZF+71iF/u2uJVvFffp
         rTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775593192; x=1776197992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5F/h7KugE6fbvjgPOHVFnVDYl0H2cgQ8aKqNXa/3w5M=;
        b=sf4uJJthQ4U3xluhRORdMEabU6HwKG7Kkg4ZjQEE0q8oYaklncgFCgHaxKYzH0PUiF
         ELiVI1/+zm7pj8Rkco0JmgpsvbHqkw+eTc8z6CVSXU7LaBRNg8GioXaVk7SvyzrXUEhw
         ceQtT6aM2YPPSShfyAY9kDzEA7j3qZsiEEMI5Q3cY6DesLBwIZ15RDNC5qJVVt8ZoKb/
         JHO+h7QQiGpDqTP1dAwS2b0wcrHrZCGgbA0aBotG5M73VKH9i2sy0HLlKcm3fEcdFyvo
         ykU6HYfNpHP/5AcF4Mzo7f844Y3JRt5bg7jDOR8Uo8foDrJplxEyM/5FurWvn8yrpwN4
         mWBw==
X-Forwarded-Encrypted: i=1; AJvYcCWupCDsjq6Ynp/j1oxGub/joPkL0t2wTVipR2kpx8YzBLWSL2OlI3hRvB8vvYzUz8Am9RGDjBVsKrmVLYdt@vger.kernel.org
X-Gm-Message-State: AOJu0YynhTXfZfJn/z3202G9xu8k2xBU4q+CnvNrF2E6WORGzvqkm6/h
	ayLdkddc86OhsXQuOKbILUQWGH1OAlJeuzzvAyERZCVO3P3n9HWH2220b7YjcK9l7TygncazrQr
	J2idsrEZIwWK6d/4hJbah0Ekwnd64ei9YeMvcJ6M=
X-Gm-Gg: AeBDievme1itk+b2zm6L1UpLylKrBX3NjMtp+6nGgzxIorJBkri/FOJPRJY5MAjTQX6
	0GoT+4sBVS/ktBQdPW1FZYJ9uScSRKrcszgjNYpmgiTY1kBL1ncM8qMgfsNIo6EBFc8qel11dRI
	msVFQZ5MT2JsLosJFxt7fZZLQxK8Negdtoc9pzx2WAoUWYddhX5UY7nhOousAw7nF+z9lZzeXOZ
	rHMLxBxLME7QePGjaaAvoE1I34U/F/7BTSQkQM2Bm7PZwWfKxKT6vAa1eGF2VAbuhFz0IAf8z1h
	TFo1dBY1z+Z2ZzBV1ilF/L0rBDI8WvuI6JkU
X-Received: by 2002:a17:907:3e99:b0:b97:7d03:68c1 with SMTP id
 a640c23a62f3a-b9c67957b45mr816891966b.30.1775593192032; Tue, 07 Apr 2026
 13:19:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407083219.478203185@kernel.org> <20260407083248.035227538@kernel.org>
In-Reply-To: <20260407083248.035227538@kernel.org>
From: John Stultz <jstultz@google.com>
Date: Tue, 7 Apr 2026 13:19:39 -0700
X-Gm-Features: AQROBzB5Kk-9wmWuv1ZegtmjY7I9xuAgB8C2jMw495vm72Eo-cG6s6UJbujlAjQ
Message-ID: <CANDhNCp9TRWAF1EHQAcFHLv3eRusVycTrNDk=UFpzg0oTBjQyQ@mail.gmail.com>
Subject: Re: [patch 08/12] alarmtimer: Convert posix timer functions to alarmtimer_start()
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
> Use the new alarmtimer_start() for arming and rearming posix interval
> timers and for clock_nanosleep() so that already expired timers do not go
> through the full timer interrupt cycle.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: John Stultz <jstultz@google.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> ---
>  kernel/time/alarmtimer.c |   20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)

Acked-by: John Stultz <jstultz@google.com>

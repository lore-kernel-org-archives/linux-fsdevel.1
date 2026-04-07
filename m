Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CFB377ECE
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 20:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775593301; cv=pass; b=pd/0vT5+OLUff0nkHAVvxs3IgySh+wiKGUWsc4enOWUBgNqmhAuYi7/bM76iNNAllRbwptUu30n1fXQKTsU4HJXAjnNSzrgbCfwackLp9kObvr/Cg5/A1CwI9XiDyqxXIZ5x9Z+1Rj8cTp8GYKVntOYClyUYxkziN+mPdXnA+bY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775593301; c=relaxed/simple;
	bh=OJ1tQJvTeGMBujVZAtwZtubFV7cagCryNfAmpVWvX2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aYg4gUrlOFrAXiT5S90B3jJ1XNysTQsKypSCp34+Mz02CYkk2yi8F/E5XFwZBl4ZJJ7RJCaz7GVbJVKr86t0uKXSUb+7/2TkGxkswOtCXSaxwOcPVCkSkA0K65pS9SyMrMQ3yAbuo4g/uga1TMUW8VNyAKWlNtuoU4bV1F89yaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Digbjsaj; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Digbjsaj"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b9c04152730so861975266b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2026 13:21:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775593298; cv=none;
        d=google.com; s=arc-20240605;
        b=TupQatGek0yq8uBnyksZHZQUmTOMY9IoFVZGNVh3zYHIi7N/MzSbMvsgbMBpatJRN7
         rWY+rvEEGyEt+CZ5w0THQrMo7nXbStGLW5yXnxfOfRIK+g/TM4kg1iVL2i3XgNdLP334
         aOs/O4DF2aMlPtHOXi95SRe3ri3VeaCB4O+7tBzh5JguFgpIoVFgJCsxuV+zdP76Aa/7
         fAV2JUs3ZjG3YhxQZgxumiot2UcuF1sJQr6QD7qE7HRZB9MaHzK7CDuM0nspm51oNAYP
         IukkIkQVuF5i/pZTEb1DTQ5vRwwZUlFCvYq1rKbJ8GeCSA9/MTvGYYUjUfXrlHzYWklp
         M9Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OJ1tQJvTeGMBujVZAtwZtubFV7cagCryNfAmpVWvX2I=;
        fh=HKTNz4odChgt7zjSQHyfk2cp/LJHfGAIUfGKEMCb/fk=;
        b=IUAOrmpkunDUB2013DtgzTEi0DQYD6QhAoYLae04sJOGkZJIVaSUK44OP3qFs4ELQa
         rIp/hekmAwHaytA7dNPU5/lBMhAR/Xh+cEoZ0EtljdA9KM+c3E5BVa+5w4m4Dogq1VFB
         7D/zdJ//JoNpj39wUwhcKLPHLbiZqCvIBRuHdQPoYk0EPnAX1IMZ6HeuUZGVFQtk+Bt4
         IL6YwexJyR/lfPVgyTV5YpRt8n11isuEApbEUjow8IYzeu+KfACaqfYycKda0aHzsYIe
         ZBvisOBYIj5bmQGGobn16/Agcp9SYPcJPSqp6KOKIXrsCiJn5qibIyqIyRMX+AHEdVv7
         CCmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775593298; x=1776198098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OJ1tQJvTeGMBujVZAtwZtubFV7cagCryNfAmpVWvX2I=;
        b=Digbjsaj5m93nHOVCFbrS3mEpKIjOF4kS6gA7CWIqEpP3wvyqeZ/dsdw3MIxmi27HL
         VZWC9n+VFO/hCZ3c5zbfPz3WafWZBytYKl8NbTq7Pn8ejMvVECeP8s1DHrLCFz/WVzHg
         U8DgyM+IEaU1tBI4PlQ8DB7kI+czlsSQL0bgKEX+/lLwjTruuJ+J4EtQI7aEqlIopIZs
         5pBtHrWzBBRMy49lhxL6D4ksvk7rueuqlp/8QGqAbYgfnykffsJMEhVqqcKgKbP9TCWW
         aGYogSMDWI5ArIpl8vGQRgVQzrKgMMJibmE543+XHuFjJsAl4lw5hm1G1PjwKwKWXzlJ
         j6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775593298; x=1776198098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OJ1tQJvTeGMBujVZAtwZtubFV7cagCryNfAmpVWvX2I=;
        b=rc0XFox194KvTjRWE0XQWnnYypmcABug9RRZCZH0y5WLFdCx4sIJKwJK1Y9XAbO8LM
         85Q0khDJMp6Nmakhj1+jzcSaJ9sD1ajbti+XhlkpX6FxEskASBhNkGDTswYUfA20IKsm
         RFAG+fY26H/sNFrK+MlNJy7tWT8Hs4ZLoQLnrLIBtCfWCSVlRxit0NJDAh0CQgj/rrN7
         VWs8BFM/JNNn6BBZQyV9+vg/CfTy6I1J6xi1paKMGbT+hbVqfAGCWgpkF9qPxeozDXc6
         URmBYA/KZ8kYuwS7nJVNYOHChY4rH4b823kNXnFdtHUq3sUObp9tzAjPxx8kNXr3rZR3
         2slw==
X-Forwarded-Encrypted: i=1; AJvYcCVIRFjTKhqhqU5J3QgPC12DfrXfWbzolgOC2msd9huWqYSyxjWsErPibgmaBf19A0PBwNos9mCOlKsdUMwp@vger.kernel.org
X-Gm-Message-State: AOJu0YzbXbPzHWxSAi1z/qgHLTBTU7eU+ktkTPLjJAfUn/esG5LIbvuF
	sV2NeAXVgfQyup1jO6SiZK01Uge/YG+hOco227lsW4f1ceCZB/Zf2ZwyL3icuKuTZF0J1YUYDew
	MYHe/3GQs2YuXbDqUnCRfznJivTqonKJZ73IxOxE=
X-Gm-Gg: AeBDietr4kGiDxWSJygZFuqh7lG3bk9Oaes5YBawXrCcmg8fHoeGGbkVbDpUZi/ffKZ
	EWaO2YSZsBqfER3BPjFiWgyIAPZH4jyUWQjxg+jPb5BC277slfZu7Ys5Sr5NI8QgIT8ancSoYC3
	Hz/YsDSILtETEtHzHJpbqdeAy8ICnveTBtPmRMjcQSvk7M5ZGNAz5Flb0/vDOkQexTFiOmVAUYo
	NZSgexelKH3zkds+JHC4sSLr6HEzMm4jQryiXVZHozeuZrPvwJHozrQhbQ0r86r+uCWx4QdL+TD
	xmyHXs6ZCioM48fmx85pGvdyq6fkESBbrGyj
X-Received: by 2002:a17:907:d87:b0:b9c:9594:e10 with SMTP id
 a640c23a62f3a-b9c9594137dmr648296266b.14.1775593297523; Tue, 07 Apr 2026
 13:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407083219.478203185@kernel.org> <20260407083248.303293327@kernel.org>
In-Reply-To: <20260407083248.303293327@kernel.org>
From: John Stultz <jstultz@google.com>
Date: Tue, 7 Apr 2026 13:21:25 -0700
X-Gm-Features: AQROBzC7PDFv8vCtFbIbXkiDn8QPhKuu5um8yGzNerNDgS5PLItAWlJfqN0nP1w
Message-ID: <CANDhNCoTUyvQ_-Vn3neffN_Cu2uwPW36O4CtZLCu2JHPztW8Kg@mail.gmail.com>
Subject: Re: [patch 12/12] alarmtimer: Remove unused interfaces
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

On Tue, Apr 7, 2026 at 1:55=E2=80=AFAM Thomas Gleixner <tglx@kernel.org> wr=
ote:
>
> All alarmtimer users are converted to alarmtimer_start(). Remove the now
> unused interfaces.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: John Stultz <jstultz@google.com>
> Cc: Stephen Boyd <sboyd@kernel.org>

Acked-by: John Stultz <jstultz@google.com>

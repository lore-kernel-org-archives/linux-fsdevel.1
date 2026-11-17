Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936954;
	b=qQyFrALtbkjw3f+CTH1ZMAS4TLgQYPDZqMAo6AG6ZynOh1nOGozwQpkRgXOW+dp/wFkA
	 Gzg+oMlHX6K04oMWmwcbJo610lJfL+ael1k5I/QOUQjQybXjnyE0eSTXEngM0Arb6A+iB
	 266jLSNKCYeHTJdy4g+Z0WbiZis9wjWAWndaVQ3S/6/q0QeSpXfe7AhF2GXVr45BkpnfJ
	 Rat97NrCsae+9pqJ/WoHa6HWXf/GaKKKRarx7s+g1anOjs0iF2keIx78sHkM4NJIHgFG1
	 9A8KJFjyTurcIzJCcOWkjj7SWa2RlcTp4pnvZ0UwuoS8HXbXixJZcr2T0R/LkGT8bZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936954;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Op8k0rbkFHjlj5Xpq160zqvss+WGLpfkmyU9f5oGVbI=;
	b=HRVYhljRxFDEagq8OZ3FXJgIWQE4258D6iF3BqXEJdhRj8Vm0GiSn2AGGIzIcUWZhe5k
	 tfZ7EEPMdbCB9wlXCOEdxMQHUI/0PMCTM9jlZm+3d4U6267J4Iwfb5d5SXEcwrRieu5Uq
	 hquWrIsS4e88N7emrYLARJJavbSzPJPmeLFXbcuMZiFt7XF44WhmVwcf4/ef5X+B1c1y4
	 DEBs0wEMpE2HJmRq/Fc0nVKuMWGh+3mRsJ+BUWTO0r/F4EXeDjs+se4dPOi0iUo/bKPAt
	 aildgi8pnCLiBMtOOSajGfywFBwZcflIT4/LgsHuHY7w9gtqKbQFlRV6Kx1zZ5QhEzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=KW2PcXFe;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C49B606A31C
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 17:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C49B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=KW2PcXFe
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c510a28688dso62284166b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 09:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794936952; x=1795541752; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Op8k0rbkFHjlj5Xpq160zqvss+WGLpfkmyU9f5oGVbI=;
        b=KW2PcXFeCjuxMsZtD0FkUR/nt92huuyMTWju3iKTw5Nimm2U8e4IMb5OdyW3texQQz
         fkqeDZGNclwtWfzAbBLUiT615BZ2RTvv/8B7stcVi1GPkeQakvfWrCabtxyWZ6FJHTb2
         4uzROt6Fu/BQOi5wddMP+fkMw0uqJTQWzIyns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794936952; x=1795541752;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Op8k0rbkFHjlj5Xpq160zqvss+WGLpfkmyU9f5oGVbI=;
        b=Bicr4PH5A6jAf4nUAUFGRHAyVAHY0+KPmXaMs0WT302Pp34ooqUuKP9RGgwqt9rRrn
         4IJOHF15RQdZTc4+vmtdL+aQL9oHkebzL79h4W+zIZlDOA7Cl6sQRDdhPlrrTbyGVbTH
         bBTrAz4JedNeAvrIHeU7pmJwAj3GQaaUP2+2zM+9ObSaS+0VVKBC1coQLwFKWbZemnhD
         Yj4fYF0xope0xpbLmX7y/itQUf8eKYA0c02cXNRQzEZuiXBNKNCxmWh7NYAkFpQJRlPV
         +SRESJ6UG50C05U5RSXlf7wCe/UDm1GYJLHuPxmfrbfvnET6jZJDd1yJnIRoYiwwLiI6
         1Qaw==
X-Forwarded-Encrypted: i=1; AL+hErFIv4aaXMmLBJJEJkya32Lz/88fFT347+/ooGkHxgzKzWGNBUOU5aOeVQe7EG8vnp4vcHjS6i9BbwLdAiXb@vger.kernel.org
X-Gm-Message-State: APuU4Z9z+qCPAeIquuxy3XqdgzLSyMR1KnjbKgdRvsUUGxyMJzZm9neh
	Dr3QN8XuqDtBOZ/pXEQOzrssC8qWvQ2QalZN7MNqQpIZ6LmYrCrfcKMrsfbX8VzC4rQomyX7Jm/
	WNDgYguwVjg==
X-Gm-Gg: AYBFou2LZP3eth5uVkI//jb5RrHd0obHpbw6thXuMe1srH3Prq5vErHozcyX+iAwaUx
	TwVu9GtmrWGfSnvZgkzO5rgnZ2BSLFv4yDIALVEyS/vA2tyYv38DAWmaTb2ycJyppwUfUbyMWbZ
	58EREknQjKpmYtYQQKaZGGZMb6nxL+JrsSiICPCtMKf8JnNtdcwy9M4LjsyoTFKMmPdoXQso+5q
	a+UyFPZXhYzUGslE/CLlrpg6CbUjhT40xZuFstlnswvc8jffnO7HNAa5l5z4OGRBQTMhSDBT9ut
	/rcl6tzDWr2mLKel3JW4rdN29ILQErItOj0rENo9RCihlEio7rBeW1DkVbbLvw3o/nflvKAGGTU
	X80XpUgtwQ2oiuTbEIlsURgLqNsT1vw2t5r82NvZ+PryXbQTG97640Q9mu6GcVtJzWNfTbmlND2
	HAPl1xim6JaSGekVu/iLwaVfUdGbCrAK14gyhznT2GLmcENRpwvC+yX5vT/pIgURk2zB1Jj5m1t
	G3iyXDLzuWysRwFn/OGJX9QFOboLrsczawyZ1d4pQ6EuaZ39WYuXQ+64DgZhbgy7oQRCqIUe98C
	i1rDZ+RFm4W9+tk+EsaryIC6PNmRTIyBBd0hVzeGsxgGBBb8DBS79e85+mDac+xCo6CIkKCMhkX
	c+Ww=
X-Received: by 2002:a17:906:c14d:b0:c26:1648:a062 with SMTP id a640c23a62f3a-c509640d6ebmr1292559766b.29.1794936952502;
        Tue, 17 Nov 2026 09:35:52 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c510cb14813sm6285366b.66.2026.11.17.09.35.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 09:35:52 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c510a28688dso62278466b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 09:35:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHmbwRlUcrGNCIrCOF1VQADAz3VBpFEy/hdVk0BjsSaRZkEZhmZ6D36yS5Umg2p8Tc38te0EJpirjz4I0yj@vger.kernel.org
X-Received: by 2002:a17:906:5642:b0:c50:d92b:6f40 with SMTP id
 a640c23a62f3a-c50d92b78d9mr526182466b.20.1794936951190; Tue, 17 Nov 2026
 09:35:51 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-pipe-epollexclusive-wakeup-v1-1-0af6283e9fda@columbia.edu>
 <avxWKI795DthE8Sb@redhat.com> <CAHk-=wjOq+G=6gte4vX_YxOD_VfE1uZh7=+KHs8N0wU75xyHEg@mail.gmail.com>
 <avyODoFhZ_M7YDU5@redhat.com>
In-Reply-To: <avyODoFhZ_M7YDU5@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Nov 2026 09:35:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgcBSBtHE+3ceKGjq1jyF64OyoEqf5JPpixowAa80GqNQ@mail.gmail.com>
X-Gm-Features: AclHuK_5gKon9D6gpxIEpwE3Nt5zs6NVA-jEDB-muz-aO1jPRcXkbqK0yG36EEs
Message-ID: <CAHk-=wgcBSBtHE+3ceKGjq1jyF64OyoEqf5JPpixowAa80GqNQ@mail.gmail.com>
Subject: Re: [PATCH] pipe: keep per-write wakeups for EPOLLEXCLUSIVE consumers
To: Oleg Nesterov <oleg@redhat.com>
Cc: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Christian Brauner <brauner@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org, 
	Mani Tofigh <mt4022@columbia.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Nov 2026 at 09:25, Oleg Nesterov <oleg@redhat.com> wrote:
>
> So. Do you agree that we can "ignore" this report from Mani for now?

I think we can ignore it, but I also have a cunning plan.

Normally, exclusive wait events always go at the tail of the wait
queue. We do that mainly because we want to wake all non-exclusive
ones first, and because it's fair.

But pipes don't *have* non-exclusive waiters (ignoring the splice
case, which waits for space, and if there are readers or writes that
would take the space we don't care).

So what we could do is to just make the pipe code open-code its own
wait event logic, and add its waiters at the head.

Voil=C3=A0 - we never even care about epoll braindamage.

Yes, that makes pipes unfair in that new readers get preference over
old readers, and maybe that's not great. It might affect things like
the make jobserver. I'd expect it would probably improve throughput -
new waiters are hot waiters - but it's most definitely worth
mentioning.

It won't fix the "EPOLL edge triggered braindamage", where old
applications asked for edge triggered things and actually wanted level
triggers. But it should solve *this* issue.

Hmm?

Let me stew on this a bit.

           Linus

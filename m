Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794937360;
	b=ZuMfDlZ7n7IjaYNnx6wz56y+2fgMpc7rxW1qgIzwAySL9UuPiCg2TuMQpeJWlqI2+h1Q
	 VqnwjGV6jY8AeeuzwJdi6oBHo/pXbADH7CELDEH73lQ3FmO59GtkDyjpJDyMEqO/SwDLa
	 J3XRC7Ub0zGfvaT4O+p81pBleX1yjraD1vEIVvxPLQkPcMaJpIyZbJ1KQiLoeb0360+tu
	 8a6wTLoskLQYYni5mKVyaVEVqtFGI2x//PstS4kQXiwQXQLHAhu50ZG2HCzExrI9TJqRx
	 4J5a0qZyxfgeezQdgL03vkJAPGm1Pp84rlEDNsNnmHEKrZGLj9rdFQf08nKBdnNei1Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=C0Br6uNbCeSZG/D0SaMC7uBQz4y4PQvjObMC5HHmvxw=;
	b=1dRcbR8Em1aBaMxIB5MLW5AAhGDduK/AjMVM7p1H3B2SOmAemMjZ1zE/wZlzSKeRM+Wf
	 Pmep7U6Y6e2HQ9jw2ZqliGT1Bjok1JPGe/QAssAnJX9WK/ZArBasPNxKJp1cCvbTOjSnq
	 LjDbQow3cJKdqpzgU9EWfx2sk+rOqI3dbjIG4G+KZq7l/Fj+EWqCrCnl2Jw5TTzY9r9UE
	 a99l1X0C7jWUJMGDSYx8o7qv6TgcDQqLVgZEAREK+jXM+yvvHyygHVXdB8YjU4iPCqFft
	 zNiNbG26oyRAbI7kLoCWvNQStmnWz/aeDyjiPbyMUwEzsIwP+p5yG0HZk/MvX26WYZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EEvWGAFb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.179
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87930606A31C
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 17:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87930606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EEvWGAFb
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3acd239776cso1622771fa.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 09:42:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794937359; cv=none;
        d=google.com; s=arc-20260327;
        b=Zzpy0bQgXI5uT2ELy+DCNHkzHU79lbKLPHw1QWCIbp5r79JJeqxh9KrlE0ikfoNjby
         t99W5KJu0t2FoIiNfBg3jRMBl8CllWSKiSzdvtwy9+tiDleINwJdiavAcBF6UrZBuX09
         3I96yNzJcoVlCKqUHCs5MdRHX64rSEdY9blMHBAPVU3kz6kPDrFtVJ6SUQl4CigjxVqf
         hczbeSzztcMZH4YVfVvVcADvS1sK4aTPAQ02lp/7wUdwhrLN35wZqAU+HcuQzOx8p1bz
         5wIYCfe9f2GuUDZfNtQBzhJmcG1RQ4KDETQLlftdI8Sco68yjXYGhSPsHYV3boI04Mqs
         K2yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C0Br6uNbCeSZG/D0SaMC7uBQz4y4PQvjObMC5HHmvxw=;
        fh=FppMR6JMyF1YXQa25y6IQk8nx7nob/FsJ1gbH6Zr6KI=;
        b=fGP7Zi5WJtjjVadPHnQv8LyWcc2d4PKVd2erOh3EOgLjLK2trIdcJiUiBjUXdv7ZtT
         ui+sJyTBzrFkLt8KM40SfdyM14PAwxSFmnD4aLqokoW5brOj5sRN8uaRZztxczL/43GV
         DvwQ8cVCs3mrgbUgWY7ijOGqiO1cZE9XihXCoC7Sp8J2dZt+WtG63Xlr2ZhRzt5BIhWP
         ZEU3WrjsIg7P8z9XiU5ytXGF/7JzauSsXmKW5FoR7MbEPSZEudPk2qOHfUAvEq3ZwV/O
         GLDJRO5GK3NnhCJXQ0ulUmbVR4ot1KNuLGlifIjfXP58DT2Gg5Ni/UelFAybhAMU73Hn
         xTlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1794937359; x=1795542159; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C0Br6uNbCeSZG/D0SaMC7uBQz4y4PQvjObMC5HHmvxw=;
        b=EEvWGAFbOmPz0e1bruaOl0rjybH0s4KDHt1ZdsIprIDdOYSYYFkdgv0P5ZbqLm9wOt
         QUKZ38KmXI7yBp+GV0/eyJrlR0x9jaOEr3Ii55nnjpnVrQIiwkaoActJokk0nmQSZd7G
         61WKKrB70e3ufmKjp4oHO9TAABVl1efKkOpBvtOYK6RF6gVHy0E+rjZz0xIx57DanHDh
         1TInlFBGPv/IJYMg1cTj312Sc7q2gHY8Ugtu6+Jpk/LKIOoiULHPpgJvsVB0ghEN1g8q
         2dPQMdyQdgbZ8hjQrp+yJxxt3I0107KE+viwJ2hHYYVk4FGOG+dWGVAy9wgHIHfa0LWA
         TeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794937359; x=1795542159;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C0Br6uNbCeSZG/D0SaMC7uBQz4y4PQvjObMC5HHmvxw=;
        b=eYAIfr5w3YgBnECkVR4YAUnsTDFMabFPV/27uP/W7vcHzI1xNvJOfKnD8jleJpHNpQ
         ZVDmqbgjumlAO14IwzxizEy6YaGCvFprW0+VvpIkMOAkBmshz3PyOwFPkW73z+37F9TS
         zL1HDKjPjzQWqY7n3NGY7LmbaTXAuHZ4TRO0QrvG+CmXZ4vgUTmDSZn+GBEnFZmhluh6
         lzVEUtOfYEBbid3Slp8N9ycUrIgv/kFqLT/IO/0YRSt8wKXDIdlpA03jPIS09ORJP2IQ
         CTNt5xQxfqaypKLSbzfOJ/tLlXgvxazvDr0f6sCK2Tyfl5DXlpwe5yowZDFPyPqOgtJI
         DCYw==
X-Gm-Message-State: APuU4Z8scA6OV9GiN7qqaZBKTrBCrC0c2Wf+a5xg+Vf63itGRPX4PMhn
	pqgBvARhMbu4ivh1z7GPwBU19pL3c0lMWPoEXa/5/836m3Q16uPdOvrKTEC3cm9SAo89R1CiAcY
	vFaJPWbw7/M3f38Z20GwLRr91wjSDLoHYkx2H8mNK
X-Gm-Gg: AYBFou0+RmfCRLh4zzJ9MTv9e9/5F+89HAv59Tetnl1xRj8dJSESuD/ucSU5OzrWlBJ
	FtPIjWuzAxbJYzQognssCJQB1ZxoEjCyvOzwfLRTjjA0F4qiEQb6u2CrGd7tCCRZKaoqPLTto4p
	Xwx9whs6XdpkuDIePq+Az8mXSlnSzdMRLIKSuSo0sO8pBMJdNY8xlWw3OPB4RadOdlJK/Rvo3hY
	gHSZMDUcBvO/qRq3/rsgvbXPBY7gDqaaYrBa4VpGAmUCHJlvfVcjQ41Ruy8zjHuIrvCrHI0spiI
	AZFZ1jdrYnjAb3kVe6tcYuO6iq5HxBtH2N28ZsMUEtSKrvi3im9H7RmhD++KQIeQYlzU4Gqz/Il
	IuouNdz8tpkYhGR8fH3pPYLS0CjPHrLi6aw==
X-Received: by 2002:ac2:4bc9:0:b0:5c1:4ccf:f0b8 with SMTP id
 2adb3069b0e04-5c170a0bb3cmr7252657e87.16.1794937358574; Tue, 17 Nov 2026
 09:42:38 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117050841.3289652-1-jarkko@kernel.org> <20261117050841.3289652-8-jarkko@kernel.org>
In-Reply-To: <20261117050841.3289652-8-jarkko@kernel.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 17 Nov 2026 09:42:26 -0800
X-Gm-Features: Aa3M54o6AJsup2EB_D5C3UIkkriS8wK22wW9apyv8KKATx5_DoWBh2HrH9mfDyU
Message-ID: <CALCETrWtbUFQGDOCHkxAN9O4i29ixfL5KKF1Cqw2-CjxKwC6gQ@mail.gmail.com>
Subject: Re: [RFC PATCH 07/13] rootns: Add rootns_enter() system call
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Ben Segall <bsegall@google.com>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, David Howells <dhowells@redhat.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
	Juri Lelli <juri.lelli@redhat.com>, Kees Cook <kees@kernel.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Manfred Spraul <manfred@colorfullife.com>, Mel Gorman <mgorman@suse.de>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Paul Moore <paul@paul-moore.com>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
	Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Serge Hallyn <sergeh@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Suren Baghdasaryan <surenb@google.com>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Vlastimil Babka <vbabka@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 9:09=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> Multithreaded userspace daemons cannot call setns(CLONE_NEWUSER) or
> safely mutate process-wide filesystem state in place before spawning a
> child into a target namespace set.
>
> Add the rootns_enter() system call to fork a child process directly into
> a rootns whose root mount has been installed. Transition the rootns from
> ROOTNS_READY through ROOTNS_FORKING to ROOTNS_RUNNING for the first
> process so it becomes PID 1, serialize concurrent entrants on waitq
> until bootstrap resolves, and admit subsequent callers into the running
> PID namespace until teardown begins.
>
> Require CAP_SYS_ADMIN in the target user namespace, forbid credential or
> PR_SET_NO_NEW_PRIVS privilege escalation

Why are you disallowing this if no_new_privs?

This isn't necessarily a showstopper, but fork() is really quite slow
in many cases.  It would be nice to have a more spawn-like API
available.  I assume it's possible to open a file in the target's
mountns by some sane API even without entering that mountns, as a side
effect of how the fsopen / move_mount mechanism works.

--Andy

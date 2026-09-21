Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65164E1C74
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 17:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790010014; cv=none; b=Xtgtcd08QBOne7w/sqCgSs1qzNEYPBpRwlnFbvi2JRlzCn9/lTLaR1kb53+EQ8FQrgqKQX4Msoty/qRoDa8LTb/EbKjDmiKEeBwJSSOZ8zvYZsA0ihdjSz2hI2DBDh1xQ6+cqu91t9pRHz9fbVujc8sZbmd+CwnkmzreiGYcXeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790010014; c=relaxed/simple;
	bh=hK+61oik5gsxN96IHn3CnokMCdTIaajwpmg47B7x+JA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nyp0tjzGhip9VxNmTEiCFiw6ZAa3y7+SLIb9kwBARxPmIJxbmp+uROjLmwUv1cM4WtKysszHfW8XID2VSWU3BX2QbndJ5kAOotLCuC5hZhFPkka2vZkS9mhgUa91mZ1BY+I8WJ05BHzF50pEBKQhXLqXuPMWtsCQgXgydJy3OP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f16f15so3411078e87.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 10:00:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790010010; x=1790614810;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hK+61oik5gsxN96IHn3CnokMCdTIaajwpmg47B7x+JA=;
        b=VoUds8auSzniKheqFF7DwQVlWhHYJXy7JGphgmlvmycozL/MkjplNYoPynIHsa2j7a
         1Kc9CW3ePdELxBn2cEkjPc/hyOTJpxK8X4BrzRDmn5EdD4vm03xG6Vlmdd9xZKCv5IAp
         oL61cQ6srvu4fQPNb2mCXGrWsl3H35U9it2EoTQRRKLuT2erG5doM/Agn8PhAZ7Lmi7t
         GcaViUPubPSXAzOI2G/UjjQmnzKINpcfShKuhavFRMAmJNrdkDvNRU0UNN21jtOFOG7p
         INUa8WUnJ/mNDSg+PQToXPrlzHUIpVzwm1OrsPybB+cXhB9FjHjTS/k5kmIOC07Fngsi
         v2qQ==
X-Forwarded-Encrypted: i=1; AKwUvBz9Cs/4+8X8Lp7vMi9/s/WSbpQ/8CBTVzHpm6fAZm2AJMPFkkCG31DOKmz1q/LIPLmkvZsM417Pra4M0s6b@vger.kernel.org
X-Gm-Message-State: AFuF++k6NWd4MjJUtbHGYM/YYaGCPHfcs8XY8WVQF9zGtoM/o6HK7MrL
	TlAg6RQPQdVWgp/b2yM+MohK6N/wNO1R1wT0PStC8Rssi+uHQ2tNf/QohzyUlIwsT8Fz4Q==
X-Gm-Gg: AYBFou3c7o1t9265uFwj52hWEp6B1YoPJxcfCvwKqv8lVxbiUBWSrjRveOCewyK6Bq4
	/fmiFbtT6ev+YBZ613W5Lm9Q/cuXqYjYdwa1ooYifq3D4x9d4o9gPSsqcd/WScErGLa8k7ehli2
	YnxbTqFsMst8Boobbq94c6Szsjl328ebRRaT/bVRRZsQyAgRHZMlZgjgReroYjKBw0EGGgYvapk
	DRKAve6byYzJqk94zPuKdNpHRGsq/iYXn3UFqcNdg67xGiE7RqggI4TBrifM6odlP0QvDA+TYd/
	tQBNHN9UI56+SRO1EUNq74a+efL1g21R+Pp05HNN2SGrw0/aQiKNE78NNxKHb3F9xyhWrbpiOBJ
	t7qFrVMmOb7g/zm8r8mjQtVaoc4WEWykleaVW+uYPdQagVK5wnHJkoPpcZgB1BiQ24vS8VJ0JJh
	aIoQkLWAxhc8oLEpn+YPUjxinB0jzp64348exPnCFscT+TLL5qZeayLaPDUOMzCTj2h+Z1xIfMr
	/nKXHoXCJqp1+x2/TUL6S5v4IhWSGy5X1aaXReI38g2WwKaTIHCdPd03T/8EB16
X-Received: by 2002:ac2:51c3:0:b0:5b8:bc5e:d10f with SMTP id 2adb3069b0e04-5b8c1977565mr3987202e87.57.1790010010241;
        Mon, 21 Sep 2026 10:00:10 -0700 (PDT)
Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com. [74.125.229.204])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8c7944a46sm2154672e87.33.2026.09.21.10.00.10
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 10:00:10 -0700 (PDT)
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f16f15so3411058e87.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 10:00:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwkI6pSeavnrn+Y10BknJeob3zozA8CO5OR4MzOwmijAZetz/CMaF90GZ3/XQF+SM0unJOgZmAUDbGUMJXZ@vger.kernel.org
X-Received: by 2002:ac2:4c4e:0:b0:5ad:55f6:1ec3 with SMTP id
 2adb3069b0e04-5b8c181f45bmr3718755e87.5.1790009663874; Mon, 21 Sep 2026
 09:54:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831-pidfd-get-paths-v2-0-c59ea6a21b72@black-desk.cn>
 <lhuecf9cbl8.fsf@oldenburg.str.redhat.com> <CAC1kPDPu41RxMLHpPtz4VqfkEZeu-fYXG76XVZMh8bbQa3okaw@mail.gmail.com>
In-Reply-To: <CAC1kPDPu41RxMLHpPtz4VqfkEZeu-fYXG76XVZMh8bbQa3okaw@mail.gmail.com>
From: Chen Linxuan <me@black-desk.cn>
Date: Tue, 22 Sep 2026 00:54:11 +0800
X-Gmail-Original-Message-ID: <CAC1kPDMCFoVsPDZgoCF6mHqHQafCkDc3Pohpp6pNOLJzE2OTYg@mail.gmail.com>
X-Gm-Features: AcwNN1U1zJ5xAFsdo7eYagPVPgcyEU2aovVJcIoR_uPclCIazBY4PYSmw97k5Co
Message-ID: <CAC1kPDMCFoVsPDZgoCF6mHqHQafCkDc3Pohpp6pNOLJzE2OTYg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] pidfd: add task path ioctls
To: Chen Linxuan <me@black-desk.cn>, Jann Horn <jannh@google.com>
Cc: Florian Weimer <fweimer@redhat.com>, 
	Chen Linxuan via B4 Relay <devnull+me.black-desk.cn@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Kees Cook <kees@kernel.org>, John Johansen <john.johansen@canonical.com>, 
	Georgia Garcia <georgia.garcia@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jann,

Christian suggested adding you to the discussion on this series.
I sent a follow-up reply with you, but I=E2=80=99m not sure whether it
reached you.

When you have a chance, could you please take a look at the thread and
let me know if you have any concerns?

Thanks,
Chen Linxuan

Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDEF29E0E6
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 03:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774409306; cv=pass; b=GarofuftsDshSwmcrNMh2z40Oj5IBbhUdkXEijqo5hfM5YW+3CK6YgCvEaXqjf0XUMGfgPhLgbUn6T22M4sZgHmQqrIv1pLp8xwAKny+a5IOn/riXmIts/tyIwOlRg1mhcx+0KJWqzHOQNw7qlTVyABE1uELe5ID+44aK+VU4cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774409306; c=relaxed/simple;
	bh=KfOpMhcNS6f88rapmkmpKiOfFBNoVXxKR1Bw0cQUfXs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=o4o6N3fOB7QxeRmzphu8cc4ExzkHUWw2sBG28tK4zioy+V4XY/bT0aj1EXK6ejF3VS1Z5c/UPDe9pnCR5uQyGusEE8HKIzNHKrpGgn1N2ptGtoCaXcE8u6f8jleL7SaWs2InrtJcKdLAwmBjkMQJwNI16ZURPwudS4gyelSXFtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5/UsgaN; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5/UsgaN"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59dea72099eso5606746e87.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 20:28:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774409303; cv=none;
        d=google.com; s=arc-20240605;
        b=k7LqxfGoePWE20XFgPj6gdhJ7frEhTC2SIER7ZkRD+TWkmz10+D+QEOydZpGdslYRT
         yjY/uX/1U0wog38Z0muapdckIc8JR/VHamJ5kzRW8gdqdY7mT2M3fOqUAaEs6/EDB2Ib
         r0jh5hShS0dO9DyYoYYJp/oyHnZRY2GLWxcpYwv1ttYXrnv0Tworr0lgXYLcIWQXc+EH
         nZLbk8e6R9jLO2QEswGeSOalvke1Akk374iZ6NLt1i4CBWoFew+OKITM/QeWspzKbCVy
         tfjf4HbhM05VYtohLIez0krpwQH7rEnVP8oDrtXq5nVXZ8gY/CsO285I6uApAZx1Y1Oa
         dvWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=KfOpMhcNS6f88rapmkmpKiOfFBNoVXxKR1Bw0cQUfXs=;
        fh=on5so1iZ1tYm751VXv8x5u+l+XerJy9A4qWb/XOx/D0=;
        b=AX3CCDtr3OJghackDLPZ3Do/wBA3NsL6hlK7fqEia2bzTabPjbR9vkKpiSqm+sFKSm
         Bvm/PRzpllRmo1rT4WXqy27h5ve70eTRdG+jJ4aCm7D9Bma2dDLP7LH58BUT3mYa/tlD
         +aXVwQaqFGvE7BmSfxK7kK2RMm0DO1qhj2cjYcUTawXatyddghS1w1BXIHc5DXAMEh3j
         QfQF7fmaZ4SFNmhxinfhbLKPLmlFiHkTCS5CaTs64ACBlPkR4zwDje157XYAm66ahlGj
         6SJHErThcV5JlchHx2uaFwh6yxZ1tYfqIqv+AlJ2JuTTEL70aHaRh5mqeHHdpo/ZkNC/
         EsCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774409303; x=1775014103; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KfOpMhcNS6f88rapmkmpKiOfFBNoVXxKR1Bw0cQUfXs=;
        b=G5/UsgaN8iayJMP8eDGORKwFdk/SzBdWiwfQ/d3iehmzDEosrdIrUeQJa0VQAUlEc3
         I27cR3DRa7U5khbKitWup/GPiABN0LAK1mrkmrtFx1DeebOnaGKQskUAFeo++HtWXIJ8
         bgU9oKGgEljX19sbcT7edQG7FSBfistXv+yenky1eg2hpEKt+pVKFDy/2yn59mU4KuEi
         kGEfTnMF8Nv5VLWtwdI2iBT02YVGKVim8pqBhAaICkmcg79FveXjBKuw6hp89nx+Y27q
         uBzMb1oJJoreA/xTvegTNzA/Dory+oOjXobeVmao9heJfKhmFDOVwaknLyhubFG8p8po
         lk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774409303; x=1775014103;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KfOpMhcNS6f88rapmkmpKiOfFBNoVXxKR1Bw0cQUfXs=;
        b=NGXg8YiGSm3Q5bmUdPo9qky661AX8qB3H1UqBL73k2IAunvhey1UvN/wI70j5EDF59
         3KYj8d1okrw9OV+QV4Y59j4lXGdt94cttwp7Abv0D7FLyH/+7YhlAKqXHd45RqAVM7Ny
         d57E+5gM15gxPQbJnii+IjwtNyNBcOVqEzGGF6qhmDbGJDr04Vvk8R5bZiRRmuHU9+8A
         S6IV0xAi8j+bEU1bWuU3GQLdSbVNfeSQyyJfcPNRRcujpVCoupfo74yJVK29n8PK22E4
         vPzsGgWCv5rQYfr50yUlzKeYUYtVtZgc/HUhnN4kSXdw1SMI6/IN+m4KE+BvEEx5d4DG
         AhPA==
X-Gm-Message-State: AOJu0Yw9S75B9IYS60NLZFODOH2ZKIhux8z8E8LDC1B2OwXy1silNODX
	0MmI5wyVMqK6qP+eDgj/SQckV9bjInR/M9+hb6eT/7bGlDnjz/29PWpBgtsVoQ1a7pecq2tTU4v
	3v2QHjLubAacpqLgZfCm64rO919DUpmJZxQ==
X-Gm-Gg: ATEYQzyFAFzpnsbzSMWm5oysgv73emcS0REteWVra8kf3G/rR6L+mcqGW3uN12nqkmf
	M5KHE5ukqyaJDgYFu9AvZeJK3QrXeSzWTkthI1nsSH7tL8qjrQFKzTJSOqGOv6xb19p+Gzo0CGP
	3GbLpRNUnGqENX3ev1Xrwc507pI/LuiptEnfJNtvGGozScC/0Xh7wAIyiUZR+9MZSix0L1BpJIa
	4URunclAFmzoiXhqsQT9OUYtY70rO9lH5njO+99lu4jiw+NfSnTtDqMsOIi+iuy25DhNA0qp6tm
	Vz+DWGA9zE0cdLs=
X-Received: by 2002:a05:6512:3d03:b0:5a1:64ff:a6f4 with SMTP id
 2adb3069b0e04-5a29b9745afmr571814e87.5.1774409303329; Tue, 24 Mar 2026
 20:28:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sean Smith <defendthedisabled@gmail.com>
Date: Tue, 24 Mar 2026 22:28:12 -0500
X-Gm-Features: AQROBzChDGs3nqtsxL47LN2T5zBmNgcRRE9zHi2ihehU0yg9N9G9G5K5j69GfjY
Message-ID: <CAOx6djOWbr=uhxXrwc+Z8L0SvKWRDD8RSWOj2-FXwGEfdkiN2g@mail.gmail.com>
Subject: subscribe
To: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sincerely,
Sean Smith
DefendTheDisabled.org

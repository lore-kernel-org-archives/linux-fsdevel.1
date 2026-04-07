Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB303783C3
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 20:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775593246; cv=pass; b=STF5urrCATDt8fkjJJNYMeRmwucdk5ZJ/WggYtOhlkN94dGMWH+VaL0c0b/2GVwBjOeftva+UrXGhfqw6Ed99+eG5pSFLBEE5iKzvkuGDRIBw1HiNW3tKZjJnUF2u/fJHVbyVAVs46ufXbBQ156vnuV/3vqud6vsTABGJusoSF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775593246; c=relaxed/simple;
	bh=cjT74Ocy+s/QiUPJBz2L2D9lT8JxlLpHzuEDVDl9Xlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LmwD9w+GucWFHXSZlo8MCskynEqHzTcpRrPbNSdAOcasCEqkLMHr9PUu+61gniKSLrRpWZlQTtjnp3+PoCHuJ8RqFExXftNF4nTzTKJyItd00hGf9dw9lgMdh+BvYwui3gi4Izo0L/6zlXMvgRizIh25g/i9MbBnclo05qimsMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tEFDH9Ri; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tEFDH9Ri"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so681876666b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2026 13:20:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775593243; cv=none;
        d=google.com; s=arc-20240605;
        b=akncmUzGPGr3Vbz+AWJ7IIuQawgINfdC1yY4E7nZTzU+vJHFcVlAUyDKZmCOIfHuB6
         VzOcEEU1uKxCzayoPnlkhx89ey9P0UQkPuU5oMPNpCJYUfsK+Kkq1srRnfBfJ/IUkilu
         /Thh5nt4hxQh8+ahHHL1zap2d4SHe6GlqS/F/2Gc5iDRFOnK8AWBXZZdf9BQInRWYQ/r
         ifgEtIWCzXAWm2YvqqtUQChNci2EUe9mCI21FTGuNKa1fVBXzIiNHl5Co6NhWtKO7Jo/
         24dKtlzXncCpNKlMnkezEwi+3/af6r9Q4zKaBH9/FpIv1EsjXoLm8hRiVxQiNl87Siwz
         tOLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cjT74Ocy+s/QiUPJBz2L2D9lT8JxlLpHzuEDVDl9Xlk=;
        fh=teNnlgKfjtfPGhTKFv4HDu45DGgjVpg3Ytv+QCekU9I=;
        b=L5s728+JgqpCNyVyI9A70Iknm1nLpztyOKpuC/E1b8C5vxTm3ZMGEyTBBcRqePXlvq
         oCjx053iCUQGwkkkXsumuV05Q+4HJiUKUK9RHU+j/xhLRox5Klixs+V2v/Hz63zoHfzR
         lzvrUt/YfvlTm+gzEG3KVSE6Lin7ttEQ+6mvcZxfkk89tl02M36x06Erz2heqvPq5gHu
         jT3tHVTCxqEFOLDqBR7eKXu8/NhAjC9h44W3LRMp9FhlXMYZJmxr57r5zOvGsZHK5PXz
         7Nl9YqWwiChrm1004ZB7zOswB4E7Fch5zU3Xtdf6RFDcOkn6dnZizQrgJzet2naUN1cM
         0oeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775593243; x=1776198043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjT74Ocy+s/QiUPJBz2L2D9lT8JxlLpHzuEDVDl9Xlk=;
        b=tEFDH9RilULLpzbXtcJhRp8eKc/U45MaQeEOCBfP57R01x9ZQhnv2QSlBiNawt+rEJ
         WiTV88m6PGXaYhIpTj/LSkIFYMe/chWzskINUuXjOM7t6JB3pWTrScrcJeqSQVs/6DII
         /XXEyNRNTG+JAmAq45oL6wOAVNI2H6FB7Dvg1rMPox75U9dOY71OUIoGl7fGezIil7ij
         PtLGGbMfAGpkBVFNy5NEoUlxu5QL/iR4PAc1jOp82gw5+JHVYTQlogiJMXIBFNs64m3n
         ocoSUp/QC0/vaqDTAmVvNDk9W9qTOXoR7KCIXmOg3fceNnW6IaEgp16oW/aoz8FcolHU
         En2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775593243; x=1776198043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cjT74Ocy+s/QiUPJBz2L2D9lT8JxlLpHzuEDVDl9Xlk=;
        b=ZYKRSqRiA5pvEmm+IqgoWQOaQbTiDaPTN1vyIyU4BidR/TnDzHlrEKpCZwNvvP+cEG
         VxQp0zwkYQi8q0+Os4nYvTPPwHLXq0nH2WgKDCj1q7cueTWfqJuwIiVxL0cEOkN7KCnd
         OHbI9xDo0UYzcxP/g6jFO8C1lGJ5snGqyshWf2h4W0p0HmGibZvOzg2pTx79kiSNk/fy
         iHT9W5/NgSDuO3Ki9t4wLekk039sOgiyI6QxpG5qZCPLaaaWVFGTZM+2ExHpQKy/nVAV
         joacHsy/Mnt7imbqjhNz9nOM+VNNiYu6MQPtjzfIa0Cc53pMG3d8PxuTkwISyTFS2VIr
         3NbA==
X-Forwarded-Encrypted: i=1; AJvYcCWs5nRo/CQvDGE99FC2FAi//Zh0Lf0qZMUARwG6tP08rPsRxmP/UeT/MNqK2XOsbXNwxgnez6ZTEIs6ktOm@vger.kernel.org
X-Gm-Message-State: AOJu0YwHXIoOdU8GLLMM0gNyiNVXBQ7Xs0rndUldBLrl9sct+71rkDB7
	Jd+xGlCJVZtGu9WAoGNjGbWbMCuYI5Ax4k6Og6CyLx6pDeiRUHSAGGGtRI9NcVG4BGqv7ZRuvTs
	YBk3Xxttrv7G3MOHXKntCOxA29a/yMIUrNJeX3pM=
X-Gm-Gg: AeBDievoB7td/YASUeL6UwANTmHSNbNLGQsmFbvDxA39IotKQkE4i2lKS26IOs47qNZ
	edIYZbJvQbY3T6+/ktigRUBqQU6eJACql8lteK8cXc34vUw5VjyqI4akRneKhlOC23RQOoKB7mI
	6N988btKl2obOdQXj53FrhP+elMIKPFWQefnnQZw+wz8Spx3nuXWQreKcqEAzIo3cyRT3SO5Kj1
	Zo9j6acTGkbiwTfajcTymN3pwZHEebcjJ4PaaArKaTAZgNcjEm6g9h1NTfbaxbV44lnju/9xewj
	SvCiF78l1ZsVypcqjmD76RfI/a0nrPIE+j3q
X-Received: by 2002:a17:907:8b93:b0:b9b:ddb2:b1c1 with SMTP id
 a640c23a62f3a-b9c6780cd71mr930525866b.21.1775593242554; Tue, 07 Apr 2026
 13:20:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407083219.478203185@kernel.org> <20260407083247.763539663@kernel.org>
In-Reply-To: <20260407083247.763539663@kernel.org>
From: John Stultz <jstultz@google.com>
Date: Tue, 7 Apr 2026 13:20:30 -0700
X-Gm-Features: AQROBzD-zfvxt2CXKn7k44eSW_jC6hzwik2D295qjg-xw73ZHrijJ7W3y5q868U
Message-ID: <CANDhNCrPm0w6sFADMY_6-Ne3XeHp5aDXU9a8QNt8WPbeLWX5gw@mail.gmail.com>
Subject: Re: [patch 04/12] posix-timers: Expand timer_[re]arm() callbacks with
 a boolean return value
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Calvin Owens <calvin@wbinvd.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 1:54=E2=80=AFAM Thomas Gleixner <tglx@kernel.org> wr=
ote:
>
> In order to catch expiry times which are already in the past the
> timer_arm() and timer_rearm() callbacks need to be able to report back to
> the caller whether the timer has been queued or not.
>
> Change the function signature and let all implementations return true for
> now. While at it simplify posix_cpu_timer_rearm().
>
> No functional change intended.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: John Stultz <jstultz@google.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Frederic Weisbecker <frederic@kernel.org>

Acked-by: John Stultz <jstultz@google.com>

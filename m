Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125095;
	b=gdTCMA5fnHIvftzZVUa7itzdK0RRRj69NKfg/65gO7giiWcaYGhzmQeCmQeB0XQDL1VS
	 1BcYOJ+pf/bFXHJ/v1QGijSt8Dx7prRRBOwrBTVMFaqjilisjGMMVM9HFqZuNlLPKA8FB
	 5eljBwswzKjcAhEmc/nDpqckXhxZcS97dlo/ZDADoZOGud/5hN6zwNXGQ4tOKDzolOVSx
	 eaW9RKVP/NIpWtQg26Y4dCJpzVg3G66MiMaXOtoYGMwo8emC1aOeVklOen+d5ZwcDiqC0
	 5cRDPknn4aLf3acv3TKuxUMOjCR6NMaSvdg+Qduop4C8VdWFJgTsOuHdACah06VrAvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125095;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=VgwqDMDL6GCHYL+uBCPhR4parfpWbie6/XUxbqyiET0=;
	b=gfU1W3azbBd42wKewwZdUImotAPmOESpAUNAbaakXi+GeDWVzYgXlwDjL0WUBkRjJ9Ox
	 lRPvhSGS11U5J/vKTyli91ymIPLPvDwbuxeFcZDrtMg4G3KHaQGG5LjHVqQ3orV7UV8q7
	 bvdZJnn0Sd6mck5L3iXqCFKfHh9+58W292mPje7X/dljk1vkyHklbY1ADFOwUADGVgNkM
	 K+VKz+50dn0AFNhxnBmLSl+a4nMgXyY8fcCvucFZhvLf7hppnDQtB/pzBhQ21uLXp9OS8
	 2KUyhckQEQOuSZ21719c/poTNl3tgbTbypbqULHvVp8nIbmGLJQrgEN45kmG0xOYPjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=FWLhTkYH;
	arc=none smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ADA606A31D
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 18:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6ADA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=FWLhTkYH
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b408f2d936so337858a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 11:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793125093; x=1793729893; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VgwqDMDL6GCHYL+uBCPhR4parfpWbie6/XUxbqyiET0=;
        b=FWLhTkYHp76UWnv/lRvrAcEX2Pn2bXOno+oVIwabCTaYdb+zoco6l3JUED/X9AHDKR
         Qio7prtgaaC6kuhvcH7WF8SpgRDzl3iSsYlnuOdC/pytQNdEYDkXAdPOspLZqWVGIXUC
         3b9usZB2e4impamoLV/Mkge/x4+Wjv5m8Qp0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793125093; x=1793729893;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VgwqDMDL6GCHYL+uBCPhR4parfpWbie6/XUxbqyiET0=;
        b=LexnJ1lUA9z4kOAXyF6XdGqfW5vvJaRmilKuyJysYaOp7SrydkeIb2DJFWfBH1Y4/r
         z7gqrMBG5ET5vORz/fJjBhmThvOQNPkvkkONqdn/QQC3KQRYG70W5jlMEJLwhk8ZYcBH
         i0JdbfOz+7fvm5B/Wo9vSaD8+SxvndZ6CLugkZYzu39EFjZ7/Y2/VZ2KRnwP8MY1cEaF
         QA9iMQ+WLBkUkt4JTQp0u7hSUZe92VtvEwsVrpQ5fPNxL7BlUHJv49V4CQlbC1cIbN9S
         GyPPmy4aq9IH32EijWdtzlLMtwpxk25SHEIsugAocif2KqwtOQJIIPEgezbBjSOQcJfX
         xu7g==
X-Forwarded-Encrypted: i=1; AKwUvBzWlUwYxabNTjj94muFp65wLG5dvnBQoEQHwmxTbWC+ewMPWjHxME6w3OMuxdbyDQsZ3JqOzmE48lOL5XaX@vger.kernel.org
X-Gm-Message-State: AFq9FYI92MQ6XAj8aXeESUKbS7RQ2Bk3xyg0Ked4BJnzRFCXl+wNC67T
	JBEJHqSGeyPJ8LVbFNdBXLTB6IL71X8KCm1FBIvSSmC+wHVnGoDbes9+bTBr/MZmgnOIO4CydAY
	rscLBsiy6IA==
X-Gm-Gg: AYBFou3n2rIK35yNvY906o+FuGkW4M+yT72SDMroFC1c42fJZ4Lqz+lV6tP/hgZYTVW
	qWZbXCVsG699b0yeCX87QnipPfXYfBuetHzchlF3QKIZLHzuXxY0LTYuErQpbHUMezVyZJfN714
	miOvmEQWYWLr29ks394BziqdLLZgiwkftlSPO+9WxpJyCWGOyo8rEBaD5ZsOoRpC0REZUVTVCD/
	c/nbmI7wgg6afQZT2TlMixLpRa1DNxhLVtudvnFG0Y01VSDNFA8K9h+K2CeufPZzDAElLH3gG9k
	3Eww1T2X71zt57KjWvjka+LIRiTAdgYC4Jz1jdbZlI45mYv+Ul0GiPwGanAicL6R2lXZoSXWi80
	dLy0fcM30rLewJrJcDxq9z8IzTcTJWZ2mKiJXI2zIcuZP7jDZsd18Kl6hhvdHNbiseasm1fDS34
	ZoLr/oh0xO+i5ethTI4byVAaqf6Lj6aUebenneHhAGebLtVIDBW7sFnk2+FMUG4o4xUZcarmfr3
	Lia7rW6ABQROsxsa+fJkbMeEcr7wmIyPFJWjH6lGpTgPk6GJGKY5G/UC9qbCnUbN3S1ryVvJNHx
	lmmo+Wsd/JK8arEQythtNBC/8L7Hbw==
X-Received: by 2002:a17:907:72c8:b0:c46:75e7:25af with SMTP id a640c23a62f3a-c49bdf25754mr6282866b.11.1793125092952;
        Tue, 27 Oct 2026 11:18:12 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd34fbcfsm499032266b.2.2026.10.27.11.18.12
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 11:18:12 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c46822eefb6so15056266b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 11:18:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByTRKNSR7faoTw/XanB6B7pkIvWhXyVlpAeoE+VhtYak0veAqnVd/vUXMEFUNkext4VOkfNS4XrX26L/xlX@vger.kernel.org
X-Received: by 2002:a17:907:9691:b0:c46:645f:ced7 with SMTP id
 a640c23a62f3a-c49bdfb88c4mr6329166b.39.1793125092132; Tue, 27 Oct 2026
 11:18:12 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <atdn5xA9AZHAWNsM@hobbes> <CAHk-=wgjwxSCDQ7VhH5NgHSK2RG+9tDb=infbWbgQbWWHjVbow@mail.gmail.com>
 <auBcFQyaV727f4fm@hobbes>
In-Reply-To: <auBcFQyaV727f4fm@hobbes>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 27 Oct 2026 08:17:53 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjqJ8FLVmLCs-S3LHt=8J47HaNpitwitGarn=30jDO+Fw@mail.gmail.com>
X-Gm-Features: AclHuK90DoqSL-e53B27zZ_Rq4yt-2aPlPVaLD6JS2GDJP9bp6JxOAkvvHPT1b8
Message-ID: <CAHk-=wjqJ8FLVmLCs-S3LHt=8J47HaNpitwitGarn=30jDO+Fw@mail.gmail.com>
Subject: Re: [GIT PULL] sysctl changes for v7.4-rc1
To: Joel Granados <joel.granados@kernel.org>
Cc: Bradley Morgan <brads@mainlining.org>, Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
	Oleg Nesterov <oleg@redhat.com>, Yibo Tan <lhfff@tju.edu.cn>, 
	Zhan Xusheng <zhanxusheng@xiaomi.com>, Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Oct 2026 at 02:10, Joel Granados <joel.granados@kernel.org> wrote:
>
> Writing fewer elements than the vector or junk after a complete vector
> behave exactly as before. What changes is only a write that already
> returned EINVAL.

Ok, I mis-read the code. I thought we used to just ignore junk at the
end of an incomplete vector write.

If we already returned -EINVAL for that case, then I withdraw the
worry. That would have shown up before, unlike a silent "ignore junk"
case would have.

              Linus

Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFBC2E54D3
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Aug 2026 06:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785565738; cv=none; b=CWrSJBFtyEU7HLNNs8McwNN/m/6jf0x4rER3ch8DQf7CDyx2tc1zoRTGVjz60yecHJwDgGkJIJTbf4hJptgIuekNJ3YO2YkUu5QjsOIR/AVIfCdFKZ0imzvpXy0iKLhUF5XlvCQPFTcfrT76tgJQaIqLe5/f0iZEBo/kUBZwV+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785565738; c=relaxed/simple;
	bh=COvKaGnF6LpDq29zlvmPP4pHInzce7eb7TOvIa0Cn1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RZcwWrZ+SlvSPBiMvnmNOzALjKGJ4PYg5Yt/YWJOeHB2pEHYcrRYRB1jJkAkMmQWnk+kcYZFMmJ+KBh558jDgJr0et+aKqz0cWWdbf2HLworkvPxm1RaBbgo5TTHYXO2QbILcdOxbq3aQNtKgYT00H6Xfnku+rqsw3awXldbilE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=black-desk.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aeb8c19017so2154265e87.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 23:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785565735; x=1786170535;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=16SUzRhWVW6EVWBmL0y+JvMFJQWcBIjhRCitx1SlS08=;
        b=X6XDEHnyRcB6YHcTnqyfg7aFXfzhRV4t2EPq9oPqUkQjyuHtd5WMGkLEeO5eXAhfbu
         gDIKmdhYSLjBknC27rqoIJPWp3xjgZCyrAQniWcEE8FUkY3YQbBushnuRIKLs+ynz5Mv
         oW89hJMp5pEHhUeLjyVKqhWRyaDx4tDBtEGPIYC/XI578/QDng/Ih/YpCVQ2+tLT6tjo
         1fiXKXdjYIUApA3AlOuuMrytjF3Df+js8nLfn0BuN0n3MvCkNqOlSE14ZAik3xfvIR6B
         bCKEJBszxiLMxFOuNDd/APZZuDeyRJ9ec2g0dLQO3LhAeGnRQ95IwIqqJUZo6vLm2WTK
         KNUQ==
X-Forwarded-Encrypted: i=1; AHgh+RqybAHsUHPhx/Mb9hvA1xxvvZ1BrE9O/tvUSQbzvwYEGNAeWOIs2iMgRvNAgm9GU6r8m0trnqetrms8msmr@vger.kernel.org
X-Gm-Message-State: AOJu0Yynm/XgmRL4cMJxGK8Cw93jmSYzD/yzzW0irqS8gCBcWO0ZVSXm
	KcMCr/Jm4A6+Gx+/n1uFqWS7Ue3zxUef9cHZFUCJELVki9MF9PQ5RNYqTp9NUcxlTVc=
X-Gm-Gg: AR+sD10HdWGZyKSEuXJkNzbbsRuHU4FVfGJUKGWpe1Mt/+BXTfirUdytTfubNyWfC0/
	+ih4UObmpW487qPvP4IodkMsdOtN2hx+4D8onpTWjvoOZxzDOO8WhO1sPAKoC64gxYLyjjz6Adb
	cZPSEhUDJ7iHof0HXUXoCvFZIo9cBI2GW3/6tPR7abrBIxCHkfpHTkVBIC223kdtUI6ps4M8dIr
	H0lGR5AqLog1sl20L73SHUuBn8aFMgWMPO0l6pPpnA4IxqBgS3zcUe9OHvb9DTwFKbCZNWh9AiZ
	qClO8vxLVLIdqfSYFd6G9DFtBqUHxhYuptmmrF7q+3f082epY3LouwAP2S+DHg6ew57gZhZQF94
	9NRdqWLgOiSEvxqmLSyXZFH+UWa/dvAqmJpdcGbS0Fg7GmX2X3EDDZ0HDytOIAWkHsc1M52vu6K
	ECU9P93x7s7OUfyGjJa3DCDPgaX6bDf60HQGaiiCnMZbXiaHQTiE5jdJuXa1Hdrfuc9AusjKYJk
	k2xr72HpJe3YQ2HEL5a3LBoDvRHAENa6keK67l0fKlLVGIMDUxH
X-Received: by 2002:a05:6512:3ba8:b0:5ae:bb19:1864 with SMTP id 2adb3069b0e04-5b2e4f33f77mr487853e87.21.1785565734599;
        Fri, 31 Jul 2026 23:28:54 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2e2441ec2sm748320e87.43.2026.07.31.23.28.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2026 23:28:54 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b159850b16so1446808e87.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 23:28:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RozsPXOhuHrC6zSf0lEpv4xtP69aSub6D2nfbC0sXResivxtwaR/OvMgAedT/M4BnrznjTea+N2QDteSG1m@vger.kernel.org
X-Received: by 2002:a05:6512:1455:20b0:5b2:b7f2:f7af with SMTP id
 2adb3069b0e04-5b2e4f1b820mr311654e87.2.1785565734267; Fri, 31 Jul 2026
 23:28:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731-pidfd-exec-update-lock-v1-1-b388f2f3a8b0@black-desk.cn>
In-Reply-To: <20260731-pidfd-exec-update-lock-v1-1-b388f2f3a8b0@black-desk.cn>
From: Chen Linxuan <me@black-desk.cn>
Date: Sat, 1 Aug 2026 14:28:42 +0800
X-Gmail-Original-Message-ID: <CAC1kPDNd3KTpFJduy2YopaxH2WYFZm9BTcjcx-oaT+nsMkXd0g@mail.gmail.com>
X-Gm-Features: AUfX_myNdjD-tDqaRQGIo5jviX-U1IrbV_ZULMEOokd7ywszYjRDxh--xiEA8tM
Message-ID: <CAC1kPDNd3KTpFJduy2YopaxH2WYFZm9BTcjcx-oaT+nsMkXd0g@mail.gmail.com>
Subject: Re: [PATCH] pidfd: hold exec_update_lock around namespace ioctl
To: me@black-desk.cn, Jann Horn <jannh@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 10:50=E2=80=AFPM Chen Linxuan via B4 Relay
<devnull+me.black-desk.cn@kernel.org> wrote:
>
> From: Chen Linxuan <me@black-desk.cn>
>
> The PIDFD_GET_*_NAMESPACE ioctls in pidfd_ioctl() perform a filesystem
> credentials ptrace access check before handing out a namespace file
> descriptor.  The accompanying comment states that the code "mirrors nsfs
> behavior", but, unlike the corresponding procfs paths, it does so without
> holding the target task's exec_update_lock.

After sending v1 I realised that the exec_update_lock in the procfs namespa=
ce
paths was just added by commit 6650527444da to fix CVE-2026-64371.
So the pidfd PIDFD_GET_*_NAMESPACE ioctls, which mirror those procfs
paths, should be fixed the same way.

CC Jann.

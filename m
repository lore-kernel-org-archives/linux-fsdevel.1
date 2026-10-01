Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050FD367F4A
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 04:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829244; cv=pass; b=j38hCUrkUbkbAt8zEXtqWiGGKxmXKmX+VgK1Mv8fGbpRrbs1vipX3fTdhEjLim9D76KpEcY4vICIeP7zyJIykSdUKeuVsOnW2Rhl3euLN4IUgdZBL4NyQGBJATf8Ixs7jzRFA9j2h7z0Vh++4YoWyLMHwWSsovID+cH8y9MBlpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829244; c=relaxed/simple;
	bh=SsD7P6PfA1YYsVqoiE5QKifgHw2H/lNYtQ2xlqkrqDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TSQQuk/n2nBQcUqL+33C4EQX0KAibUB/mDX0VxTwmfmrWIDRNCTfRDq7rOg93RRlqhwWFNAtL9MUuEr5g3ZUnuqnwbSVqMpHNtRjz0Fosr0SPd5DYkRaeGHcqi6ReGb12d5bYYVz9kwvVrHQ0q+K4UjkgOwN+Ar4kMwJ8iZyjh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MSaer8p/; arc=pass smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MSaer8p/"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-144f7915355so5376443c88.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 21:34:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790829242; cv=none;
        d=google.com; s=arc-20260327;
        b=PbCEsXHriDi/9q9ivj+pYBCNdwpKblNlZzQ0D8qfU3oj9qF+xeEl0YLmVwcD5t0tPd
         JYcNfHVHxg5Qz4Hzq8q8Q+1dY31/l9Qb6v+Wqm3MfekoKjYP7R4tn2/P+LTT1xhkUerh
         tgOUmegiv5bqHtUjEjDjkQo0jhH4eP5MY7wN8XNnK0xUroIKzUm2rbS1vYWyW+5hvbFN
         qjzToM6SSgKBOkiL3tuZT2WUorITR2Qq+lttW+TIZpqnNYlKfkBiBroKUMxCBGDqXnF/
         eLaM/ytJ92UsMAO7JtkyeaKecGgT92pqddRIVNJ8jjGwBxDskbG5AyDz0AHH8uPMpE74
         5bUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SsD7P6PfA1YYsVqoiE5QKifgHw2H/lNYtQ2xlqkrqDo=;
        fh=49MV/ib1cRxvmhzWnSLikPj5COcvi2xVpIpQFKS4cFY=;
        b=RtGr/NcoC2LwAuvBbHrm9j5NLvkChraZIbpvW4pGWYdUNsYigDvTVEct9PjaNZHXPF
         UxqTFPzOfBcSVeUYZslFv6g60xYQOzbbFF8cZj+oordctUPGKHv88lK+cl0E90TR9Kj+
         YyNts02z0imSf6tAqm6R2u0gYbwfbSqvnhGAGOAScIm0/9A7LIRJPKeRw1JmiedKhtH3
         XzBh9gnFauKZLMuzSCxl2ZyBegm1u1tPkuqNSGNCSS/ZD+iTQRqCzXma2eDMGMKsMT1g
         01PsgWmyif1OAZSqF1Md5/IKqa7pBSeX1k+VXaiMGMwlsb0uQmKJlJsd1pReHsqsyidF
         ECrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790829242; x=1791434042; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SsD7P6PfA1YYsVqoiE5QKifgHw2H/lNYtQ2xlqkrqDo=;
        b=MSaer8p/sI42pnatnOD0xT1uwap1OtQuj/9Ums7pRw4GZxjEZYLnaAXrW0Abdisu60
         0KY7c19Q6nZChgecO0+1VxLfYLFlZFZn1J/jBV3QJO6mBVllp0FhRSakBri4HZtpNgcq
         JlyUvCviHjZD41Ycy7anEV13Hqg4igje66r0jgIc3m7Tw8MT4sIIiONabiyknRzcY5Xh
         X7zzmfbJjA0UQQsI+PE3xgCT3dU39WvQvDIdzQ+0hDxO1zoH8CoB2aPFlWS/bx+aOyXF
         YODa6bxF42useHea3Edf7WCYvtZZsJ3x9Nwkm5N/NyQIX6orN2ygv/uSfa+RRTet90kt
         YeFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790829242; x=1791434042;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SsD7P6PfA1YYsVqoiE5QKifgHw2H/lNYtQ2xlqkrqDo=;
        b=aUAZFviE+7fK+nskaeL3KW29iv/mtRUIi8iwogLegSC/kOxQqUbOClaNvuMxoexHED
         M69G1qCzH4zjN9iZevWO2yi/lpo0VdN8Dm0V/r3KWceHWUHkmv/pCxBHgZBJSOCrhaq1
         oee8NtQnCXkgBWUPs5L8/S43jXHFVfnpuywjgJd+pwDH4el5HeNJqU/jM+iCxqUPizgu
         No6J73RTZhChqbjeRwHduGsba6MscAKCV1h3o+IiaNK/fkMAofjG7PEm76NtLrSNNKRD
         FM2x+nxx5YDKejSnVln9n9iek2Cho2DD0mVV6HtWnywI7wbKSqGacmHNZBY0AS28ZE/c
         JUsQ==
X-Forwarded-Encrypted: i=1; AKwUvBwQ752Xx2lEuwOTusmMWjGrK+m7OtxpPR+U9+PVAQcBfQE7hBmsXDGvkyN4KOuHHkwE4Quxq1w7jsbO2eXD@vger.kernel.org
X-Gm-Message-State: AFuF++mNFcbd2oVNGbVfAv8KYwPAy9dq1njUpZdxXInxc7tyQs7JkYnF
	8uSburnl1SfNK++J3ZBzn1Kc44EU2gP1SNx1FO6Ab6+2GxFazaVn9OTT+O9xGuy/r5qoTe3vmvg
	YQvJwDeAMb0GXDV19ey2DV0ZrhrU1dRpXLy6bKNp2
X-Gm-Gg: AYBFou0Mp6TdfEiGqMJZtd0gNyT+8V+GxU6LVnfNz6310C0Rl/U2sGVXL9h7wVK6LYu
	5iheokNmzykdDCd5R+OUty6YhPBUU//zMhW6gJFDLLM0aupzsoFCXbEjjbz6TxBqHIQjQXm9tTR
	UzKYEHuOKwKTABxXmUet4ZVxQsFPfVb0l5l9hRtj+G6Ivp2p6JH8hcehLeL8ERpuoZpUYjJedP3
	uYVCxbIas9KZcUhOiCwLCmzByZDmWR+FEvJnu0eYoJSX+Ckjgh75fvy3kq6tDdwYe7JTbnxmXlS
	dC4bELHWtzHlSFPtslkTYcRxEzceq9Cghzi9u6e2H+m/cYIpKzVOm/50Tzwvso32v1kJvwpd2lD
	3WYIW/lsBzi/H/Ks8IRM2aAHZa29IckkxRdsURZNaTqLYyj7hAzFVm4h5ABazF1bz9TE=
X-Received: by 2002:a05:701b:4187:10b0:143:4d12:396d with SMTP id
 a92af1059eb24-14d32fb9a44mr3389493c88.26.1790829241124; Wed, 30 Sep 2026
 21:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928-work-unix-passpidfd-v3-0-532018a91b21@amutable.com> <20260928-work-unix-passpidfd-v3-6-532018a91b21@amutable.com>
In-Reply-To: <20260928-work-unix-passpidfd-v3-6-532018a91b21@amutable.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 30 Sep 2026 21:33:49 -0700
X-Gm-Features: AclHuK80-WytqOlhQ_cTt40E22rT2LSFx63QxmMEJnVWBKUyH4pl6_lj5c5cTLI
Message-ID: <CAAVpQUAgB+awkOOr6BdVCMVfNJ4tS0WrK-vT1n4pecz44SxC7w@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] af_unix: record the pid of the connecting thread
To: Andrew Halaney <andrew@amutable.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 2:27=E2=80=AFAM Andrew Halaney <andrew@amutable.com=
> wrote:
>
> From: Christian Brauner <brauner@kernel.org>
>
> Currently only the struct pid of the thread-group leader is recorded.
> The identity of the actual thread that connected to a given socket
> cannot be retrieved.
>
> Add the plumbing to make it possible to retrieve a pidfd for the
> connecting thread. Nothing uses the thread-specific struct pid yet. No
> functional changes.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> Signed-off-by: Andrew Halaney <andrew@amutable.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

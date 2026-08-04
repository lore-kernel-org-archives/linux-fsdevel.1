Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6727F48097D
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 16:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862221; cv=pass; b=H8Y+Ge2pDjOPowO7btcJShDrwYPhJTS+f2itZ3LSl+nMzde1pt9jOPBrmK2lE8xYX/TLp/sXTcGDEUuRM5J1ARMrudB8mUz0RHzqTm79YwHE8Dk5LXZNsGXV0tcJczN3QPqt1vY7+KyZU5NQ12ZzWU21Y/T9IFcuw5OGZgaRcEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862221; c=relaxed/simple;
	bh=tuanMOupDYAV+JqOtUwVlLQmntJtBt1U3N0HaQ3Aw5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tO3b1/EqCtJ9ut54j0tyP3IyXTHZI+DORIVLKTpMBV8OvigZbY+Mc/ZzY52FD2gl3x87XJ/59lp164wpBmRFazvLvLlheaRiLnvdmrwu80PUVdL387riM98CfaRsWoZB2/U8uGgIFH6/pHpQ+L4HnTYBwT0YOOrgSiGhAnUpy2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BuahdNWw; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BuahdNWw"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-848761b5897so25685b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 09:50:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785862206; cv=none;
        d=google.com; s=arc-20260327;
        b=VkekUjqsP4vv3E+Qix0DtZMyboNFwZ6AdlvU/GzOhXEUt9Aq9Wxk5lUQlys/i3nmMV
         Jj//vFIcEGGueWQ3s4CECx63NER4WWty2zLL5Au9v9W5//5S80Oa59lAHk0KfdNN23NG
         Dqq/Imss03HR/gpQT1lN7tMAUZ/y7dr27AY0QeLKXU3sT6ssNG0jlY8xbHX9YKwODmTY
         pmfHacEDmHTYHf2bG2VnxCtOBLZurlkXr0Uw+KrxmLX63pAPs9fvgyu0XdJbocbVpMct
         /+gl6Ckk1hXyhEfOe1pJC4LT8LOa1pxHwOC+A9l73PAnmqk/1KCe9ZfasouZndQM5MH1
         gahg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tuanMOupDYAV+JqOtUwVlLQmntJtBt1U3N0HaQ3Aw5I=;
        fh=ZlTwrYC/T5Ct/HFHxiVJY1SNipOLuGA9fm/m1tkR1L4=;
        b=X8RuOFYwQ5UDAsQdEp/cHYu7Yt9f6JXanBPE2ahlC/V3TJ+sBzi0SDOQuR6cgApqaT
         CGN5U8B79PVFYYBxuzEI3OYkPH/jfbIB7J1vGn+XDCB2OwZWfsGJAc8PnclqY3goKYVf
         SrLb326aVFY1hkh2O1VjlpgDQ34Kn5IJz7sJPepL7ycGE40M6KP3YRZA+2eIT8fvDviz
         3m35z82qT0Lh2/FBHkpOnN2QMMtukbdcEmQ9RXe3D/V86rTrXt4feZXSQXg6FgsLUtdA
         1jy4qUZsMzJoGKi6uvj02VH32pEEKwcg8mT8obuTSs2IhMETJY+1jXkprl0O8szvCq+e
         4COQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785862206; x=1786467006; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tuanMOupDYAV+JqOtUwVlLQmntJtBt1U3N0HaQ3Aw5I=;
        b=BuahdNWwupVIZfb7zF7Dc++15mYkom2zG69fp+MXGRdCzuZyaPpWCeK2RSJdbxGq3J
         ze/L+gnKXaamm8it8a/8xWRhM1nE21GeIciYAPYPD9okkJJBuU02XfXO0zMyeRRVRV1B
         dGpn1J0RfdJwpl17EwKT+O4I6dnFlRjgrSvbfYp5OIpc91nVxcm1cpf8LhEV4PnARCjx
         /Hx13+frt0uZ642YEvh6467doCmXBABxhkIPEBJZQadzjck1C+i8tlXYtoCi9uQLnb8R
         afEcFuEq1DY4JcxJx1tL8cY+PFIfqpMHBW++OFFXItu8vSxsLLnAbW/iW7Mu67Fajw62
         KDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785862206; x=1786467006;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tuanMOupDYAV+JqOtUwVlLQmntJtBt1U3N0HaQ3Aw5I=;
        b=jFPu8ZttmAx0L8K2mMxhBoKzJH8gy7ycJuwKXU7/6O6c6LvLEoE4cMVOOtLSiCHE9d
         oZnWKqwnIvNNZrlSfenJ8+9Fexto/AWt1NeDrM6sn1gr1D+uWyr4eCFygC7mNVK2nPTv
         uFICRXfwWKQtuabj00eJYhwTtl25RVDeKQ50ZMUR1g143LLRDB6I5JWfahTcoknF8Fh4
         PR3Sbn1vTYFBS4kT4VvxZ8wDGXu/ce2CW2Z/p60pjgmWjLC1pUq9egAk7zC7JGIzLw58
         w02Iin7BqhMPmAue21sk/lfM5j+drncPqhrJAFxIxi/fQH8+gG99uz420DsGKqXwC7eq
         WpqQ==
X-Forwarded-Encrypted: i=1; AHgh+RrMQhcJH+siJ3Gj+S/WWorBBBPED88Ujs9NtwBR/hTl/hjIhlJxYywh/5lAs5X+fruHXXO55OkbsN4qc6qh@vger.kernel.org
X-Gm-Message-State: AOJu0YxVr/6gu8h+6JYEYIz4D9JcB6omCz5whnlbyTSuyU+dFu6p3xW7
	Lc8uwZqeCH8AdNPTM5gyqr1tY88pfDN70MvDKFhRA1EM5OBzU/1qPsuxPxkEA5DXrMbf0vLhCZ4
	8YAnVSmVKb78tBLUKR4zvbpOEijlapLNfi9m3ZdDO
X-Gm-Gg: AR+sD13MNpUBJCDXbNGfJUlI07wXyNYB+E5K0SuiRuHrga6ozmzePBHLq29krD1gvVd
	MBxw8oetRuNslUfHrz9G2dCgkNmvKZ6CDT4neC8t+atpWVQE4mA5GsH6b9iRyIbETI6HDG4RcMS
	qPYjQn5I1EVdCFnpoI7Ova9OrGjjODGbVyiLNylB7U/rTNpNROIUcg2TCxb8/3W1Mb2dHTnpMcO
	DqzgGWYTrVYXrWvHAy1UtVK7EQAptlGxoWryOZ7/iU4qolIQNJrvfe9ieMFXExkKvc440mRZy/G
	ovW1y9qqvTzcw4RLj8496CleNymNrYafM8jS/oxJLKpDaeXKaE5kOl0PgI5zdLEbsmlrf2fwdkI
	kv/gPdxInHCe5yHlkactWicuDD538UQYV3G37hNywUxuB12BaL/9Bm68V6kd06U7wFQQMzjN49i
	In1TwvW+BHb2cspZNSH9SO0Ww=
X-Received: by 2002:a05:6a21:3392:b0:3c3:9595:57ef with SMTP id
 adf61e73a8af0-3cb85ffd1cemr193900637.31.1785862205404; Tue, 04 Aug 2026
 09:50:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802151212.3294591-1-jkoolstra@xs4all.nl> <20260802151212.3294591-2-jkoolstra@xs4all.nl>
In-Reply-To: <20260802151212.3294591-2-jkoolstra@xs4all.nl>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 4 Aug 2026 09:49:52 -0700
X-Gm-Features: AUfX_myNnvBRmCYK55Ljjsutf2qL7MqRgERjXdZYx1md0JbPpsxmxzq8ks8CsOU
Message-ID: <CAAVpQUAW4eTfvNGaY+9gD06Jct6tgM3LRYdLEVFG+VzhCFYojw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/4] net: af_unix: enable custom setsockopt
 for all socket types
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: brauner@kernel.org, cyphar@cyphar.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 2, 2026 at 8:11=E2=80=AFAM Jori Koolstra <jkoolstra@xs4all.nl> =
wrote:
>
> unix_setsockopt() and the SOCK_CUSTOM_SOCKOPT flag were only wired up
> for SOCK_STREAM (introduced along with the stream-only SO_INQ).
> Consequently custom AF_UNIX options are unreachable on SOCK_DGRAM and
> SOCK_SEQPACKET: those setsockopt() calls bypass unix_setsockopt() and
> fall through to the generic sock_setsockopt(), failing with
> -ENOPROTOOPT.
>
> Set SOCK_CUSTOM_SOCKOPT for every AF_UNIX socket type in unix_create(), a=
nd
> also for accepted sockets in unix_accept() (reachable for stream and
> seqpacket).
>
> This is a prerequisite for making SO_RIGHTS_NOTRUNC settable on all AF_UN=
IX
> socket types.
>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

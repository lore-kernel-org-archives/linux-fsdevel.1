Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF3F32B12A
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 21:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781818057; cv=pass; b=lyReM1BU3lK8oAsRR2PSZIr7j4MGaY0QgwGTgla3TvuWbFL9tDmmfYrAJwFYlqht5/asjPaqF7dC4VuBc1uuV6u1dRCze82zFwDehV00wC8G22mVIDrksqawMXmT5npeUWSXQw3vL3WJ4qzni9vToskev+/zlAfEDww/MR/XKmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781818057; c=relaxed/simple;
	bh=p3Vire4HF8bMaAvnFbWPE37aaxkHVoazO/qNdFKC658=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcoyiEeAI9VtAR5aCHrCJQZlUxhwXCw4WcqVn4PLct6LgjBu3MY07KKNaRiMm59IlKzNwxWdqeYZoyx2BnZiNfDa+JqUFS1I+Yp62WgOzOqYtxCQMUtJMgIJRvs6b+H7cf5z8PAaSaUjjg2sCjlgXbGCunz6XbS+PSXdKHEgUuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pq88eN45; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pq88eN45"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5176096116fso15065081cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 14:27:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781818055; cv=none;
        d=google.com; s=arc-20240605;
        b=jBxtIs/30gr7nZHy7HYnQsa8sleuoo6+fJj1b0tz5qUa+NLAubfvM6WjIbl0pbrjWa
         QuCiKToy7zOxV4FGhLBT2nwuk3khNO6L9xB4K/B9GZAGk5gY8yxeo5ZplxXY+yYK2V+k
         moROszpgFvpCon/AAnGAAaHGh/v9xWLJOlxlvcc5GebbHsWPSnnK7vHbyoOdrhSaZDcP
         am60vncu2YTFXno8VFTC9fbx+vvCEQp8C/xb5jsR6wUzJ5w9BTo9iopkV9Dx0jLzPGIu
         O3gzTpFfyx7YRf03S4u5wTUsZTqC+81cX1KWrFcJTGxRpRIv8EWSygc8ITVRkaN1qz3A
         wPuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=p3Vire4HF8bMaAvnFbWPE37aaxkHVoazO/qNdFKC658=;
        fh=52dVRCSwxzmezzT/n2scUtmgFP8l1M8blduiBl3cSv8=;
        b=KiJQ7wZTjixuHJfM1gCnygi8T17pte7yGYftg80LjH+d0YcmCDoKH1KZbHOZVkTxyJ
         7xTxh2DBnEi2D2ijRyiBI9mRufgPOqLaHjzNjG21h+k2+8TxftB5BZYyMVyIxzlTDpiq
         NsZekMhvbww4l9lC8D700hUkzhhu5BYUFTmyCb/RxR/ZLQqKOupHj065+cIQZB3rDOUe
         a/TAdIqT4v8/5TSRY0EcrT/UY4xSJ+P5kHjMNcEjOkKy09v7Pon2zRmLYPrdrSUDFRBy
         kIeGvJq+BTW204aJ2xk/lvRg5KDp0BgxHABd2CSF+DEDwK6CVZ4JL3g7OQvbRf1c9jM7
         Q4GA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781818055; x=1782422855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3Vire4HF8bMaAvnFbWPE37aaxkHVoazO/qNdFKC658=;
        b=pq88eN453EVvaaQc4xgl3bGm9mygrCMs5EFNLkJdVlxgsA+eJ3IKTBZ8bYkl+JofcO
         1uxoIsAeNseCOWSm/pN9EDCKhVSynTcH1dNDKwuw60yjMYVjNuBLguYiSFCVTTVNTb8x
         ZrO8wsAUl2fO/AE/5xxH2H0dPnEaLoo1cPI70Y0var3A9kVAVRvBFRBYQgZKHLNV5Hzm
         tzPAd02EBaHNfZWRGs/dglfA8q92w9sWjS9LplnWkCkWlL2BVw6rlsl1MbTNZ8qsBcUI
         X4uk5jEosPurkJ9q/tffROS5Prh7YqM7fPTd7HDFaZOWbcM+2clc64A/a6nr67TN/5CV
         zqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781818055; x=1782422855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p3Vire4HF8bMaAvnFbWPE37aaxkHVoazO/qNdFKC658=;
        b=jhAYF/CmoaLUZwmKHZbUZmhf5JvLNmf0USTsv6dCYgjy2NW5NaFGI9U9qS4eNVHLFp
         kfIb0gSApQMAA/prxinj5BT3sVr32uJ4WmempLLXncF5dbT59flSFR5hpPb1Y9cdadbh
         awUKRpk+T99VOYIaEt1JEKxwSOScY5s3Pt4W5Vcs83tpjPV1rA5Y6Qpab8mZI2UOUeV3
         +RN1IXPp/NG2lHuJCo4gpnMZ9l72/25/FpU05gfLpBFGAgO7JQsDZUlHt6WF937VOPVR
         gDnnPrtvk/2GCQxARD6kYqQhbgjbviAM8JiazsSL76n48Acrs3sly/NLT9Jwo9mbjXmc
         4xuw==
X-Forwarded-Encrypted: i=1; AFNElJ8IFl2y2SG1xtYII5MCuoUtjP6CzcModnF4uTFqdAa1D73Z0OPuK9+VO/aST/hzVKZM5nXNrriq8wS8WsyZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo2Ia0HZCx66PDZiU1Z+ty4whA9RF3Om/dG7FRtoRRja0LQra2
	bvrNGnuSF6y6PR5HFE9NoPoOpCqVQA/hZNhPHTcBXqWjTYM8QlW8D8YtZc5+52lWHIePtHJDMIP
	m6aXgrrx8enojknxYTbXZNtYH5o7uHZ0=
X-Gm-Gg: AfdE7ckLxNy7kD9V5YoMwql9YZd3X0X13cneiqqBT4qe7kdN9sSHs04kCnC8qUYWpvu
	M7nZ1UkRfFBknDQu0N1KvPWq/w9qZHDmF59BrzUHXExiPBPLWyc/cPAQSWVjOyj18OcU42ccV5k
	iFI7Co76aAbZW63HWZEu6iCPdkwRY+0LVlIyZ2Zp6DEVKx7IKAIKG59pi85Zavju7uywXHWINRt
	/hHLjSedsoLxZa74IDaUklByeaZCKaAoUu9sTN8dRRoHGCPr+KzDLaymniEDe9cO08iJwE8ONUP
	EaKh9auesbJTGRoJdD2mFr+M0umXRDo=
X-Received: by 2002:ac8:58c3:0:b0:517:5b70:7a2e with SMTP id
 d75a77b69052e-519e4c6eed8mr14436551cf.41.1781818054789; Thu, 18 Jun 2026
 14:27:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618193005.3162-1-iganschel@gmail.com> <ajRg4gkZswI5ox5l@casper.infradead.org>
In-Reply-To: <ajRg4gkZswI5ox5l@casper.infradead.org>
From: Keshav Verma <iganschel@gmail.com>
Date: Fri, 19 Jun 2026 02:57:22 +0530
X-Gm-Features: AVVi8CcLAc8xDmwPFBR7xOJ11YJP2YcztlahnNdFbIIYLeo6zxCf0o49rmLNWAU
Message-ID: <CAPE_3zJA3qxsy-D6yN0nkeE4N3NL2YfZOEVV1rU0Rgx799rpfw@mail.gmail.com>
Subject: Re: [PATCH] efs: fix direct extent lookup for indirect extents
To: Matthew Wilcox <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Mateusz Guzik <mjguzik@gmail.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 2:49=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
>
> Nah.
>
> https://lore.kernel.org/linux-fsdevel/20260618211822.3599089-1-willy@infr=
adead.org/

Thanks, I missed your EFS removal patch.

I'll drop this one.

Thanks,
Keshav

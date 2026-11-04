Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793828871;
	b=geDopIx+er/VmxNVqpcXr5F9oaeiyzktrlFwJ1p+fDVqpORbvDZ2L+LVLlPn6ZgqiKmq
	 z0oNegS/ZYjBLqA8jBJ2+KGIMoV3Mf9c7KMLaCzkBBR2WjDFQ+RkXsx4IjAWUA/aajf3X
	 vmLlfENPe0GYE5WUDSuLmvD3nINlk3dJYcWBDkMP3lt6boRONc6IqRvI4Sg6I+ru9RZee
	 5jVshEH4MMrfVJI00Dh4bL+i+X0pot4qdO3nYkS7DEj7T7FxhuJ1qLE5OmQ7GmvDjcJjk
	 XSJoayoHteZVr/4Mhp1eSmgywl2Z0i2jDlj+qD/zsdbu69EBxG+MiIrPPcjwWG0eWhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793828871;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=txGOMs192OxKyTZmMbJ3QvyYzjbP0wWct2TcusgRIzY=;
	b=fHq93gFHMjniGf7FUW6Ojzwb1K3dAilSE7f7ovbmKAo7zIZXzmaOmjfFD41FIBFg+HpK
	 JXWHg9+9VvQh53Aw0dTf0YecC5EKc59CTn4yKapRBNu5ze5z38lQJSI+V0BIBZuz2jegD
	 DAqoUOVoW/1/QmZiScgMUUGg49oEwgjD17lRJhweND2WZjKl3WqctTu5TspKKZjWSSeUR
	 315DOAdOwwobWJDkw83AqHlniibLjwCrkRnhPQgAavhb9izjLSeFe6MoYby0bla3SauZ2
	 jCrQ/2kB86L87Fayc+CQO/+Km+iqh8SLomqJzhNeATxiB47+ObYiXJR75VSuB98wUWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jcZoJXKk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5016070403
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 21:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A5016070403
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=jcZoJXKk
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e8d6fcbba0so7585ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 13:47:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793828870; cv=none;
        d=google.com; s=arc-20260327;
        b=mwbV+FZhNiV0wAFefFQsvCCtdFn5fy1oLEjChYst5ZnjNyzuNRIPO2QWs5h5YOsSiw
         gaBoGWChnYDjy+k//wo0iuyZL1ema+wGraW7ZA12x6P5lqBMtRQzFDCqLKf4oj+M1cgV
         Fmie9sYVXX9oPC5xSqvxeFuMQxouWR1GGmmAFFX9OLvhenMZApViYP6kyGncm+HNCBum
         yxduKN2mTKFRHKWQGvB0T3f6naW5ft7m9m4izDUc0upvSmx2UIiGrwgPWZ1Bd1MmK+yJ
         Vx5TXbXPEtJsjF1eiZJrlJL7vTjOvxyjVu3494HSpNdEJsU12UoretkAyJxerOIvpkvA
         /SXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=txGOMs192OxKyTZmMbJ3QvyYzjbP0wWct2TcusgRIzY=;
        fh=7mJUVuDvnfYWIVRqWfdluoKVGa5gmjySN/dGUDufUu4=;
        b=ZtKNsiPwnMs74EWnSOBEbAAih/xKluxfBZgElfcivd/5MNj+L5qAz5i2a9gwKWjyp7
         Jn0sD0gymVOVa2wpYUAooC1u21kIlEofO+/WZdItGHIu6wPDUNXzjP+BUxgK+5xgmvKH
         UwR7zfMV8lA0GD6Dfusizckmlm1NJ2xVBEBJWAhR2eK4Y1l/HPnfChueZIMd8v4R1vXB
         tF2y5ySodFafTX9CbZObd0OEd6nGxSmifSTHXz0RDNG73RB7MHAfwvuevVHy0AqaiKiq
         fhRpYDatNpR5thw/5e5cWwBg3AebbM302FoPQ+u3ov9SB1gl/zvJ2kVz0vruVsfmS01w
         B1Sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793828870; x=1794433670; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=txGOMs192OxKyTZmMbJ3QvyYzjbP0wWct2TcusgRIzY=;
        b=jcZoJXKkSB76n2UUeiSCnXG4yLLCwDUV0kFMb32um/DLbz73eNnY+inszMBTNEiCAo
         AklMzGXeB6SJpbNgV3ZWKaR8Cjj1BNU/a5uWeG0fXt+JdrPbChh6kpRBeE411pxVQz0I
         /fRhwzVofT/67dmwF66PdWUEXVvM9r0Io8jVt92ph3wv5sD1lr+UHhqqS7mcfygNZXsZ
         +bBmz+YKqDnMSfHdtgx6RdiLmdDwZurI7IbI+LcoC1y6FWGhMMEuRSN2wJA0LQejf9o5
         OHUfNhXyfbue9TT3ANxoJWH8xf5dhJ6As1wBXWM4P3BFWIsRBIE9r/pARmynYOASsaru
         WZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793828870; x=1794433670;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=txGOMs192OxKyTZmMbJ3QvyYzjbP0wWct2TcusgRIzY=;
        b=IBlIWt0LeaOWuMr68LDxh4AGWyyjAFiQQg7gTVNfT7dCxtKCT9Khn0F58iaPlcf4G6
         JsS/OQlAezdEGOLO6ngHnUlZjEPKw9fqAKW5i5PvKfgS6xIXgckCwIi+sGnmnpfDDHtr
         kzJ4oKUlzZfaDmXgi9zhKwW/J8XWTb8r1ZDMLJjXSf60Joyc0aQumWj5l6YfX0Vn2bc7
         CK6rKz9YzN42OLg6tdbQrOy3JwcY7qyTSdygntKNEMMNJYPytONhnMuEWAAnybHfobvz
         9yq5QmIuw7xWX2NlP+7L8obIcD1Raux1XJrjK7LPlmVMSCvt4jSTNs7vQVt11CTvlepm
         PYjA==
X-Gm-Message-State: APuU4Z88q6bPMaL94GjYIe/o8IZqq7O58PdVSBV/GOCwgKWgWZ3S2UtW
	oHCio4PYjfratZZrKIYYhZrS9BSDqOUR4jEjTE/JP4ewhgmjksBfjSonP3QEegOJLivACyLEc8W
	46fUJZhORzKhZ1214iHr6+mQK7dF9W9tZII8mys6N
X-Gm-Gg: AYBFou0aClDzbaCmRErrwJ1t34oJnjL8Rdw/73AVzb80wTWZsJAqg3b89z0FhnSlF2g
	FNAwplOIwS32CglubDPbhB6OQcehYYk1nKCsyZjGcFEyVgw5QdZpX3kp3MfKA/Q2oQWqLXk16Sd
	fX6eeFZjUCrpExOnQnjSaJIu4tT2GK6dZMn+ftO/wsrVmWb5vRREr1/0Oaj9FV7HR689t2iJH7P
	FSthZV/8uU1EhoLr1bHfFSdadZhP4gsXBqLpSHg/51PmSCDz2j8SPtmFmh6o4WOPetC1uJzF8Hd
	PhhKvQ89h/Mh3mp+J/mK8xrFmZPhHdHRx1PwphQBj2V0EEDfnOm0fvgWznVzpQWFVxBzWgjJ3Wk
	QezLkb9E84ZTKQevkHxYdX7j+kzznK8RLlyvdD416DYkRbFjP3nd5qMrN2Nslw46Z5XrnZHW9TN
	ej8tlczr67BvVuTeSpz79Vts7HNgvyWskHk6eh+5gPWTd8
X-Received: by 2002:a17:903:32cd:b0:2e9:5a0b:9f3 with SMTP id
 d9443c01a7336-2ed27dd6431mr440895ad.7.1793828869735; Wed, 04 Nov 2026
 13:47:49 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030-work-procfs-ai-fixes-v1-0-772392d3ccfd@kernel.org> <20261030-work-procfs-ai-fixes-v1-1-772392d3ccfd@kernel.org>
In-Reply-To: <20261030-work-procfs-ai-fixes-v1-1-772392d3ccfd@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Wed, 4 Nov 2026 22:47:12 +0100
X-Gm-Features: AclHuK87Eq_CqZxMDwsbPp8xTVv4X7jqGlmaXniBVGqRBz3XJnp1SDTTtcBjVNc
Message-ID: <CAG48ez3c1dSqv6w=tOqFmhN3ELHMDVQ2W3JUCakfFkv1YE3geg@mail.gmail.com>
Subject: Re: [PATCH 1/7] proc: get the inode from the file instead of ->private
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Chris Mason <mason@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 5:12=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> The fdinfo files and the ONE() files stash their inode in the seq_file's
> ->private. The seq_file points to the file anyway so get the inode from
> there and free up ->private. The following patches need it.
>
> No functional changes.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Jann Horn <jannh@google.com>

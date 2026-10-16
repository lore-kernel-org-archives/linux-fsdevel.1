Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BC9371041
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143575; cv=pass; b=u/FMwkcuDWDGJ4aeB3NEWl4dwi8eTF39hWLXYxmHu2lJlbmjzNBZwSdQNdQTDDAAPB0YcYKnK4ABtiv5FgsKROfld35TyNh5lpb6QEn5ViIjf9lc0t8gpqNAWKMKkGbwubxKHRvhyK/i2Gqy0GrQi3IB21w8Nn3vizY5Jhy6meE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143575; c=relaxed/simple;
	bh=ZjCCv2vHBwi9IOWqvGjy/7XdqWbDo0x6Omk32EfPwq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n9B1r7mByeRkmOvn/98msUPDyV3m2CNIiW+OIVw9ANp3o+OKcPAce62z3O6PFEf6y4dsv2uTqw5M+DRPkpr0PRzyv5ZJxAOuU9sTt0BU6w+bRCm9LA4iXeioZyEZ8rtim8lNy/GU/jMvG/nlU3Eh6M21vZdVXYBXv1tRWdVKVsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=pG4nQDv1; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="pG4nQDv1"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35f036b17easo2179358eec.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 02:39:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792143573; cv=none;
        d=google.com; s=arc-20260327;
        b=bWg8GzlWoM5uBrNy/wnZ6Mk0Gr4dTQI5azH5+OtTm+48LlfsxqDSBXygKK9gZfSuew
         wJBaIqDlpsfDa5FypxxEe3NzqrJW2FTLn0EqpM2zpFHIpxGoOG9ZbdI71CInrrPQQUrG
         FwEXUKnkQzHdQC8Lgbnm1kuEeYojvJSJNtMJHKU8itjz4fYWLKNyJIOB5X79aa/RTvWc
         kqEdkHcck6YoTpk2R5uO6UNi0d786QlzX3tIstTxdzP+C24PxtCFigTQ72BUJK2JQLhD
         t99IW6xcwumrmOjcEO7XjHlxAhndaukR29i2xYySBCbyhmbNh572Ytxpeogk6zL3IupL
         9pcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=j3B/54ttrXHpvRKJzNCedyWQvahtZ3m41HUn5RlCMIg=;
        fh=9+exqFBHl280EIF268C0J9uMcecozVfBprQcAyCQGVc=;
        b=EcJORGBEGZ1SIJVtl/TACybduRQj/8EDNG1sXo7IHpx8j6ehHjDZ+yWdx78hh/fMWz
         oX6SFkrnIoRUEKMW33Ff/FARijYo29d381SDmvUygTnBz6Q8lc+G4w+qEg4DTlJ3Mt6z
         c1T2QfryPjpOXJZ4iM4zDWQ1VR+aidwiX5pW3s0vIGIQdPAvekPtBC8MZewFtqz8d3UY
         IOq040gCU8RH2KppC+Ig28/FGAOlZC2ef91P8jzIIwY7m4DjOYrzfCaRFgLeQSNHY/lh
         K7K1M2LK2ZJcUXWO+cfjb/xWsERjkYAAN6jD3QpXafA6u6On+oPpNRUlDU19wxVL08bU
         jJ4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1792143573; x=1792748373; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j3B/54ttrXHpvRKJzNCedyWQvahtZ3m41HUn5RlCMIg=;
        b=pG4nQDv12EahyCrQYEQrDkAydQxgNrSRZfZj5+myHy3cwyK7yYSfto51Jw9r2He6Ed
         38fNDs8UC6D++3SZ7Ubj2N3ZnRSvGEb7iex+k81vQw65I5fRmR79oZUQcz3gj6iq/cqd
         Wd67T/dEanOU/JUfa0G0Vj5yOzfmeoRFMs+z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792143573; x=1792748373;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j3B/54ttrXHpvRKJzNCedyWQvahtZ3m41HUn5RlCMIg=;
        b=bP89VJuEbUc435FBksY/j0LJCnVIm7sU14v1hbIQfYtJ8EqLq0r+UhAEZj8ny//m4a
         pcRC33LOR+jpiDEo6XZ9skzrpA1iq7QiGfgfHLxL81gauPkgeG5p/yhwv7XPv/UNIc8A
         RuyXK7RjToqEDB7b963Qz1uIcHLkNQ6AxdLyirMy5Lw0Wa0SGZhgQBdglmHVZHlyNMJQ
         YJezxjhgYZHXo8HKypGkZNVaUr9h+SuiJJypkfToujgGv8ZSRfRRxgHXBKHKw/Y9THn4
         4vEuG03QAG96T9KfIIBCWY3TFrSO2TEqHzDiCa+UY4Wnzb+9V0WrQ9uLQLmbftrZOQ5l
         BFnQ==
X-Forwarded-Encrypted: i=1; AKwUvBy0Hdg1qqP8ibzobpZjuQKMyGdwubhOzJ4VdXYHswKbe+p2HNGj9WTTmmw+nAFoOzrylNVJF40knCO349ob@vger.kernel.org
X-Gm-Message-State: AFq9FYIhqCHTLNA8iRnLQmI/uM4p7Dp4ituUpuiGPmeo8f0WsG+elZDe
	JTYm+pH81cQdM6o/y2qdyYHDnTpZ2Dz9mICEENI0tsPho/3PjhArjxp79wyfpxjBnSxfL9Wv2Nj
	DnPG8BhXrrIYCcwowhL23t0/Tvfhcpx0JCDCUxKHHEQ==
X-Gm-Gg: AYBFou2JN+nOA2ZGuc47DqwXBMF1WSEVwo9idPi+Zi22HLxsR1mpM+hYMGKlyT160Hq
	7EUK1BvvlyE1oKvgGWFOh0+lRS17p33dY7oDQb4PqfeV3LTUobgUmWEKy9E9+kyX/JAxB1Taa0n
	D87vv54kT6CzFULC8qfpFamnLcd+nav4QomV4sPH4D9Jbrhj4fp09AdmWp8h3bllsrdcyL5fOD9
	LIsfctPD0SHzrxsq/dV5UmlaRL2WBRxyWU6SlfQXYxn0CfgXO1pG1FetDfr9vNZFKpSMvHnqy1y
	do+3yJz/8pL57Sh3WzVrYQa5X+uypGVqdztuS74M5uzBPb2s0uIWAswhRld3sazBiPfB7OB+hZ2
	mIUBTsuk=
X-Received: by 2002:a05:7300:55a5:b0:35a:29b6:b466 with SMTP id
 5a478bee46e88-35a29b6c486mr18778429eec.30.1792143571660; Fri, 16 Oct 2026
 02:39:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929032927.1451259-1-neilb@ownmail.net> <20260929032927.1451259-3-neilb@ownmail.net>
In-Reply-To: <20260929032927.1451259-3-neilb@ownmail.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 16 Oct 2026 11:39:19 +0200
X-Gm-Features: AclHuK_HY98FdVFdI2B8_Xyq2_mR-0nCvi6kN-LGNYhpYxSjTYAUSIadCJthF2I
Message-ID: <CAJfpegtG2NGxbUjR-bifU4aWmswocYwZaxpvTSFooQ=F-dcWBQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: Use d_alloc_trylock() in fuse_direntplus_link()
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Sept 2026 at 05:29, NeilBrown <neilb@ownmail.net> wrote:
>
> From: NeilBrown <neil@brown.name>
>
> fuse uses the results of readdir to prime the dcache.  Using
> d_alloc_parallel() can block if there is a concurrent lookup.  Blocking
> in that case is pointless as the lookup will add info to the dcache and
> there is no value in the readdir waiting to see if it should add the
> info too.

Need to send FORGET in that case.   See this sashiko review:

https://sashiko.dev/#/patchset/20260929032927.1451259-1-neilb%40ownmail.net

Thanks,
Miklos

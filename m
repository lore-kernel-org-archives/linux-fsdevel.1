Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A6E3FC5CF
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 20:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783371375; cv=none; b=RJYfhNjxKUcKDAOFhKgzK6R3Dp9jl6knOgzow69PlolKEbuC4ja8GkYLktQksOrfYKga6SMAs7OyVp2nj3KQaID7CuF/y29WoIEUiL6FYDKWa3/huRh38GbNGw81jKEEy2e07pQgD/JtyVCouRAINl6uv49s8IG/maj4HE4RM6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783371375; c=relaxed/simple;
	bh=QFWRRi3dcvbfNDuINnUyg6dlCUW+03hLVAiuG+24s80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bL5DA9HZhjjphNRWmkt1T/cmXiV7TnCteb1C6aslT1YbdI1bUA7ZL4VkdHu1ZwhDVupv8cG1WgtJrrMSdKMx0tZOigvZ0mmQ5A0N88BYtn12sEXDZkBtfd1CE2hk86UwW1tlt4cSAitxaVKoEc0/42L4LuGDS0JuZ0B1Bk/skrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAvDFl9V; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAvDFl9V"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493c59f740cso24262375e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 13:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783371370; x=1783976170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zwPoF8Fmw0t1qCCzDlMOhOvsU58fwUTJ7U89Tmxw7lk=;
        b=MAvDFl9VFmopT7uY33IWMJxCq+CEJ6VfCxtCrBaqmE6npfmxtkrBZ0pRpYCbg68zpa
         MS3T7SrVGgUlCxAY6uBTbibtg6vO09q/u4ygNzf8vfFDY13IOsa/Kg0QNbya6rqs+7j8
         7VN7ioPGor+hgU16o8i1fCmYcSPVGgjP3qZ9Hxi5tMuctGSyynQCkvtyIkUw9CL4WX0K
         pE3RCRn6XAd/5n1Rxuh7dN1ULlqKnXQXUpCWUcv+JEalJDn90JeMXavRFUHLCqsXMVQs
         uuKxBTQZAa73osCmyX0JJKZtWoSYXFGasOJDUyQ0MeSsuF+z9gv6NA+4lCdUX9t3rClB
         Wn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783371370; x=1783976170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwPoF8Fmw0t1qCCzDlMOhOvsU58fwUTJ7U89Tmxw7lk=;
        b=XOjqv/WxP/C2+g7qa3hTmbl3cDZ5vgAIOwcSsWcuw/K5lw+Pj3JQfKScUO+7kaFbHr
         VGHvJ5AAylAbstnLjHm6kzF6Mt9OIyXdSJ8PXUD724leNO3iqq71waZO6XuonD/KWzf3
         ABgXJ2vJn7xEuvd7KfaPbIh4vLbxjhKt9voEL8P9VH7hrS42KMhxBkr7Eh8H/T8xZevT
         ljQTDe+HLdPB4mMy7PhHZ6e+imyB6id+r3RHQUW+h4jV3TjUnRDO4S52OhncsZsFmF/E
         S3FRxYHH689y+1NMOwY2/YfnhXfaQqygDnh3zq69CxzFYLg6V8xyVx8TFtzZYCufvUK8
         UsUQ==
X-Forwarded-Encrypted: i=1; AHgh+RpIuxLAx9Ti2lQt9v/r0YlFuR+/pBAjGl2sE2k9swx67AR/SsKOFCfI925fxGKM5dvv4RRyoa2Q/BjrUOq8@vger.kernel.org
X-Gm-Message-State: AOJu0YzRNiCZqbmChiy+Z6/nA5oylCvvLa2sd5b8WtmQla1l3N+hUmgq
	0wvBHaM74Jd2EaU16ODXN/NY+z6ad64foj/AW0z5hPKU5lApmgwDhknB
X-Gm-Gg: AfdE7cmIzd6vq9fadZsNoJF9XBt9q9+hJyJh5gB8NHTXmBVherXMSOFr2FUPQI2jZ/M
	SpLkFSH6bN6dZ5mD8SePxIGHCQdmgQIa2ARsL05m8yyIkfsVbBdpGmZ0YLidZSgCjKGPyIxn0TH
	OuOVEOdYPmXYAsCDYUXqWlXB5lrc4d5lyh14WjpMSGRG8qK4zrtWz4q7KRclwdJDlBRGWQ1izVY
	dLX+p6u2BKzykk0pNbmOtbxepr6eYLSJtGBio7hQZcw5mk5hyKLq1gdYjxq4rYjSmKR9QmUSjjM
	iH5SoaTiFydLy3Uc7bxELkIhAzaPVWIiF9qQraRC8uUTCm19Rv+baRwcYwrWIl/IctvVOkqwkra
	rIwdG/p9GousrBYOy3Z8sk3jVOIQCl+vuiGZfVQ9OywrGQvSho2FT629ZU54SeDUaWIleXa4W2V
	pRy7Jy3/KpYGPXsjYwJGKTJjyDorkULrI9ZFo4BiAQN5q98WZMY96HHFsvACiaVQnzLvPzddc=
X-Received: by 2002:a05:600c:4f88:b0:493:bd37:1cdf with SMTP id 5b1f17b1804b1-493df083006mr23349065e9.2.1783371369725;
        Mon, 06 Jul 2026 13:56:09 -0700 (PDT)
Received: from f (cst-prg-85-255.cust.vodafone.cz. [46.135.85.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f294b3sm244745e9.3.2026.07.06.13.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 13:56:08 -0700 (PDT)
Date: Mon, 6 Jul 2026 22:56:00 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Jann Horn <jannh@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Magnus Lindholm <linmag7@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] proc: Fix broken error paths for namespace links
Message-ID: <ua3v3vjbbyzae5twf2oywqysfwnojqy4fmhzfucqwahy75pgb7@bwq7sdgwyft5>
References: <20260706-procfs-ns-eacces-fix-v1-1-a69ab14c02e6@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260706-procfs-ns-eacces-fix-v1-1-a69ab14c02e6@google.com>

On Mon, Jul 06, 2026 at 08:22:42PM +0200, Jann Horn wrote:
> Don't return the return value of down_read_killable() (0) when a ptrace
> access check fails, return -EACCES as intended.
> 

This is the kind of a bug LLMs can find very reliably.

In fact Sashiko did report it, along with something extra to take a look
at:

https://sashiko.dev/#/patchset/20260518-procfs-lockfix-part1-v1-0-5c3d20e0ac33%40google.com


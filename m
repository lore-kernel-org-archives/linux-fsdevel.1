Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3EC286419
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 00:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779152238; cv=pass; b=KHFmYznTHYyQKGobINCCQ2FgqdMeEx8Meq19O1FKxgU4qtHhV2SGeVOz/x7tgopUZ9Njezvk+pj1mVGZ6Y5FFUAYOQlSSqHaQW2h46RaDPtAKcsd7EDaZ/VSR4jHLNaCBwzk6BgbGS3es1TI3W7JYOLABdeaM+VH0g8YlVze3Uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779152238; c=relaxed/simple;
	bh=kPPc67NtrAWleEKVne4c/j/uzzgH1YApxWrhWKlymok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C0HldioPsSsJyZXePSdJ/MQUc1OGLdUOOHq8x/kvbq79tKb0LUqLdXDvgfNl5LOSc5Pp9eyFc9/n95XTqPOuVpUoCKaLmXMAsFum6N9cgCHTlKkqMtDrFgODLT5eAVDGvP3jNH0nyWDjp471F7T96WXHHVVKIwMZQKIRRrEBL4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYUVY+7B; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYUVY+7B"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7bde9d73678so25943297b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 17:57:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779152237; cv=none;
        d=google.com; s=arc-20240605;
        b=bLZOkarrqz+ota3LDkkAiJvdXmbLYmQb41lK+jlum169MwRmiDm1+19T7eF+h3NurO
         1ztvnIWrRJwz+pGIo+t8glSeXdNUSDha1qJuP0riDHWGGraNEr0QmVmCXRtTqYTrZTHs
         /4OcTqo+tFI42p/ijaBhhFkvj+xs73fDPcANYV4ZI0roUrjALC1YjO0RfrQQlpxXCOpg
         9smwmlhixFoQnqcCNTdS7YLUIJR8Q9ueDKW5MbjRiSmxmIDUaP3mYHaJwSxqIeoa3XFZ
         oSVUBMgM+pMT3D04kvD91UQ/CACML/QnJYSjtZKYR0XGt6p3mQJ57B09PvLHNHcTU9iT
         T+mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FD1oyzH3rlFKo++Lyr0jPFwyFy9e5n7p6nOd9rFVQA8=;
        fh=3Oi0RxS2X240Fh59wDdmXRNMY5xy7pCmYI5qDziBgqs=;
        b=U60n72Sqv3UQfZP+JaGT+ysRs/NcBQryFObWow5516PMhJ132D0EvnNcT1LljddThS
         qvmn7RKeVLZtEdoRzq0NkUCX2w+jQGal5xlnP6aN3Y8qI+AFiTeMevefsEPVNStH5Kl9
         g5laXn3w4XdVmhwNbuWPcDQI42dRPQQ8AC0MHd6rV5qzx6lprPj65AegDWpx6c3KQXHu
         UN9Mj4Lb8rlvIL4XlUR5l/ZIflry7WClPVGB2/ZlKIuIC33ZU8k+7FQ1WwWyEoRFxi21
         hLX7Qmmgk2ow2RytqKs5fR7SfP5T278ch3ILprnP+ki0xQsVxdUBSKxCR55oC4byDUtH
         fMqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779152237; x=1779757037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FD1oyzH3rlFKo++Lyr0jPFwyFy9e5n7p6nOd9rFVQA8=;
        b=SYUVY+7B2XdjNCowpF9hUuhfmebp5hWWKvnNxcUYVBwaS8WsM2FRyceEUgJ6HJk4AH
         n0Y+0GCgi4tr3tNPYfhfow0c33WW4GkC7IgPAjp95PkiBam6N8UQYURqEzDlE9EaY0GJ
         hhy7os9J489zhi+37Sj0vkHUP0H/aaEYKKo+Rmq71mqPD8r/GX9Y2I67zwpehksPZ/ZN
         KDWONxlX6Sy47vhP4HjQosCOztwwCBWkhZGkZTBBU2EUuI2yJvGYL9S1zIDM1AqnQATZ
         2EsS/yC/nwnCsOX6fw2yEFzUTSb7KywNU1JUga6InzrS+rloe1AzwczCrfacxRlqjzW7
         gmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779152237; x=1779757037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FD1oyzH3rlFKo++Lyr0jPFwyFy9e5n7p6nOd9rFVQA8=;
        b=beT5Wnrcmx7j2iKqmKPqHiv3uumoubD08Y6FcFTU2HtwKtRLfCO68ejlzXrvfGxNN2
         VQyNjke3SdDwAfeyguchPZtW0GEd3Lv2NmD5mBnD11XnjbqDZxOGIxFnWolCw+7evcsR
         hqODevELJOJ+YPmcC7A5DjmFUWwHRS02fHgFm/hNMHngAztjKWvRtGpJM5Jw5a7L5eNs
         iIYX4UFsEhbhyqPtkrRO5kOHALwMh89XJV1zMI2+OuCwczzkR5GUS/RtU6YtrhZceCmr
         JJIhtcXPekrjLBU5DntSckse3Qc/8tZXOB6KH0y8fEAYEp9hIBgyHq9//GX+jjNYH8XR
         wEfg==
X-Forwarded-Encrypted: i=1; AFNElJ+LkqaFgSYRExOjCT4jAUy33/idmN1qrmzTUCXds7/61QhZzMKgFjciD2S/xsNppfUMqBwK/EkzJnUOIoIh@vger.kernel.org
X-Gm-Message-State: AOJu0YyLYllgh6FMf+1Ta3mxUZzAOGpw/DUV5OtPbYppnFhpSi/nsOSa
	qYD8RnEHJkwyXm4Bzqwj9IuYatR3Kjw5qgiHdrl+a+X/01iM5iEN5p2f5t2EY7kOqKlzAXinMbx
	oBUTN6CU0cAK4HHB2KJVk35vbUWt6awo=
X-Gm-Gg: Acq92OHFmt7dvvI5VhyMam0pf5IXd7qJop6CE1DqFbIYNuhVbTS0avacVrUD1O4YDaF
	OySNzB1S81YVywvH/+kj3IzUF7YijDvngZ6v9xoxSP/G9HJ9V+xpyndw4tXcITu7CJe+//o6kc6
	muhc5UHnawLYtO/eMjz7gppzETIRj5Nk2v7iNqdqyjxad9xqMFZQpFMK9HX9ff5/lzWqGmwuv8+
	JZaM9LERb+mbY5A1oqj2C2RvxUnOvRu9rFOEFoo8gYWoJU7ZLhUpo9wOwbS/CEusmsWb1Sd+p5C
	Wikw6lN7SoDsxe2KIZPQtCM50gxeMaG1f6kb+xqtayjIoP8=
X-Received: by 2002:a05:690c:c18:b0:7bd:8952:1322 with SMTP id
 00721157ae682-7c7e88e8bb4mr180955027b3.27.1779152236685; Mon, 18 May 2026
 17:57:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517111015.3187935-1-michael.bommarito@gmail.com> <20260518144022.4d0d0056d304d5fd9607bc10@linux-foundation.org>
In-Reply-To: <20260518144022.4d0d0056d304d5fd9607bc10@linux-foundation.org>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Mon, 18 May 2026 20:57:05 -0400
X-Gm-Features: AVHnY4Il8MSATFfQxeNIeO15MzMVRMDd8IMYQN5K7rcLoK7Kim8Dvf--x0za2Xw
Message-ID: <CAJJ9bXwOQ+7sf5Js7nZwRtn7=8+GXv6bjqk0X-+27L1XAX6DMQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] ocfs2: harden inode validators against forged metadata
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, ZhengYuan Huang <gality369@gmail.com>, ocfs2-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 5:40=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
> Thanks.  Sashiko review might have found a few issues:
>         https://sashiko.dev/#/patchset/20260517111015.3187935-1-michael.b=
ommarito@gmail.com

Yes, I think patches 1 and 3 need a v2.  Sashiko found a sibling issue
in patch 3, which is the most important part.

I'll send revisions later tonight.

Thanks,
Mike

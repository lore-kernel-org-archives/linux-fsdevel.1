Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE953876B7
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 21:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784929820; cv=pass; b=C7uCXYvvKWOUFrWKXDUAWqad9y30pcjtyNlzwUKa78HJNjo5p4zZuKwEFr4MOeDDrJaSukWyW9gemYJaemsHAnO9l7IhEKY3F2jB6jEhjLyZ4oyIls8RaPUNcQLYAyLhrG5Ex/zI0SuS4mW04vtWfgrdgvwQPfH818mMehtjZws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784929820; c=relaxed/simple;
	bh=GONOZECKD4VhAKuWjYwwp0qP75BxUV1SGAkrOKq4bp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ek2WkWm2ZrJsP3KltPhl9s3cJXCJm4A6CQSea6jXsl6E0NUvKCcAp69W6tRzy0+Wm+UIFASk9FlXypWFZwZE7BPK+8/GPf9YoUV/xctQNKpiq4byO6BIB6wPTW/SCk48pzpZ5fya7GVSrcKkW3annTLzX8K6K0bzg5N6BNnlOu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahBrZtSs; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahBrZtSs"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493b966dd74so5808265e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 14:50:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784929817; cv=none;
        d=google.com; s=arc-20260327;
        b=Du6CziOlZVCdikeORaI4Upzdb/XAK7qd4ytgw1Ypc/PAlEnxAvi3Mt2zhTiZLBs6Qr
         5AkWP/hbJfk2vxx+9/qDsifOiTHCCeVVjYO1qKcu2sRUNO//BXQsx3sgIhbo7u36EteD
         K3uUrxs81W6sW7SiylAe2rOaCgSnip3arxjktsHjcUAVOWST8yRAXpXWsy35HiRfG4BK
         sqCFoVBNZzykat0ojhcFdLXTjWjgOYaMJqwBwBUcKiyZcuaB6fhh68N394tLylD6Gg3e
         Nhxbm3cUt/F70SHH86haV/SbMQpWHXewUSf0SItUMjAsNnebv6NSwVgC8rRLLt5YQw8r
         JoZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PcTCJx0iNMKEVpJqVWQmDz8mtFGHipUozPuux86X/uc=;
        fh=cfMzSSoNxP+tpAHa8PuRE5s7P6FDbP8x4ioiFiaNy1Q=;
        b=qnwPG2cehg4s0k5oukcOiby+ELPK+/NSfqa4PQaQG9UYK+rZDnvR/7zRMe1l75lgDI
         TMz3vzE4qH7muoUhe0KyodFw+vx5LP3B1R0EzU6hk2dL+C2C8ofQmVM6Ay0qmpitcwxb
         xAXa4BuShibcp5jFDljNWp1nG+4p8TJyKs2bpkh8Zhd+KDfe46wtjjaVEPnTErhT4lqh
         NOJBZNF6WZF4LYsJIFKvdSSlUE92QCv2bURMOT5Y1xImLokhR3/bKMtkSYksSjicejA2
         FuOo3yCO0QhOkuPlJqBN2zB/80oWYZltOUt3DRPt4+ji5BwdAdeKmdX532WuQ9EMv5uu
         J6lA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784929817; x=1785534617; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PcTCJx0iNMKEVpJqVWQmDz8mtFGHipUozPuux86X/uc=;
        b=ahBrZtSs67kDaSkppi6tu+bKx31L3rQSeMDpDEDVWSOM482mlwVnGkh1+3MeqMFpCO
         qwyVbJN89xtMCvMRHPTYRIo+HAf7//5hh0/ex81bcERPxRuFJ20BU4hz2fL/DflhZuzj
         TEzQV3rnp3dNrnx9O5rxuHaqrahc/iMWlxqarNiqTj1qTQ8W7LdyyajfPBVITa9iXsVa
         KiQ/FKgEK5AWan6el3kuE3ZDOQnxlIESXECaunNhnkrrlocLWIyHGyE6S/qPY98dHCQ7
         xvivZBhoBDR4qLdHYCSeLYD361CthJLfjAzB/jRFHqgNJ+3ht/Rf4cW/fcl71KdmePTS
         aXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784929817; x=1785534617;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PcTCJx0iNMKEVpJqVWQmDz8mtFGHipUozPuux86X/uc=;
        b=QABhGAH/WjAWWv9bEkTOxPq2Djwe2ztZgLtZ/ZpnTF2P5/iTekY31aPPso3lM1MJg4
         U/RNB5GEvQK0Z215qZd3vA+lo+ognhUcwCpen6Gyv/AdBSpzkqGdDuz5nhpt12bIEZVY
         Da6q7oCUbSkomvTYbab7Wq0rTw/SUzdmFVTEWtSv735RXAzaNSCmvh8PqfCWCBI719We
         VRbCzzWQ110Ji24/q4XCxwqvCZ2KgBOZ7Y7AYN8bJIMO7QWaU+4iy1ZvX8tazVjnqB9u
         4jM9uyPTY7ig1NDr+ZIhGHVEpWe+aQWRA34p+S8lCvlJ/mLU3KTJFNxQC9u8L7PQ+XFb
         ky9w==
X-Forwarded-Encrypted: i=1; AHgh+Rpp2kCrj0N8gpL6xksFtkaBMFeUZafsHesCo4D/0ZHfJq3Hn3NPdKvU0QYKz7vVAcoOgj9e2Vj6o08zfV0t@vger.kernel.org
X-Gm-Message-State: AOJu0Yx29m/QXA6NdZu2TpVqXcUo5R+bPAtzpRvM+iux9APHNvWT1gu6
	l6ILXSD/sPYo7e7YNpidH0UG+BG95BvdHV5dUjni98buO+oCXxuJerDN8h1LVuS/wJX+bL7Bf7u
	d74cOSDPJOQtoXEZAGwe9qIYZGXMaHyw=
X-Gm-Gg: AR+sD12ovVgoqSVvY0wFHpA1ECK4SlyJ3TMelhQSP0eLcvaY89/XP6uduxUSiiHq9/F
	oOv0YL0gHGxidc1aJRaUxjCtbQrj0mjHNJpZbK6tO6UrksaDz4N/tLLideW+RHNpA9x8rhGLnDJ
	LGLV440rzUBqBG664KlnUoxUJHbipxWpgbc/Ktdjj3zjyVgxwJMmOS/4jD/U1ZwyNhQsWGInma1
	cfyHwkM9M4Wqbqe8M/yFhkcdmJGt7uwyPGsExx/tKNKxBf23sL/bfq6JolnJbIMKF7yn59zVose
	pF8jyX8NLtHRY9yz335a81wZsEf+Adt0fgKF8A7/PA==
X-Received: by 2002:a05:600c:3507:b0:495:5dcc:52ae with SMTP id
 5b1f17b1804b1-496b56e6f5bmr907305e9.3.1784929816876; Fri, 24 Jul 2026
 14:50:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723050201.3381045-1-hch@lst.de>
In-Reply-To: <20260723050201.3381045-1-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 24 Jul 2026 14:50:04 -0700
X-Gm-Features: AUfX_my_nPSev9bT-9Z2cTW7X3xJ7bo6cpxTit3ZoW611uMe8LHBds-augHG3Tg
Message-ID: <CAJnrk1a=83CxXxqaV23dpT_-QTYAoz1pkeGXDU5H0stUW0kVmQ@mail.gmail.com>
Subject: Re: decouple simple direct I/O reads from iomap_dio_rw v2
To: Christoph Hellwig <hch@lst.de>
Cc: changfengnan@bytedance.com, "Darrick J. Wong" <djwong@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, Carlos Maiolino <cem@kernel.org>, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 10:02=E2=80=AFPM Christoph Hellwig <hch@lst.de> wro=
te:
>
> Hi all,
>
> this series reworks how the iomap simple dio read fast path is called and
> decouples it from the generic iomap_dio_rw and the iomap iter.  This is
> to make the iomap_iter_next transition easier and cleaner.  It slots in
> after the first patch from Joanne's
>
> [PATCH v3 00/20] iomap: convert to in-iter iomap_next() model
>
> series, and the first patch from that is included as the first patch
> here unmodified as reference.  If the approach looks good to everyone,
> I'd suggest to include it in the next spin of that series.
>

This series looks good to me. I'll wait a few days just in case
there's more replies on this and/or the iomap_iter_next series, and
then I'll send out v4 of that series with these patches (w/ the typo
fixup Darrick mentioned folded in) included.

Thanks,
Joanne

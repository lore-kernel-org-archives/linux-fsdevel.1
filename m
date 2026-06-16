Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0A130C360
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623679; cv=pass; b=gpUJ3AzmCex5XXkMwDm87Zse+pJhtFMRFg9GkISXfvUKl5UDrxRlOS7HveByQp/s+74Y5xUoTbJ8ynHmq6h4TDiMUMt+P9zpYW76BOyEt/BQqv0Lnstsmj8+1ygFq51mz3h1FcW4/MfUBe9/Wk3X3EuarQJWo5phMAICvvseviQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623679; c=relaxed/simple;
	bh=JLrM1xbg7WNoFd1R52gDVcFG2OYrCj3C2PfAg6PrdI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V25oKQX4CO0KffFU6RjssV5sQQzW3/xMeJTOI8Ttr9NJrzafNLvkPyrtY38hJ1rPS5y7Z2hpu1x78KXUQI5uGV7OFVozFixF1+VOOsN6YTAtnqxJn+h1ZKdx+Mi2d4dbOE/nfGS5kpdbpy674JK3cHQRxziheaytfMfr7dzcbiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRUwX7pq; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRUwX7pq"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-68d23396ed3so7993684a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 08:27:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781623676; cv=none;
        d=google.com; s=arc-20240605;
        b=EzEQS/KRa0B1lNZMxfIy8LKRLrTiC10UDSYBeh5NoaT66Ujpogp4b0y9ZSvT2mm39H
         tTWHyrK0P63pw5rVo4OrdAJD/YlkqULmP1AWrSrCOjL67jM2RbEjoUr6soshPFYOhBJg
         uJ03kFAJ6M/696lSdro1eRnkuVueuM8r4rVP7F/9pvsFzUSnSJvJ76f3GsS/0DmG9og/
         qaW41phWBRTcxG+RQ1faNkjro0FMnlBcdJATye0HycPhG4UKlu9oZ/YXK56lCDR9DjMm
         YFBPMKSy3OnYwzadPIZpTujSCPXdM2f2lQfHqrwp9T2+bCHH8thnBnkHrsHRm6RhJYFH
         L/WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vfwq8LlZeHpEi4EpQFth2IGbia8ygjuHEcYigc5yQBA=;
        fh=0JHQwaM9y4ih+Bc/lAjzb57X1jqxHBEdOC4gwi0KI34=;
        b=iuA5ewORi6HE2V7cJypHVzd5RSWivTD10PyH/wS0WGJAPIl99wVUUhHwRalDZ8bok8
         r84gElvI4/Oz9oWCRg4E5fQQ5fPET30PxdRXA27ht/i6YVDGTY/vSwRuFcEmI7PCf/zW
         HiZLvZ6+wTg1+iBWJePg4EhjsvVpwhkwu32UoWecs4n5eUT/bgV0OYBchSti6R0Sq9Ga
         cBZ3zAlijOq6Non1m+JdzOFwp8xRTsuPuci4iR5orguC6QffrrJUC3tMiUZLgd+ctVPd
         w9Mq6ML5Sp4ift22DDludVHvZ3ekuCXPPpcmjI/P9+1/8oy9J1IkQUgTboqYwv0nvRx7
         FCPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781623676; x=1782228476; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vfwq8LlZeHpEi4EpQFth2IGbia8ygjuHEcYigc5yQBA=;
        b=DRUwX7pqmvXurf9GcSJurP8uEkXha4OiFUZGb/5BW+DgIYaA/n1t/OGY2v8CRXHVAZ
         dLbGbmLUwDkyt0lVfnS7cyLssMlxrG/yHPF1xCiYayA0/96mEYSeyNVcdy4c1UUU+P+L
         yk7fmoVxJ9oeQWCufDz/Y02ya7E+g8SR+4dSqCnbPzxf1mt9Te3OB00GoAG6NVo0Rg27
         xiRPfX7lYHGBKNhTwiju9aLrHN5AJvY21v9fwxDRP6PM61Qa/oEyGxITLcO3Ks3147mq
         dfZlO1MEK6rv+Ww/TSE5h0fyuD9iaURvqzE5iWySgHX2M99mB9/zGtgsJ2WeSPnydJx2
         SXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781623676; x=1782228476;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfwq8LlZeHpEi4EpQFth2IGbia8ygjuHEcYigc5yQBA=;
        b=ke1c226sF1kZn+9SO9UrNTfAfRGMFegk2AIS2/EGTSWW8bJZ732JkFimL5RW+jdkiK
         aT3uv+JbaJshdN6y/tdLeD/eTZ2IbiG1TGDYdCPp/VonHKFb9jB+2KwU4i7Z6A0n7TvE
         MEJtTLRuOLE6s0OAduh6mDI15RXkjVD3uoib1gEobHoVQ9UVaA6zY+UyGPfM5Xw8UT2k
         cZEg6dezNzeNt0rmutG8984sv09O5kC+P97UlVnfMsOdUHtXbpdOK/cC5s8Wy8poVBNg
         qCgdDTEH4EKoE9E9pTo29auEDFJwdEKB/t7ykz6t80V5YL93rDTZiUOaVqqZTRGx88R9
         NaiA==
X-Forwarded-Encrypted: i=1; AFNElJ+uJJSThu3I29I45oNW6SjKG47RAKqlZK5axi5P/dPuDecqTV95IaoOHYvnVzE2bUPdhJJE8IyQUlxJDnNY@vger.kernel.org
X-Gm-Message-State: AOJu0YxS2p4I7WUeBCH5M10DgQ9/idsQe1hWn7VQA7ABv5VYOnM9gCyZ
	NyovRhCWpzkYChYICIsGFVDQhS4CnQxrrs8KKRC4yJOmHYcZwicpetE5VfKEj6oe302aDOnHtEm
	1ktwkMwMi3YnUUz2yfIvairj/B4szn2PIla7s
X-Gm-Gg: Acq92OHB8ScOuUtfC1Scgx0ZBfSOty2I7uorUnB2nuOauJAluM7cwdtECqyyfQQb0n0
	+iRzVi2vEJa3Ucgapy71vB8z+bRK1XnyfJFdqoEOIQJpw3pVafKACC8RAyHzUSuN8y+wcjahP8+
	LiSimdZminzb4onhXPmeXOceoeifte00lhXr57/s4xdBEkS2J8WF8hyViw77b9b/ol6RGE478Cf
	el5ibvc6ziW58VXJMW+Wq5wcozfthuMfFf6zH3s2i6kHemLFFFHe5ZLW66JiD3PZ9AV6uIWg6PN
	nNOilWTL4g==
X-Received: by 2002:a05:6402:2682:b0:693:ee1:9018 with SMTP id
 4fb4d7f45d1cf-6950875d115mr2305500a12.28.1781623676259; Tue, 16 Jun 2026
 08:27:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613172816.18034-1-technoboy85@gmail.com> <878q8e699i.fsf@mail.parknet.co.jp>
 <871pe65ydk.fsf@mail.parknet.co.jp>
In-Reply-To: <871pe65ydk.fsf@mail.parknet.co.jp>
From: Matteo Croce <technoboy85@gmail.com>
Date: Tue, 16 Jun 2026 17:27:17 +0200
X-Gm-Features: AVVi8CceXckBfhnEW0xk1QjPnFAyQ9rYfoW1lAEtdlBnLtONlrsgU1_PHWRXcJE
Message-ID: <CAFnufp26AYeeDF9Jv8_oG4q5FG=D1t-WXE0qGFJK3ozatnq79A@mail.gmail.com>
Subject: Re: [PATCH v3] fat: stop reading directory entries past the
 end-of-directory marker
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Andrew Morton <akpm@linux-foundation.org>, Timothy Redaelli <tredaelli@redhat.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Matteo Croce <teknoraver@meta.com>
Content-Type: text/plain; charset="UTF-8"

Il giorno mar 16 giu 2026 alle ore 16:54 OGAWA Hirofumi
<hirofumi@mail.parknet.co.jp> ha scritto:
> I re-reviewed this part. Since here is failure case, so we have to
> release *bh, isn't it?
>
>                 brelse(*bh);
>                 *bh = NULL;
>
> >> +            return -1;
> >> +    }
> >> +    return err;
> --

Oops, right.
Can I send a v4 or it was already merged somewhere?

Thanks,
-- 
Matteo Croce

perl -e 'for($t=0;;$t++){print chr($t*($t>>8|$t>>13)&255)}' |aplay

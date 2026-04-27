Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7823D8906
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304151; cv=pass; b=MHowxrD+rnzNWB4ftQZC4XSOCp7moZhEimH4N2IoZQ9qGWQv6X68UOMf8zVelmldXXCek7oLbBV/sVzUvSRCCX/xyt8A+jNnfMUi6Z7gbLRkjAKl/onrzY24Gvr914cIYiXvX1uMJoVNNEB2qtLvUEEdN7gGL/FkZ6fYz4gK2bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304151; c=relaxed/simple;
	bh=OJ8C68rHbb+yhqS9Gv7h1e4KYiHPaZDzreANAkGjZB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kPzIW8WaqFFAjYQ1j0EiT2+E/onflP1mZgMCETYDzQVv9M7sM5VtPGJayb+pAliF4eePTsdwb795gupwt/jgtpRnaOmJBgSgiloJ8RINNUuQMuqj67ijCrnLn3U86akVVlKU2OyCI0VxdAvGLEM0PAfp15LR/VM5nZwwGbdIu9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8Xq3IYB; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8Xq3IYB"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d73422431so9665810f8f.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 08:35:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777304149; cv=none;
        d=google.com; s=arc-20240605;
        b=URwGXrnFYyC3+eiXO25W0R7MAKfrZzSEVRBXLMC0v8li+kG+oV9dHKR8n5BfAueWKy
         wxeeUEJ4FZNiDNXp5cId+QUSJ37MSJ9oGZuzH6OYSiSgdJVOwlkaH1NYotTbwYcKquHp
         IAgFzWpWk/yhuNoGG5TD3L0vWyuqrTWAuD2UNXAjPUgA0KHwIeKHrWqCr2xX/8We4iVw
         Epd8vyV+H+qTbucwS9zko+45RQR4+5GuElxSxZ4bt+5HJtiGBJhyk+ly3sn9QR/W9oO1
         8mn06hq/U4GyLSd8lvX0VXoPgFZlaqmnXh1umgCqUF4ZIRL2N7NpJPrW1NlPhaty10pA
         21+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OSaSMqrH5WyzZBVNlDG7oX+MGATMWsNFSbJOtB4IE2A=;
        fh=+necO+U42X/rhEnDtPD2BKhPAYP4HjZu7v0V3wjQVlY=;
        b=Wjc+Wk5kDB3tavQLcZ0PwNvJkeOuRcK/JCmasqEZTIBqt9RMuBTuE+TNBXItX3G4u8
         BCO/KYlKsBlKPblkTlhUJDEtFrRScHCsKxV2UTfF9gQWJk3xIxQq11mItzs2JKYzUNIv
         8/ZZo6/cRlaYofvEqQeBaS6cxxdlFBwygPtyO2pZKjOwTyvp+g5LgcmvzVejkUeSj2BS
         ELP0dZjqRXtayOcie7ZpmuRT7VKKpbs3kGHNUhJ5EjER7zOYclo88zGMvGdwJ9WWlQl8
         9xhNweUMVxv6uzQe5avbCO022DTcd6QttYGfOtCYbpoAhMEQ91nNwCXqT7m9NEfLBXsy
         86pA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777304149; x=1777908949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSaSMqrH5WyzZBVNlDG7oX+MGATMWsNFSbJOtB4IE2A=;
        b=P8Xq3IYBpt0ULXPSQzs5bmstX4Nf8tMLkvh7Vlh6jsc5iZazFhF1/KK5gyldYWNgwF
         e0hDE787XYcUqIN+99Iz6g2tNbJPZLPjsPkQto9LqkuDXAuGvW/nh1xve7wdGgFwI/iK
         JXYke671WcnJpdBOpc0nRE1r6eYVGw2YcS3PaUlUpFautc7D1miNdB4xfyncwBiz9vrt
         WUiInQpSFveq8VZXdgA7aaTDQS6jw1C/LWccewJYzdCg5/00VtW43TqzO+/zPGviEZhQ
         bh5jHfb1Do4TfrQeO+3TtJ33cw1rsl1IKr4phifylssFFOwOwSlOisNjSUDXO6E5Ogc/
         LU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777304149; x=1777908949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OSaSMqrH5WyzZBVNlDG7oX+MGATMWsNFSbJOtB4IE2A=;
        b=UVbLQS7d2wrjG/B0RIVCDaKkxy+uNyAxkJ402KTYvVz/IvRLGEcgOFBoly1YZlICaq
         rLBfOPB9ExLa6gronE8j2ITg782rNH0N3B7K2oVqKWAIFT2nD4sq4M2viVUwatzgb+hl
         9IUdOWKpD3McBZRJ5U1AVJzPSqn94MT3ogJ3WG5ckzmekasHbLZjzNOJX59JLqh0C4h5
         ML+6PgC7Ns95wEV+lCsTyy7cdESqlsCXPJUPrnFi3Lo+8+DVtrHt9H1TSYqZc26GPqMP
         H+sT0lEeiNJx6+3EDtGrbY5iVwyQC+JZgbq2rbC7C5YzX1Cesp2Cf6aAhb6LFdmaa3l1
         XxZQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ADngFIGfqxgCYTVwn9r2waSabBk/LPeY43FGYnALCKfdivUBWWuIDkttlPLueEWzPyf8v7LhbapVqfen1@vger.kernel.org
X-Gm-Message-State: AOJu0YzWPmeXLc9MZJKftOgZAakjueqPzCMWiZS/Ek8brz1HfCjeIpO3
	E9fRX7NbsT2GQgXvVk4ynF49YF8yo3ClzFGNULK2gRFFp5EW213EKi0r8edzMsG9D3qKVJOVvQF
	y9V2wTrrm2wfE6MLsoP19TGBilb6CZDM=
X-Gm-Gg: AeBDieuIvMD1zEGEaaRXwEp5mKGPtersGCp6wj1zD1FRN5sbbXZU7L5eRDPOg6lQzpn
	VTA3O2cET2O3GZuSpBBhBLJpRea+nO3V3+SX7vTJFHHW5Yi0tXeprYHqcoTE9C1KRSpqFQUxtrN
	nmxiPKbSUtIFHh2Qro+YzQEYXlVBBuE1xQe8ABCuhPbEp0MEGYKeF2EKYnxkggjcys1EjrI3fB/
	a9bsadcmWQK3MLgDpvbFNhSzILa81kPuEFgfF9LpBCsK4Rq6Bmszsd7LkEKL+d4mHhDhVBQIwZQ
	CJsCDuVNVAcijajXfimCB/0rk4HoDZakCg==
X-Received: by 2002:a05:6000:24c7:b0:43c:fe0e:5bb9 with SMTP id
 ffacd0b85a97d-43fe3dd4ca7mr67804820f8f.12.1777304148368; Mon, 27 Apr 2026
 08:35:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com> <20260413-reduced-nr-ring-queues_3-v4-2-982b6414b723@bsbernd.com>
In-Reply-To: <20260413-reduced-nr-ring-queues_3-v4-2-982b6414b723@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 27 Apr 2026 16:35:36 +0100
X-Gm-Features: AVHnY4ITUlhMMVKTj9K_yTE69N91M4XPki42fvD4YCQ_wychvf2_XkPg22dllPg
Message-ID: <CAJnrk1YNXEV_wmN3qCWvVr6xM5fPzxE5E3ry6eA24o7cr+mOUg@mail.gmail.com>
Subject: Re: [PATCH v4 2/8] fuse: {io-uring} Rename ring->nr_queues to max_nr_queues
To: bernd@bsbernd.com
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	Luis Henriques <luis@igalia.com>, Gang He <dchg2000@gmail.com>, Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 10:41=E2=80=AFAM Bernd Schubert via B4 Relay
<devnull+bernd.bsbernd.com@kernel.org> wrot
>
> From: Bernd Schubert <bschubert@ddn.com>
>
> This is preparation for follow up commits that allow to run with a
> reduced number of queues.
>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  fs/fuse/dev_uring.c   | 24 ++++++++++++------------
>  fs/fuse/dev_uring_i.h |  2 +-
>  2 files changed, 13 insertions(+), 13 deletions(-)
>

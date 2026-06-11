Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC3D2C0F6D
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 07:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781164390; cv=pass; b=PrKWZLCo05wWSFHpWOmjSC3lpXJPg58meaLU0fzjW6JTaYhfEO4GPYExnZCyrw8L199cYm86wf0CkAxHYcRqf/1Gf2+gh8ckQWXnW4gMw9uzIMwOCc65lpTKkQyPtosbjDGO2zx4gbCLpHby++7HQgAD3QVr5VNHh8gmVpFO8Is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781164390; c=relaxed/simple;
	bh=sNSfo8zUpmWK9Y7Rd6wY7XxVAPz6JobY0UcL4DjKuA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FM3N0bF/hD3uu3Yw/BUt3GalrbzNAs+OKum/MQRiYSAfmAwecWaR/G03WuF/mXAVtm0Su38Ifh2rPpkNIdw8fKigorFcp/Xn74GSsA7d6E5Cygdk6tzJVBv/q1wGGhNTqVpKJwZGdXazoXekai0/wI8Cv07NphUAyvyW89L+WRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=OVRu6O1B; arc=pass smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="OVRu6O1B"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-915aa0a9293so80360785a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 00:53:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781164388; cv=none;
        d=google.com; s=arc-20240605;
        b=CW+Tn7teBw0ryBXyxxrehmiNeiDgM2UVNdwHgeqA6b70jkQarxrxXfCTVWsyRRvIE8
         f/o96LRXpsd1mkJD80EOSvNbOIhfJ3BtocAsjIez5nX+926RzqhHg6iGXpDLMFw/RfWo
         k7D2PY40NcvlowlbJhUH2BhodsNM+OBPUrgapbi3mzNE15KQb+xmJCn+Czx59c3kcwEf
         sL1qSh41beAJ/aP3SH6daueithQiu9wNnn/9Gk9vDRxasYjpX4W/rFMJXTz5LDTqnEmd
         W2ahxwk6NrYDAT1G1+kkufIh4F5tqFyiNfKPIrDpwRsJSHVL8+REAoprEfI5Aml5jh5a
         /Eug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sNSfo8zUpmWK9Y7Rd6wY7XxVAPz6JobY0UcL4DjKuA0=;
        fh=NgsYcLaiUGjTd6HNdL9Q7aE1rpTv0YjXH+AJ+smRs40=;
        b=RS9jlVczzsOyvBk4v4HjD1Pcxio046EAmemuZEcHRba+8W5ItbvIApKA8lPfCxPVCz
         0dqL6dC79rK6mTLHdO1OV62VAdYVCka/2qq3DrA6P47BX4vi/kmSAP8l3p6Hr1xm0az+
         Nnc5ueb8bCHwB/hWxvifYqgP0PWsyojwMAUCrq1eg+Ghbm59n2iAiUfv0SYDvWXzwMp6
         OyK7BgpFRWZz/r6+lYWzSA7bMd2LZPCZiJb36QuR05l/c7MDFaUsIrLb8DF2QDu/2Op0
         4fEsD08jWhmeuWtd21yQfQnt1Nu//S3O7d6hFUMOevmG2wOzsjRuPWzXfvsOKaVrvoEZ
         3m1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1781164388; x=1781769188; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sNSfo8zUpmWK9Y7Rd6wY7XxVAPz6JobY0UcL4DjKuA0=;
        b=OVRu6O1BsQID2LsytAg+nbdlQRJwk6SpbZa3c1tC4xzk884qiPbm/jZxlEm1NBVYkA
         WltuVH0l1bZ5Yyoa4sfxPJTty0Iw+Y3Xhnh/23ZZVI1pqKU00Ub32UJp+bIkK2+pkp/2
         LO0kiaYrnBceMkM+KEqzl7xMNx+nULtiS9ND0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781164388; x=1781769188;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNSfo8zUpmWK9Y7Rd6wY7XxVAPz6JobY0UcL4DjKuA0=;
        b=aNn75sM34J9tE8YmpDFygudzfeY2Jm09ePAfpGzSpjojGam+U5QCPinATgaU4VhLqL
         woi5zNQYmjGFuUh5lxX5T4grkWoyYBJIl0+8RFbfT9t0pPJ0DefTVYh61L8+/d+V22+9
         7K8sE49EROJo6Q5xF6Cy/sKR0+pDLbOyICgeqgWyP8gdkX+CMQQn6O49I9n1/rq/qP59
         I47rq67IBfXktGLym1w4Tif2BRkaYAjhCd5iNv+4STG1i62/hiTIQ/q5mDy4HKwBq3HK
         bRoV/NYwx32RTMU4UOpfhFOM8krX6DozVQ9DWhU4zlbJy2w0c1a0blEL1v9NwYqJh7Wu
         IBlw==
X-Gm-Message-State: AOJu0YxsrnOJIkuuxzVZSHpvjLTomHKMwpZLvQxU77mhZjLcgyG6yCGw
	6ZSHoHySwcPHzYyk54S6G63Pu2TkQV7HXZVh11FP0tCAXPunbwArQYVrmy3CB2hGZkxgZVtGHdc
	RZPMim++1B+hK4gQaw0odUMrDatSAhFOR2z2mWwVJjA==
X-Gm-Gg: Acq92OH8JAxXAbUtEsa3oGI5d41nPA0L799ZrPfp734mESCHRibesdi6VUREINHSd9y
	od5tGsd+HdfUf31Pcw2eZjlvLNzO9APm7E5lGHQT1YjsKLqHU+1mL8Pr8b9oANwIpdOQ2hxMsLZ
	g1e2HjMaNOmUgvJAs2vZE6IdAX6CJFa8AdeqSa+5znbJh+kodKTkuf6zmfTCETeIuLFjj+uWHwT
	Y4RpTeJv3RAYZY6KirKErV9qhwd1QZ4d2pvfGDEXzEB+rrjPiC+A80hqSfUw0X0J8cglucDHYWH
	v683/geA1doRJB66riEzRzEld150Eot/IWFLZoWxiTqY4ZmIZNM=
X-Received: by 2002:a05:622a:410a:b0:516:ddfa:b6b9 with SMTP id
 d75a77b69052e-517ef0b7dc3mr16791231cf.23.1781164387823; Thu, 11 Jun 2026
 00:53:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306010525.4105958-1-joannelkoong@gmail.com> <20260306010525.4105958-5-joannelkoong@gmail.com>
In-Reply-To: <20260306010525.4105958-5-joannelkoong@gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 11 Jun 2026 09:52:56 +0200
X-Gm-Features: AVVi8CcA1bGPhVyiQp58ClL367XAc0j0KAt5IajVY3kppNLV32oVn8_CQhI39mg
Message-ID: <CAJfpegtNdYsyusKpazfmzcRQf7JKSds07zsBrdqMm6F4fZQe3Q@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] fuse: clean up interrupt reading
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Mar 2026 at 02:06, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> Clean up interrupt reading logic. Remove passing the pointer to the fuse
> request as an arg and make the header initializations more readable.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Applied, thanks.

Miklos

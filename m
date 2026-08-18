Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301503446B0
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 08:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787041614; cv=pass; b=an5WS9dXFsKV37RQYSAXMBAjfTRYXnmZYuCsoj5cC2hYNghsXM+kry40la/PSlStHOeVbi6jC60thY6seWQY9KwQ6mO+2sduvTgkHDrBreApvyOxbNPRdwAV64cT0o6E9MDn/8F/TBDo0psSKcHZo/spxkyi3Pk74xjwRPUiQgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787041614; c=relaxed/simple;
	bh=2Myb2+yqDeCxQ9gqAc47zhR9XON5EgteIQveOiiHKnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GoK6YoCRRjGH31B0VXn3ErHGG8O/oFb2II/zOA0fgQzhncSGUqDWuAKtb7RVzJvD1+dtzEtFqJta1JUSxSfE+ffsadRRuh4E/UtuFUtlu1/u4iZSEPOh/lvj2RFgww4zdZuKFQmvvjpwMsFzQPJNUwM57xwI1CEvfcrzcnVvO04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=V4xz3pMf; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="V4xz3pMf"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-52b3934af3fso43410251cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 01:26:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787041612; cv=none;
        d=google.com; s=arc-20260327;
        b=MfGW1G/jA+qwyTVAIC+GwSulbQ9otllSHPzInEWWbUfaITewxW/mMWw07k51ng+IlU
         zLhnRZDK1IJcj7VpLBdd0ibpPiIfoiXKbaYmTherKUogpMBsRDTGJj6ixwrPgQRKaY5b
         DjbkuhybAphs6S5O9HYLg7cjoqDDDEsdtvLlMRXs8xFX1pb1QxTMCOsIpe3W3ua2Nx/x
         +tWnf9iAwr392jZMgOBnWx/uFSvyS9R99QlrLZajPF9hlvEHKJ5rsXSDZR36J2zLA0gT
         j4wvc9LILr6u9JzAAKVzb1lc8MsJQTAzqR+EFlJHWVcUBvGaQnRwsfkPg1cNtXyguVpK
         qSpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Li+5o8nckwjrY5g/MDrxhJ+cF+3KxPxI+CbcJDK1QtU=;
        fh=3iG/0z5gnKYPvx8qjIyWAjgTa7HqTIZ0uZQA4Gp4jbE=;
        b=IMgrHf3A/G71co8Gxm07x1wLDflUfC6eA2ZorUMLwYWD2AeWSPLIiCsMHv1TXinIf4
         eDn3k4Iu81imN8yHoQe+l84133m+T6IMdXZexP3Z26/lPAsYIKzi22T9sPmiRI2BLADR
         MDIqMJzmS8l8OrxoTppGPY+j81gXfIDLPRUq9I3YkGDLAI3ntKD/JwDlGFWdHLYwqV9j
         RLiAjSeUGX26rJoobAnd1IT3ZTXwWd4/PW+U60K0NHY8Sx8TM0AHA4TOUDTd7P5OHVLn
         Zz4fIwmJQB3CBtIzMGk4392/hR/hTPHKx9TcskIq8+cLv0MLMNvsh7dN0vEPgatv67sL
         MElA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787041612; x=1787646412; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Li+5o8nckwjrY5g/MDrxhJ+cF+3KxPxI+CbcJDK1QtU=;
        b=V4xz3pMfAtSQA99q0WlcsB3ubFDOOhlSqrE/MLB3kOjlC58pA/LsGRCBLgh5N+X5Bx
         ZUbtGSoKrNob5NzjkqoOpkmesnf2fqJbwIlclf4JlEkeVijzq+RGsVusnLrEy4qqcFgt
         oTGyGpoh5X0YHZV4THbJnlTU8gkEs6ZHNssCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787041612; x=1787646412;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Li+5o8nckwjrY5g/MDrxhJ+cF+3KxPxI+CbcJDK1QtU=;
        b=R1QqR0nOrrrE0EGO2ftZ7ZC+4ZAJZP0pvVabyE6slAXaoOeVZzbordWgxswqEndfvu
         nEYQ879yyvFY/qAuxi6Bx7iQ+Fg7E+ob450KcqIYZStETfL6KAuPRXEXMxThCHRhN9ee
         rqgtJWr6Q+GcKNl7aGpc1rc+8YWUf+2hIso0rR0VcLhFsdsRjuu7MfOBw1xErJm6teem
         zB0nCabplXo2yVc9vdwFresgP1v5qRuyWXzVp9lJXzr2SOwP8wKVgoJg3pz24pnMuaWO
         3usbSW6jiDLaXVfIm2d5pAdU16Q64DStX8m9zVdfhSuG47S83AdhzYLHWj1qtVeU8bR1
         PYnQ==
X-Forwarded-Encrypted: i=1; AHgh+Rruak2p2Kcjp4cXpv/1oIl6cZrDbf4ni5pSe6PLUoTRlA3JLR76SVokpt69UBpicyh5hAstAUDZ2vtOTVrP@vger.kernel.org
X-Gm-Message-State: AOJu0YwCVLX5rL8f+1o0Tyy/I51CZ9vxmR0jQFD7oCspIHyreSbwsErL
	NA4xG6nvQm/NTMTA8vBXPyvbeH4KM8lvmfBoBZyJUb1robFp2k9o1diWk6LGV9Cy7SYEc4ftme0
	KCZUCrjqLOsqwIPVIHYVM02l4DMU3ZznM5qn1NP4TVEsC9iba/T1U
X-Gm-Gg: AR+sD10unuxorNl2xsfS0tzo10R9J2REsTxFIhI4LqqdRJo6c7ZvTo0ikW9kMBEESQr
	7Hoj8oFfkO9zXyOIFm1UA7MIKZIFmdUcHQ+G2LvPKfUvHp6dz0NWYgm1Sv6Ze+KppLf/JXqIoom
	FjsX7qY1OeFOkxtu8ApUJzOxJmnG9Q/EsPnppSzQGDwNWTvsrIkIpQ7RI2rXwm+XDBfhVoGHRrY
	V7C65sgmXESA56z3Rl17Q5gHaEIboWo3l7353zaQU6kla5n63pQSHQ7qXlWLkZnK3G9eu8ONunq
	LrIoKX3s5VxhjknqPPvfYpGai4A8TXL6jvQGKGIghKHoweumJXtMAscqGrO6phc+l58jdCVztVr
	j
X-Received: by 2002:a05:622a:1a88:b0:51c:51e:661c with SMTP id
 d75a77b69052e-52d8543f3c0mr324010091cf.25.1787041612031; Tue, 18 Aug 2026
 01:26:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817151801.2677899-1-libaokun@linux.alibaba.com>
In-Reply-To: <20260817151801.2677899-1-libaokun@linux.alibaba.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 18 Aug 2026 10:26:40 +0200
X-Gm-Features: AcwNN1U-JaWd29eb1fwL1cQD3kcJieXaEWabirRkz-qqA_zZczUovgOLY9MN07I
Message-ID: <CAJfpegvRuBfDPY0-snNh-evEUWpNdUnD-RE5e42a6a3fo5MhdQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] fuse: fix invalidate lock leaks on DAX truncate error paths
To: Baokun Li <libaokun@linux.alibaba.com>
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, vgoyal@redhat.com, jefflexu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Aug 2026 at 17:18, Baokun Li <libaokun@linux.alibaba.com> wrote:
>
> Baokun Li (2):
>   fuse: fix invalidate lock leak on setattr writeback failure
>   fuse: fix invalidate lock leak on open O_TRUNC DAX failure

Applied, thanks.

Miklos

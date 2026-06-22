Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A0230DEDD
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139909; cv=pass; b=rP5bvw/3qlQBirbjo3T7fRmwMcmK7JXC6A5aBGr6QOZ4PxLVEHOcdBUHXORTHAVWGJwfv6b5BOwIdibMhToc7qfHC9ZfHHP0M92REevwsLbwgbgcNiNOOJpjk4al0LYajHiYjvmz45zAsAkgDh7XDVqscLaw06kbATIjM1tEW0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139909; c=relaxed/simple;
	bh=gVbkal9XxM7heT9tHAnvOJu3bikEkIeqFY5378Ceans=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LuDo0R4HOglwsMoQCmNwOihepl8PA1OPOisgAp3ouAtClsib2HfvwukHZrCQzNIST3vfvqcnSIikYedAoUBh0w1nwEFVsSIWVav7lJfHJNUvvLAAo/d0oJuIEpTO4+O0QuluWKKRBYb/7QIZQzq8FI7vUlqhvVcxCjJMfOc0So4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=R1EQ7fo1; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="R1EQ7fo1"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51778077b28so48709561cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 07:51:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782139907; cv=none;
        d=google.com; s=arc-20240605;
        b=MA8K3zs6Q3rHrVR8y7cgSvRcExKDA1ASNsS8dRb1shmuB3x03zBSVUW9d3q0T2SvN1
         bb7QbneixyOUsy9qAXYNFBrTkO1QVfgp1tbUUIj27r2os7tIdxD6RLTj5cIdL3vcU4TN
         +ufA5XE8DpUmKKTyBnhnDUMrRNllA4l+7LqpBMVc/UCrSnlA//mA1FXuJOD3f1mT919v
         XGPtmZgSd2prIGmKMr4LV3YxN9rVZupu+rsebdJYq8eLlU8PNTTcOeibwGQ3go0Ys+2S
         GtAvyhmAv5Ms2b9QoxhEPNlKRn1tFZA61lxsvWmVavpxpbLfNQuNO2Rbmox2X5/2Rfsv
         C3ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FIRcBeKUzgIFS2r0s3+CnH5+LXYqWTzOkLNGyJcAnus=;
        fh=0BVDuEGwi2Y2eJJzuEWZRH2bC6hNeuRaJ9kDu/AjsAM=;
        b=TyV195XD+pA5HxPFo/8FCzn1ehZzZFr9HM9KP2eNaQjltcLllm9KDB0V9AKjc2ArQJ
         VW43mNYawdmM8/ro7xVPPRiWn9vrJi6uLdQFmc29mG+9iv41iOR++YdQAUsR4bSL5rpw
         4LiPHRvexyh+4oNLCMY82SowSPrRXuTEwC/BqizTNqmCVGgOQF5lI5mpShEy2YBSzZzZ
         z74QG4lZdhxTsEGB7pVasF5J2AjonWYDNyKFxuYRRhUWcBjuWeLLLzJa9iOJGyL5tBuu
         YlPTgcXiCyK98ncX9rcS1vhGAFk/bgRgAWCQXXmydsK9zNJhmMIdO8+8XDzbOvsEGYBd
         HJHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1782139907; x=1782744707; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FIRcBeKUzgIFS2r0s3+CnH5+LXYqWTzOkLNGyJcAnus=;
        b=R1EQ7fo1jAh2vvNiGZUnvpseWWomR621zV5DKYRZ5VHWX2iWPl5bJik6hlPI6n1GrH
         4ev7uIHFS/IQ8ONSxhmCxAUx2X3BEMICdrhFJ8avjqGd9iHsHWyCtWNX07blOZ6rhOxN
         8bY9xDg07t3ZKMhXZd3bSggxaWN9FPCl/Fk2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782139907; x=1782744707;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIRcBeKUzgIFS2r0s3+CnH5+LXYqWTzOkLNGyJcAnus=;
        b=Uc46EnEneCfKDuAmQ4HyPiROP1z82Wfk/1XhrTHI82kqz348BkcSbCB+HEDDLSGDFJ
         ATawy7w4e+zJ1hoMeOxJ7ENhMIAtwomgbFNn6s9tNwzbGmSApfW6lWuR/aO73Oty/Z7E
         bO6YLM44uKIr54ebStN/zxaKfcXg7Sg0HLctoUjYfJ+ohB7W9PLt7m4zA3RbKWfrIkVZ
         Qb/x+B3mff1VtBFtqOtCb8ea7b2aYYoJclQl2TYWiIrJij8oE1QUBCF9lkjEngSBEd4R
         JspZNYPZpVjlxSpVhmz/CuR8DtczZav0GaqQbJDhFEwQvdVsbVhsSUueGHxWDkMXYPjB
         O88Q==
X-Forwarded-Encrypted: i=1; AFNElJ/SkG2SYrUws+QU4aja6P563l2w9sZUXmOtLj9uYpPazCFirOW8JIhi7yxjfv04Ine15AF/NJpEU05wmw2Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg4AscRjJ6LxHH7Qtz4Mbq3pRzS58AUlfvwMcBvIa1/oqHHKhr
	SMZ3oKHBofl5T34V+IrwuEd1xUPbzIBDgpmKQw+dNhq+DqHFuUe3u7FWSlrRKyFx4JIU+MlwtDo
	SsKH6UTJPvDeye3mGDsBdVCNk2QJ+yo825c+o8CjzoA==
X-Gm-Gg: AfdE7cl/nuAsD4VgEvd89urS5lVjU4xoIRPToNU4RNQKlD6+QMdDHZ3G3ej/xnAR0yo
	f+UYB6xbE8Ub7kogzzFTexX1UtLIpnHnFSYLP8eJSnn068eEftzyk0Ji55BQ89+FPUKVIdUW6wP
	aub2D4/Oalw+Ux3vD64MXzq6dqc4ugQ/kZ3k0eKrXKVteCGArPDnHJiPQqP4cXjlS/VV80KwgET
	XiEu+TMJlVouK0PnAaa19PGZ0rKWrNCz8il/2rE/9vE01Mb0AA03yhapSeEFiyGJfooT/YyKipv
	bkE66xmG5k9ZUutRocxTLNXl
X-Received: by 2002:a05:622a:607:b0:517:6f47:599c with SMTP id
 d75a77b69052e-519e4a55947mr220299571cf.20.1782139906703; Mon, 22 Jun 2026
 07:51:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429102058.1362965-1-mszeredi@redhat.com> <a8aa3a49-7491-4085-80f2-19f89da00489@bsbernd.com>
In-Reply-To: <a8aa3a49-7491-4085-80f2-19f89da00489@bsbernd.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 22 Jun 2026 16:51:34 +0200
X-Gm-Features: AVVi8Cdxv7sCbT4BNSPA1KwJvWytoZqd0p-OJfO1crF6eHFEiBG_yqyB8O0gBng
Message-ID: <CAJfpegtQSr9jp-3Qzkpr2UP06SvvJ2OZmcqLWWck0cV=htYpOQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: add fusex filesystem
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 May 2026 at 19:58, Bernd Schubert <bernd@bsbernd.com> wrote:

> > +#define ADD_IN_ARG_ZERO(args) \
> > +     ADD_IN_ARG(args, 0, NULL)

> could we avoid that? If we don't want to change existing op codes, could
> we avoid it at least for any new op code?

Good point.

What we really want is fixed size headers, and what better time to do
that with fusex.

Do you see any issue with just taking the 128 + 128 bytes that
fuse-uring is using and padding the headers with zeroes?

fuse_setstatx_in goes over the limit, but we can just move the statx
part to the payload.

Thanks,
Miklos

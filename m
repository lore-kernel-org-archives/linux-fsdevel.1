Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A7037AA94
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 20:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787084624; cv=pass; b=BtXQiw3X3BGp0RaXOfuO/Kkxquj/Ulbe/udnFaRhXRuM3qIvMCJSFX7Dx2jY00n8nE7+TYC0w37OWF30eGb5agoRNgbEZEVlFN2sCfODwkNy5MPwLn9D6QZrJR96fKmrV5thpbweQUjRnqKwK+17lPaFvJ4avN8HJnrfGAxVNj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787084624; c=relaxed/simple;
	bh=b12FOYNV5nyithT6OlCb8Z0YTlojmZTUrPBI5ONi7LA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSFqbjucw/p7fZ71zkRjylfOYO3blmpqTdqxw51a/wLd5hSAFk17yjS0tnVEaE0hDppkcUzCeQW1ts1EcXaSQQOqvsrzoaAX54gAVrRFUVXGXO+osQkOmmoxTKlnyXE54QnOhmLQUKIlX5BDsaeMsr+bx7SVptkavcWIYtjnm/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAvjKDkV; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAvjKDkV"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a18840e2abso462558a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 13:23:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787084621; cv=none;
        d=google.com; s=arc-20260327;
        b=dMKai8d2IyoDYaIjXNDO5yoIR8EGsU36RC9sBWBd9rHQpMZNwHv6M9yglOwmysOcwV
         BltHAtJEj6sfMv9TYgWDzXpxKbc+dGAr0kipUdcjtSYIffuOA2SwF5rz5QbvvpfwjFuc
         NaN8PyaBJx4mqJ3C6VaKjg31/dOlSzCIsC0cYtVH37nDkaDuuykquSv3rti78qxBf034
         S4idBKCc9olqiTaDjFKPHvKB7TyV6gEydo7qJeRDLp98x8EOMROCtfKvKCAD/GiXWS+K
         aVBhMhBDRNfLvrih5fi2KztO8QYPT9T+Jx0M3krPPvHZGdKF06nSrZFQQTZOoxYIoeG7
         qbYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b12FOYNV5nyithT6OlCb8Z0YTlojmZTUrPBI5ONi7LA=;
        fh=5KigTbJ4zzalH2GgMPUQHDs1ICcqhHBOAlr2alJGbso=;
        b=SQCyGKmUhEets9aQjA+C9/3Fgfs2d2+VWJlG7sLtct4sp64xeiuWJO0h0bcYgYbR5m
         JswhVCHPHUOcNXMM1yQ7HKXTxT/h4EYhRk7yHhZipK45Dde1hH5qb+PVJT1O5WObZyZz
         saSAybtg2ss/y+vLwpuXQkoolgSzbpWHqLnIV6sHylMb1v1dvVTuPLphbzvZFFqFthJN
         /YFhmovbTlBKIRulBV1XijVM07IqVUmdb/oC890pgpGA/ZQSueKcWWRxjWMJv2aEA5ow
         gabiPLSmIyqzIlXON+LdSbBV/hetkW44vPvxX7iL0m7j+Lx39VIpxW36u0+vgqqwdZp1
         Ldlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787084621; x=1787689421; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b12FOYNV5nyithT6OlCb8Z0YTlojmZTUrPBI5ONi7LA=;
        b=WAvjKDkVZQa6GcOZK0bI1OtG4M0gbXOKs9NJc5kKlM8luMRGfpoNxtR6udE0qXjhGt
         B1P714ONsn/wxA2N7mclYyEMracXNKSzpPGUZMk9isC4jyLTwjBkR7gLpijToH9e9Tnf
         X0MfpXNfX71OtdMZh7fZCZ0owdFozrp+iWbSyZHAgmd71e74pWnLKPM7vGo/ndhRzivW
         qqZVmW/R3aDOWxw3gjSLfYz5KjfVCsGMW2UR4XHavCeUvCGQAbtoS6tapFE2omDSTx2H
         0v0pN2+Yb1nks4bildRmRHkg0iZtxgh75w5QsJ//o+dtBa58ccWWLncy5tT+qy4ojrRP
         Di1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787084621; x=1787689421;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b12FOYNV5nyithT6OlCb8Z0YTlojmZTUrPBI5ONi7LA=;
        b=fnP8fE+hNYI/Q2Hh6sQz5SMJQmgwIS3aJn7lqYcVycv975SYPm9NwU8oCRdavbGigS
         rUeVkDleWB1o0BOOE0IYUMJvBZHRwQPPierJ7POmMrjGJYHjcH/cfU+XhdSxAqnPeQD2
         mOtzWPrQz5QmN6Ml6u033VODl7MCM3zgZUeQldd3benIpUmpvTDQ9LPCJLPZPD/wLyu3
         xKpPqTLkWxtGixi94bcoBssUq9Hsm0m5LPi7eBiPgZ68nVgqOmucODu3aaOatkCPfMKj
         K8qzd1WXZANwTHrLdGKVlKI6dr2/C1TnsDq9+rxpeWUJJcJ6xbcxMx+dShK9U1YYVnSe
         Msew==
X-Forwarded-Encrypted: i=1; AHgh+RrmvFyZ9zSafuYa6d52Epde02BaF/ONNMIgL3RimeaZYYGVa6tAzfyYXapa6/60rkMnWvcBMIuht/G5WhF9@vger.kernel.org
X-Gm-Message-State: AOJu0YzWXNuZcPo2vxmKZ6TBlRJ71OAwu9LGHjylfYrc2px/mqgaSyXw
	enQ4SY9dpVV5jcQ1lCLZPc/3EO4zc/460grsiTJaLiKVSyt4m5XnVM31a14yqAvLxi/2kZk/EcO
	APVWNBVgnol6yOL91Ug8yTDDtgp3X0VE=
X-Gm-Gg: AR+sD10BNVJLD0YwW95cA54mh/UtQhJocJPVv+2CcDYrd9LoBm2ZI2TWxoyeUbWgc2D
	eR6RyhOK5VbLMIpYrKF2HsBCR2QceBL6e3V/eKDtWCN7Qq32+V7cz6JAfYmeh7X0OksTtSOK969
	fBwoTPHCNsjYY+ezh20gc6VzQRGATI/fuAFV8egZH2x1o9b1lDbD9lqvHR/q++PM5Y8Vmna8wZi
	ptlDMzMOiBua9PVqwK7WAGraoLlaqtV3xiMaM092t+IWWsBGqBlePcvOgrnzJg0I6zmEC1gZD77
	/a1FNHDUz87YM5byrur/yoZ4SLh0sQlsTyEXmSV7gCWvfA==
X-Received: by 2002:a05:6402:21d6:b0:6a3:f74d:6a47 with SMTP id
 4fb4d7f45d1cf-6a3fb56d9ebmr504788a12.0.1787084620914; Tue, 18 Aug 2026
 13:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA5ehdZpfp2w6SWjGm3K7rs-F9Fj-jBY1pRqu_zDbnan2X3U9w@mail.gmail.com>
 <rvcniqbnyaarjm57qxh2qq7mdv27j25cadu5iatynezbdabod3@6aqbsocpuqog>
In-Reply-To: <rvcniqbnyaarjm57qxh2qq7mdv27j25cadu5iatynezbdabod3@6aqbsocpuqog>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 18 Aug 2026 22:23:29 +0200
X-Gm-Features: AcwNN1W7Ab8BARhDE3KRC-mR-HEYtuyTgVbQUWu3UIenBRUT1RwTxWAESVzeFwY
Message-ID: <CAOQ4uxhDFifNsY+cv_+3cc+_NGKj8V_-b-b7usF6J+A+uOtBTQ@mail.gmail.com>
Subject: Re: [RFC PATCH] fsnotify: raise default fs.inotify.max_user_instances
 now that memcg accounts for it
To: Jan Kara <jack@suse.cz>
Cc: Harsh Upadhayay <harshupadhayay906@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, longman@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 3:47=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> Hello!
>
> On Wed 12-08-26 20:51:36, Harsh Upadhayay wrote:
> > I hit this running a 3-node k3s homelab cluster: every container on a
> > node shares one 128-slot fs.inotify.max_user_instances pool (no user
> > namespace remapping), kubelet alone was holding 25-40+ instances just
> > from ConfigMap/Secret volume watching, and the pool emptied under
> > normal load -- surfaced as an unhelpful, inotify-silent "too many open
> > files" in whichever container's turn it was to ask next. Filing as
> > RFC since I couldn't find prior discussion of raising this default.
>
> Not sure what Amir thinks about this but I think default is just a defaul=
t
> and it is natural it is not good for everybody. I can see how 128 inotify
> instances may not be enough for Kubernetes setups but then the answer is
> for Kubernetes installation to configure maximum inotify instances to a
> higher value. And as you show below, different container runtimes tune th=
e
> value differently which just proves my point that whatever value we choos=
e
> people will need to tune it - which is the point of this limit being tuna=
ble
> after all.

I agree that I don't see a strong enough reason to change an upstream defau=
lt
to another arbitrarily bigger value that could be easily changed by the dis=
tro
or by the kubernetes host.

>
> So I don't see a strong enough reason to bump up the default limit becaus=
e
> there can be other users for which increased limit could allow a potentia=
l
> DoS in their setups. The concern isn't as much the memory consumed by
> inotify instances themselves as you write below but more all the events
> that can get queued to each instance. OTOH those are accounted to the
> instance's memcg so your overall argument that in memcg enabled setups th=
e
> limits aren't that much needed is still somewhat valid.
>

Not only the memory of marks nor events but also processing time and
arbitrary long delays to other users in the system.
I'll explain this with an extreme example below...

> > fs.inotify.max_user_instances has been a flat 128 since inotify's
> > introduction in 2005. That number is not per-container or per-workload
> > -- it is a single pool shared by every process running under a given
> > real UID on the host. On a multi-tenant Linux box, that means every
> > container's root process shares one 128-slot pool with every other
> > unremapped container's root, plus the host's own kubelet/containerd
> > (or equivalent) bookkeeping, since user-namespace UID remapping is
> > off by default in essentially every mainstream container runtime.
> >

...let's do a thought experiment, why stop at one multi-tenant level
why not nest it several times as userns is designed to do to allow for
containers inside containers.

In this hypothetical environment I am not sure it makes sense for
users in container A to pay for the cost of subscribers in nested
containers B.*.*.

It may make more sense in nested environment for container B to have a
single group in container B getting the events for all the subscribers in B=
.*
and forwarding the events to sub-subscribers and so forth in B.*.*.

Maybe the group in container B does not have inode marks but fs marks
with bpf inode maps as filter.

IOW, if kubernetes needs to increase max_user_instances for modern day
workloads - it may do that, but I don't think this design extends well into
a future of many more containers on the same host.
Even if userns were used by kubernetes, I am not sure that the current
publish subscribe model of inode marks would be able to handle thousands
of userns well.

Thanks,
Amir.

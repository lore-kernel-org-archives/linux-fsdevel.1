Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795830680;
	b=lBtDXqz/QQyvivTLvws6+b+7VIcZXUCD17Pm2NFQbI/OCyu3LrzIz3EkuLjunRpr5CdB
	 AxE6b475uYgXJWyXo4NFiokrm55N/LGJl6NZgDBLAlQ5jPMA9k9uBa/ORWvD0ARYRKweM
	 RcZfd2nBzB+VlMclogj7gKP+k+L9m4MqmdqzFi6wn41MHtsaU/YrdhUXb8XG7Rq7TlBAY
	 TD5tEh6pD8Hf8s4d6SC3veJ8ZUp9ex3WJ+hDWKtDjpBAbYY/wLWnkW3/X9pqqkGHB9Urg
	 2nSUn1Jp9MBejt3Gfh+Bm0OGuRcsNoloNZuWLfZaj11MoIaXJpMdQGzv7ePbPxZJtGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795830680;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=M+kv6M/MroHXNub3A7PdHe23Ap2KXe5JLqM78W2xjvU=;
	b=yVXnLycJbOfT7SNMAbKVbKbuCnl0bRfRUb1wMHfApwhy9kNASkmBVXSAo5Tpz3xgwDmy
	 13Z5fnk7IZqUI0LvVL4gguKBI5JYopHJyKVrvI8xV3bWNct1J76mtIqBiwx8tSKjDhPhb
	 FZT1ncvswpaX1jYPhCRMCDRX8yoF0/ga9aI4riuhqKqIDgfZsH9SWPy+1kCgLqJHo+TMj
	 46pqq7wUfQrw7i4tKiaueJG7QuwNEYFSuB4Km/XERJoQYH3LVW3iFPEb6baL+i0ies3dX
	 9HeguaxebPROoDWBIpwDYfVeYUvbW+mV3KXFv2XXkfRkDJZ/+jI/qCox+gSN96vMRCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XLosXPN4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78574606A31E
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Nov 2026 01:51:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78574606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XLosXPN4
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c5127c7abd5so1322752266b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 17:51:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795830679; cv=none;
        d=google.com; s=arc-20260327;
        b=Y/xpkdo2KAMTmlRSotm22A2qyTU/4WusOyUnp31xCtZFvSjQRq73nSvq/Tz8hN2Dlu
         NOiGzym0KaFYhkYBrOgiAQZG9kFclXmfSu4LMB5yHQMW9mkoJRrVwvotQBq2ZpBclWvp
         Jc2Yi9wRJIUcaIsFRF0Zgpl/wlGovMA8Kn3JL6ATKhcx2ey3YUxy4tpNcNpGMfSmawH9
         YOcW80oPAxIdiJzAdfj/Wk7VVPE6V9Z4ho/PF0sVLuxkruah/XVw4yb2om25OSXDqK4K
         gHCSakbDcZPKjIYADDYmCMHOWpvqTWS0HDAmMSldvS7owMdw2DH/sgVDWO5s0oAbAh2U
         V9Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M+kv6M/MroHXNub3A7PdHe23Ap2KXe5JLqM78W2xjvU=;
        fh=0qUW0ij8DdkssAtXlzpFy4V5jDsl+yuKnES3f97FwUI=;
        b=PjM20r9TLlTLG2QdeC7lMETLJNvKBDw9Oc6RoBHCvZwMrG4WM1Q75mkCsugI0r7dwv
         bHC7Vgl/SBqjbdWyGzffeMWAmqnxkneE4LKM13UuDLzlPSVbjy9D/r20z4STnsniI0Vk
         AmOkI/t9EbG47h2QwO0W/WK3ZFJsMk83XlLxLzFquK2mqmm8zmYGyMof8b6UbuMEIFLP
         rxVj6T+GpVOJilVxDRB+QXj/OcAHTOKZCYKYuPgmHlYolYeylwxbPOTIaFuA/nCeT3SW
         /9kkn3ynwrUmEWWfAzfSLkUAa+39T9PWWtIENENL6EcKwGh3fVqJUmtJTZWS1okMFO57
         SsnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795830679; x=1796435479; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M+kv6M/MroHXNub3A7PdHe23Ap2KXe5JLqM78W2xjvU=;
        b=XLosXPN4XY1X7SNdxkqBL+OmW6RyoS3KUKiJGN6VkhP3L0yhHIWAe9gfCGB7c23JLd
         lHNLLgTgGaPV+ANwny7auVJWhylTPy7tn8Qbd1QmlxO7gDNExEWgSGEhy30NAozJQ+8+
         +xKv07hbVc2PMmC0nQwONM+Snu/fB4CVx2Zu1RVG2ABrNV3bydSS40OT+TsJEZK+JELi
         MFuPTs18dGi6k3X7RKL9C6rS6PY4lyASR9cQGoX1ApSJvF/sCt8fWc54v5qN8Mgd+424
         mRGAbRe9QyqlYYy8UZHrD36MAiba/qdVjAz2hG+uSVag6rBQPtZrBpUV+D6X33j1iq7k
         51pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795830679; x=1796435479;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M+kv6M/MroHXNub3A7PdHe23Ap2KXe5JLqM78W2xjvU=;
        b=oloD/+e0sjv0HiUSRHdYHh3kBCAME84aVoArJAVA2lYTYpmAzHsKJcQxJudmvpuAoF
         Qt+vC9F8ibBpmC4iPLsCzg7QU3jF1l9vmrBbwaOg6g27UiUP/ZJLpSCAOfi2R2vaDW8X
         GQlzz+HXvEeGOUlhWg5FXqy3Wri6Yo+AILpDwacysHu095uXmTQAbpsRuh20pPpTX92d
         veL0vPi+d8nkymeWdcx7/+2ACkYch0b496l5V9yddMVB5ZRamhWs6XwFAlR0bhAnvLBl
         n9YcdFovjENNIXovoclMtc2hrrrrDEvLRmVaJkAgVw4M9tHYZ03z2/5mCjB4kgL6ilht
         7oQA==
X-Forwarded-Encrypted: i=1; AL+hErEzNQ/2cCj9mOCWiwLOd/+7ySHiiOVGSuIm4UZy3l7R92JRUppBGMFMGiqBseec1hv7jxOzu5LVcZ1eD8Sm@vger.kernel.org
X-Gm-Message-State: APuU4Z+fcfKwm7uwcGOrPhoQa85PFO1Vrns+pRSkirB6IbEKTDDujWpn
	MReusTsqjmulr8uggBxFLzYA3E76iIYZdihyr+a+gmSN12d9UvhAmlkQ620bE54le5gplnzjRIO
	lVnYt1BvBPdHpfwIxc2PtKGhm6e0w/9k=
X-Gm-Gg: AZFdTZfvQEjMfB2lUaTO2vbukIRoyPNuO0WqVmT7uHDVXBn3BaekxtvvhpPI7eyCcWK
	huH4MeQ07kvbxe1xu8MdMj0P99Ee3JoXdzhFsJ7LYPAq/h9rl5LnMMMYBeCaNq2B9hGC6AG4q8b
	OwGl/ETsq03k3apIheTWIDu57xqP3fS0TK4V3bHUp46SOncDAHt7MDRQ6pmCfnkrIfto8Sy0AsO
	w8SJtBRF9CDQpp5Y/7+6CZl5odst65+7aaTysO5kB6P6hkB1YM8AUhUpbRHqW/0NmcvNbSKI4/A
	8I69WMibwkvKARrTfpRB91yTqm5DcKy/UO3jcg68tOcR1/7sO2x3Q34GMqBDT3wHmRa/A/FA2tl
	ejjStACqcoRx3hXncTL9PFxq8lKvQwGEYeBme
X-Received: by 2002:a17:906:fa82:b0:c50:4b6e:329 with SMTP id
 a640c23a62f3a-c513a5eaea2mr1724212966b.15.1795830678877; Fri, 27 Nov 2026
 17:51:18 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <awOQDOel_72Xwjm7@kernel.org> <20261127214103.542291-1-safinaskar@gmail.com>
 <awn-ioAuksHNV-Rc@kernel.org> <awn_Y7oI4ckfsjSv@kernel.org>
 <awoHex4LVst2JwkO@kernel.org> <awoO9R7YF_5_6dHA@kernel.org>
In-Reply-To: <awoO9R7YF_5_6dHA@kernel.org>
From: Askar Safin <safinaskar@gmail.com>
Date: Sat, 28 Nov 2026 04:50:42 +0300
X-Gm-Features: Aa3M54pCi2p8qLdocdLXd3OCMkn8g_j_UUSVEEax8LAEOxwj1oFmxFAoHI8_4lc
Message-ID: <CAPnZJGBnFyrmr88OsYkMwtLiR93z4g0NAuoMurcnhcYFXz51jg@mail.gmail.com>
Subject: Re: [RFC PATCH v7 00/26] userland: Userland containers
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: aleksa@amutable.com, alex@amutable.com, alexei.starovoitov@gmail.com, 
	arnd@arndb.de, bpf@vger.kernel.org, brauner@kernel.org, 
	containers@lists.linux.dev, corbet@lwn.net, dhowells@redhat.com, 
	ebiggers@kernel.org, giuseppe@scrivano.org, hughd@google.com, jack@suse.cz, 
	jlayton@kernel.org, josef@toxicpanda.com, kees@kernel.org, kpsingh@kernel.org, 
	lennart@poettering.net, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	luto@amacapital.net, neal@gompa.dev, oleg@redhat.com, paul@paul-moore.com, 
	ptikhomirov@virtuozzo.com, sergeh@kernel.org, skhan@linuxfoundation.org, 
	viro@zeniv.linux.org.uk, zygmunt.krynicki@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 28, 2026 at 2:15=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
> thinking more sequencing than data structures. I.e. I have a game where
> I need to end up to process creation without embryonic state, and add
> just enough weight to kernel to support that outcome, and that leads
> to ~2K'ish LOC of extra kernel complexity.

So you don't have embryonic state? I don't like this.

Let's assume the following situation. Userland's PID 1 is already running.
Our container manager attempts to spawn yet another process into userland.
As well as I understand, it should do clone3 with CLONE_INTO_USERLAND,
and then execve.
This creates time hole when there is process, which already runs inside
userland (i. e. its PID namespace and other namespaces), but runs
container manager's binary and have container manager's mm.
This invites for bugs. Other processes, which already run inside userland,
may somehow take advantage of this.
For example, see section "CVE-2019-5736 Is a Very Very Very Bad
Privilege Escalation to Host Root"
of https://brauner.io/2019/02/12/privileged-containers.html .
So, here I like embryos.

--=20
Askar Safin
